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
    fields TEXT,
);

CREATE TABLE admins (
    login TEXT,
    password TEXT,
)