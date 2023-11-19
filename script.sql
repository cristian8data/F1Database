drop table if exists circuitos cascade;
drop table if exists carreras cascade;
drop table if exists participantes cascade;
drop table if exists pilotos cascade;
drop table if exists escuderías cascade;
drop table if exists empleados cascade;
drop table if exists esponsores cascade;
drop table if exists compañías cascade;

CREATE TABLE circuitos (
    nombre_circuito character varying(50),	
    ciudad character varying(20) NOT NULL,
	país character varying NOT NULL,
	longitud numeric(4,0),
	vueltas numeric(3,0),
	año_inicio numeric (4,0),
    CONSTRAINT circuitos_pkey PRIMARY KEY (nombre_circuito)
);

CREATE TABLE carreras (    
    fecha_carrera date,
    nombre_circuito character varying(50) REFERENCES circuitos(nombre_circuito),
	CONSTRAINT carreras_pkey PRIMARY KEY (fecha_carrera)
);

CREATE TABLE escuderías (    
    nombre_escudería character varying(30),
    jefe character varying(30) UNIQUE,
	sede character varying(30),
	tipo_coche character varying(30),
	campeonatos numeric(2,0),
    CONSTRAINT escuderías_pkey PRIMARY KEY (nombre_escudería)
);

CREATE TABLE empleados (    
    cod_identificación numeric(4,0),
    nombre_emp character varying(30),
	trabajo character varying(30),
	nombre_escudería character varying(30) REFERENCES escuderías (nombre_escudería),
    CONSTRAINT empleados_pkey PRIMARY KEY (cod_identificación)
);

CREATE TABLE pilotos (    
    dorsal numeric(2,0),
    nombre character varying(30),
	apellido character varying(30),
	edad numeric(2,0),
	estatura numeric (3,0),
	nacionalidad character varying(30),
	campeonatos numeric(2,0),
	podios numeric(3,0),
	puntos numeric(6,2),
    nombre_escudería character varying(30) REFERENCES escuderías (nombre_escudería),
    CONSTRAINT pilotos_pkey PRIMARY KEY (dorsal)
);

CREATE TABLE compañías (    
    CIF numeric(5,0),
    nombre_compañía character varying(30),
    CONSTRAINT compañías_pkey PRIMARY KEY (CIF)
);

CREATE TABLE participantes (
    pos_ini numeric(2,0),
    pos_fin numeric(2,0),
    fecha_carrera date REFERENCES carreras(fecha_carrera),
    dorsal numeric(4,0) REFERENCES pilotos(dorsal),
    CONSTRAINT participantes_pkey PRIMARY KEY (fecha_carrera, dorsal)
);

CREATE TABLE esponsores (    
    coste numeric(4,2),
    duración numeric(2,0),
	dorsal numeric(4,0) REFERENCES pilotos(dorsal),
	CIF numeric(5,0) REFERENCES compañías (CIF),
    CONSTRAINT esponsores_pkey PRIMARY KEY (dorsal, CIF)
);





INSERT INTO circuitos VALUES ('Circuito Internacional de Bareín', 'Manama', 'Bareín', 5.412, 57, 2004);
INSERT INTO circuitos VALUES ('Circuito de Cataluña', 'Montmeló', 'España', 4.675, 66, 1991);
INSERT INTO circuitos VALUES ('Circuito de Mónaco', 'Mónaco', 'Principado de Mónaco', 3.337, 78, 1950);

INSERT INTO carreras VALUES (to_date('28/03/2021','dd/mm/yy'), 'Circuito Internacional de Bareín');
INSERT INTO carreras VALUES (to_date('09/05/2021','dd/mm/yy'), 'Circuito de Cataluña');
INSERT INTO carreras VALUES (to_date('23/05/2021','dd/mm/yy'), 'Circuito de Mónaco');

INSERT INTO escuderías VALUES ('Mercedes', 'Toto Wolff', 'Reino Unido', 'Mercedes', 8);
INSERT INTO escuderías VALUES ('Red Bull Racing', 'Christian Horner', 'Reino Unido', 'Honda', 4);
INSERT INTO escuderías VALUES ('Ferrari', 'Mattia Binotto', 'Italia', 'Ferrari', 16);
INSERT INTO escuderías VALUES ('McLaren', 'Andreas Seidl', 'Reino Unido', 'Mercedes', 8);
INSERT INTO escuderías VALUES ('Alpine', 'Davide Brivio', 'Reino Unido', 'Renault', 2);

INSERT INTO empleados VALUES (1110, 'Thomas', 'Mecánico', 'Mercedes');
INSERT INTO empleados VALUES (1111, 'Cowell', 'Mecánico', 'Mercedes');
INSERT INTO empleados VALUES (1112, 'Willis', 'Mecánico', 'Mercedes');
INSERT INTO empleados VALUES (1113, 'Allison', 'Ingeniero', 'Mercedes');
INSERT INTO empleados VALUES (1114, 'Elliot', 'Ingeniero', 'Mercedes');
INSERT INTO empleados VALUES (1115, 'Shannon', 'Médico', 'Mercedes');
INSERT INTO empleados VALUES (2220, 'Fallows', 'Mecánico', 'Red Bull Racing');
INSERT INTO empleados VALUES (2221, 'Monaghan', 'Mecánico', 'Red Bull Racing');
INSERT INTO empleados VALUES (2222, 'Wheatley', 'Ingeniero', 'Red Bull Racing');
INSERT INTO empleados VALUES (2223, 'Marshall', 'Ingeniero', 'Red Bull Racing');
INSERT INTO empleados VALUES (2224, 'Newey', 'Médico', 'Red Bull Racing');
INSERT INTO empleados VALUES (3330, 'Clark', 'Mecánico', 'Ferrari');
INSERT INTO empleados VALUES (3331, 'Mekies', 'Mecánico', 'Ferrari');
INSERT INTO empleados VALUES (3332, 'Adami', 'Ingeniero', 'Ferrari');
INSERT INTO empleados VALUES (3333, 'Clear', 'Médico', 'Ferrari');
INSERT INTO empleados VALUES (4440, 'Roberts', 'Mecánico', 'McLaren');
INSERT INTO empleados VALUES (4441, 'Stella', 'Mecánico', 'McLaren');
INSERT INTO empleados VALUES (4442, 'Ferran', 'Ingeniero', 'McLaren');
INSERT INTO empleados VALUES (4443, 'Brown', 'Médico', 'McLaren');
INSERT INTO empleados VALUES (5550, 'Taffin', 'Mecánico', 'Alpine');
INSERT INTO empleados VALUES (5551, 'Brivio', 'Ingeniero', 'Alpine');
INSERT INTO empleados VALUES (5552, 'Fry', 'Médico', 'Alpine');

INSERT INTO pilotos VALUES (44, 'Lewis', 'Hamilton', 36, 174, 'Británico', 7, 182, 387.5, 'Mercedes');
INSERT INTO pilotos VALUES (77, 'Valtteri', 'Bottas', 32, 173, 'Finlandés', 0, 67, 226, 'Mercedes');
INSERT INTO pilotos VALUES (33, 'Max', 'Verstappen', 24, 181, 'Holandés', 1, 60, 395.5, 'Red Bull Racing');
INSERT INTO pilotos VALUES (11, 'Sergio', 'Pérez', 31, 173, 'Mejicano', 0, 15, 190, 'Red Bull Racing');
INSERT INTO pilotos VALUES (55, 'Carlos', 'Sainz', 27, 178, 'Español', 0, 6, 164.5, 'Ferrari');
INSERT INTO pilotos VALUES (16, 'Charles', 'Leclerc', 24, 180, 'Monegasco', 0, 13, 159, 'Ferrari');
INSERT INTO pilotos VALUES (3, 'Daniel', 'Ricciardo', 32, 180, 'Australiano', 0, 32, 115, 'McLaren');
INSERT INTO pilotos VALUES (4, 'Lando', 'Norris', 22, 170, 'Británico', 0, 5, 160, 'McLaren');
INSERT INTO pilotos VALUES (14, 'Fernando', 'Alonso', 40, 171, 'Español', 2, 98, 81, 'Alpine');
INSERT INTO pilotos VALUES (31, 'Esteban', 'Ocon', 25, 186, 'Británico', 0, 2, 74, 'Alpine');

INSERT INTO compañías VALUES (4203, 'Petronas');
INSERT INTO compañías VALUES (4205, 'Hewlett Packard');
INSERT INTO compañías VALUES (4208, 'UBS');
INSERT INTO compañías VALUES (5306, 'TagHeuer');
INSERT INTO compañías VALUES (5309, 'Mobil1');
INSERT INTO compañías VALUES (6110, 'Ups');
INSERT INTO compañías VALUES (7410, 'Dell');
INSERT INTO compañías VALUES (8888, 'Castrol');

INSERT INTO participantes VALUES (2, 1, to_date('28/03/2021','dd/mm/yy'), 44);
INSERT INTO participantes VALUES (3, 3, to_date('28/03/2021','dd/mm/yy'), 77);
INSERT INTO participantes VALUES (1, 2, to_date('28/03/2021','dd/mm/yy'), 33);
INSERT INTO participantes VALUES (11, 5, to_date('28/03/2021','dd/mm/yy'), 11);
INSERT INTO participantes VALUES (8, 8, to_date('28/03/2021','dd/mm/yy'), 55);
INSERT INTO participantes VALUES (4, 6, to_date('28/03/2021','dd/mm/yy'), 16);
INSERT INTO participantes VALUES (6, 7, to_date('28/03/2021','dd/mm/yy'), 3);
INSERT INTO participantes VALUES (7, 4, to_date('28/03/2021','dd/mm/yy'), 4);
INSERT INTO participantes VALUES (9, NULL, to_date('28/03/2021','dd/mm/yy'), 14);
INSERT INTO participantes VALUES (16, 13, to_date('28/03/2021','dd/mm/yy'), 31);
INSERT INTO participantes VALUES (1, 1, to_date('09/05/2021','dd/mm/yy'), 44);
INSERT INTO participantes VALUES (3, 3, to_date('09/05/2021','dd/mm/yy'), 77);
INSERT INTO participantes VALUES (2, 2, to_date('09/05/2021','dd/mm/yy'), 33);
INSERT INTO participantes VALUES (8, 5, to_date('09/05/2021','dd/mm/yy'), 11);
INSERT INTO participantes VALUES (6, 7, to_date('09/05/2021','dd/mm/yy'), 55);
INSERT INTO participantes VALUES (4, 4, to_date('09/05/2021','dd/mm/yy'), 16);
INSERT INTO participantes VALUES (7, 6, to_date('09/05/2021','dd/mm/yy'), 3);
INSERT INTO participantes VALUES (9, 8, to_date('09/05/2021','dd/mm/yy'), 4);
INSERT INTO participantes VALUES (10, 17, to_date('09/05/2021','dd/mm/yy'), 14);
INSERT INTO participantes VALUES (5, 9, to_date('09/05/2021','dd/mm/yy'), 31);
INSERT INTO participantes VALUES (7, 7, to_date('23/05/2021','dd/mm/yy'), 44);
INSERT INTO participantes VALUES (3, NULL, to_date('23/05/2021','dd/mm/yy'), 77);
INSERT INTO participantes VALUES (2, 1, to_date('23/05/2021','dd/mm/yy'), 33);
INSERT INTO participantes VALUES (9, 4, to_date('23/05/2021','dd/mm/yy'), 11);
INSERT INTO participantes VALUES (4, 2, to_date('23/05/2021','dd/mm/yy'), 55);
INSERT INTO participantes VALUES (1, NULL, to_date('23/05/2021','dd/mm/yy'), 16);
INSERT INTO participantes VALUES (12, 12, to_date('23/05/2021','dd/mm/yy'), 3);
INSERT INTO participantes VALUES (5, 3, to_date('23/05/2021','dd/mm/yy'), 4);
INSERT INTO participantes VALUES (17, 13, to_date('23/05/2021','dd/mm/yy'), 14);
INSERT INTO participantes VALUES (11, 9, to_date('23/05/2021','dd/mm/yy'), 31);

INSERT INTO esponsores VALUES (16, 4, 44, 4208);
INSERT INTO esponsores VALUES (3, 2, 44, 4203);
INSERT INTO esponsores VALUES (2, 2, 44, 4205);
INSERT INTO esponsores VALUES (3, 2, 77, 4203);
INSERT INTO esponsores VALUES (2, 2, 77, 4205);
INSERT INTO esponsores VALUES (13, 3, 33, 5306);
INSERT INTO esponsores VALUES (6, 4, 33, 5309);
INSERT INTO esponsores VALUES (5, 3, 11, 5306);
INSERT INTO esponsores VALUES (2, 4, 11, 5309);
INSERT INTO esponsores VALUES (9, 2, 16, 6110);
INSERT INTO esponsores VALUES (5, 2, 55, 6110);
INSERT INTO esponsores VALUES (10, 5, 4, 7410);
INSERT INTO esponsores VALUES (3, 3, 3, 7410);
INSERT INTO esponsores VALUES (6, 2, 14, 8888);
INSERT INTO esponsores VALUES (8, 2, 31, 8888);





















