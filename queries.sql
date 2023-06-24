/*Queries that provide answers to the questions from all projects.*/

/*Project 1*/

SELECT * FROM animals WHERE name LIKE '%mon';
SELECT * FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
SELECT * FROM animals WHERE neutered = true AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name IN ('Agumon','Pikachu');
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered = true;
SELECT * FROM animals WHERE name <> 'Gabumon';
SELECT * FROM animals WHERE  weight_kg BETWEEN 10.4 AND 17.3;

/*Project 2*/

BEGIN;
UPDATE animals SET species = 'unspecified';
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;

BEGIN;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;
SELECT * FROM animals;
COMMIT;
SELECT * FROM animals;

BEGIN;
DELETE FROM animals;
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;

BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SELECT * FROM animals;

SAVEPOINT my_savepoint;

UPDATE animals SET weight_kg = weight_kg * -1;
SELECT * FROM animals;

ROLLBACK TO my_savepoint;
SELECT * FROM animals;

UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
SELECT * FROM animals;

COMMIT;

SELECT COUNT(*) AS total_animals FROM animals;

SELECT COUNT(*) AS escaped_animals FROM animals WHERE escape_attempts = 0;

SELECT AVG(weight_kg) AS average_weight FROM animals;

SELECT neutered, SUM(escape_attempts) AS sum_escapes FROM animals
GROUP BY neutered
ORDER BY sum_escapes DESC
LIMIT 1;

SELECT species, MIN(weight_kg) AS min_weight,
MAX(weight_kg) AS max_weight FROM animals GROUP BY species;

SELECT species, AVG(escape_attempts) AS average_escapes
FROM animals
WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31'
GROUP BY species;

/*Project 3*/

SELECT A.name AS animal_name, O.full_name AS owner
FROM animals A
JOIN owners O ON A.owner_id = O.id
WHERE O.full_name = 'Melody Pond';

SELECT A.name AS animal_name, S.name AS type
FROM animals A
JOIN species S ON A.species_id = S.id
WHERE S.name = 'Pokemon';

SELECT O.full_name AS owner, A.name AS animal_name
FROM owners O
LEFT JOIN animals A ON O.id = A.owner_id

SELECT S.name AS type, COUNT(*) AS type_count
FROM species S
JOIN animals A ON S.id = A.species_id
GROUP BY S.name;

SELECT A.name AS animal_name, S.name AS type, O.full_name AS owner
FROM animals A
JOIN species S ON A.species_id = S.id
JOIN owners O ON A.owner_id = O.id
WHERE S.name = 'Digimon' AND O.full_name = 'Jennifer Orwell';

SELECT A.name AS animal_name, O.full_name AS owner, A.escape_attempts
FROM animals A
JOIN owners O ON A.owner_id = O.id
WHERE O.full_name = 'Dean Winchester' AND A.escape_attempts = 0;

SELECT O.full_name AS owner, COUNT(*) AS animal_count
FROM owners O
JOIN animals A ON O.id = A.owner_id
GROUP BY O.full_name
ORDER BY animal_count DESC
LIMIT 1;

/*Project 4*/

SELECT a.name AS animal_name
FROM visits v
JOIN vets ve ON v.vet_id = ve.id
JOIN animals a ON v.animal_id = a.id
WHERE ve.name = 'William Tatcher'
ORDER BY v.visit_date DESC
LIMIT 1;

SELECT COUNT(DISTINCT v.animal_id) AS animal_count
FROM visits v
JOIN vets ve ON v.vet_id = ve.id
WHERE ve.name = 'Stephanie Mendez';

SELECT v.name AS vet_name, s.name AS specialty_name
FROM vets v
LEFT JOIN specializations sp ON v.id = sp.vet_id
LEFT JOIN species s ON sp.species_id = s.id;

SELECT a.name AS animal_name
FROM visits v
JOIN vets ve ON v.vet_id = ve.id
JOIN animals a ON v.animal_id = a.id
WHERE ve.name = 'Stephanie Mendez'
AND v.visit_date BETWEEN '2020-04-01' AND '2020-08-30';

SELECT a.name AS animal_name, COUNT(*) AS visit_count
FROM visits v
JOIN animals a ON v.animal_id = a.id
GROUP BY a.name
ORDER BY visit_count DESC
LIMIT 1;

SELECT animals.name AS animal, vets.name AS vet_name,
MIN(visit_date) AS first_visit 
FROM animals JOIN visits ON animals.id = visits.animal_id 
JOIN vets ON vets.id = visits.vet_id 
WHERE vets.name IN ('Maisy Smith')
GROUP BY animal, vet_name
ORDER BY first_visit
LIMIT 1;

SELECT a.name AS animal_name, v.name AS vet_name, vi.visit_date
FROM visits vi
JOIN vets v ON vi.vet_id = v.id
JOIN animals a ON vi.animal_id = a.id
ORDER BY vi.visit_date DESC
LIMIT 8;

SELECT vet AS non_specialist, COUNT(number_of_visit) as visit_count
FROM (SELECT vets.name AS vet, visits.visit_date AS number_of_visit,
specializations.species_id AS spec_id 
FROM vets
LEFT JOIN visits ON vets.id = visits.vet_id 
LEFT JOIN specializations
ON vets.id = specializations.vet_id) as non_specialize
WHERE spec_id IS NULL GROUP BY vet, spec_id;

SELECT vets.name AS vet_name, species.name AS treated_species,
COUNT(species.name) as max_quantity 
FROM vets JOIN visits ON vets.id = visits.vet_id 
JOIN animals ON animals.id = visits.animal_id 
JOIN species ON species.id = animals.species_id 
WHERE vets.name IN ('Maisy Smith')
GROUP BY species.name, vets.name
ORDER BY max_quantity DESC
LIMIT 1;