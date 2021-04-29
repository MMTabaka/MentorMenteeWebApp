DROP TABLE users;
DROP TABLE connections;
DROP TABLE departments;
DROP TABLE interests;

-- Clear everything
VACUUM;

CREATE TABLE users (
    
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_type INTEGER NOT NULL,
    email TEXT NOT NULL UNIQUE,
    password TEXT NOT NULL,
    name TEXT,
    department TEXT,
    bio TEXT,
    interest_areas TEXT,
    suspension INTEGER DEFAULT 0
);

CREATE TABLE departments (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    department TEXT UNIQUE NOT NULL
);

CREATE TABLE interests (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    interest TEXT UNIQUE NOT NULL
);
CREATE TABLE connections (
     id INTEGER PRIMARY KEY AUTOINCREMENT,
     mentee_id INTEGER NOT NULL,
     mentor_id INTEGER NOT NULL,
     status INTEGER NOT NULL,
     active INTEGER NOT NULL,
     request_time TEXT,
     end_time TEXT,
     rejection_reason TEXT
);

INSERT INTO users (user_type, email, password, name, department, bio, request, acceptance, suspension, interest_areas)
VALUES (1, 'email@email.com', 'VerySecurePass1337', 'Mentee John', 'Department of Computer Science', 'Random bio text',
        '', 0, 0, 'field1,field2,field3');

INSERT INTO users (user_type, email, password, name, department, bio, request, acceptance, suspension, interest_areas)
VALUES (0, 'email2@email.com', 'SecurePass123', 'Mentor Paul', 'Department of Nothing', 'Random bio text',
        '', 0, 0, 'field1,field5,field6');

INSERT INTO users (user_type, email, password, name, department, bio, request, acceptance, suspension, interest_areas)
VALUES (0, 'email3@email.com', 'VerySecurePass1337', 'Mentor Ringo', 'Department of Computer Science', 'Random bio text',
        '', 0, 0, 'field1,field2,field3');