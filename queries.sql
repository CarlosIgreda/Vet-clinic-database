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


