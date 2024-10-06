use testdb;

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    userId VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    username VARCHAR(100) NOT NULL,
    phone VARCHAR(15) NOT NULL
);

CREATE TABLE reservations (
    id INT AUTO_INCREMENT PRIMARY KEY,
    userId VARCHAR(50),
    movieTitle VARCHAR(100),
    director VARCHAR(50),
    genre VARCHAR(30),
    reservationDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
