-- Crear la base de datos "nelo"
CREATE DATABASE IF NOT EXISTS nelo;

-- Usar la base de datos "nelo"
USE nelo;

-- Tabla Usuarios
CREATE TABLE Usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    correo_electronico VARCHAR(100) UNIQUE NOT NULL,
    contraseña VARCHAR(255) NOT NULL,
    nombre VARCHAR(100),
    apellido VARCHAR(100)
    -- Otros campos según sea necesario
);

-- Tabla Roles
CREATE TABLE Roles (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) UNIQUE NOT NULL,
    descripcion VARCHAR(255)
);

-- Tabla Permisos
CREATE TABLE Permisos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) UNIQUE NOT NULL,
    descripcion VARCHAR(255)
);

-- Tabla Roles_Permisos
CREATE TABLE Roles_Permisos (
    id_rol INT,
    id_permiso INT,
    FOREIGN KEY (id_rol) REFERENCES Roles(id),
    FOREIGN KEY (id_permiso) REFERENCES Permisos(id),
    PRIMARY KEY (id_rol, id_permiso)
);

-- Tabla Usuarios_Roles
CREATE TABLE Usuarios_Roles (
    id_usuario INT,
    id_rol INT,
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id),
    FOREIGN KEY (id_rol) REFERENCES Roles(id),
    PRIMARY KEY (id_usuario, id_rol)
);

-- Tabla Propietarios
CREATE TABLE Propietarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    telefono VARCHAR(15),
    direccion VARCHAR(255),
    correo_electronico VARCHAR(100) UNIQUE NOT NULL
);

-- Tabla Empresas
CREATE TABLE Empresas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    direccion VARCHAR(255),
    direccion_visible BOOLEAN NOT NULL DEFAULT TRUE,
    telefono VARCHAR(15)
);

-- Tabla Empresas_Propietarios
CREATE TABLE Empresas_Propietarios (
    id_empresa INT,
    id_propietario INT,
    FOREIGN KEY (id_empresa) REFERENCES Empresas(id),
    FOREIGN KEY (id_propietario) REFERENCES Propietarios(id),
    PRIMARY KEY (id_empresa, id_propietario)
);

-- Tabla Categorias
CREATE TABLE Categorias (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
);

-- Tabla Items
CREATE TABLE Items (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_empresa INT,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    tipo ENUM('producto', 'servicio') NOT NULL,
    id_categoria INT,
    disponibilidad ENUM('limitada', 'agotar_existencia', 'indefinida'),
    FOREIGN KEY (id_empresa) REFERENCES Empresas(id),
    FOREIGN KEY (id_categoria) REFERENCES Categorias(id)
);

-- Tabla Reacciones
CREATE TABLE Reacciones (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT,
    id_item INT,
    tipo ENUM('positiva', 'negativa') NOT NULL,
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id),
    FOREIGN KEY (id_item) REFERENCES Items(id)
);

-- Tabla Comentarios
CREATE TABLE Comentarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT,
    id_item INT,
    comentario TEXT NOT NULL,
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id),
    FOREIGN KEY (id_item) REFERENCES Items(id)
);

-- Tabla Reacciones_Comentarios
CREATE TABLE Reacciones_Comentarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT,
    id_comentario INT,
    tipo ENUM('positiva', 'negativa') NOT NULL,
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id),
    FOREIGN KEY (id_comentario) REFERENCES Comentarios(id)
);

-- Tabla Contactos
CREATE TABLE Contactos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_empresa INT,
    tipo_contacto ENUM('telefono', 'email', 'instagram', 'facebook', 'twitter', 'otro') NOT NULL,
    valor VARCHAR(255) NOT NULL,
    FOREIGN KEY (id_empresa) REFERENCES Empresas(id)
);

-- Tabla Ubicaciones
CREATE TABLE Ubicaciones (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_empresa INT,
    latitud DECIMAL(10, 8) NOT NULL,
    longitud DECIMAL(11, 8) NOT NULL,
    radio DECIMAL(10, 2),
    FOREIGN KEY (id_empresa) REFERENCES Empresas(id)
);

-- Inserciones de ejemplo para la tabla Usuarios
INSERT INTO Usuarios (correo_electronico, contraseña, nombre, apellido) VALUES
('usuario1@example.com', 'contraseña1', 'Juan', 'Pérez'),
('usuario2@example.com', 'contraseña2', 'María', 'González'),
('usuario3@example.com', 'contraseña3', 'Carlos', 'Martínez');

-- Inserciones de ejemplo para la tabla Roles
INSERT INTO Roles (nombre, descripcion) VALUES
('Administrador', 'Rol con permisos de administración'),
('Usuario', 'Rol estándar para usuarios del sistema'),
('Empresa', 'Rol para usuarios que gestionan empresas');

-- Inserciones de ejemplo para la tabla Permisos
INSERT INTO Permisos (nombre, descripcion) VALUES
('Crear Empresa', 'Permite crear una nueva empresa'),
('Editar Empresa', 'Permite editar la información de una empresa'),
('Eliminar Empresa', 'Permite eliminar una empresa'),
('Ver Empresas', 'Permite ver la lista de empresas'),
('Crear Producto', 'Permite crear un nuevo producto o servicio'),
('Editar Producto', 'Permite editar la información de un producto o servicio'),
('Eliminar Producto', 'Permite eliminar un producto o servicio'),
('Comentar', 'Permite agregar comentarios sobre productos o servicios'),
('Reaccionar', 'Permite reaccionar positivamente o negativamente a productos o servicios'),
('Ver Usuarios', 'Permite ver la lista de usuarios'),
('Asignar Roles', 'Permite asignar roles a los usuarios');

-- Inserciones de ejemplo para la tabla Roles_Permisos
-- Asignar permisos al rol Administrador
INSERT INTO Roles_Permisos (id_rol, id_permiso) VALUES
(1, 1), -- Crear Empresa
(1, 2), -- Editar Empresa
(1, 3), -- Eliminar Empresa
(1, 4), -- Ver Empresas
(1, 5), -- Crear Producto
(1, 6), -- Editar Producto
(1, 7), -- Eliminar Producto
(1, 8), -- Comentar
(1, 9), -- Reaccionar
(1, 10), -- Ver Usuarios
(1, 11); -- Asignar Roles

-- Asignar permisos al rol Usuario
INSERT INTO Roles_Permisos (id_rol, id_permiso) VALUES
(2, 4), -- Ver Empresas
(2, 8), -- Comentar
(2, 9); -- Reaccionar

-- Asignar permisos al rol Empresa
INSERT INTO Roles_Permisos (id_rol, id_permiso) VALUES
(3, 1), -- Crear Empresa
(3, 2), -- Editar Empresa
(3, 4), -- Ver Empresas
(3, 5), -- Crear Producto
(3, 6), -- Editar Producto
(3, 7); -- Eliminar Producto

-- Inserciones de ejemplo para la tabla Usuarios_Roles
-- Asignar el rol de Administrador al usuario con id 1
INSERT INTO Usuarios_Roles (id_usuario, id_rol) VALUES (1, 1);

-- Asignar el rol de Usuario al usuario con id 2
INSERT INTO Usuarios_Roles (id_usuario, id_rol) VALUES (2, 2);

-- Asignar el rol de Empresa al usuario con id 3
INSERT INTO Usuarios_Roles (id_usuario, id_rol) VALUES (3, 3);

-- Inserciones de ejemplo para la tabla Propietarios
INSERT INTO Propietarios (nombre, apellido, telefono, direccion, correo_electronico) VALUES
('Pedro', 'García', '555-1234', 'Calle Principal 123', 'pedro@example.com'),
('Ana', 'López', '555-5678', 'Avenida Central 456', 'ana@example.com');

-- Inserciones de ejemplo para la tabla Empresas
INSERT INTO Empresas (nombre, direccion, direccion_visible, telefono) VALUES
('Plomería Pérez', 'Calle del Agua 456', TRUE, '555-7890'),
('Electricidad López', 'Avenida de la Luz 789', FALSE, '555-2345');

-- Inserciones de ejemplo para la tabla Empresas_Propietarios
INSERT INTO Empresas_Propietarios (id_empresa, id_propietario) VALUES
(1, 1),
(2, 2);

-- Inserciones de ejemplo para la tabla Categorias
INSERT INTO Categorias (nombre) VALUES
('Plomería'),
('Electricidad'),
('Carpintería');

-- Inserciones de ejemplo para la tabla Items
INSERT INTO Items (id_empresa, nombre, descripcion, tipo, id_categoria, disponibilidad) VALUES
(1, 'Reparación de grifos', 'Reparación de todo tipo de grifos', 'servicio', 1, 'limitada'),
(2, 'Instalación eléctrica', 'Instalación de sistemas eléctricos', 'servicio', 2, 'agotar_existencia');

-- Inserciones de ejemplo para la tabla Reacciones
INSERT INTO Reacciones (id_usuario, id_item, tipo) VALUES
(2, 1, 'positiva'),
(3, 2, 'negativa');

-- Inserciones de ejemplo para la tabla Comentarios
INSERT INTO Comentarios (id_usuario, id_item, comentario) VALUES
(2, 1, 'Excelente servicio!'),
(3, 2, 'No quedé satisfecho con el trabajo.');

-- Inserciones de ejemplo para la tabla Reacciones_Comentarios
INSERT INTO Reacciones_Comentarios (id_usuario, id_comentario, tipo) VALUES
(1, 1, 'positiva'),
(2, 2, 'negativa');

-- Inserciones de ejemplo para la tabla Contactos
INSERT INTO Contactos (id_empresa, tipo_contacto, valor) VALUES
(1, 'telefono', '555-7890'),
(1, 'email', 'contacto@plomeriaperez.com'),
(1, 'facebook', 'https://facebook.com/plomeriaperez'),
(2, 'telefono', '555-2345'),
(2, 'email', 'contacto@electricidadlopez.com');

-- Inserciones de ejemplo para la tabla Ubicaciones
INSERT INTO Ubicaciones (id_empresa, latitud, longitud, radio) VALUES
(1, 19.432608, -99.133209, 5.0),
(2, 34.052235, -118.243683, 10.0);