-- Database
CREATE DATABASE constellationify;

-- Tables
CREATE TABLE constellation (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    image TEXT NOT NULL,
    stars_quantity INTEGER NOT NULL,
    centroid FLOAT ARRAY[2] NOT NULL,
    feature_array FLOAT ARRAY[100] NOT NULL
);