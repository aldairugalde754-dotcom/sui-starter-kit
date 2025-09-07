# 🚀 Sui Starter Kit Backend

Sui es una plataforma de blockchain y contratos inteligentes de capa 1 diseñada para que la propiedad de activos digitales sea rápida, privada, segura y accesible.

Move es un lenguaje de código abierto para escribir programas seguros que manipulan objetos en la blockchain. Permite bibliotecas, herramientas y comunidades de desarrolladores comunes en blockchains con modelos de datos y ejecución muy diferentes.

---

##  Proyecto

Este repositorio es un proyecto para llevar la logica de compras para cursos en linea utilizando la blockcain de SUI, ademas de considerar poder pagar esos curos emplendo las cirptomonedas de SUI,
esto permite tener mayor seguridad en las transacciones de compra ademas de eliminar personas e intituciones bancarias intemediarias, de modo que cualquiera puede crear una escuela y dentro de ella
crear varios curos que al venderse directamente le transfieren los fondos a su Wallet, y le regresar un objeto nft al comprador como prueba de su compra

---

## Comenzando con Codespaces

### 1. Clona el Repositorio  
Copia este repositorio a tu cuenta de GitHub haciendo clic en el botón **Fork**. Puedes renombrar el repositorio según tu proyecto.

![Fork](./imagenes/fork.png)

### 2. Abre en Codespaces  
Presiona el botón `<> Code` y navega a la pestaña **Codespaces**.

![Codespaces](./imagenes/codespaces.png)

### 3. Crea el Codespace  
Haz clic en **Create codespace on master**. Esto abrirá un entorno de Visual Studio Code directamente en tu navegador, con todas las herramientas necesarias ya instaladas.

---

### 🧪 Ejecutando el Proyecto

Para asegurarte de que todo está configurado correctamente, puedes ejecutar las pruebas unitarias incluidas.

### Ejecuta las pruebas:

sui move test

BUILDING starter
Running Move unit tests
[ PASS    ] starter::escuela::prueba_creacion_escuela
[ PASS    ] starter::escuela::prueba_creacion_curso
[ PASS    ] starter::escuela::prueba_compra_curso
Test result: OK. Total tests: 3; passed: 3; failed: 0

### 🧩 Estructura del Proyecto

El código fuente se encuentra en sources/escuela.move.  
El módulo escuela contiene las siguientes funciones clave:

### Estructuras
Se crearon 3 estrcuturas que son la Esucuela, el Curso y el Acceso al Curso, que son las plantillas de objeto para crear las diferentes funciones del
proyecto

### Funciones 
- crear_escuela: Crea una nueva escuela propiedad del remitente
- crear_curso: Agrega un curso a una escuela existente
- actualizar_curso: Modifica los detalles de un curso
- eliminar_curso: Elimina un curso del catálogo
- eliminar_escuela: Elimina una escuela y todos sus cursos en ella
- comprar_curso: Permite comprar un curso, gestiona el pago y genera un NFT de acceso


### Seguridad

Emplea notificaciones de error para mostrar que esta pasando mal al ejecutar el proyecto
 -  #[error]
    const ID_YA_EXISTE: vector<u8> = b"El ID ya de la escuela ya esta registrado";
 -   #[error]
     onst ID_NO_EXISTE: vector<u8> = b"Este ID de curso no existe.";
 -   #[error]
    const NO_PROPIETARIO: vector<u8> = b"No puedes modificar el contenido del curso o la escuela debido a que no eres propietario.";
 -   #[error]
    const NO_DISPONIBLE: vector<u8> = b"Este curso no esta disponible por el momento.";
 -   #[error]
    const SALDO_INSUFICIENTE: vector<u8> = b"El salod disponible en tu Wallet es insuficiente";

Ademas se utilizaron, assert para verificar que quien modificara la escuela o el curso fuera el propietado
- assert!(escuela.propietario == tx_context::sender(ctx), NO_PROPIETARIO);
Y para verificar que los objetos solicitas realmente existieran
-assert!(escuela.cursos.contains(&id_curso), ID_NO_EXISTE);

### Compra de Cursos
Para la funcion de comprar cursos por parte del usuario de coloco una funcion que recibe parametros de la escuela y el curso ademas de las moneadas esto para poder comprar el curso, 
transferir las monedas al instructor o escuela y que el comprador mediante la estrucutra de "AccesoCurso" y la funcion "accesonft" pueda crearse un nft que le sera devuelto como su
legitimo e irrepetible acceso seguro.

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
    

### 💬 Interacción con el Contrato

Para interactuar con el contrato, utiliza la CLI de Sui, mediante algunos comandos 

 Comando de compra

```
sui client call \
  --package 0xa51552f92adae538397cd31762da054bc718441ce1070af7799d79b5db7c07ca \
  --module escuela \
  --function comprar_curso \
  --args 0x724ed8374b50faaefa81c9e533aec15569ca8555e0622dd90d13f3331c7a128e 4 0x228e255f0a101391c6b91bba094581e023307fd45c37b92286382e7a0a11bfa7 \
  --gas-budget 10000
```




