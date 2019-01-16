------------------------------------------------------------------
-- Create USER
------------------------------------------------------------------
DROP USER IF EXISTS "web_generic";
CREATE USER "web_generic" WITH LOGIN PASSWORD '1234'; 

------------------------------------------------------------------
-- Database: PECLWeb
------------------------------------------------------------------
DROP DATABASE IF EXISTS "PECLWeb";
CREATE DATABASE "PECLWeb";

------------------------------------------------------------------
-- Use Data base
------------------------------------------------------------------
\c "PECLWeb" 

------------------------------------------------------------------
-- Create EXTENSION
------------------------------------------------------------------
CREATE EXTENSION IF NOT EXISTS pgcrypto;

------------------------------------------------------------------
-- Table: public.aeropuertos
------------------------------------------------------------------
DROP TABLE IF EXISTS public.aeropuerto Restrict;
CREATE TABLE public.aeropuerto (
    nombre text COLLATE pg_catalog."default" NOT NULL,
    tasas real NOT NULL,
    CONSTRAINT aeropuertos_pkey PRIMARY KEY (nombre)
);

ALTER TABLE public.aeropuerto OWNER to web_generic;

INSERT INTO public.aeropuerto(nombre, tasas) VALUES ('Aeropuerto de Madrid', 15.0);
INSERT INTO public.aeropuerto(nombre, tasas) VALUES ('Aeropuerto de Barcelona', 35.0);
INSERT INTO public.aeropuerto(nombre, tasas) VALUES ('Aeropuerto de Palma de Mayorca', 15.0);
INSERT INTO public.aeropuerto(nombre, tasas) VALUES ('Aeropuerto Ibiza', 5.0);
INSERT INTO public.aeropuerto(nombre, tasas) VALUES ('Aeropuerto La Coruña', 85.0);
INSERT INTO public.aeropuerto(nombre, tasas) VALUES ('Aeropuerto JT', 2.0);
INSERT INTO public.aeropuerto(nombre, tasas) VALUES ('Aeroparque Jorge Newbery', 2.0);
INSERT INTO public.aeropuerto(nombre, tasas) VALUES ('Aeropuerto Ciudad de México', 6.0);
INSERT INTO public.aeropuerto(nombre, tasas) VALUES ('Aeropuerto de Los Ángeles LAX', 9.0);

------------------------------------------------------------------
-- Table: public.compras
------------------------------------------------------------------
DROP TABLE IF EXISTS public.compras Restrict;
CREATE TABLE public.compras (
    id_usuario text COLLATE pg_catalog."default" NOT NULL,
    id_compra text COLLATE pg_catalog."default" NOT NULL,
    total real NOT NULL,
    CONSTRAINT compras_pkey PRIMARY KEY (id_compra, id_usuario)
);

ALTER TABLE public.compras OWNER to web_generic;

------------------------------------------------------------------
-- Table: public.trayecto
------------------------------------------------------------------
DROP TABLE IF EXISTS public.trayecto Restrict;
CREATE TABLE public.trayecto (
    aer_origen text COLLATE pg_catalog."default" NOT NULL,
    aer_destino text COLLATE pg_catalog."default" NOT NULL,
    id_viaje SERIAL NOT NULL,
    precio real NOT NULL,
    fecha date,
    plazas integer,
    CONSTRAINT trayecto_pkey PRIMARY KEY (id_viaje)
);

ALTER TABLE public.trayecto OWNER to web_generic;

------------------------------------------------------------------
-- Table: public."Billete"
------------------------------------------------------------------
DROP TABLE IF EXISTS public.billete Restrict;
CREATE TABLE public.Billete (
    aer_origen text COLLATE pg_catalog."default" NOT NULL,
    aer_destino text COLLATE pg_catalog."default" NOT NULL,
    fecha timestamp without time zone NOT NULL,
    identificador varchar(6) NOT NULL,
    id_usuario varchar(9) NOT NULL,
    id_trayecto integer,
    CONSTRAINT usuario FOREIGN KEY (id_usuario)
        REFERENCES public.usuarios (DNI) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

ALTER TABLE public.billete OWNER to web_generic;

------------------------------------------------------------------
-- Table: public.usuarios
------------------------------------------------------------------
DROP TABLE IF EXISTS public.usuarios Restrict;
CREATE TABLE public.usuarios (
    nombre text COLLATE pg_catalog."default" NOT NULL,
    contrasena text COLLATE pg_catalog."default" NOT NULL,
    DNI varchar(9) NOT NULL,
	  ENABLED BOOLEAN NOT NULL,
    CONSTRAINT usuarios_pkey PRIMARY KEY (DNI)
);

ALTER TABLE public.usuarios OWNER to web_generic;

INSERT INTO public.usuarios(nombre, contrasena, DNI, enabled)  VALUES('user', '123', '00000000P', true);
INSERT INTO public.usuarios(nombre, contrasena, DNI, enabled) VALUES('admin', '123', '56708090F', true);

------------------------------------------------------------------
-- Table: public.usuarios
------------------------------------------------------------------
DROP TABLE IF EXISTS public.authorities Restrict;
CREATE TABLE public.authorities (
	  user_role_id SERIAL PRIMARY KEY,
    DNI varchar(9) NOT NULL,
    AUTHORITY varchar(20) NOT NULL,
	  UNIQUE (DNI, AUTHORITY),
	  CONSTRAINT authorities_fkey FOREIGN KEY (DNI) REFERENCES public.usuarios (DNI)
);

ALTER TABLE public.authorities OWNER to web_generic;

INSERT INTO public.authorities(DNI, AUTHORITY) VALUES('56708090F', 'ROLE_ADMIN');
INSERT INTO public.authorities(DNI, AUTHORITY) VALUES('00000000P', 'ROLE_USER');

