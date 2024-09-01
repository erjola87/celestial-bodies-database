-- Table for Galaxies
CREATE TABLE galaxies (
    galaxy_id INT PRIMARY KEY,
    name VARCHAR(100),
    type VARCHAR(50),
    distance_from_earth FLOAT,  -- in light years
    number_of_stars BIGINT
);

-- Table for Constellations
CREATE TABLE constellations (
    constellation_id INT PRIMARY KEY,
    name VARCHAR(100),
    region VARCHAR(100),
    major_stars INT,  -- number of major stars in the constellation
    best_time_to_view VARCHAR(50)
);

-- Table for Stars
CREATE TABLE stars (
    star_id INT PRIMARY KEY,
    name VARCHAR(100),
    type VARCHAR(50),  -- type of star, e.g., Main Sequence
    mass FLOAT,  -- in solar masses
    radius FLOAT,  -- in solar radii
    temperature INT,  -- in Kelvin
    distance_from_earth FLOAT,  -- in light years
    luminosity FLOAT,
    galaxy_id INT,  -- Foreign key to Galaxies
    FOREIGN KEY (galaxy_id) REFERENCES galaxies(galaxy_id)
);

-- Table for Planets
CREATE TABLE planets (
    planet_id INT PRIMARY KEY,
    name VARCHAR(100),
    mass FLOAT,  -- in Earth masses
    radius FLOAT,  -- in Earth radii
    orbital_period FLOAT,  -- in Earth days
    distance_from_star FLOAT,  -- in AU
    has_life BOOLEAN,
    star_id INT,  -- Foreign key to Stars
    FOREIGN KEY (star_id) REFERENCES stars(star_id)
);

-- Table for Moons
CREATE TABLE moons (
    moon_id INT PRIMARY KEY,
    name VARCHAR(100),
    mass FLOAT,  -- in Moon masses
    radius FLOAT,  -- in Moon radii
    orbital_period FLOAT,  -- in Earth days
    distance_from_planet FLOAT,  -- in kilometers
    planet_id INT,  -- Foreign key to Planets
    FOREIGN KEY (planet_id) REFERENCES planets(planet_id)
);

-- Table for Asteroids
CREATE TABLE asteroids (
    asteroid_id INT PRIMARY KEY,
    name VARCHAR(100),
    mass FLOAT,  -- in kilograms
    radius FLOAT,  -- in kilometers
    orbital_period FLOAT,  -- in Earth days
    orbit_type VARCHAR(50),  -- e.g., Near-Earth, Main Belt
    discovered_by VARCHAR(100),
    discovery_date DATE
);

-- Table for Comets
CREATE TABLE comets (
    comet_id INT PRIMARY KEY,
    name VARCHAR(100),
    nucleus_mass FLOAT,  -- in kilograms
    nucleus_radius FLOAT,  -- in kilometers
    orbital_period FLOAT,  -- in years
    discovered_by VARCHAR(100),
    discovery_date DATE,
    perihelion_distance FLOAT,  -- in AU
    aphelion_distance FLOAT  -- in AU
);

-- Many-to-Many relationship between Stars and Constellations
CREATE TABLE star_constellation (
    star_id INT,
    constellation_id INT,
    PRIMARY KEY (star_id, constellation_id),
    FOREIGN KEY (star_id) REFERENCES stars(star_id),
    FOREIGN KEY (constellation_id) REFERENCES constellations(constellation_id)
);

-- Insert data into Galaxies
INSERT INTO galaxies (galaxy_id, name, type, distance_from_earth, number_of_stars)
VALUES (1, 'Milky Way', 'Spiral', 0, 100000000000);

-- Insert data into Stars
INSERT INTO stars (star_id, name, type, mass, radius, temperature, distance_from_earth, luminosity, galaxy_id)
VALUES (1, 'Sun', 'Main Sequence', 1.0, 1.0, 5778, 0, 1.0, 1);

-- Insert data into Planets
INSERT INTO planets (planet_id, name, mass, radius, orbital_period, distance_from_star, has_life, star_id)
VALUES (1, 'Earth', 1.0, 1.0, 365.25, 1.0, TRUE, 1);

-- Insert data into Moons
INSERT INTO moons (moon_id, name, mass, radius, orbital_period, distance_from_planet, planet_id)
VALUES (1, 'Moon', 0.0123, 0.273, 27.32, 384400, 1);

-- Insert data into Constellations
INSERT INTO constellations (constellation_id, name, region, major_stars, best_time_to_view)
VALUES (1, 'Orion', 'Equatorial', 7, 'January');

-- Relate a star to a constellation
INSERT INTO star_constellation (star_id, constellation_id)
VALUES (1, 1);

SELECT name FROM planets
WHERE star_id = (SELECT star_id FROM stars WHERE name = 'Sun');

SELECT stars.name
FROM stars
JOIN star_constellation ON stars.star_id = star_constellation.star_id
JOIN constellations ON star_constellation.constellation_id = constellations.constellation_id
WHERE constellations.name = 'Orion';
