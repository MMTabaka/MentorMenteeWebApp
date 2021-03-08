CREATE TABLE m_users (
    
    id INTEGER PRIMARY KEY,
    user_type TEXT NOT NULL,
    ucard INTEGER NOT NULL,
    email TEXT NOT NULL,
    password TEXT NOT NULL,
    description TEXT,
    explanation TEXT,
    request TEXT,
    acceptance INTEGER,
    suspension INTEGER,
    fields TEXT
    
);

CREATE TABLE admins (
    login TEXT,
    password TEXT
);

INSERT INTO m_users VALUES (1, "Mentor", 23456, "email@email.com", "password", "description", "explanation", "request",
                           0, 0, "field, field, field");
INSERT INTO m_users VALUES (2, "Mentor2", 65432, "email2@email.com", "password", "description", "explanation", "request",
                           0, 0, "field, field, field");