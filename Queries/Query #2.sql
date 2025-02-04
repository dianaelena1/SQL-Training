CREATE TABLE movies (
    id INT PRIMARY KEY AUTO_INCREMENT,
    titlu VARCHAR(255),
    an INT,
    actori VARCHAR(255),
    regizor VARCHAR(255),
    locatie VARCHAR(255),
    descriere TEXT,
    rating FLOAT,
    nr_vizitatori INT
);
