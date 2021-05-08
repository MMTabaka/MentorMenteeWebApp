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