CREATE TABLE m_users (
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

INSERT INTO m_users VALUES ("Mentor", 23456, "email@email.com", "password", "description", "explanation", "request",
                           0, 0, "field, field, field");