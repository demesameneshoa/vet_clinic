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

--set primary key for animals table
ALTER TABLE animals ADD PRIMARY KEY (id);

-- remove species column from animals table
ALTER TABLE animals DROP COLUMN species;

ALTER TABLE animals 
ADD species_id Int,
ADd CONSTRAINT fk_species FOREIGN KEY(species_id) REFERENCES species(id),
ADD owner_id Int,
ADD CONSTRAINT fk_owners FOREIGN KEY(owner_id) REFERENCES owners(id);