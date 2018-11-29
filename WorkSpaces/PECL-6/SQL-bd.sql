CREATE TABLE public.coches
(
    "nomCoche" text NOT NULL,
    "gananciaPotencia" integer NOT NULL,
    PRIMARY KEY ("nomCoche")
)
WITH (
    OIDS = FALSE
);

ALTER TABLE public.coches
    OWNER to postgres;
    
    
    
CREATE TABLE public.circuitos
(
    "nombreCircuito" text NOT NULL,
    ciudad text NOT NULL,
    pais text NOT NULL,
    "longVueltas" integer NOT NULL,
    "numVueltas" integer NOT NULL,
    "numCurvas" integer NOT NULL,
    PRIMARY KEY ("nombreCircuito")
)
WITH (
    OIDS = FALSE
);

ALTER TABLE public.circuitos
    OWNER to postgres;
