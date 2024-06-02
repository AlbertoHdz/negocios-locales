# Proyecto de Gestión de Empresas y Servicios

## Descripción
Este proyecto es una aplicación web diseñada para gestionar empresas y sus servicios, así como permitir a los usuarios buscar y revisar los servicios ofrecidos por estas empresas. Proporciona una plataforma para que las empresas muestren sus servicios y para que los usuarios puedan interactuar con ellos.

## Estructura de las Tablas

### Usuarios
- Almacena información básica de los usuarios.
- Campos: id, correo_electronico, contraseña, nombre, apellido.

### Roles
- Define los diferentes roles que pueden tener los usuarios.
- Campos: id, nombre, descripcion.

### Permisos
- Define los diferentes permisos que pueden tener los roles.
- Campos: id, nombre, descripcion.

### Roles_Permisos
- Relación muchos a muchos entre roles y permisos.
- Campos: id_rol, id_permiso.

### Usuarios_Roles
- Relación muchos a muchos entre usuarios y roles.
- Campos: id_usuario, id_rol.

### Propietarios
- Información sobre los propietarios de las empresas.
- Campos: id, nombre, apellido, telefono, direccion, correo_electronico.

### Empresas
- Información sobre las empresas.
- Campos: id, nombre, direccion, direccion_visible, telefono.

### Empresas_Propietarios
- Relación muchos a muchos entre empresas y propietarios.
- Campos: id_empresa, id_propietario.

### Categorias
- Información sobre las categorías de productos/servicios.
- Campos: id, nombre.

### Items
- Información sobre productos/servicios ofrecidos por las empresas.
- Campos: id, id_empresa, nombre, descripcion, tipo, id_categoria, disponibilidad.


### Reacciones
- Información sobre las reacciones de los usuarios a los items.
- Campos: id, id_usuario_cliente, id_item, tipo, fecha.

### Comentarios
- Información sobre los comentarios de los usuarios sobre los items.
- Campos: id, id_usuario_cliente, id_item, comentario, fecha.

### Reacciones_Comentarios
- Información sobre las reacciones de los usuarios a los comentarios.
- Campos: id, id_usuario_cliente, id_comentario, tipo, fecha.

### Contactos
- Información de contacto adicional para las empresas.
- Campos: id, id_empresa, tipo_contacto, valor.

### Ubicaciones
- Información de ubicación geoespacial para las empresas.
- Campos: id, id_empresa, latitud, longitud, radio.

## Funcionalidades
- Registro e inicio de sesión de usuarios.
- Administración de roles y permisos.
- Gestión de empresas y sus propietarios.
- Catálogo de servicios ofrecidos por las empresas.
- Búsqueda y visualización de servicios por categoría.
- Comentarios y reacciones de los usuarios sobre los servicios.
- Información de contacto para las empresas.
- Integración de ubicaciones geoespaciales para las empresas.


