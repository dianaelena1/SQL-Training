CREATE TABLE movie_actor (

    movie_id INT,

    actor_id INT,

    PRIMARY KEY (movie_id, actor_id),

    FOREIGN KEY (movie_id) REFERENCES movies(id),

    FOREIGN KEY (actor_id) REFERENCES actors(actor_id)

);