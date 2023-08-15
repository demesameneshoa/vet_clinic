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
SELECT neutered FROM animals WHERE escape_attempts IS MAX;
--avg escape attempt
SELECT neutered, AVG(escape_attempts) AS avg_escape_attempts
FROM animals
GROUP BY neutered;
--min and max weight with species
SELECT species, MIN(weight_kg) as min_weight, MAX(weight_kg) as max_weight
FROM animals
GROUP BY species;
