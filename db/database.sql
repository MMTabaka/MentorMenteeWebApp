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

INSERT INTO users (id, user_type, email, password, name, department, bio, interest_areas, suspension) VALUES (1, 0, 'mentor1@mentor.com', 'Password123', 'Mentor One', 'Aerospace Engineering', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', 'Accounting,Aerospace Engineering,Applied Social Sciences,Archaeology,Financial Management', 0);
INSERT INTO users (id, user_type, email, password, name, department, bio, interest_areas, suspension) VALUES (2, 0, 'mentor2@mentor.com', 'Password123', 'Mentor Two', 'Archaeology', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', 'Aerospace Engineering,Applied Social Sciences,Archaeology,Financial Management,Modern Languages & Cultures', 0);
INSERT INTO users (id, user_type, email, password, name, department, bio, interest_areas, suspension) VALUES (3, 0, 'mentor3@mentor.com', 'Password123', 'Mentor Three', 'School of Architecture', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', 'Accounting,Aerospace Engineering,Financial Management', 0);
INSERT INTO users (id, user_type, email, password, name, department, bio, interest_areas, suspension) VALUES (4, 1, 'mentee1@mentee.com', 'Password123', 'Mentee One', 'School of Clinical Dentistry', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', 'Accounting,Aerospace Engineering,Financial Management', 0);
INSERT INTO users (id, user_type, email, password, name, department, bio, interest_areas, suspension) VALUES (5, 1, 'mentee2@mentee.com', 'Password123', 'Mentee Two', 'MEng Engineering', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', 'Accounting,Aerospace Engineering,Applied Social Sciences,Financial Management', 0);
INSERT INTO users (id, user_type, email, password, name, department, bio, interest_areas, suspension) VALUES (6, 1, 'mentee3@mentee.com', 'Password123', 'Mentee Three', 'Automatic Control and Systems Engineering', '', 'Accounting,Robotics,Theoretical Physics', 0);
INSERT INTO users (id, user_type, email, password, name, department, bio, interest_areas, suspension) VALUES (7, 1, 'mentee4@mentee.com', 'Password123', 'Mentee Four', 'Geography', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', 'Sociology,Urban Studies,Zoology', 0);
INSERT INTO users (id, user_type, email, password, name, department, bio, interest_areas, suspension) VALUES (8, 0, 'mentor4@mentor.com', 'Password123', 'Mentor Four', 'Faculty of Science', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', 'Accounting', 0);
INSERT INTO users (id, user_type, email, password, name, department, bio, interest_areas, suspension) VALUES (9, 0, 'mentor5@mentor.com', 'Password123', 'Mentor Five', 'Archaeology', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', 'Dental Surgery,Economics,Politics', 0);
INSERT INTO users (id, user_type, email, password, name, department, bio, interest_areas, suspension) VALUES (10, 1, 'mentee5@mentee.com', 'Password123', 'Mentee Five', 'School of English', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', 'Computer Science,Politics', 0);