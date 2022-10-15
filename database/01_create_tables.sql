DROP TABLE IF EXISTS students;

CREATE TABLE students
(
    id   VARCHAR(32) PRIMARY KEY UNIQUE NOT NULL,
    name VARCHAR(255)                   NOT NULL,
    age  INTEGER                        NOT NULL
);

DROP TABLE IF EXISTS tests;

CREATE TABLE tests
(
    id   VARCHAR(32) PRIMARY KEY UNIQUE NOT NULL,
    name VARCHAR(255)                   NOT NULL
);

DROP TABLE IF EXISTS questions;

CREATE TABLE questions
(
    id       VARCHAR(32) PRIMARY KEY UNIQUE NOT NULL,
    answer   VARCHAR(255)                   NOT NULL,
    question VARCHAR(255)                   NOT NULL,
    test_id  VARCHAR(32)                    NOT NULL,
    FOREIGN KEY (test_id) REFERENCES tests (id)
);

DROP TABLE IF EXISTS enrollments;

CREATE SEQUENCE enrollments_id_seq;

CREATE TABLE enrollments
(
    id         INTEGER PRIMARY KEY UNIQUE NOT NULL DEFAULT nextval('enrollments_id_seq'),
    student_id VARCHAR(32)                NOT NULL,
    test_id    VARCHAR(32)                NOT NULL,
    FOREIGN KEY (student_id) REFERENCES students (id),
    FOREIGN KEY (test_id) REFERENCES tests (id)
);

ALTER SEQUENCE enrollments_id_seq OWNED BY enrollments.id;

INSERT INTO students (id, name, age)
VALUES ('1', 'Mauricio Martinez Chaves', 29);

INSERT INTO students (id, name, age)
VALUES ('2', 'Ana Patricia Cortes Ortega', 27);

INSERT INTO students (id, name, age)
VALUES ('3', 'Pepito Perez', 26);

INSERT INTO students (id, name, age)
VALUES ('4', 'Juanita Perez', 25);

INSERT INTO tests (id, name)
VALUES ('1', 'Golang');

INSERT INTO tests (id, name)
VALUES ('2', 'JavaScript');

INSERT INTO tests (id, name)
VALUES ('3', 'PHP');

INSERT INTO questions (id, answer, question, test_id)
VALUES ('1', 'R1-Golang', 'Q1-Golang', '1');

INSERT INTO questions (id, answer, question, test_id)
VALUES ('2', 'R2-Golang', 'Q2-Golang', '1');

INSERT INTO questions (id, answer, question, test_id)
VALUES ('3', 'R1-JavaScript', 'Q1-JavaScript', '2');

INSERT INTO questions (id, answer, question, test_id)
VALUES ('4', 'R2-JavaScript', 'Q2-JavaScript', '2');

INSERT INTO questions (id, answer, question, test_id)
VALUES ('5', 'R1-PHP', 'Q1-PHP', '3');

INSERT INTO questions (id, answer, question, test_id)
VALUES ('6', 'R2-PHP', 'Q2-PHP', '3');