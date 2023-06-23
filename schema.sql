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
