# 🚀 Sui Starter Kit Backend

Sui es una plataforma de blockchain y contratos inteligentes de capa 1 diseñada para que la propiedad de activos digitales sea rápida, privada, segura y accesible.

Move es un lenguaje de código abierto para escribir programas seguros que manipulan objetos en la blockchain. Permite bibliotecas, herramientas y comunidades de desarrolladores comunes en blockchains con modelos de datos y ejecución muy diferentes.

---

## 📦 El Proyecto

Este repositorio sirve como un kit de inicio para desarrollar proyectos backend en la blockchain de Sui utilizando el lenguaje de programación Move.  
Incluye un contrato inteligente completo y funcional para un sistema de gestión de cursos básico, con módulos para crear una escuela, cursos y manejar pagos.

---

## ⚙️ Comenzando con Codespaces

La forma más sencilla de empezar es usando un Codespace de GitHub, que ofrece un entorno de desarrollo preconfigurado con todas las herramientas necesarias.

### 1. Clona el Repositorio  
Copia este repositorio a tu cuenta de GitHub haciendo clic en el botón **Fork**. Puedes renombrar el repositorio según tu proyecto.

![Fork](./imagenes/fork.png)

### 2. Abre en Codespaces  
Presiona el botón `<> Code` y navega a la pestaña **Codespaces**.

![Codespaces](./imagenes/codespaces.png)

### 3. Crea el Codespace  
Haz clic en **Create codespace on master**. Esto abrirá un entorno de Visual Studio Code directamente en tu navegador, con todas las herramientas necesarias ya instaladas.

---

## 🧰 Herramientas Incluidas

Este proyecto viene con las siguientes herramientas esenciales para el desarrollo en Sui, preinstaladas en el Codespace:

- **SuiUp**: Administrador de versiones para la CLI de Sui  
- **Sui CLI**: Interfaz de línea de comandos para interactuar con la red Sui  
- **Extensión de Move para VS Code**: Resaltado de sintaxis y soporte para Move  
- **Move Formatter**: Extensión para formatear código Move  

Estas herramientas fueron desarrolladas por **MystenLabs**.

---

## 🧪 Ejecutando el Proyecto

Para asegurarte de que todo está configurado correctamente, puedes ejecutar las pruebas unitarias incluidas.

### Ejecuta las pruebas:
```bash
sui move test

BUILDING starter
Running Move unit tests
[ PASS    ] starter::escuela::prueba_creacion_escuela
[ PASS    ] starter::escuela::prueba_creacion_curso
[ PASS    ] starter::escuela::prueba_compra_curso
Test result: OK. Total tests: 3; passed: 3; failed: 0

🧩 Estructura del Proyecto
El código fuente se encuentra en sources/escuela.move.
El módulo escuela contiene las siguientes funciones clave:
Funciones Principales
- crear_escuela: Crea una nueva escuela propiedad del remitente
- crear_curso: Agrega un curso a una escuela existente
- actualizar_curso: Modifica los detalles de un curso
- eliminar_curso: Elimina un curso del catálogo
- comprar_curso: Permite comprar un curso, gestiona el pago y genera un NFT de acceso

💬 Interacción con el Contrato
Para interactuar con el contrato, utiliza la CLI de Sui.
🛠️ Crear un Curso
sui client call \
  --package <TU_ID_DEL_PAQUETE> \
  --module escuela \
  --function crear_curso \
  --args <ID_DE_LA_ESCUELA> 7 "Blockchain Avanzado" "Instructor X" "Aprende a construir sobre Sui." 100 \
  --gas-budget 50000000


🛒 Comprar un Curso
sui client execute-transaction-block \
  --assign @escuela=object(<ID_DE_LA_ESCUELA>) \
  --assign @pago=sui::coin::create_for_testing(500) \
  --move-call <TU_ID_DEL_PAQUETE>::escuela::comprar_curso @escuela 7 @pago \
  --transfer-objects @pago \
  --gas-budget 50000000



🧱 Base para Proyectos Más Complejos
Este kit es una base sólida para construir aplicaciones más avanzadas en Sui.
Puedes extenderlo para incluir:
- Certificados NFT
- Reputación de instructores
- Evaluaciones y retroalimentación
- Integración con frontend web o móvil

📄 Licencia
Este proyecto está bajo la licencia MIT. Puedes usarlo, modificarlo y distribuirlo libremente.
