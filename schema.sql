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
ADD CONSTRAINT fk_species FOREIGN KEY(species_id) REFERENCES species(id),
ADD owner_id Int,
ADD CONSTRAINT fk_owners FOREIGN KEY(owner_id) REFERENCES owners(id);

--Create Table Named Vets
CREATE TABLE vets (
    id Int GENERATED ALWAYS AS IDENTITY,
    name varchar(200),
    age Int,
    date_of_graduation Date,
    PRIMARY KEY (id)
);

-- Create specialization join table
CREATE TABLE specializations (
  id INT GENERATED ALWAYS AS IDENTITY,
  vet_id INT,
  species_id INT,
  FOREIGN KEY (vet_id) REFERENCES vets(id),
  FOREIGN KEY (species_id) REFERENCES species(id),
  PRIMARY KEY(id)
);

--Create visit join table

CREATE TABLE visits (
  id INT GENERATED ALWAYS AS IDENTITY,
  animal_id INT,
  vet_id INT,
  visit_date DATE,
  FOREIGN KEY (animal_id) REFERENCES animals(id),
  FOREIGN KEY (vet_id) REFERENCES vets(id),
  PRIMARY KEY(id)
);

--How many visits were with a vet that did not specialize in that animal's species?
SELECT count(*)
FROM visits vi
JOIN animals a ON vi.animal_id = a.id
WHERE vi.vet_id NOT IN (
    SELECT s.vet_id
    FROM specializations s
    WHERE s.species_id = a.species_id
);

--What specialty should Maisy Smith consider getting? Look for the species she gets the most.
SELECT sp.name, COUNT(*) as visit_count
FROM visits vi
JOIN vets v ON vi.vet_id = v.id
JOIN animals a ON vi.animal_id = a.id
JOIN species sp ON a.species_id = sp.id
WHERE v.name = 'Maisy Smith'
GROUP BY sp.name
ORDER BY visit_count DESC;



-- Add an email column to your owners table
ALTER TABLE owners ADD COLUMN email VARCHAR(120);

-- add index for a visits table by animal id
CREATE INDEX idx_animal_id ON visits (animal_id);

-- add index for a visits table by vet id
CREATE INDEX idx_vet_id ON visits (vet_id);

--add index for owners table by email
CREATE INDEX idx_email ON owners (email);