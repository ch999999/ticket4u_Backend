-- Insert single cinema
INSERT INTO "Cinemas" (id, name, address, phone)
VALUES (gen_random_uuid(), 'Megaplex Cinema', '789 Broadway St, Metropolis', '555-0300'),
(gen_random_uuid(), 'Gigaplex Cinema', '767 Main St, Downtown', '564-9033');

-- Insert 5 halls
INSERT INTO "Halls" (id, cinema_id, name, capacity)
SELECT gen_random_uuid(), 
       (SELECT id FROM "Cinemas" WHERE name = 'Megaplex Cinema'),
       'Hall ' || chr(64 + hall_number),
       70
FROM generate_series(1, 5) as hall_number;

-- Insert 70 seats for each hall (7 rows x 10 seats)
INSERT INTO "Seats" (id, hall_id, row, number, type)
SELECT gen_random_uuid(),
       hall.id,
       chr(64 + row_number),
       seat_number,
       'Standard' as type
FROM "Halls" hall
CROSS JOIN generate_series(1, 7) as row_number
CROSS JOIN generate_series(1, 10) as seat_number
ORDER BY hall.id, row_number, seat_number;

-- Insert movies
INSERT INTO "Movies" (id, title, genre, duration, release_date, last_showing_date, image_url, trailer_url, synopsis) VALUES
(gen_random_uuid(), 'Interstellar', 'Sci-Fi', 169, '2024-10-15', '2025-02-15', 'https://ticket4u-bucket.s3.ap-southeast-1.amazonaws.com/interstallar.jpg', 'https://www.youtube.com/embed/Lm8p5rlrSkY?si=q9J_mdKE887GP4gW', 'ARRRRRRRRRRRRRAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABBBBBBBBBBBBBBBBBBLAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAJKSSEFDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD'),
(gen_random_uuid(), 'Insidious', 'Horror', 110, '2024-10-20', '2025-02-20', 'https://ticket4u-bucket.s3.ap-southeast-1.amazonaws.com/insidious.jpg', 'https://www.youtube.com/embed/zuZnRUcoWos?si=UK377-d9eYMBDVCW', 'ARRRRRRRRRRRRRAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABBBBBBBBBBBBBBBBBBLAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAJKSSEFDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD'),
(gen_random_uuid(), 'JUON The Grudge', 'Horror', 115, '2024-10-25', '2025-02-25', 'https://ticket4u-bucket.s3.ap-southeast-1.amazonaws.com/juon-the-grudge.jpg', 'https://www.youtube.com/embed/BxbBdEA7ZCQ?si=FdlZnGacwfwHg_WF', 'ARRRRRRRRRRRRRAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABBBBBBBBBBBBBBBBBBLAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAJKSSEFDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD'),
(gen_random_uuid(), 'Alien Romulus', 'Sci-Fi/Horror', 125, '2024-10-30', '2025-02-28', 'https://ticket4u-bucket.s3.ap-southeast-1.amazonaws.com/alien-romulus.jpg', '', 'ARRRRRRRRRRRRRAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABBBBBBBBBBBBBBBBBBLAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAJKSSEFDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD'),
(gen_random_uuid(), 'The Babadook', 'Horror', 120, '2024-10-01', '2025-03-01', 'https://ticket4u-bucket.s3.ap-southeast-1.amazonaws.com/babadook.jpg', 'https://www.youtube.com/embed/k5WQZzDRVtw?si=chRXmJdRrWYYA-W2', 'ARRRRRRRRRRRRRAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABBBBBBBBBBBBBBBBBBLAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAJKSSEFDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD'),
(gen_random_uuid(), 'Captain America', 'Action', 140, '2024-10-05', '2025-03-05', 'https://ticket4u-bucket.s3.ap-southeast-1.amazonaws.com/captain-america.jpg', '', 'ARRRRRRRRRRRRRAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABBBBBBBBBBBBBBBBBBLAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAJKSSEFDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD'),
(gen_random_uuid(), 'Deadpool and Wolverine', 'Action', 135, '2024-10-10', '2025-03-10', 'https://ticket4u-bucket.s3.ap-southeast-1.amazonaws.com/deadpool-and-wolverine.jpg', '', 'ARRRRRRRRRRRRRAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABBBBBBBBBBBBBBBBBBLAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAJKSSEFDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD'),
(gen_random_uuid(), 'Terrifier 3', 'Horror', 118, '2024-10-15', '2025-03-15', 'https://ticket4u-bucket.s3.ap-southeast-1.amazonaws.com/terrifier-3.jpg', '', 'ARRRRRRRRRRRRRAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABBBBBBBBBBBBBBBBBBLAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAJKSSEFDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD'),
(gen_random_uuid(), 'Kungfu Hustle', 'Action/Comedy', 130, '2024-10-20', '2025-03-20', 'https://ticket4u-bucket.s3.ap-southeast-1.amazonaws.com/kungfu-hustle.jpg', '', 'ARRRRRRRRRRRRRAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABBBBBBBBBBBBBBBBBBLAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAJKSSEFDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD'),
(gen_random_uuid(), 'Matrix Reloaded', 'Sci-Fi/Action', 138, '2024-10-25', '2025-03-25', 'https://ticket4u-bucket.s3.ap-southeast-1.amazonaws.com/matrix-reloaded.jpg', '', 'ARRRRRRRRRRRRRAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABBBBBBBBBBBBBBBBBBLAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAJKSSEFDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD'),
(gen_random_uuid(), 'The Substance', 'Horror', 122, '2024-10-30', '2025-03-30', 'https://ticket4u-bucket.s3.ap-southeast-1.amazonaws.com/the-substance.jpg', '', 'ARRRRRRRRRRRRRAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABBBBBBBBBBBBBBBBBBLAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAJKSSEFDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD'),
(gen_random_uuid(), 'Never Let Go', 'Thriller', 128, '2024-10-05', '2025-04-05', 'https://ticket4u-bucket.s3.ap-southeast-1.amazonaws.com/never-let-go.jpg', '', 'ARRRRRRRRRRRRRAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABBBBBBBBBBBBBBBBBBLAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAJKSSEFDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD'),
(gen_random_uuid(), 'Speak No Evil', 'Horror', 117, '2024-10-10', '2025-04-10', 'https://ticket4u-bucket.s3.ap-southeast-1.amazonaws.com/speak-no-evil.jpg', '', 'ARRRRRRRRRRRRRAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABBBBBBBBBBBBBBBBBBLAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAJKSSEFDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD'),
(gen_random_uuid(), 'Transformers One', 'Action/Sci-Fi', 145, '2024-10-15', '2025-04-15', 'https://ticket4u-bucket.s3.ap-southeast-1.amazonaws.com/transformers-one.jpg', '', 'ARRRRRRRRRRRRRAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABBBBBBBBBBBBBBBBBBLAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAJKSSEFDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD');

-- Insert 3 showings for each movie
INSERT INTO "Showings" (id, hall_id, movie_id, start_time, pricex100)
SELECT 
    gen_random_uuid(),
    hall.id,
    movie.id,
    movie.release_date + (showing_number || ' days')::interval + 
    CASE (showing_number % 3)
        WHEN 0 THEN '14:00:00'::interval
        WHEN 1 THEN '17:30:00'::interval
        WHEN 2 THEN '20:00:00'::interval
    END,
    1500 + (random() * 500)::integer
FROM "Movies" movie
CROSS JOIN generate_series(1, 3) as showing_number
CROSS JOIN (
    SELECT id 
    FROM "Halls" 
    WHERE cinema_id = (SELECT id FROM "Cinemas" WHERE name = 'Megaplex Cinema')
    ORDER BY random()
    LIMIT 1
) hall;

-- Insert users with hashed passwords (password123)
INSERT INTO "Users" (id, username, email, phone, first_name, last_name, date_of_registration, last_modified_date, password)
VALUES 
    (gen_random_uuid(), 'user1', 'user1@example.com', '0122223333', 'User', 'One', '2024-01-15 10:00:00+00', '2024-01-15 10:00:00+00', '$2b$12$JrEq/AYYXV0gd2srNwk5i.YMmyx6MHA5ArfZ4OYnckSmki/U5MiVa'),
    (gen_random_uuid(), 'user2', 'user2@example.com', '0133334444', 'User', 'Two', '2024-02-01 14:30:00+00', '2024-02-01 14:30:00+00', '$2b$12$31a.BZPw1Z/yk/MFDPI42eijpffUuSEplOl1s.SXM09C3yx8gUS.W'),
    (gen_random_uuid(), 'user3', 'user3@example.com', '0144445555', 'User', 'Three', '2024-02-01 14:30:00+00', '2024-02-01 14:30:00+00', '$2b$12$Lsq0XiuKn6Vf/8mhzcwEWe7Gm7dTTVzrF6OJHAjnLaGsEh5txjm2i');