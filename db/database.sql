CREATE TABLE m_users (
    
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_type INTEGER NOT NULL,
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

INSERT INTO m_users VALUES (1, 0, "email@email.com", "password", "description", "explanation", "request",
                           0, 0, "field, field, field");
                           
INSERT INTO m_users VALUES (2, 0, "email2@email.com", "password", "description", "explanation", "request",
                           0, 0, "field, field, field");
                           
INSERT INTO m_users (user_type, email, password, description, explanation, request, acceptance, suspension, fields) 
VALUES (0, "email2@email.com", "password", "description", "explanation", "request",
                           0, 0, "field, field, field");
