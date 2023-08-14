CREATE DATABASE vet_clinic;
CREATE TABLE animals (
    id Int GENERATED ALWAYS AS IDENTITY,
    name varchar(100),
    date_of_birth Date,
    escape_attempts Int,
    neutered boolean,
    weight_kg real
);
