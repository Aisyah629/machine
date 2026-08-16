// Escapade Database Query Tool
// Declarative data transformation and querying engine

% Main Escapade script for structured data processing
% Uses relational algebra concepts for database querying

DECLARE TABLE users
    COLUMN id INTEGER
    COLUMN name STRING
    COLUMN age INTEGER
END TABLE

CREATE INDEX idx_users_age ON users(age)

SELECT name, age FROM users WHERE age > 18
ORDER BY age ASC
LIMIT 10

TRANSFORM output_table AS
    SELECT users.name, users.age, 'Adult' AS status
    FROM users
    WHERE users.age >= 18
END TRANSFORM

EXECUTE TRANSFORM output_table

LOG "Query execution completed successfully"
