CREATE TABLE connections (
  
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  mentee_id INTEGER NOT NULL,
  mentor_id INTEGER NOT NULL,
  status INTEGER NOT NULL,
  request_time TEXT,
  end_time TEXT,
  rejection_reason TEXT
  
);