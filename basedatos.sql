-- CREACION DE USUARIO 
CREATE USER 'proyectobd'@'localhost' identified by 'umg';

-- CREACION DE BASE DE DATOS 
CREATE DATABASE proyectobd1 CHARACTER SET utf8 COLLATE utf8_general_ci;

-- CONSEDER PERMISOS AL USUARIO
GRANT ALL PRIVILEGES ON proyectobd1.* TO proyectobd@localhost;
FLUSH PRIVILEGES;

-- CREACION DE TABLA PERSONA 
CREATE TABLE persona(
	id_persona INTEGER NOT NULL AUTO_INCREMENT,
    dpi INTEGER NOT NULL UNIQUE,
    nombre VARCHAR(250) NOT NULL,
    apellido VARCHAR(250) NOT NULL,
    direccion VARCHAR(250) NOT NULL,
    nit VARCHAR(20) NOT NULL UNIQUE,
    PRIMARY KEY (id_persona)
);

-- CREACION DE TABLA PROVEEDOR 
CREATE TABLE proveedor(
	id_proveedor INTEGER NOT NULL AUTO_INCREMENT, 
    nombre VARCHAR(250) NOT NULL UNIQUE,
    direccion VARCHAR(250) NOT NULL UNIQUE,
	PRIMARY KEY (id_proveedor)
);

-- CREACION DE TABLA EMPRESA 
CREATE TABLE empresa(
	id_empresa INTEGER NOT NULL AUTO_INCREMENT, 
    nombre VARCHAR (250) NOT NULL UNIQUE,
    direccion VARCHAR (250) NOT NULL UNIQUE,
    nit VARCHAR(20) NOT NULL UNIQUE,
    PRIMARY KEY (id_empresa)
);

-- CREACION DE TABLA TELEFONO PERSONAS
CREATE TABLE telefono_persona(
	id_telefono_persona INTEGER NOT NULL AUTO_INCREMENT,
    numero INTEGER NOT NULL UNIQUE,
    id_persona INTEGER NOT NULL,
    PRIMARY KEY (id_telefono_persona),
    FOREIGN KEY (id_persona) REFERENCES persona(id_persona) ON DELETE CASCADE ON UPDATE CASCADE
);

-- CREACION DE TABLA TELEFONO PROVEEDOR
CREATE TABLE telefono_proveedor(
	id_telefono_proveedor INTEGER NOT NULL AUTO_INCREMENT,
    numero INTEGER NOT NULL UNIQUE,
    id_proveedor INTEGER NOT NULL,
    PRIMARY KEY (id_telefono_proveedor),
    FOREIGN KEY (id_proveedor) REFERENCES proveedor(id_proveedor) ON DELETE CASCADE ON UPDATE CASCADE
);

-- CREACION DE TABLA HORARIO
CREATE TABLE horario (
	id_horario INTEGER NOT NULL AUTO_INCREMENT, 
    entrada TIME NOT NULL,
    salida TIME NOT NULL, 
    PRIMARY KEY (id_horario)
);

-- CREACION DE TABLA PUESTO 
CREATE TABLE puesto(
	id_puesto INTEGER NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(250) NOT NULL UNIQUE,
    sueldo FLOAT NOT NULL,
    PRIMARY KEY (id_puesto)
);

-- CREACION DE TABLA EMPLEADO 
CREATE TABLE empleado (
	id_empleado INTEGER NOT NULL AUTO_INCREMENT,
	contrasenia VARCHAR (250) NOT NULL,
    fecha_inicio DATE NOT NULL, 
    fecha_fin DATE, 
    id_persona INTEGER NOT NULL, 
    id_puesto INTEGER NOT NULL, 
    id_horario INTEGER NOT NULL,
    PRIMARY KEY (id_empleado),
    FOREIGN KEY (id_persona) REFERENCES persona(id_persona) ON DELETE CASCADE ON UPDATE CASCADE, 
    FOREIGN KEY (id_puesto) REFERENCES puesto(id_puesto) ON DELETE CASCADE  ON UPDATE CASCADE,
    FOREIGN KEY (id_horario) REFERENCES horario(id_horario) ON DELETE CASCADE ON UPDATE CASCADE
);

-- CREACION DE TABLA CONTROL DE ASISTENCIA
CREATE TABLE asistencia(
	id_asistencia INTEGER NOT NULL AUTO_INCREMENT, 
    hora_entrada TIME NOT NULL,
    hora_salida TIME,
    fecha DATE NOT NULL, 
    id_empleado INTEGER NOT NULL,
    PRIMARY KEY (id_asistencia),
    FOREIGN KEY (id_empleado) REFERENCES empleado(id_empleado) ON DELETE CASCADE ON UPDATE CASCADE
);

-- CREACION DE TABLA TIPO DE INASISTENCIA 
CREATE TABLE tipo_inasistencia(
	id_tipo_inasistencia INTEGER NOT NULL AUTO_INCREMENT, 
    tipo VARCHAR(250), 
    PRIMARY KEY (id_tipo_inasistencia)
);

-- CREACION DE TABLA INASISTENCIA
CREATE TABLE inasistencia(
	id_inasistencia INTEGER NOT NULL AUTO_INCREMENT,
    fecha DATE NOT NULL,
    id_tipo_inasistencia INTEGER NOT NULL, 
    id_empleado INTEGER NOT NULL, 
    PRIMARY KEY (id_inasistencia),
    FOREIGN KEY (id_empleado) REFERENCES empleado(id_empleado) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_tipo_inasistencia) REFERENCES tipo_inasistencia(id_tipo_inasistencia) ON DELETE CASCADE ON UPDATE CASCADE
);

-- CREACION DE TABLA EQUIPO 
CREATE TABLE equipo (
	id_equipo INTEGER NOT NULL AUTO_INCREMENT, 
    nombre VARCHAR(250) NOT NULL,
    id_empleado INTEGER NOT NULL,
    PRIMARY KEY (id_equipo),
    FOREIGN KEY (id_empleado) REFERENCES empleado(id_empleado) ON DELETE CASCADE ON UPDATE CASCADE
);

-- CREACION DE TABLA DETALLE EQUIPO
CREATE TABLE detalle_equipo(
	id_detalle_equipo INTEGER NOT NULL AUTO_INCREMENT,
    id_equipo INTEGER NOT NULL,
    id_empleado INTEGER NOT NULL, 
    PRIMARY KEY (id_detalle_equipo),
    FOREIGN KEY (id_equipo) REFERENCES equipo(id_equipo) ON DELETE CASCADE ON UPDATE CASCADE, 
    FOREIGN KEY (id_empleado) REFERENCES empleado(id_empleado) ON DELETE CASCADE ON UPDATE CASCADE
);

-- CREACION DE TABLA VACACIONES 
CREATE TABLE vacaciones(
	id_vacaciones INTEGER NOT NULL AUTO_INCREMENT,
    fecha_salida DATE NOT NULL,
    fecha_entrada DATE NOT NULL,
    id_empleado INTEGER NOT NULL,
    PRIMARY KEY (id_vacaciones),
    FOREIGN KEY (id_empleado) REFERENCES empleado(id_empleado) ON DELETE CASCADE ON UPDATE CASCADE
);

-- CREACION DE TABLA PAGO 
CREATE TABLE pago(
	id_pago INTEGER NOT NULL AUTO_INCREMENT,
    pago FLOAT NOT NULL,
    fecha DATE NOT NULL,
    id_empleado INTEGER NOT NULL,
    PRIMARY KEY (id_pago),
    FOREIGN KEY (id_empleado) REFERENCES empleado(id_empleado) ON DELETE CASCADE ON UPDATE CASCADE
);

-- CREACION DE TABLA DETALLE DE PAGO
CREATE TABLE detalle_pago(
	id_detalle_pago INTEGER NOT NULL AUTO_INCREMENT,
    detalle VARCHAR(400) NOT NULL,
    monto FLOAT NOT NULL,
    id_pago INTEGER NOT NULL, 
    PRIMARY KEY (id_detalle_pago),
    FOREIGN KEY (id_pago) REFERENCES pago(id_pago) ON DELETE CASCADE ON UPDATE CASCADE
);

-- CREACION DE TABLA NOMBRE DE PIEZA
CREATE TABLE nombre_pieza(
	id_nombre_pieza INTEGER NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(250),
    PRIMARY KEY (id_nombre_pieza)
);

-- CREACION DE TABLA ESTADO DE PIEZA
CREATE TABLE estado_pieza(
	id_estado_pieza INTEGER NOT NULL AUTO_INCREMENT,
    estado VARCHAR(250) UNIQUE,
    PRIMARY KEY (id_estado_pieza)
);

-- CREACION DE TABLA MARCA DE PIEZA
CREATE TABLE marca_pieza(
	id_marca_pieza INTEGER NOT NULL AUTO_INCREMENT,
    marca VARCHAR(250) NOT NULL UNIQUE,
    PRIMARY KEY (id_marca_pieza)
);

-- CREACION DE TABLA CARRO 
CREATE TABLE carro(
	id_carro INTEGER NOT NULL AUTO_INCREMENT,
	marca VARCHAR(250) NOT NULL,
    modelo VARCHAR(250) NOT NULL,
    linea VARCHAR(250) NOT NULL,
    PRIMARY KEY (id_carro)
);

-- CREACION DE TABLA PIEZA 
CREATE TABLE pieza (
	id_pieza INTEGER NOT NULL AUTO_INCREMENT,
    numero_pieza INTEGER NOT NULL,
    precio_compra FLOAT NOT NULL,
    precio_venta FLOAT NOT NULL,
    id_proveedor INTEGER NOT NULL,
    id_nombre_pieza INTEGER NOT NULL,
    id_estado_pieza INTEGER NOT NULL,
    id_marca_pieza INTEGER NOT NULL,
    id_carro INTEGER NOT NULL,
    PRIMARY KEY (id_pieza),
    FOREIGN KEY (id_proveedor) REFERENCES proveedor(id_proveedor) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_nombre_pieza) REFERENCES nombre_pieza(id_nombre_pieza) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_estado_pieza) REFERENCES estado_pieza(id_estado_pieza) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_marca_pieza) REFERENCES marca_pieza(id_marca_pieza) ON DELETE CASCADE ON UPDATE CASCADE, 
    FOREIGN KEY (id_carro) REFERENCES carro(id_carro) ON DELETE CASCADE ON UPDATE CASCADE
);

-- CREACION DE TABLA INVENTARIO PIEZA
CREATE TABLE inventario_pieza(
	id_inventario_pieza INTEGER NOT NULL AUTO_INCREMENT,
    cantidad INTEGER NOT NULL,
    id_pieza INTEGER NOT NULL, 
    PRIMARY KEY (id_inventario_pieza),
    FOREIGN KEY (id_pieza) REFERENCES pieza(id_pieza) ON DELETE CASCADE ON UPDATE CASCADE
);

-- CREACION DE TABLA PRODUCTO 
CREATE TABLE producto (
	id_producto INTEGER NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(250) NOT NULL,
    precio FLOAT NOT NULL,
    descripcion VARCHAR(250),
    id_proveedor INTEGER NOT NULL,
    PRIMARY KEY (id_producto),
    FOREIGN KEY (id_proveedor) REFERENCES proveedor(id_proveedor) ON DELETE CASCADE ON UPDATE CASCADE
);

-- CREACION DE TABLA INVENTARIO GENERAL 
CREATE TABLE inventario_general(
	id_inventario_general INTEGER NOT NULL AUTO_INCREMENT,
    cantidad INTEGER NOT NULL, 
    id_producto INTEGER NOT NULL, 
    PRIMARY KEY (id_inventario_general),
    FOREIGN KEY (id_producto) REFERENCES producto(id_producto) ON DELETE CASCADE ON UPDATE CASCADE
);

-- CREACION DE TABLA TIPO DE FACTURA 
CREATE TABLE tipo_factura(
	id_tipo_factura INTEGER NOT NULL AUTO_INCREMENT,
    tipo VARCHAR(250) NOT NULL UNIQUE,
    PRIMARY KEY (id_tipo_factura)
);

-- CREACION DE TABLA TIPO DE PAGO 
CREATE TABLE tipo_pago(
	id_tipo_pago INTEGER NOT NULL AUTO_INCREMENT, 
    tipo VARCHAR(250) NOT NULL UNIQUE,
    PRIMARY KEY (id_tipo_pago)
);

-- CREACION DE TABLA FACTURA GENERAL 
CREATE TABLE factura_general (
	id_factura_general INTEGER NOT NULL AUTO_INCREMENT,
    fecha DATE NOT NULL,
    total FLOAT NOT NULL, 
	id_empleado INTEGER NOT NULL, 
    id_empresa INTEGER NOT NULL, 
    id_tipo_pago INTEGER NOT NULL, 
    id_tipo_factura INTEGER NOT NULL,
    PRIMARY KEY (id_factura_general),
    FOREIGN KEY (id_empleado) REFERENCES empleado(id_empleado) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_empresa) REFERENCES empresa(id_empresa) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_tipo_pago) REFERENCES tipo_pago(id_tipo_pago) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_tipo_factura) REFERENCES tipo_factura(id_tipo_factura) ON DELETE CASCADE ON UPDATE CASCADE
); 


-- CREACION DE TABLA FACTURA COMPRA
CREATE TABLE factura_compra(
	id_factura_compra INTEGER NOT NULL AUTO_INCREMENT,
    id_proveedor INTEGER NOT NULL,
    id_factura_general INTEGER NOT NULL, 
    PRIMARY KEY (id_factura_compra),
    FOREIGN KEY (id_proveedor) REFERENCES proveedor(id_proveedor) ON DELETE CASCADE ON UPDATE CASCADE, 
    FOREIGN KEY (id_factura_general) REFERENCES factura_general(id_factura_general) ON DELETE CASCADE ON UPDATE CASCADE
);

-- CREACION DE TABLA DETALLE FACTURA COMPRA 
CREATE TABLE detalle_factura_compra(
	id_detalle_factura_compra INTEGER NOT NULL AUTO_INCREMENT,
	cantidad INTEGER NOT NULL, 
    id_factura_general INTEGER NOT NULL, 
    id_pieza INTEGER NOT NULL, 
    PRIMARY KEY (id_detalle_factura_compra),
    FOREIGN KEY (id_factura_general) REFERENCES factura_general(id_factura_general) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_pieza) REFERENCES pieza(id_pieza) ON DELETE CASCADE ON UPDATE CASCADE
);

-- CREACION DE TABLA FACTURA VENTA
CREATE TABLE factura_venta(
	id_factura_venta INTEGER NOT NULL AUTO_INCREMENT,
    id_persona INTEGER NOT NULL,
    id_factura_general INTEGER NOT NULL,
    PRIMARY KEY (id_factura_venta),
    FOREIGN KEY (id_persona) REFERENCES persona(id_persona) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_factura_general) REFERENCES factura_general(id_factura_general) ON DELETE CASCADE ON UPDATE CASCADE 
);

-- CREACION DE TABLA DETALLE FACTURA VENTA 
CREATE TABLE detalle_factura_venta(
	id_detalle_factura_venta INTEGER NOT NULL AUTO_INCREMENT,
	cantidad INTEGER NOT NULL, 
    id_factura_general INTEGER NOT NULL, 
    id_pieza INTEGER NOT NULL, 
    PRIMARY KEY (id_detalle_factura_venta),
    FOREIGN KEY (id_factura_general) REFERENCES factura_general(id_factura_general) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_pieza) REFERENCES pieza(id_pieza) ON DELETE CASCADE ON UPDATE CASCADE
);

-- CREACION DE TABLA FACTURA PRODUCTO
CREATE TABLE factura_producto(
	id_factura_producto INTEGER NOT NULL AUTO_INCREMENT,
    id_proveedor INTEGER NOT NULL, 
	id_factura_general INTEGER NOT NULL, 
    PRIMARY KEY (id_factura_producto),
    FOREIGN KEY (id_proveedor) REFERENCES proveedor(id_proveedor) ON DELETE CASCADE ON UPDATE CASCADE, 
    FOREIGN KEY (id_factura_general) REFERENCES factura_general(id_factura_general) ON DELETE CASCADE ON UPDATE CASCADE 
);

-- CREACION DE TABLA DETALLE FACTURA PRODUCTO 
CREATE TABLE detalle_factura_producto(
	id_detalle_factura_producto INTEGER NOT NULL AUTO_INCREMENT, 
    cantidad INTEGER NOT NULL,
    id_factura_producto INTEGER NOT NULL, 
    id_pieza INTEGER NOT NULL,
    PRIMARY KEY (id_detalle_factura_producto),
    FOREIGN KEY (id_factura_producto) REFERENCES factura_producto(id_factura_producto) ON DELETE CASCADE ON UPDATE CASCADE, 
    FOREIGN KEY (id_pieza) REFERENCES pieza(id_pieza) ON DELETE CASCADE ON UPDATE CASCADE
);

-- CREACION DE TABLA DETALLE EXTRAORDINARIA
CREATE TABLE detalle_factura_extraordinaria(
	id_detalle_factura_extraordinaria INTEGER NOT NULL AUTO_INCREMENT, 
    cantidad INTEGER NOT NULL,
    descripcion VARCHAR(400) NOT NULL, 
    id_factura_general INTEGER NOT NULL,
    PRIMARY KEY (id_detalle_factura_extraordinaria),
    FOREIGN KEY (id_factura_general) REFERENCES factura_general(id_factura_general) ON DELETE CASCADE ON UPDATE CASCADE
);


-- CREACION DE TABLA TIPO TRANSACCION 
CREATE TABLE tipo_transaccion(
	id_tipo_transaccion INTEGER NOT NULL AUTO_INCREMENT,
    tipo VARCHAR(250) NOT NULL UNIQUE,
    PRIMARY KEY (id_tipo_transaccion)
);

-- CREACION DE TABLA CAPITAL 
CREATE TABLE tipo_capital(
	id_capital INTEGER NOT NULL AUTO_INCREMENT,
    total FLOAT NOT NULL,
    monto FLOAT NOT NULL, 
    fecha DATE NOT NULL,
    id_tipo_transaccion INTEGER NOT NULL, 
    PRIMARY KEY (id_capital),
    FOREIGN KEY (id_tipo_transaccion) REFERENCES tipo_transaccion(id_tipo_transaccion) ON DELETE CASCADE ON UPDATE CASCADE 
); 

