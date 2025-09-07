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
