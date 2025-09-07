!(./imagenes/banner.jpg)

Sui Starter Kit Backend
Sui es una plataforma de blockchain y contratos inteligentes de capa 1 diseñada para que la propiedad de activos digitales sea rápida, privada, segura y accesible.

Move es un lenguaje de código abierto para escribir programas seguros que manipulan objetos en la blockchain. Permite bibliotecas, herramientas y comunidades de desarrolladores comunes en blockchains con modelos de datos y ejecución muy diferentes.

El Proyecto
Este repositorio sirve como un kit de inicio para desarrollar proyectos backend en la blockchain de Sui utilizando el lenguaje de programación Move. Incluye un contrato inteligente completo y funcional para un sistema de gestión de cursos básico, con módulos para crear una escuela, cursos y manejar pagos.

Comenzando con Codespaces
La forma más sencilla de empezar es usando un Codespace de GitHub, que ofrece un entorno de desarrollo preconfigurado con todas las herramientas necesarias.

Clona el Repositorio: Copia este repositorio a tu cuenta de GitHub haciendo clic en el botón Fork. Puedes renombrar el repositorio según tu proyecto.

!(./imagenes/fork.png)

Abre en Codespaces: Presiona el botón <> Code y navega a la pestaña Codespaces.

!(./imagenes/codespaces.png)

Crea el Codespace: Haz clic en Create codespace on master. Esto abrirá un entorno de Visual Studio Code directamente en tu navegador, con todas las herramientas necesarias ya instaladas.

Herramientas Incluidas
Este proyecto viene con las siguientes herramientas esenciales para el desarrollo en Sui, preinstaladas en el Codespace:

SuiUp: Un administrador de versiones para la CLI de Sui.

Sui CLI: La interfaz de línea de comandos para interactuar con la red Sui.

Extensión de Move para VS Code: Proporciona resaltado de sintaxis y otras características para el lenguaje Move.

Move Formatter: Una extensión para formatear código.

Estas herramientas fueron desarrolladas por MystenLabs.

Ejecutando el Proyecto
Para asegurarte de que todo está configurado correctamente, puedes ejecutar las pruebas unitarias incluidas.

Abre tu terminal dentro de Codespaces.

Ejecuta las pruebas con el siguiente comando:

Bash

sui move test
Una salida exitosa mostrará que tus pruebas han pasado:

Bash

BUILDING starter
Running Move unit tests
[ PASS    ] starter::escuela::prueba_creacion_escuela
[ PASS    ] starter::escuela::prueba_creacion_curso
[ PASS    ] starter::escuela::prueba_compra_curso
Test result: OK. Total tests: 3; passed: 3; failed: 0
Estructura y Funcionalidad del Proyecto
Este proyecto se basa en el módulo de Move escuela, que gestiona la creación y compra de cursos digitales. El código se encuentra en el archivo sources/escuela.move.

Funciones Principales
crear_escuela: Crea un nuevo objeto Escuela propiedad del remitente de la transacción.

crear_curso: Agrega un nuevo Curso a un objeto Escuela existente. Esto solo puede ser realizado por el propietario de la escuela.

actualizar_curso: Permite al propietario de la escuela actualizar los detalles de un curso.

eliminar_curso: Elimina un curso de forma permanente del catálogo de la escuela.

comprar_curso: Una función de Bloque de Transacción Programable (PTB) que permite a los usuarios comprar un curso. Maneja el pago, devuelve el cambio y otorga al comprador un NFT AccesoCurso.

Interactuando con el Contrato
Para usar estas funciones, debes utilizar la interfaz de línea de comandos (sui client).

Creando un Curso
Para crear un nuevo curso, usa el comando sui client call. El costo se especifica en MIST.

Bash

sui client call \
  --package <TU_ID_DEL_PAQUETE> \
  --module escuela \
  --function crear_curso \
  --args <ID_DE_LA_ESCUELA> 7 "Blockchain Avanzado" "Aprende a construir sobre Sui." 100 \
  --gas-budget 50000000
Comprando un Curso
Para comprar un curso, debes usar un PTB porque la transacción implica manejar un objeto Coin y recibir nuevos objetos (el cambio y el NFT del curso).

Bash

sui client execute-transaction-block \
--assign @escuela=object(<ID_DE_LA_ESCUELA>) \
--assign @pago=sui::coin::create_for_testing(500) \
--move-call <TU_ID_DEL_PAQUETE>::escuela::comprar_curso @escuela 7 @pago \
--transfer-objects @pago \
--gas-budget 50000000
Este proyecto proporciona una base sólida para construir aplicaciones más complejas en la blockchain de Sui.



Aprendizaje guiado

Gemini puede cometer er
