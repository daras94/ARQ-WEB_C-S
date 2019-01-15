------------------------------------------------------------------
-- Create EXTENSION
------------------------------------------------------------------
CREATE EXTENSION IF NOT EXISTS pgcrypto;

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
-- Table: public.aeropuertos
------------------------------------------------------------------
DROP TABLE IF EXISTS public.aeropuerto Restrict;
CREATE TABLE public.aeropuerto (
    nombre text COLLATE pg_catalog."default" NOT NULL,
    tasas real NOT NULL,
    CONSTRAINT aeropuertos_pkey PRIMARY KEY (nombre)
);

ALTER TABLE public.aeropuertos OWNER to web_generic;

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
    identificador text COLLATE pg_catalog."default" NOT NULL,
    id_usuario text COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT usuario FOREIGN KEY (id_usuario)
        REFERENCES public.usuarios (DNI) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

ALTER TABLE public."Billete"
OWNER to postgres;

------------------------------------------------------------------
-- Table: public.usuarios
------------------------------------------------------------------
DROP TABLE IF EXISTS public.usuarios Restrict;
CREATE TABLE public.usuarios (
    nombre text COLLATE pg_catalog."default" NOT NULL,
    contrasena text COLLATE pg_catalog."default" NOT NULL,
    rango text COLLATE pg_catalog."default" NOT NULL,
    compras_totales integer,
    DNI varchar(9) NOT NULL,
	  ENABLED BOOLEAN NOT NULL,
    CONSTRAINT usuarios_pkey PRIMARY KEY (DNI),
    CONSTRAINT verificarnombre CHECK (nombre ~ '^([A-ZÁÉÍÓÚÑ][a-záéíóúñü]*\s)+\s*$'::text)
);

ALTER TABLE public.usuarios OWNER to web_generic;

INSERT INTO public.usuarios(nombre, contrasena, rango, compras_totales, DNI, enabled)  VALUES('user', '123', 'P', 0, '00000000P', true);
INSERT INTO public.usuarios(nombre, contrasena, rango, compras_totales, DNI, enabled) VALUES('admin', '123', 'P', 0, '56708090F', true);

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

------------------------------------------------------------------
-- Function: public.comprobar()
------------------------------------------------------------------
DROP FUNCTION IF EXISTS public.comprobar();
CREATE OR REPLACE FUNCTION public.comprobar()
  RETURNS trigger AS
$BODY$DECLARE letrasValidas CHAR(23);
	letraCorrecta CHAR;
	letraLeida CHAR(24);
	valor INTEGER;
	resto INTEGER;
BEGIN
	letrasValidas:='TRWAGMYFPDXBNJZSQVHLCKE';
	valor:=(CAST(substring(NEW.DNI,1,8)AS INTEGER));
	resto:=valor%23;
	letraleida:=substring(NEW.DNI,9,9);
	letraCorrecta := SUBSTR(letrasValidas, resto+1, 1);
	IF (letraCorrecta = letraLeida) THEN 
		RAISE NOTICE 'CORRECTO';
		RETURN new;
	ELSE 
		RAISE EXCEPTION 'ERROR';
		RETURN null;
	END IF;
END$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION public.comprobar() OWNER TO postgres;


------------------------------------------------------------------
-- Trigger: comprobardni
------------------------------------------------------------------
DROP TRIGGER IF EXISTS comprobardni ON public.usuarios;
CREATE TRIGGER comprobardni
    BEFORE INSERT OR UPDATE 
    ON public.usuarios
    FOR EACH ROW
EXECUTE PROCEDURE public.comprobar();

COMMENT ON COLUMN public.usuarios.compras_totales IS 'Compras totales para ver si hay que aplicar el descuento';
