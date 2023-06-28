/* Database schema to keep the structure of entire database. */

/*Project 1*/

CREATE TABLE animals (
	id serial PRIMARY KEY,
	name varchar(100),
	date_of_birth date,
	escape_attempts integer,
	neutered boolean,
	weight_kg decimal(10,2)	
);

/*Project 2*/

ALTER TABLE animals ADD COLUMN species varchar(100);

/*Project 3*/

CREATE TABLE owners (
	id serial PRIMARY KEY,
	full_name varchar(255),
	age integer
);

CREATE TABLE species (
	id serial PRIMARY KEY,
	name varchar(100)
);

ALTER TABLE animals DROP COLUMN species;

ALTER TABLE animals ADD COLUMN species_id integer;

ALTER TABLE animals ADD CONSTRAINT fk_species
FOREIGN KEY(species_id) REFERENCES species(id);

ALTER TABLE animals ADD COLUMN owner_id integer;

ALTER TABLE animals ADD CONSTRAINT fk_owners
FOREIGN KEY(owner_id) REFERENCES owners(id);

/*Project 4*/

CREATE TABLE vets(
id serial PRIMARY KEY,
name varchar(100),
age integer,
date_of_graduation date
);

CREATE TABLE specializations (
    species_id INT REFERENCES species(id),
	vet_id INT REFERENCES vets(id),
    PRIMARY KEY (species_id, vet_id)
);

CREATE TABLE visits (
    id INT PRIMARY KEY NOT NULL GENERATED ALWAYS AS IDENTITY,
    animal_id INT,
    vet_id INT,
    date_of_visit DATE,
    CONSTRAINT fk_vets
      FOREIGN KEY (vet_id) REFERENCES vets(id),
    CONSTRAINT fk_animals
      FOREIGN KEY (animal_id) REFERENCES animals(id)
);

/*Preparation for Database Performance Audit*/

-- Add an email column to your owners table
ALTER TABLE owners ADD COLUMN email VARCHAR(120);

--Improving queries:

CREATE INDEX idx_visits_animal_id ON visits (animal_id);
CREATE INDEX idx_visits_vet_id ON visits (vet_id);
CREATE INDEX idx_owners_email ON owners (email);