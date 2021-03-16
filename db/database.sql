DROP TABLE m_users;
DROP TABLE admins;

-- Clear everything
VACUUM;

CREATE TABLE m_users (
    
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_type INTEGER NOT NULL,
    email TEXT NOT NULL UNIQUE,
    password TEXT NOT NULL,
    name TEXT,
    department TEXT,
    bio TEXT,
    interest_areas TEXT,
    request TEXT,
    acceptance INTEGER,
    suspension INTEGER
);

CREATE TABLE admins (
    login TEXT,
    password TEXT
);

INSERT INTO m_users (user_type, email, password, name, department, bio, request, acceptance, suspension, interest_areas)
VALUES (1, 'email@email.com', 'VerySecurePass1337', 'Mentee John', 'Department of Computer Science', 'Random bio text',
        '', 0, 0, 'field1,field2,field3');

INSERT INTO m_users (user_type, email, password, name, department, bio, request, acceptance, suspension, interest_areas)
VALUES (0, 'email2@email.com', 'SecurePass123', 'Mentor Paul', 'Department of Nothing', 'Random bio text',
        '', 0, 0, 'field1,field5,field6');
