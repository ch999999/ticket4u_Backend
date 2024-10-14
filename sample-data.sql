-- Insert sample Cinemas
INSERT INTO "Cinemas" (id, name, address, phone) VALUES
(gen_random_uuid(), 'Starlight Cinema', '123 Main St, Cityville', '555-0100'),
(gen_random_uuid(), 'Galaxy Theater', '456 Oak Ave, Townsburg', '555-0200');

-- Insert sample Halls
INSERT INTO "Halls" (id, cinema_id, name, capacity) VALUES
(gen_random_uuid(), (SELECT id FROM "Cinemas" WHERE name = 'Starlight Cinema'), 'Hall A', 70),
(gen_random_uuid(), (SELECT id FROM "Cinemas" WHERE name = 'Starlight Cinema'), 'Hall B', 70),
(gen_random_uuid(), (SELECT id FROM "Cinemas" WHERE name = 'Galaxy Theater'), 'Hall C', 70);

-- Insert sample Seats (70 seats for each hall: 7 rows, 10 seats per row)
INSERT INTO "Seats" (id, hall_id, row, number, type)
SELECT 
    gen_random_uuid(),
    hall.id, 
    chr(64 + row_number),
    seat_number,
    'Standard' as type
FROM 
    "Halls" hall
CROSS JOIN 
    generate_series(1, 7) as row_number
CROSS JOIN 
    generate_series(1, 10) as seat_number
ORDER BY 
    hall.id, row_number, seat_number;

-- Insert sample Movies
INSERT INTO "Movies" (id, title, genre, duration, release_date, last_showing_date) VALUES
(gen_random_uuid(), 'The Space Adventure', 'Sci-Fi', 120, '2024-05-15', '2024-08-15'),
(gen_random_uuid(), 'Love in Paris', 'Romance', 110, '2024-06-01', '2024-09-01'),
(gen_random_uuid(), 'The Mystery of the Lost City', 'Adventure', 135, '2024-07-01', '2024-10-01');

-- Insert sample Showings
INSERT INTO "Showings" (id, hall_id, movie_id, start_time, pricex100) VALUES
(gen_random_uuid(), (SELECT id FROM "Halls" WHERE name = 'Hall A'), (SELECT id FROM "Movies" WHERE title = 'The Space Adventure'), '2024-05-20 19:00:00+00', 1500),
(gen_random_uuid(), (SELECT id FROM "Halls" WHERE name = 'Hall B'), (SELECT id FROM "Movies" WHERE title = 'Love in Paris'), '2024-06-05 20:00:00+00', 1700),
(gen_random_uuid(), (SELECT id FROM "Halls" WHERE name = 'Hall C'), (SELECT id FROM "Movies" WHERE title = 'The Mystery of the Lost City'), '2024-07-10 18:30:00+00', 1600);

-- Insert sample Users - All passwords are password123 in plaintext
INSERT INTO "Users" (id, username, email, phone, first_name, last_name, date_of_registration, last_modified_date, password) VALUES
(gen_random_uuid(), 'user1', 'user1@example.com', '0122223333', 'User', 'One', '2024-01-15 10:00:00+00', '2024-01-15 10:00:00+00', '$2b$12$JrEq/AYYXV0gd2srNwk5i.YMmyx6MHA5ArfZ4OYnckSmki/U5MiVa'),
(gen_random_uuid(), 'user2', 'user2@example.com', '0133334444', 'User', 'Two', '2024-02-01 14:30:00+00', '2024-02-01 14:30:00+00', '$2b$12$31a.BZPw1Z/yk/MFDPI42eijpffUuSEplOl1s.SXM09C3yx8gUS.W'),
(gen_random_uuid(), 'user3', 'user3@example.com', '0144445555', 'User', 'Three', '2024-02-01 14:30:00+00', '2024-02-01 14:30:00+00', '$2b$12$Lsq0XiuKn6Vf/8mhzcwEWe7Gm7dTTVzrF6OJHAjnLaGsEh5txjm2i');