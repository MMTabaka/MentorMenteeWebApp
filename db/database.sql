CREATE TABLE m_users (
    user_type TEXT,
    ucard INTEGER,
    email TEXT,
    password TEXT,
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