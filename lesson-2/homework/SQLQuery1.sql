use class1;

CREATE TABLE test_identity (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(50)
);

INSERT INTO test_identity (name)
VALUES ('A'), ('B'), ('C'), ('D'), ('E');

SELECT * FROM test_identity;

DELETE FROM test_identity;
SELECT * FROM test_identity;

INSERT INTO test_identity (name) VALUES ('F');
SELECT * FROM test_identity;

TRUNCATE TABLE test_identity;
SELECT * FROM test_identity;

INSERT INTO test_identity (name) VALUES ('G');
SELECT * FROM test_identity;
DROP TABLE test_identity;
SELECT * FROM test_identity;

