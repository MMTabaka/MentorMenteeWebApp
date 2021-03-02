
CREATE TABLE mentors (
    ucard INTEGER,
    email TEXT,
    password TEXT,
    description TEXT,
    explanation TEXT,
    request TEXT,
    acceptance INTEGER,
    suspension INTEGER,
    fields
);

CREATE TABLE admins (
    ucard INTEGER,
    email TEXT,
    password TEXT,
    request TEXT,
    acceptance INTEGER,
    suspension INTEGER,
    fields
);

CREATE TABLE fields (
    
);

CREATE TABLE admins (
    login TEXT,
    password TEXT,
)