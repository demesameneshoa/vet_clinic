CREATE DATABASE vet_clinic;
CREATE TABLE animals (
    id Int GENERATED ALWAYS AS IDENTITY,
    name varchar(100),
    date_of_birth Date,
    escape_attempts Int,
    neutered boolean,
    weight_kg real
);

ALTER TABLE animals ADD species varchar(100);

CREATE TABLE owners (
    id Int GENERATED ALWAYS AS IDENTITY,
    full_name varchar(200),
    age Int,
    PRIMARY KEY (id)
);

CREATE TABLE species (
    id Int GENERATED ALWAYS AS IDENTITY,
    name varchar(200),
    PRIMARY KEY (id)
);
