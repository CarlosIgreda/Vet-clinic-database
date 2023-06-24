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