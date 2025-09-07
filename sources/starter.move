module starter::escuela{

    use std::string::{String};
    use sui::vec_map::{VecMap, Self};
    use sui::sui::SUI;
    use sui::coin::{Coin};
    use sui::coin;

// Notoficaciones de error
    #[error]
    const ID_YA_EXISTE: vector<u8> = b"El ID ya de la escuela ya esta registrado";
    #[error]
    const ID_NO_EXISTE: vector<u8> = b"Este ID de curso no existe.";
    #[error]
    const NO_PROPIETARIO: vector<u8> = b"No puedes modificar el contenido del curso o la escuela debido a que no eres propietario.";
    #[error]
    const NO_DISPONIBLE: vector<u8> = b"Este curso no esta disponible por el momento.";
    #[error]
    const SALDO_INSUFICIENTE: vector<u8> = b"El salod disponible en tu Wallet es insuficiente";

//estructuras de Escuela, Cursos y el acceso al curso
    public struct Escuela has key {
        id: UID,
        nombre: String,
        propietario: address,
        cursos: VecMap<u64, Curso>,
    }

    public struct Curso has store, drop {
        id: u64,
        titulo: String,
        instructor_nombre: String,
        descripcion: String,
        disponible: bool,
        costo: u64
    }

    public struct AccesoCurso has key, store {
        id: UID,
        curso_id: u64,
        propietario: address,
    }


// Funciones de adminitracio de escuela y cursos
    public fun crear_escuela(nombre: String, ctx: &mut TxContext) {
        let escuela = Escuela {
            id: object::new(ctx),
            nombre,
            cursos: vec_map::empty(),
            propietario: tx_context::sender(ctx),
        };
        transfer::transfer(escuela, tx_context::sender(ctx));
    }

    public fun crear_curso(escuela: &mut Escuela, id: u64, titulo: String, instructor_nombre: String, descripcion: String, costo: u64, ctx: &mut TxContext) {
        assert!(escuela.propietario == tx_context::sender(ctx), NO_PROPIETARIO);  // filtro para que solo el propietario pueda administrar
        assert!(!escuela.cursos.contains(&id), ID_YA_EXISTE);               //verificacion de su existencia

        let curso = Curso { id, titulo, instructor_nombre, descripcion, disponible: true, costo };
        escuela.cursos.insert(id, curso);
    }

    public fun actualizar_curso(escuela: &mut Escuela, id: u64, titulo: String, instructor_nombre: String, descripcion: String, costo: u64, ctx: &mut TxContext) {
        assert!(escuela.propietario == tx_context::sender(ctx), NO_PROPIETARIO);
        assert!(escuela.cursos.contains(&id), ID_NO_EXISTE);

        let curso = escuela.cursos.get_mut(&id);
        curso.titulo = titulo;
        curso.instructor_nombre = instructor_nombre;
        curso.descripcion = descripcion;
        curso.costo = costo;
    }

    public fun eliminar_curso(escuela: &mut Escuela, id: u64, ctx: &mut TxContext) {
        assert!(escuela.propietario == tx_context::sender(ctx), NO_PROPIETARIO);
        assert!(escuela.cursos.contains(&id), ID_NO_EXISTE);

        escuela.cursos.remove(&id);
    }

    public fun eliminar_escuela(escuela: Escuela, ctx: &mut TxContext) {
        assert!(escuela.propietario == tx_context::sender(ctx), NO_PROPIETARIO);
        let Escuela { id, nombre: _, propietario: _, cursos: _ } = escuela;

        id.delete();
    }



// Funcion para comprar cursos por los alumnos
    public fun comprar_curso(escuela: &mut Escuela, id_curso: u64, mut pago: Coin<SUI>, ctx: &mut TxContext): (Coin<SUI>, AccesoCurso) {
        assert!(escuela.cursos.contains(&id_curso), ID_NO_EXISTE);

        let curso = escuela.cursos.get(&id_curso);
        let costo_curso = curso.costo;
        let pago_value = coin::value(&pago);

        assert!(curso.disponible, NO_DISPONIBLE);
        assert!(pago_value >= costo_curso, SALDO_INSUFICIENTE);

        let cambio = sui::coin::split(&mut pago, pago_value - costo_curso, ctx);
        sui::transfer::public_transfer(pago, escuela.propietario); // Se transfiere al propietario de la escuela

        let accesonft = AccesoCurso {    // Creacion de un ibjeto nft que se devuelve al comprador
            id: object::new(ctx),
            curso_id: curso.id,
            propietario: tx_context::sender(ctx),
        };

        (cambio, accesonft)
    }

}