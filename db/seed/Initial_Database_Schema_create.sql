CREATE TABLE Categories (
    media integer NOT NULL,
    id integer NOT NULL CONSTRAINT Categories_pk PRIMARY KEY,
    CONSTRAINT Media_Categories FOREIGN KEY (media)
    REFERENCES Media (id)
);

CREATE TABLE Media (
    id integer NOT NULL CONSTRAINT Media_pk PRIMARY KEY
);
