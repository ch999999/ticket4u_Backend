# Instructions to set up database in local environment (If they still haven't given us Google Cloud Database) Don't try unless your computer is good 8GB RAM + good processor

Step 1: Must install Docker Desktop. (Prereq for windows: WSL/Hyper-V - Enable in Windows features). SQLite can also, but doesn't support date and time types. You will have to modify connection string and code in database.py and may have to modify code in models.py and schemas.py that use date and time types.

Step 2: create .env file in root directory

Step 3: Copy contents of .env.example to your new .env file

Step 4: Run these commands to install essential python packages: pip install fastapi, pip install pylance, pip install sqlalchemy, pip install python-dotenv, pip install uvicorn

Step 5: Run this command to create the database in a Docker container: docker-compose up -d

Step 6: Make sure container is running in Docker Desktop

Step 7: Install pgAdmin

Step 8: Register server in pgAdmin. Name: ticket4u_db, Hostname/address: localhost, Port: 5433, Password: password123 

Step 9: To start API server and create tables in database, run this command from ticket4u_backend directory: uvicorn app.main:app

# Instructions to change database schema (table structure and relationships)
If models in models.py changed, database schema must be updated to reflect it.

Step 1: Shut down API server if still running

Step 2: In pgAdmin, run this SQL command against ticket4u_db (NOT postgres!!!!):

do $$ declare
    r record;
begin
    for r in (select tablename from pg_tables where schemaname = 'public') loop
        execute 'drop table if exists ' || quote_ident(r.tablename) || ' cascade';
    end loop;
end $$;

This will drop all tables in ticket4u_db.

Step 3: restart API server. same command as Step 9 from previous section

# Inserting sample data
To clear tables, you can repeat Step 2 of the last section. After restarting the API server and regenerating database tables, run this SQL statement to insert sample Cinemas, Halls, Seats, Movies, Showings and Users into the database:

-- Insert sample Halls

WITH cinema_ids AS (SELECT id FROM "Cinemas")
INSERT INTO "Halls" (id, cinema_id, name, capacity) VALUES
(gen_random_uuid(), (SELECT id FROM cinema_ids LIMIT 1 OFFSET 0), 'Hall A', 70),
(gen_random_uuid(), (SELECT id FROM cinema_ids LIMIT 1 OFFSET 0), 'Hall B', 70),
(gen_random_uuid(), (SELECT id FROM cinema_ids LIMIT 1 OFFSET 1), 'Hall 1', 70),
(gen_random_uuid(), (SELECT id FROM cinema_ids LIMIT 1 OFFSET 1), 'Hall 2', 70);


-- Insert sample Seats (7 rows, 10 seats per row)

WITH hall_ids AS (SELECT id FROM "Halls")
INSERT INTO "Seats" (id, hall_id, row, number, type)
SELECT 
    gen_random_uuid(),
    hall_id,
    chr(64 + (s.seat_number / 10) + 1),  -- Generates rows A to G
    (s.seat_number % 10) + 1,  -- Generates seat numbers 1-10
    'standard'
FROM 
    (SELECT id AS hall_id FROM hall_ids) h
CROSS JOIN 
    generate_series(0, 69) s(seat_number);  -- Generates 70 seats per hall (7 rows * 10 seats)
    

-- Insert sample Movies

INSERT INTO "Movies" (id, title, genre, duration, release_date, last_showing_date) VALUES
(gen_random_uuid(), 'The Great Adventure', 'Action', 120, '2023-06-01', '2023-08-31'),
(gen_random_uuid(), 'Love in Paris', 'Romance', 105, '2023-07-15', '2023-09-30'),
(gen_random_uuid(), 'Mystery of the Old Manor', 'Thriller', 110, '2023-08-01', '2023-10-15');


-- Insert sample Showings (3 showings for each movie)

WITH movie_ids AS (SELECT id FROM "Movies"),
     hall_ids AS (SELECT id FROM "Halls")
INSERT INTO "Showings" (id, hall_id, movie_id, start_time) VALUES
-- The Great Adventure
(gen_random_uuid(), (SELECT id FROM hall_ids LIMIT 1 OFFSET 0), (SELECT id FROM movie_ids LIMIT 1 OFFSET 0), '2023-08-15 18:00:00+00'),
(gen_random_uuid(), (SELECT id FROM hall_ids LIMIT 1 OFFSET 1), (SELECT id FROM movie_ids LIMIT 1 OFFSET 0), '2023-08-17 20:30:00+00'),
(gen_random_uuid(), (SELECT id FROM hall_ids LIMIT 1 OFFSET 2), (SELECT id FROM movie_ids LIMIT 1 OFFSET 0), '2023-08-19 15:00:00+00'),
-- Love in Paris
(gen_random_uuid(), (SELECT id FROM hall_ids LIMIT 1 OFFSET 1), (SELECT id FROM movie_ids LIMIT 1 OFFSET 1), '2023-08-15 20:00:00+00'),
(gen_random_uuid(), (SELECT id FROM hall_ids LIMIT 1 OFFSET 2), (SELECT id FROM movie_ids LIMIT 1 OFFSET 1), '2023-08-18 19:00:00+00'),
(gen_random_uuid(), (SELECT id FROM hall_ids LIMIT 1 OFFSET 3), (SELECT id FROM movie_ids LIMIT 1 OFFSET 1), '2023-08-20 17:30:00+00'),
-- Mystery of the Old Manor
(gen_random_uuid(), (SELECT id FROM hall_ids LIMIT 1 OFFSET 2), (SELECT id FROM movie_ids LIMIT 1 OFFSET 2), '2023-08-16 19:00:00+00'),
(gen_random_uuid(), (SELECT id FROM hall_ids LIMIT 1 OFFSET 3), (SELECT id FROM movie_ids LIMIT 1 OFFSET 2), '2023-08-18 21:00:00+00'),
(gen_random_uuid(), (SELECT id FROM hall_ids LIMIT 1 OFFSET 0), (SELECT id FROM movie_ids LIMIT 1 OFFSET 2), '2023-08-21 18:30:00+00');


-- Insert sample Users

INSERT INTO "Users" (id, username, email, phone, first_name, last_name, date_of_registration, last_modified_date, password) VALUES
(gen_random_uuid(), 'john_doe', 'john@example.com', '555-1111', 'John', 'Doe', '2023-01-01 10:00:00+00', '2023-01-01 10:00:00+00', 'hashed_password_1'),
(gen_random_uuid(), 'jane_smith', 'jane@example.com', '555-2222', 'Jane', 'Smith', '2023-02-15 14:30:00+00', '2023-02-15 14:30:00+00', 'hashed_password_2'),
(gen_random_uuid(), 'bob_johnson', 'bob@example.com', '555-3333', 'Bob', 'Johnson', '2023-03-20 09:45:00+00', '2023-03-20 09:45:00+00', 'hashed_password_3');
