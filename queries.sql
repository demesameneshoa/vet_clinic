SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-01-01';
SELECT name FROM animals WHERE neutered=true AND escape_attempts<3;
SELECT date_of_birth FROM animals WHERE name='Agumon' OR name='Pikachu';
SELECT name,escape_attempts FROM animals WHERE weight_kg>10.5;
SELECT * FROM animals WHERE neutered=true;
SELECT * FROM animals WHERE name != 'Gabumon';
SELECT * FROM animals WHERE weight_kg>=10.4 AND weight_kg<=17.3;
--Update species column wiht RollBack
BEGIN;
UPDATE animals SET species='unspecified';
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;
-- Update Species with commit
BEGIN;
UPDATE animals SET species='digimon' WHERE name LIKE '%mon';
UPDATE animals SET species='pokemon' WHERE species IS NULL;
SELECT * FROM animals;
COMMIT;
SELECT * FROM animals;
-- Delete rows with rollback
BEGIN;
DELETE FROM animals;
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;
-- Delete with savepoint
BEGIN;
DELETE FROM animals WHERE date_of_birth>'2022-01-01';
SELECT * FROM animals;
SAVEPOINT save_point;
UPDATE animals SET weight_kg=weight_kg*-1;
SELECT * FROM animals;
ROLLBACK TO save_point;
UPDATE animals SET weight_kg=weight_kg*-1 WHERE weight_kg<0;
SELECT * FROM animals;
COMMIT;
SELECT * FROM animals;
-- Query Data from Animals table
SELECT count(*) FROM animals;
SELECT count(*) FROM animals WHERE escape_attempts=0;
SELECT Avg(weight_kg)as Average_Weight_KG FROM animals;  
--avg escape attempt
SELECT neutered, MAX(escape_attempts) AS max_escape_attempts
FROM animals
GROUP BY neutered;
--min and max weight with species
SELECT species, MIN(weight_kg) as min_weight, MAX(weight_kg) as max_weight
FROM animals
GROUP BY species;
--avg no of escape in date
SELECT species, AVG(escape_attempts) as avg_escape_attempts
FROM animals
WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31'
GROUP BY species;

--Join Query by owner name
select * from animals JOIN owners on animals.owner_id=owners.id where owners.full_name='Melody Pond';

--Join Query by species name
select * from animals JOIN species on animals.species_id=species.id where species.name='Pokemon';

--Full Join Query by owner
select * from animals Full JOIN owners on animals.owner_id=owners.id;

--Join Count group by species
select species.name as animals_species,count(species.name) as species_count from species JOIN animals on animals.species_id=species.id GROUP BY species.name;

--Join three tables and filter by owner and species
select * from animals JOIN owners on animals.owner_id=owners.id JOIN species on animals.species_id=species.id where species.name='Digimon' and owners.full_name='Jennifer Orwell';

--Join animal and owner table and filter by owner name and zero escape attempt
select * from animals JOIN owners on animals.owner_id=owners.id WHERE owners.full_name='Dean Winchester' AND escape_attempts=0;

-- Who owns the most animals;
select full_name as owner_name, count(full_name)no_of_animals from owners JOIN animals on animals.owner_id=owners.id GROUP BY owners.full_name;

-- Who was the last animal seen by William Tatcher?
SELECT v.name AS vet_name, a.name AS animal_name, vi.visit_date
FROM vets v
JOIN visits vi ON v.id = vi.vet_id
JOIN animals a ON a.id = vi.animal_id
WHERE v.name = 'William Tatcher'
ORDER BY vi.visit_date DESC
LIMIT 1;

--How many different animals did Stephanie Mendez see?
SELECT COUNT(DISTINCT a.id) as total_different_animals
FROM vets v
JOIN visits vi ON v.id = vi.vet_id
JOIN animals a ON a.id = vi.animal_id
WHERE v.name = 'Stephanie Mendez';

--vets with specialities full join
select v.name, v.age, v.date_of_graduation, s.species_id,sp.name
FROM specializations s
FULL JOIN vets v on v.id=s.vet_id
FULL JOIN species sp on sp.id=s.species_id;

--List all vets and their specialties, including vets with no specialties.
SELECT v.name AS vet_name, a.name AS animal_name, vi.visit_date
FROM vets v
JOIN visits vi ON v.id = vi.vet_id
JOIN animals a ON a.id = vi.animal_id
WHERE v.name = 'Stephanie Mendez' and vi.visit_date BETWEEN '2020-04-01' AND '2020-08-30';

--What animal has the most visits to vets?
SELECT a.name AS animal_name, COUNT(*) as visit_count
FROM visits vi
JOIN animals a ON a.id = vi.animal_id
GROUP BY a.name
ORDER BY visit_count DESC;

--Who was Maisy Smith's first visit?
SELECT v.name AS vet_name, a.name AS animal_name, vi.visit_date
FROM vets v
JOIN visits vi ON v.id = vi.vet_id
JOIN animals a ON a.id = vi.animal_id
WHERE v.name = 'Maisy Smith'
ORDER BY vi.visit_date ASC;

--Details for most recent visit: animal information, vet information, and date of visit.
SELECT a.*, v.*, vi.visit_date
FROM visits vi
JOIN vets v ON vi.vet_id = v.id
JOIN animals a ON vi.animal_id = a.id
ORDER BY vi.visit_date DESC

-- 