-- ========================================================================
-- Script to create db and it's tables and insert data's into it
-- join tables like airports and flights
-- ========================================================================

-- Create Database
CREATE DATABASE IF NOT EXISTS airline_db;
USE airline_db;

-- Create airports table
CREATE TABLE airports (
    airport_id INT PRIMARY KEY,
    code VARCHAR(3) NOT NULL,
    city VARCHAR(50),
    country VARCHAR(50)
);

-- Insert data into airports
INSERT INTO airports (airport_id, code, city, country) VALUES
(1, 'LHR', 'London', 'United Kingdom'),
(2, 'JFK', 'New York', 'United States'),
(3, 'NRT', 'Tokyo', 'Japan');

--  View airports (optional)
-- SELECT * FROM airports;

-- Create flights table
CREATE TABLE flights (
    flight_id INT PRIMARY KEY,
    flight_number VARCHAR(10) NOT NULL,
    departure_airport_id INT NOT NULL,
    arrival_airport_id INT NOT NULL,
    departure_time DATETIME NOT NULL,
    FOREIGN KEY (departure_airport_id) REFERENCES airports(airport_id),
    FOREIGN KEY (arrival_airport_id) REFERENCES airports(airport_id)
);

-- Insert data into flights
INSERT INTO flights (flight_id, flight_number, departure_airport_id, arrival_airport_id, departure_time) VALUES
(1, 'BA117', 1, 2, '2025-09-20 10:30:00'),
(2, 'JL005', 3, 1, '2025-09-21 14:45:00'),
(3, 'AA101', 2, 3, '2025-09-22 08:15:00');

-- Query to join flights and airports
SELECT 
    f.flight_number,
    d.city AS departure_city,
    a.city AS arrival_city,
    f.departure_time
FROM flights f
JOIN airports d ON f.departure_airport_id = d.airport_id;
JOIN airports a ON f.arrival_airport_id = a.airport_id;
