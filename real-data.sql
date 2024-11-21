--Insert Cinemas
INSERT INTO "Cinemas" (id, name, address, phone) VALUES
('57d85f41-6ecc-4bea-ac06-84c5cdfb3a91', 'T4U Mid Valley', '3rd Floor, Lot T-001 Mid Valley MegaMall, Lingkaran Syed Putra, Mid Valley City, 59200 Kuala Lumpur', '0355138999'),
('18371904-e151-4b67-8dc5-685174e79a74', 'T4U EkoCheras', 'T-01, Level 2A, EkoCheras Mall No 693, Batu, 5, Jln Cheras, 56000 Kuala Lumpur', '0355138999');


--Insert Halls
INSERT INTO "Halls" (id, cinema_id, name, capacity) VALUES
('06704009-4cda-4207-809b-d211cea25edd', '57d85f41-6ecc-4bea-ac06-84c5cdfb3a91', 'Hall A', 70),
('827465c3-a1fe-4245-b4bd-326b8371a502', '57d85f41-6ecc-4bea-ac06-84c5cdfb3a91', 'Hall B', 70),
('5aa22443-5fc6-46a6-9fe6-0261c015251e', '57d85f41-6ecc-4bea-ac06-84c5cdfb3a91', 'Hall C', 70),
('b7f76a6d-f8c3-404e-b20f-fce253237a28', '18371904-e151-4b67-8dc5-685174e79a74', 'Hall D', 70),
('f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', '18371904-e151-4b67-8dc5-685174e79a74', 'Hall E', 70),
('b3ba36ff-39f1-4325-8a23-d93f09996e49', '18371904-e151-4b67-8dc5-685174e79a74', 'Hall F', 70);


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


--Insert movies
INSERT INTO "Movies" (id, title, genre, duration, release_date, last_showing_date, image_url, trailer_url, synopsis) VALUES
('3d1fd545-0db9-4f54-914b-911e962d34b0', 'Red One', 'action', 120, '2024-10-01', '2024-12-31', 'https://ticket4u-bucket.s3.ap-southeast-1.amazonaws.com/red-one.jpg', 'https://www.youtube.com/embed/7l3hfD74X-4?si=EaUVzqtDSppI3BmS', 'A holiday-themed action-adventure involving a thrilling quest.'),
('3bbb4a0d-c774-443a-b44b-0ad7695a658b', 'Death Whisper 2', 'horror', 95, '2024-10-01', '2024-12-31', 'https://ticket4u-bucket.s3.ap-southeast-1.amazonaws.com/death-whisperer-2.jpg', 'https://www.youtube.com/embed/nR_Xntr_XKo?si=5KrdCiD5KgSh6C7B', 'A sequel to Death Whisper, following teens uncovering more mysteries and horrors.'),
('b91777df-7050-40a6-b5d2-1549b34e20ff', 'Don Dukun', 'comedy', 100, '2024-10-01', '2024-12-31', 'https://ticket4u-bucket.s3.ap-southeast-1.amazonaws.com/don-dukun.jpg', 'https://www.youtube.com/embed/mirAy8FN6RY?si=2WqvBcm63kQ4xoSj', 'After finding a mysterious artifact, a man finds himself possessed by a centuries-old spirit.'),
('d349bc89-793e-4bed-a684-3bbc97162d51', 'Venom: The Last Dance', 'action', 110, '2024-10-01', '2024-12-31', 'https://ticket4u-bucket.s3.ap-southeast-1.amazonaws.com/venom-the-last-dance.jpg', 'https://www.youtube.com/embed/HyIyd9joTTc?si=hMdwW0Ky_1qp27hU', 'The final chapter of the journey of Eddie Brock as Venom, facing his ultimate nemesis.'),
('8312a1c5-f285-4602-b9ef-2ce88aa79062', 'Smile 2', 'horror', 98, '2024-10-01', '2024-12-31', 'https://ticket4u-bucket.s3.ap-southeast-1.amazonaws.com/smile-2.jpg', 'https://www.youtube.com/embed/0HY6QFlBzUY?si=uJR_WHNaJwr1Vv88', 'A continuation of the terrifying story that explores the spread of supernatural horrors.'),
('e33a67d8-eb0d-46f7-b895-3688679910ad', 'Moana 2', 'animation', 90, '2024-10-01', '2024-12-31', 'https://ticket4u-bucket.s3.ap-southeast-1.amazonaws.com/moana-2.jpg', 'https://www.youtube.com/embed/hDZ7y8RP5HE?si=vys84f1ekGOUlFdl', 'Moana embarks on a new journey across the seas to save her island once again.'),
('d6949d54-041e-4972-9348-28b52f49cc4b', 'Mufasa: The Lion King', 'animation', 85, '2024-10-01', '2024-12-31', 'https://ticket4u-bucket.s3.ap-southeast-1.amazonaws.com/mufasa-the-lion-king.jpg', 'https://www.youtube.com/embed/lMXh6vjiZrI?si=wZpnElzg3dyzTDUD', 'The origin story of Mufasa, exploring his rise to power.'),
('19eae21d-cd9e-4cf7-9269-8a1adc9b416d', 'Sonic 3', 'action', 105, '2024-10-01', '2024-12-31', 'https://ticket4u-bucket.s3.ap-southeast-1.amazonaws.com/sonic-the-hedgehog-3.jpg', 'https://www.youtube.com/embed/qSu6i2iFMO0?si=5m988tZhWAnkdG4m', 'Sonic, Tails, and Knuckles team up to face a new villain.'),
('11429350-41f3-4b4a-ab7c-4dbcf6f3dbba', 'Dongeng Sang Kancil', 'adventure', 80, '2024-10-01', '2024-12-31', 'https://ticket4u-bucket.s3.ap-southeast-1.amazonaws.com/dongeng-sang-kancil.jpg', 'https://www.youtube.com/embed/ArQpTYHixl0?si=pnTqj2ncCjjbIv_K', 'An animated retelling of the classic Malay folktales of Sang Kancil.'),
('8b32f48d-6bc0-4891-a009-aeba59ee2c52', 'Kraven the Hunter', 'action', 130, '2024-10-01', '2024-12-31', 'https://ticket4u-bucket.s3.ap-southeast-1.amazonaws.com/kraven-the-hunter.jpg', 'https://www.youtube.com/embed/hR1-ihzff3I?si=A-jBO8tXnUYkxf2O', 'A skilled hunter from Marvel comics, Kraven faces new challenges in the city.'),
('c8c74caf-55f8-45a7-bbb3-d0cfa2fb6d10', 'Gladiator 2', 'action', 140, '2024-10-01', '2024-12-31', 'https://ticket4u-bucket.s3.ap-southeast-1.amazonaws.com/gladiator-2.jpg', 'https://www.youtube.com/embed/4rgYUipGJNo?si=_5aGgRUQUspWH6Lp', 'The story follows a new warrior rising in Rome after the fall of Maximus.'),
('347a0fc6-0541-44b4-aead-c34f7f783f10', 'Cesium Fallout', 'sci-fi', 115, '2024-10-01', '2024-12-31', 'https://ticket4u-bucket.s3.ap-southeast-1.amazonaws.com/cesium-fallout.jpg', 'https://www.youtube.com/embed/fUMNq662wWE?si=gnyZlZaOLjKy5m7H', 'After a nuclear accident, a scientist must save humanity from radioactive fallout.'),
('68f0c881-371f-4a2d-8ea4-03b23004a7f0', 'Dear Santa', 'drama', 102, '2024-10-01', '2024-12-31', 'https://ticket4u-bucket.s3.ap-southeast-1.amazonaws.com/dear_santa.jpg', 'https://www.youtube.com/embed/TuJ3mM001Os?si=ekZ3_yxzYwREDz8Y', 'A young woman writes letters to Santa, only to get responses that change her life.'),
('aba38539-abdb-4db6-818a-df092ffb8601', 'A Sudden Case of Christmas', 'romance', 88, '2024-10-01', '2024-12-31', 'https://ticket4u-bucket.s3.ap-southeast-1.amazonaws.com/sudden-case-of-christmas.jpg', 'https://www.youtube.com/embed/KcTCsSUxjPM?si=MQSH60rAafcaQZuJ', 'A workaholic wakes up to find herself in a magical town that celebrates Christmas every day.'),
('a616704c-9e54-47e3-a8ec-cb32398d1dbe', 'The Best Christmas Pageant Ever', 'comedy', 95, '2024-10-01', '2024-12-31', 'https://ticket4u-bucket.s3.ap-southeast-1.amazonaws.com/best-christmas-peagant-ever.jpg', 'https://www.youtube.com/embed/cT7x4HpCICc?si=IPA6QOXpG9wca-6I', 'Chaos ensues when a group of troublemakers joins the town Christmas pageant.');


INSERT INTO "Showings" (id, hall_id, movie_id, start_time, pricex100) VALUES
-- Hall A (Dec 1)
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', '3d1fd545-0db9-4f54-914b-911e962d34b0', '2024-11-30 17:00:00+00:00', 1500),
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', '3bbb4a0d-c774-443a-b44b-0ad7695a658b', '2024-12-01 02:00:00+00:00', 1500),
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', 'b91777df-7050-40a6-b5d2-1549b34e20ff', '2024-12-01 05:00:00+00:00', 1500),
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', 'd349bc89-793e-4bed-a684-3bbc97162d51', '2024-12-01 08:00:00+00:00', 1800),
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', '8312a1c5-f285-4602-b9ef-2ce88aa79062', '2024-12-01 11:00:00+00:00', 1800),
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', 'e33a67d8-eb0d-46f7-b895-3688679910ad', '2024-12-01 14:00:00+00:00', 1800),

-- Hall B (Dec 1)
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', '11429350-41f3-4b4a-ab7c-4dbcf6f3dbba', '2024-11-30 17:00:00+00:00', 1500),
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', 'b91777df-7050-40a6-b5d2-1549b34e20ff', '2024-12-01 02:00:00+00:00', 1500),
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', '8b32f48d-6bc0-4891-a009-aeba59ee2c52', '2024-12-01 05:00:00+00:00', 1500),
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', '3d1fd545-0db9-4f54-914b-911e962d34b0', '2024-12-01 08:00:00+00:00', 1800),
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', 'c8c74caf-55f8-45a7-bbb3-d0cfa2fb6d10', '2024-12-01 11:00:00+00:00', 1800),
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', '19eae21d-cd9e-4cf7-9269-8a1adc9b416d', '2024-12-01 14:00:00+00:00', 1800),

-- Hall C (Dec 1)
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', '19eae21d-cd9e-4cf7-9269-8a1adc9b416d', '2024-11-30 17:00:00+00:00', 1500),
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', '68f0c881-371f-4a2d-8ea4-03b23004a7f0', '2024-12-01 02:00:00+00:00', 1500),
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', 'aba38539-abdb-4db6-818a-df092ffb8601', '2024-12-01 05:00:00+00:00', 1500),
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', 'd6949d54-041e-4972-9348-28b52f49cc4b', '2024-12-01 08:00:00+00:00', 1800),
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', 'd349bc89-793e-4bed-a684-3bbc97162d51', '2024-12-01 11:00:00+00:00', 1800),
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', 'a616704c-9e54-47e3-a8ec-cb32398d1dbe', '2024-12-01 14:00:00+00:00', 1800),

-- Hall D (Dec 1)
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', '68f0c881-371f-4a2d-8ea4-03b23004a7f0', '2024-11-30 17:00:00+00:00', 1500),
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', 'aba38539-abdb-4db6-818a-df092ffb8601', '2024-12-01 02:00:00+00:00', 1500),
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', 'd6949d54-041e-4972-9348-28b52f49cc4b', '2024-12-01 05:00:00+00:00', 1500),
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', 'd349bc89-793e-4bed-a684-3bbc97162d51', '2024-12-01 08:00:00+00:00', 1800),
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', 'c8c74caf-55f8-45a7-bbb3-d0cfa2fb6d10', '2024-12-01 11:00:00+00:00', 1800),
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', '19eae21d-cd9e-4cf7-9269-8a1adc9b416d', '2024-12-01 14:00:00+00:00', 1800),

-- Hall E (Dec 1)
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', '11429350-41f3-4b4a-ab7c-4dbcf6f3dbba', '2024-11-30 17:00:00+00:00', 1500),
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', 'e33a67d8-eb0d-46f7-b895-3688679910ad', '2024-12-01 02:00:00+00:00', 1500),
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', '347a0fc6-0541-44b4-aead-c34f7f783f10', '2024-12-01 05:00:00+00:00', 1500),
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', '19eae21d-cd9e-4cf7-9269-8a1adc9b416d', '2024-12-01 08:00:00+00:00', 1800),
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', '68f0c881-371f-4a2d-8ea4-03b23004a7f0', '2024-12-01 11:00:00+00:00', 1800),
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', 'aba38539-abdb-4db6-818a-df092ffb8601', '2024-12-01 14:00:00+00:00', 1800),

-- Hall F (Dec 1)
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', 'c8c74caf-55f8-45a7-bbb3-d0cfa2fb6d10', '2024-11-30 17:00:00+00:00', 1500),
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', '19eae21d-cd9e-4cf7-9269-8a1adc9b416d', '2024-12-01 02:00:00+00:00', 1500),
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', '68f0c881-371f-4a2d-8ea4-03b23004a7f0', '2024-12-01 05:00:00+00:00', 1500),
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', 'aba38539-abdb-4db6-818a-df092ffb8601', '2024-12-01 08:00:00+00:00', 1800),
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', 'd6949d54-041e-4972-9348-28b52f49cc4b', '2024-12-01 11:00:00+00:00', 1800),
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', 'd349bc89-793e-4bed-a684-3bbc97162d51', '2024-12-01 14:00:00+00:00', 1800);


INSERT INTO "Showings" (id, hall_id, movie_id, start_time, pricex100) VALUES
-- Hall A (Dec 2)
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', 'd6949d54-041e-4972-9348-28b52f49cc4b', '2024-12-01 17:00:00+00:00', 1800),
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', '19eae21d-cd9e-4cf7-9269-8a1adc9b416d', '2024-12-02 02:00:00+00:00', 1500),
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', '11429350-41f3-4b4a-ab7c-4dbcf6f3dbba', '2024-12-02 05:00:00+00:00', 1500),
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', '8b32f48d-6bc0-4891-a009-aeba59ee2c52', '2024-12-02 08:00:00+00:00', 1800),
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', 'c8c74caf-55f8-45a7-bbb3-d0cfa2fb6d10', '2024-12-02 11:00:00+00:00', 1800),
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', '347a0fc6-0541-44b4-aead-c34f7f783f10', '2024-12-02 14:00:00+00:00', 1800),

-- Hall B (Dec 2)
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', '347a0fc6-0541-44b4-aead-c34f7f783f10', '2024-12-01 17:00:00+00:00', 1800),
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', 'd349bc89-793e-4bed-a684-3bbc97162d51', '2024-12-02 02:00:00+00:00', 1500),
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', '3bbb4a0d-c774-443a-b44b-0ad7695a658b', '2024-12-02 05:00:00+00:00', 1500),
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', 'aba38539-abdb-4db6-818a-df092ffb8601', '2024-12-02 08:00:00+00:00', 1800),
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', '68f0c881-371f-4a2d-8ea4-03b23004a7f0', '2024-12-02 11:00:00+00:00', 1800),
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', 'd6949d54-041e-4972-9348-28b52f49cc4b', '2024-12-02 14:00:00+00:00', 1800),

-- Hall C (Dec 2)
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', '3d1fd545-0db9-4f54-914b-911e962d34b0', '2024-12-01 17:00:00+00:00', 1800),
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', '8b32f48d-6bc0-4891-a009-aeba59ee2c52', '2024-12-02 02:00:00+00:00', 1500),
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', '3bbb4a0d-c774-443a-b44b-0ad7695a658b', '2024-12-02 05:00:00+00:00', 1500),
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', '11429350-41f3-4b4a-ab7c-4dbcf6f3dbba', '2024-12-02 08:00:00+00:00', 1800),
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', 'e33a67d8-eb0d-46f7-b895-3688679910ad', '2024-12-02 11:00:00+00:00', 1800),
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', '347a0fc6-0541-44b4-aead-c34f7f783f10', '2024-12-02 14:00:00+00:00', 1800),

-- Hall D (Dec 2)
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', '68f0c881-371f-4a2d-8ea4-03b23004a7f0', '2024-12-01 17:00:00+00:00', 1800),
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', 'aba38539-abdb-4db6-818a-df092ffb8601', '2024-12-02 02:00:00+00:00', 1500),
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', 'd6949d54-041e-4972-9348-28b52f49cc4b', '2024-12-02 05:00:00+00:00', 1500),
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', 'd349bc89-793e-4bed-a684-3bbc97162d51', '2024-12-02 08:00:00+00:00', 1800),
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', 'a616704c-9e54-47e3-a8ec-cb32398d1dbe', '2024-12-02 11:00:00+00:00', 1800),
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', '3d1fd545-0db9-4f54-914b-911e962d34b0', '2024-12-02 14:00:00+00:00', 1800),

-- Hall E (Dec 2)
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', 'd6949d54-041e-4972-9348-28b52f49cc4b', '2024-12-01 17:00:00+00:00', 1800),
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', 'd349bc89-793e-4bed-a684-3bbc97162d51', '2024-12-02 02:00:00+00:00', 1500),
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', 'a616704c-9e54-47e3-a8ec-cb32398d1dbe', '2024-12-02 05:00:00+00:00', 1500),
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', '3d1fd545-0db9-4f54-914b-911e962d34b0', '2024-12-02 08:00:00+00:00', 1800),
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', '8b32f48d-6bc0-4891-a009-aeba59ee2c52', '2024-12-02 11:00:00+00:00', 1800),
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', '3bbb4a0d-c774-443a-b44b-0ad7695a658b', '2024-12-02 14:00:00+00:00', 1800),

-- Hall F (Dec 2)
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', 'a616704c-9e54-47e3-a8ec-cb32398d1dbe', '2024-12-01 17:00:00+00:00', 1800),
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', '3d1fd545-0db9-4f54-914b-911e962d34b0', '2024-12-02 02:00:00+00:00', 1500),
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', '8b32f48d-6bc0-4891-a009-aeba59ee2c52', '2024-12-02 05:00:00+00:00', 1500),
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', '3bbb4a0d-c774-443a-b44b-0ad7695a658b', '2024-12-02 08:00:00+00:00', 1800),
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', '11429350-41f3-4b4a-ab7c-4dbcf6f3dbba', '2024-12-02 11:00:00+00:00', 1800),
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', 'e33a67d8-eb0d-46f7-b895-3688679910ad', '2024-12-02 14:00:00+00:00', 1800);


INSERT INTO "Showings" (id, hall_id, movie_id, start_time, pricex100) VALUES
-- Hall A (Dec 3)
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', '68f0c881-371f-4a2d-8ea4-03b23004a7f0', '2024-12-02 17:00:00+00:00', 1800),
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', 'aba38539-abdb-4db6-818a-df092ffb8601', '2024-12-03 02:00:00+00:00', 1500),
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', 'a616704c-9e54-47e3-a8ec-cb32398d1dbe', '2024-12-03 05:00:00+00:00', 1500),
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', '3d1fd545-0db9-4f54-914b-911e962d34b0', '2024-12-03 08:00:00+00:00', 1800),
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', '3bbb4a0d-c774-443a-b44b-0ad7695a658b', '2024-12-03 11:00:00+00:00', 1800),
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', 'b91777df-7050-40a6-b5d2-1549b34e20ff', '2024-12-03 14:00:00+00:00', 1800),

-- Hall B (Dec 3)
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', '8312a1c5-f285-4602-b9ef-2ce88aa79062', '2024-12-02 17:00:00+00:00', 1800),
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', 'e33a67d8-eb0d-46f7-b895-3688679910ad', '2024-12-03 02:00:00+00:00', 1500),
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', 'a616704c-9e54-47e3-a8ec-cb32398d1dbe', '2024-12-03 05:00:00+00:00', 1500),
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', '11429350-41f3-4b4a-ab7c-4dbcf6f3dbba', '2024-12-03 08:00:00+00:00', 1800),
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', 'b91777df-7050-40a6-b5d2-1549b34e20ff', '2024-12-03 11:00:00+00:00', 1800),
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', '8b32f48d-6bc0-4891-a009-aeba59ee2c52', '2024-12-03 14:00:00+00:00', 1800),

-- Hall C (Dec 3)
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', 'b91777df-7050-40a6-b5d2-1549b34e20ff', '2024-12-02 17:00:00+00:00', 1800),
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', '8312a1c5-f285-4602-b9ef-2ce88aa79062', '2024-12-03 02:00:00+00:00', 1500),
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', 'c8c74caf-55f8-45a7-bbb3-d0cfa2fb6d10', '2024-12-03 05:00:00+00:00', 1500),
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', '19eae21d-cd9e-4cf7-9269-8a1adc9b416d', '2024-12-03 08:00:00+00:00', 1800),
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', '68f0c881-371f-4a2d-8ea4-03b23004a7f0', '2024-12-03 11:00:00+00:00', 1800),
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', 'aba38539-abdb-4db6-818a-df092ffb8601', '2024-12-03 14:00:00+00:00', 1800),

-- Hall D (Dec 3)
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', '8b32f48d-6bc0-4891-a009-aeba59ee2c52', '2024-12-02 17:00:00+00:00', 1800),
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', '3bbb4a0d-c774-443a-b44b-0ad7695a658b', '2024-12-03 02:00:00+00:00', 1500),
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', '11429350-41f3-4b4a-ab7c-4dbcf6f3dbba', '2024-12-03 05:00:00+00:00', 1500),
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', 'e33a67d8-eb0d-46f7-b895-3688679910ad', '2024-12-03 08:00:00+00:00', 1800),
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', '347a0fc6-0541-44b4-aead-c34f7f783f10', '2024-12-03 11:00:00+00:00', 1800),
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', 'b91777df-7050-40a6-b5d2-1549b34e20ff', '2024-12-03 14:00:00+00:00', 1800),

-- Hall E (Dec 3)
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', '11429350-41f3-4b4a-ab7c-4dbcf6f3dbba', '2024-12-02 17:00:00+00:00', 1800),
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', 'e33a67d8-eb0d-46f7-b895-3688679910ad', '2024-12-03 02:00:00+00:00', 1500),
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', '347a0fc6-0541-44b4-aead-c34f7f783f10', '2024-12-03 05:00:00+00:00', 1500),
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', 'b91777df-7050-40a6-b5d2-1549b34e20ff', '2024-12-03 08:00:00+00:00', 1800),
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', '8312a1c5-f285-4602-b9ef-2ce88aa79062', '2024-12-03 11:00:00+00:00', 1800),
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', 'c8c74caf-55f8-45a7-bbb3-d0cfa2fb6d10', '2024-12-03 14:00:00+00:00', 1800),

-- Hall F (Dec 3)
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', '347a0fc6-0541-44b4-aead-c34f7f783f10', '2024-12-02 17:00:00+00:00', 1800),
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', 'b91777df-7050-40a6-b5d2-1549b34e20ff', '2024-12-03 02:00:00+00:00', 1500),
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', '8312a1c5-f285-4602-b9ef-2ce88aa79062', '2024-12-03 05:00:00+00:00', 1500),
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', 'c8c74caf-55f8-45a7-bbb3-d0cfa2fb6d10', '2024-12-03 08:00:00+00:00', 1800),
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', '19eae21d-cd9e-4cf7-9269-8a1adc9b416d', '2024-12-03 11:00:00+00:00', 1800),
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', '68f0c881-371f-4a2d-8ea4-03b23004a7f0', '2024-12-03 14:00:00+00:00', 1800);


INSERT INTO "Showings" (id, hall_id, movie_id, start_time, pricex100) VALUES
-- Hall A (Dec 4)
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', 'd349bc89-793e-4bed-a684-3bbc97162d51', '2024-12-03 17:00:00+00:00', 1800),
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', '8312a1c5-f285-4602-b9ef-2ce88aa79062', '2024-12-04 02:00:00+00:00', 1500),
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', 'e33a67d8-eb0d-46f7-b895-3688679910ad', '2024-12-04 05:00:00+00:00', 1500),
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', 'd6949d54-041e-4972-9348-28b52f49cc4b', '2024-12-04 08:00:00+00:00', 1800),
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', '19eae21d-cd9e-4cf7-9269-8a1adc9b416d', '2024-12-04 11:00:00+00:00', 1800),
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', '11429350-41f3-4b4a-ab7c-4dbcf6f3dbba', '2024-12-04 14:00:00+00:00', 1800),

-- Hall B (Dec 4)
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', '3d1fd545-0db9-4f54-914b-911e962d34b0', '2024-12-03 17:00:00+00:00', 1800),
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', 'c8c74caf-55f8-45a7-bbb3-d0cfa2fb6d10', '2024-12-04 02:00:00+00:00', 1500),
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', '19eae21d-cd9e-4cf7-9269-8a1adc9b416d', '2024-12-04 05:00:00+00:00', 1500),
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', '347a0fc6-0541-44b4-aead-c34f7f783f10', '2024-12-04 08:00:00+00:00', 1800),
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', 'd349bc89-793e-4bed-a684-3bbc97162d51', '2024-12-04 11:00:00+00:00', 1800),
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', '3bbb4a0d-c774-443a-b44b-0ad7695a658b', '2024-12-04 14:00:00+00:00', 1800),

-- Hall C (Dec 4)
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', 'd6949d54-041e-4972-9348-28b52f49cc4b', '2024-12-03 17:00:00+00:00', 1800),
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', 'd349bc89-793e-4bed-a684-3bbc97162d51', '2024-12-04 02:00:00+00:00', 1500),
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', 'a616704c-9e54-47e3-a8ec-cb32398d1dbe', '2024-12-04 05:00:00+00:00', 1500),
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', '3d1fd545-0db9-4f54-914b-911e962d34b0', '2024-12-04 08:00:00+00:00', 1800),
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', '8b32f48d-6bc0-4891-a009-aeba59ee2c52', '2024-12-04 11:00:00+00:00', 1800),
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', '3bbb4a0d-c774-443a-b44b-0ad7695a658b', '2024-12-04 14:00:00+00:00', 1800),

-- Hall D (Dec 4)
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', '8312a1c5-f285-4602-b9ef-2ce88aa79062', '2024-12-03 17:00:00+00:00', 1800),
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', 'c8c74caf-55f8-45a7-bbb3-d0cfa2fb6d10', '2024-12-04 02:00:00+00:00', 1500),
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', '19eae21d-cd9e-4cf7-9269-8a1adc9b416d', '2024-12-04 05:00:00+00:00', 1500),
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', '68f0c881-371f-4a2d-8ea4-03b23004a7f0', '2024-12-04 08:00:00+00:00', 1800),
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', 'aba38539-abdb-4db6-818a-df092ffb8601', '2024-12-04 11:00:00+00:00', 1800),
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', 'd6949d54-041e-4972-9348-28b52f49cc4b', '2024-12-04 14:00:00+00:00', 1800),

-- Hall E (Dec 4)
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', '19eae21d-cd9e-4cf7-9269-8a1adc9b416d', '2024-12-03 17:00:00+00:00', 1800),
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', '68f0c881-371f-4a2d-8ea4-03b23004a7f0', '2024-12-04 02:00:00+00:00', 1500),
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', 'aba38539-abdb-4db6-818a-df092ffb8601', '2024-12-04 05:00:00+00:00', 1500),
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', 'd6949d54-041e-4972-9348-28b52f49cc4b', '2024-12-04 08:00:00+00:00', 1800),
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', 'd349bc89-793e-4bed-a684-3bbc97162d51', '2024-12-04 11:00:00+00:00', 1800),
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', 'a616704c-9e54-47e3-a8ec-cb32398d1dbe', '2024-12-04 14:00:00+00:00', 1800),

-- Hall F (Dec 4)
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', 'aba38539-abdb-4db6-818a-df092ffb8601', '2024-12-03 17:00:00+00:00', 1800),
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', 'd6949d54-041e-4972-9348-28b52f49cc4b', '2024-12-04 02:00:00+00:00', 1500),
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', 'd349bc89-793e-4bed-a684-3bbc97162d51', '2024-12-04 05:00:00+00:00', 1500),
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', 'a616704c-9e54-47e3-a8ec-cb32398d1dbe', '2024-12-04 08:00:00+00:00', 1800),
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', '3d1fd545-0db9-4f54-914b-911e962d34b0', '2024-12-04 11:00:00+00:00', 1800),
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', '8b32f48d-6bc0-4891-a009-aeba59ee2c52', '2024-12-04 14:00:00+00:00', 1800);


INSERT INTO "Showings" (id, hall_id, movie_id, start_time, pricex100) VALUES
-- Hall A (Dec 5)
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', '8b32f48d-6bc0-4891-a009-aeba59ee2c52', '2024-12-04 17:00:00+00:00', 1800),
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', 'c8c74caf-55f8-45a7-bbb3-d0cfa2fb6d10', '2024-12-05 02:00:00+00:00', 1500),
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', '347a0fc6-0541-44b4-aead-c34f7f783f10', '2024-12-05 05:00:00+00:00', 1500),
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', '68f0c881-371f-4a2d-8ea4-03b23004a7f0', '2024-12-05 08:00:00+00:00', 1800),
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', 'aba38539-abdb-4db6-818a-df092ffb8601', '2024-12-05 11:00:00+00:00', 1800),
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', 'a616704c-9e54-47e3-a8ec-cb32398d1dbe', '2024-12-05 14:00:00+00:00', 1800),

-- Hall B (Dec 5)
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', 'aba38539-abdb-4db6-818a-df092ffb8601', '2024-12-04 17:00:00+00:00', 1800),
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', '68f0c881-371f-4a2d-8ea4-03b23004a7f0', '2024-12-05 02:00:00+00:00', 1500),
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', 'd6949d54-041e-4972-9348-28b52f49cc4b', '2024-12-05 05:00:00+00:00', 1500),
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', '8312a1c5-f285-4602-b9ef-2ce88aa79062', '2024-12-05 08:00:00+00:00', 1800),
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', 'e33a67d8-eb0d-46f7-b895-3688679910ad', '2024-12-05 11:00:00+00:00', 1800),
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', 'a616704c-9e54-47e3-a8ec-cb32398d1dbe', '2024-12-05 14:00:00+00:00', 1800),

-- Hall C (Dec 5)
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', '11429350-41f3-4b4a-ab7c-4dbcf6f3dbba', '2024-12-04 17:00:00+00:00', 1800),
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', 'e33a67d8-eb0d-46f7-b895-3688679910ad', '2024-12-05 02:00:00+00:00', 1500),
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', '347a0fc6-0541-44b4-aead-c34f7f783f10', '2024-12-05 05:00:00+00:00', 1500),
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', 'b91777df-7050-40a6-b5d2-1549b34e20ff', '2024-12-05 08:00:00+00:00', 1800),
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', '8312a1c5-f285-4602-b9ef-2ce88aa79062', '2024-12-05 11:00:00+00:00', 1800),
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', 'c8c74caf-55f8-45a7-bbb3-d0cfa2fb6d10', '2024-12-05 14:00:00+00:00', 1800),

-- Hall D (Dec 5)
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', 'd349bc89-793e-4bed-a684-3bbc97162d51', '2024-12-04 17:00:00+00:00', 1800),
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', 'a616704c-9e54-47e3-a8ec-cb32398d1dbe', '2024-12-05 02:00:00+00:00', 1500),
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', '3d1fd545-0db9-4f54-914b-911e962d34b0', '2024-12-05 05:00:00+00:00', 1500),
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', '8b32f48d-6bc0-4891-a009-aeba59ee2c52', '2024-12-05 08:00:00+00:00', 1800),
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', '3bbb4a0d-c774-443a-b44b-0ad7695a658b', '2024-12-05 11:00:00+00:00', 1800),
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', '11429350-41f3-4b4a-ab7c-4dbcf6f3dbba', '2024-12-05 14:00:00+00:00', 1800),

-- Hall E (Dec 5)
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', '3d1fd545-0db9-4f54-914b-911e962d34b0', '2024-12-04 17:00:00+00:00', 1800),
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', '8b32f48d-6bc0-4891-a009-aeba59ee2c52', '2024-12-05 02:00:00+00:00', 1500),
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', '3bbb4a0d-c774-443a-b44b-0ad7695a658b', '2024-12-05 05:00:00+00:00', 1500),
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', '11429350-41f3-4b4a-ab7c-4dbcf6f3dbba', '2024-12-05 08:00:00+00:00', 1800),
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', 'e33a67d8-eb0d-46f7-b895-3688679910ad', '2024-12-05 11:00:00+00:00', 1800),
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', '347a0fc6-0541-44b4-aead-c34f7f783f10', '2024-12-05 14:00:00+00:00', 1800),

-- Hall F (Dec 5)
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', '3bbb4a0d-c774-443a-b44b-0ad7695a658b', '2024-12-04 17:00:00+00:00', 1800),
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', '11429350-41f3-4b4a-ab7c-4dbcf6f3dbba', '2024-12-05 02:00:00+00:00', 1500),
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', 'e33a67d8-eb0d-46f7-b895-3688679910ad', '2024-12-05 05:00:00+00:00', 1500),
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', '347a0fc6-0541-44b4-aead-c34f7f783f10', '2024-12-05 08:00:00+00:00', 1800),
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', 'b91777df-7050-40a6-b5d2-1549b34e20ff', '2024-12-05 11:00:00+00:00', 1800),
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', '8312a1c5-f285-4602-b9ef-2ce88aa79062', '2024-12-05 14:00:00+00:00', 1800);


INSERT INTO "Showings" (id, hall_id, movie_id, start_time, pricex100) VALUES
-- Hall A (Dec 6)
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', '347a0fc6-0541-44b4-aead-c34f7f783f10', '2024-12-05 17:00:00+00:00', 1800),
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', 'a616704c-9e54-47e3-a8ec-cb32398d1dbe', '2024-12-06 02:00:00+00:00', 1500),
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', '3d1fd545-0db9-4f54-914b-911e962d34b0', '2024-12-06 05:00:00+00:00', 1500),
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', '3bbb4a0d-c774-443a-b44b-0ad7695a658b', '2024-12-06 08:00:00+00:00', 1800),
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', 'b91777df-7050-40a6-b5d2-1549b34e20ff', '2024-12-06 11:00:00+00:00', 1800),
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', 'd349bc89-793e-4bed-a684-3bbc97162d51', '2024-12-06 14:00:00+00:00', 1800),

-- Hall B (Dec 6)
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', '8312a1c5-f285-4602-b9ef-2ce88aa79062', '2024-12-05 17:00:00+00:00', 1800),
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', 'e33a67d8-eb0d-46f7-b895-3688679910ad', '2024-12-06 02:00:00+00:00', 1500),
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', '11429350-41f3-4b4a-ab7c-4dbcf6f3dbba', '2024-12-06 05:00:00+00:00', 1500),
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', 'b91777df-7050-40a6-b5d2-1549b34e20ff', '2024-12-06 08:00:00+00:00', 1800),
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', '8b32f48d-6bc0-4891-a009-aeba59ee2c52', '2024-12-06 11:00:00+00:00', 1800),
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', '3d1fd545-0db9-4f54-914b-911e962d34b0', '2024-12-06 14:00:00+00:00', 1800),

-- Hall C (Dec 6)
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', '19eae21d-cd9e-4cf7-9269-8a1adc9b416d', '2024-12-05 17:00:00+00:00', 1800),
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', 'c8c74caf-55f8-45a7-bbb3-d0cfa2fb6d10', '2024-12-06 02:00:00+00:00', 1500),
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', '19eae21d-cd9e-4cf7-9269-8a1adc9b416d', '2024-12-06 05:00:00+00:00', 1500),
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', '68f0c881-371f-4a2d-8ea4-03b23004a7f0', '2024-12-06 08:00:00+00:00', 1800),
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', 'aba38539-abdb-4db6-818a-df092ffb8601', '2024-12-06 11:00:00+00:00', 1800),
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', 'd6949d54-041e-4972-9348-28b52f49cc4b', '2024-12-06 14:00:00+00:00', 1800),

-- Hall D (Dec 6)
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', 'e33a67d8-eb0d-46f7-b895-3688679910ad', '2024-12-05 17:00:00+00:00', 1800),
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', 'b91777df-7050-40a6-b5d2-1549b34e20ff', '2024-12-06 02:00:00+00:00', 1500),
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', '8b32f48d-6bc0-4891-a009-aeba59ee2c52', '2024-12-06 05:00:00+00:00', 1500),
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', '3d1fd545-0db9-4f54-914b-911e962d34b0', '2024-12-06 08:00:00+00:00', 1800),
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', 'c8c74caf-55f8-45a7-bbb3-d0cfa2fb6d10', '2024-12-06 11:00:00+00:00', 1800),
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', 'a616704c-9e54-47e3-a8ec-cb32398d1dbe', '2024-12-06 14:00:00+00:00', 1800),

-- Hall E (Dec 6)
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', 'b91777df-7050-40a6-b5d2-1549b34e20ff', '2024-12-05 17:00:00+00:00', 1800),
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', 'aba38539-abdb-4db6-818a-df092ffb8601', '2024-12-06 02:00:00+00:00', 1500),
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', '68f0c881-371f-4a2d-8ea4-03b23004a7f0', '2024-12-06 05:00:00+00:00', 1500),
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', 'd6949d54-041e-4972-9348-28b52f49cc4b', '2024-12-06 08:00:00+00:00', 1800),
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', '11429350-41f3-4b4a-ab7c-4dbcf6f3dbba', '2024-12-06 11:00:00+00:00', 1800),
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', 'b91777df-7050-40a6-b5d2-1549b34e20ff', '2024-12-06 14:00:00+00:00', 1800),

-- Hall F (Dec 6)
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', 'c8c74caf-55f8-45a7-bbb3-d0cfa2fb6d10', '2024-12-05 17:00:00+00:00', 1800),
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', 'e33a67d8-eb0d-46f7-b895-3688679910ad', '2024-12-06 02:00:00+00:00', 1500),
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', '11429350-41f3-4b4a-ab7c-4dbcf6f3dbba', '2024-12-06 05:00:00+00:00', 1500),
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', 'b91777df-7050-40a6-b5d2-1549b34e20ff', '2024-12-06 08:00:00+00:00', 1800),
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', '8b32f48d-6bc0-4891-a009-aeba59ee2c52', '2024-12-06 11:00:00+00:00', 1800),
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', '3d1fd545-0db9-4f54-914b-911e962d34b0', '2024-12-06 14:00:00+00:00', 1800);


INSERT INTO "Showings" (id, hall_id, movie_id, start_time, pricex100) VALUES
-- Hall A (Dec 7)
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', '8312a1c5-f285-4602-b9ef-2ce88aa79062', '2024-12-06 17:00:00+00:00', 1800),
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', 'e33a67d8-eb0d-46f7-b895-3688679910ad', '2024-12-07 02:00:00+00:00', 1500),
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', 'd6949d54-041e-4972-9348-28b52f49cc4b', '2024-12-07 05:00:00+00:00', 1500),
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', '19eae21d-cd9e-4cf7-9269-8a1adc9b416d', '2024-12-07 08:00:00+00:00', 1800),
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', '11429350-41f3-4b4a-ab7c-4dbcf6f3dbba', '2024-12-07 11:00:00+00:00', 1800),
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', '8b32f48d-6bc0-4891-a009-aeba59ee2c52', '2024-12-07 14:00:00+00:00', 1800),

-- Hall B (Dec 7)
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', 'c8c74caf-55f8-45a7-bbb3-d0cfa2fb6d10', '2024-12-06 17:00:00+00:00', 1800),
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', '19eae21d-cd9e-4cf7-9269-8a1adc9b416d', '2024-12-07 02:00:00+00:00', 1500),
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', '347a0fc6-0541-44b4-aead-c34f7f783f10', '2024-12-07 05:00:00+00:00', 1500),
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', 'd349bc89-793e-4bed-a684-3bbc97162d51', '2024-12-07 08:00:00+00:00', 1800),
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', '3bbb4a0d-c774-443a-b44b-0ad7695a658b', '2024-12-07 11:00:00+00:00', 1800),
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', 'aba38539-abdb-4db6-818a-df092ffb8601', '2024-12-07 14:00:00+00:00', 1800),

-- Hall C (Dec 7)
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', 'd349bc89-793e-4bed-a684-3bbc97162d51', '2024-12-06 17:00:00+00:00', 1800),
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', 'a616704c-9e54-47e3-a8ec-cb32398d1dbe', '2024-12-07 02:00:00+00:00', 1500),
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', '3d1fd545-0db9-4f54-914b-911e962d34b0', '2024-12-07 05:00:00+00:00', 1500),
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', '8b32f48d-6bc0-4891-a009-aeba59ee2c52', '2024-12-07 08:00:00+00:00', 1800),
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', '3bbb4a0d-c774-443a-b44b-0ad7695a658b', '2024-12-07 11:00:00+00:00', 1800),
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', '11429350-41f3-4b4a-ab7c-4dbcf6f3dbba', '2024-12-07 14:00:00+00:00', 1800),

-- Hall D (Dec 7)
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', '11429350-41f3-4b4a-ab7c-4dbcf6f3dbba', '2024-12-06 17:00:00+00:00', 1800),
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', 'b91777df-7050-40a6-b5d2-1549b34e20ff', '2024-12-07 02:00:00+00:00', 1500),
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', '8b32f48d-6bc0-4891-a009-aeba59ee2c52', '2024-12-07 05:00:00+00:00', 1500),
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', '3d1fd545-0db9-4f54-914b-911e962d34b0', '2024-12-07 08:00:00+00:00', 1800),
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', 'c8c74caf-55f8-45a7-bbb3-d0cfa2fb6d10', '2024-12-07 11:00:00+00:00', 1800),
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', '19eae21d-cd9e-4cf7-9269-8a1adc9b416d', '2024-12-07 14:00:00+00:00', 1800),

-- Hall E (Dec 7)
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', '8b32f48d-6bc0-4891-a009-aeba59ee2c52', '2024-12-06 17:00:00+00:00', 1800),
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', '3d1fd545-0db9-4f54-914b-911e962d34b0', '2024-12-07 02:00:00+00:00', 1500),
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', 'c8c74caf-55f8-45a7-bbb3-d0cfa2fb6d10', '2024-12-07 05:00:00+00:00', 1500),
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', '19eae21d-cd9e-4cf7-9269-8a1adc9b416d', '2024-12-07 08:00:00+00:00', 1800),
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', '347a0fc6-0541-44b4-aead-c34f7f783f10', '2024-12-07 11:00:00+00:00', 1800),
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', 'd349bc89-793e-4bed-a684-3bbc97162d51', '2024-12-07 14:00:00+00:00', 1800),

-- Hall F (Dec 7)
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', 'c8c74caf-55f8-45a7-bbb3-d0cfa2fb6d10', '2024-12-06 17:00:00+00:00', 1800),
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', '19eae21d-cd9e-4cf7-9269-8a1adc9b416d', '2024-12-07 02:00:00+00:00', 1500),
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', '347a0fc6-0541-44b4-aead-c34f7f783f10', '2024-12-07 05:00:00+00:00', 1500),
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', 'd349bc89-793e-4bed-a684-3bbc97162d51', '2024-12-07 08:00:00+00:00', 1800),
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', '3bbb4a0d-c774-443a-b44b-0ad7695a658b', '2024-12-07 11:00:00+00:00', 1800),
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', 'aba38539-abdb-4db6-818a-df092ffb8601', '2024-12-07 14:00:00+00:00', 1800);


INSERT INTO "Showings" (id, hall_id, movie_id, start_time, pricex100) VALUES
-- Hall A (Dec 8)
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', 'c8c74caf-55f8-45a7-bbb3-d0cfa2fb6d10', '2024-12-07 17:00:00+00:00', 1800),
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', '347a0fc6-0541-44b4-aead-c34f7f783f10', '2024-12-08 02:00:00+00:00', 1500),
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', '68f0c881-371f-4a2d-8ea4-03b23004a7f0', '2024-12-08 05:00:00+00:00', 1500),
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', 'aba38539-abdb-4db6-818a-df092ffb8601', '2024-12-08 08:00:00+00:00', 1800),
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', 'a616704c-9e54-47e3-a8ec-cb32398d1dbe', '2024-12-08 11:00:00+00:00', 1800),
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', '3d1fd545-0db9-4f54-914b-911e962d34b0', '2024-12-08 14:00:00+00:00', 1800),

-- Hall B (Dec 8)
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', '68f0c881-371f-4a2d-8ea4-03b23004a7f0', '2024-12-07 17:00:00+00:00', 1800),
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', 'd6949d54-041e-4972-9348-28b52f49cc4b', '2024-12-08 02:00:00+00:00', 1500),
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', '8312a1c5-f285-4602-b9ef-2ce88aa79062', '2024-12-08 05:00:00+00:00', 1500),
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', 'e33a67d8-eb0d-46f7-b895-3688679910ad', '2024-12-08 08:00:00+00:00', 1800),
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', 'a616704c-9e54-47e3-a8ec-cb32398d1dbe', '2024-12-08 11:00:00+00:00', 1800),
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', '11429350-41f3-4b4a-ab7c-4dbcf6f3dbba', '2024-12-08 14:00:00+00:00', 1800),

-- Hall C (Dec 8)
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', 'e33a67d8-eb0d-46f7-b895-3688679910ad', '2024-12-07 17:00:00+00:00', 1800),
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', '347a0fc6-0541-44b4-aead-c34f7f783f10', '2024-12-08 02:00:00+00:00', 1500),
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', 'b91777df-7050-40a6-b5d2-1549b34e20ff', '2024-12-08 05:00:00+00:00', 1500),
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', '8312a1c5-f285-4602-b9ef-2ce88aa79062', '2024-12-08 08:00:00+00:00', 1800),
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', 'c8c74caf-55f8-45a7-bbb3-d0cfa2fb6d10', '2024-12-08 11:00:00+00:00', 1800),
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', '19eae21d-cd9e-4cf7-9269-8a1adc9b416d', '2024-12-08 14:00:00+00:00', 1800),

-- Hall D (Dec 8)
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', '347a0fc6-0541-44b4-aead-c34f7f783f10', '2024-12-07 17:00:00+00:00', 1800),
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', 'd349bc89-793e-4bed-a684-3bbc97162d51', '2024-12-08 02:00:00+00:00', 1500),
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', '3bbb4a0d-c774-443a-b44b-0ad7695a658b', '2024-12-08 05:00:00+00:00', 1500),
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', 'aba38539-abdb-4db6-818a-df092ffb8601', '2024-12-08 08:00:00+00:00', 1800),
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', '68f0c881-371f-4a2d-8ea4-03b23004a7f0', '2024-12-08 11:00:00+00:00', 1800),
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', 'd6949d54-041e-4972-9348-28b52f49cc4b', '2024-12-08 14:00:00+00:00', 1800),

-- Hall E (Dec 8)
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', '3bbb4a0d-c774-443a-b44b-0ad7695a658b', '2024-12-07 17:00:00+00:00', 1800),
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', 'aba38539-abdb-4db6-818a-df092ffb8601', '2024-12-08 02:00:00+00:00', 1500),
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', '68f0c881-371f-4a2d-8ea4-03b23004a7f0', '2024-12-08 05:00:00+00:00', 1500),
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', 'd6949d54-041e-4972-9348-28b52f49cc4b', '2024-12-08 08:00:00+00:00', 1800),
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', '8312a1c5-f285-4602-b9ef-2ce88aa79062', '2024-12-08 11:00:00+00:00', 1800),
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', 'e33a67d8-eb0d-46f7-b895-3688679910ad', '2024-12-08 14:00:00+00:00', 1800),

-- Hall F (Dec 8)
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', '68f0c881-371f-4a2d-8ea4-03b23004a7f0', '2024-12-07 17:00:00+00:00', 1800),
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', 'd6949d54-041e-4972-9348-28b52f49cc4b', '2024-12-08 02:00:00+00:00', 1500),
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', '8312a1c5-f285-4602-b9ef-2ce88aa79062', '2024-12-08 05:00:00+00:00', 1500),
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', 'e33a67d8-eb0d-46f7-b895-3688679910ad', '2024-12-08 08:00:00+00:00', 1800),
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', 'a616704c-9e54-47e3-a8ec-cb32398d1dbe', '2024-12-08 11:00:00+00:00', 1800),
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', '11429350-41f3-4b4a-ab7c-4dbcf6f3dbba', '2024-12-08 14:00:00+00:00', 1800);


INSERT INTO "Showings" (id, hall_id, movie_id, start_time, pricex100) VALUES
-- Hall A (Dec 9)
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', '3bbb4a0d-c774-443a-b44b-0ad7695a658b', '2024-12-08 17:00:00+00:00', 1800),
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', 'b91777df-7050-40a6-b5d2-1549b34e20ff', '2024-12-09 02:00:00+00:00', 1500),
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', 'd349bc89-793e-4bed-a684-3bbc97162d51', '2024-12-09 05:00:00+00:00', 1500),
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', '8312a1c5-f285-4602-b9ef-2ce88aa79062', '2024-12-09 08:00:00+00:00', 1800),
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', 'e33a67d8-eb0d-46f7-b895-3688679910ad', '2024-12-09 11:00:00+00:00', 1800),
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', 'd6949d54-041e-4972-9348-28b52f49cc4b', '2024-12-09 14:00:00+00:00', 1800),

-- Hall B (Dec 9)
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', 'b91777df-7050-40a6-b5d2-1549b34e20ff', '2024-12-08 17:00:00+00:00', 1800),
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', '8b32f48d-6bc0-4891-a009-aeba59ee2c52', '2024-12-09 02:00:00+00:00', 1500),
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', '3d1fd545-0db9-4f54-914b-911e962d34b0', '2024-12-09 05:00:00+00:00', 1500),
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', 'c8c74caf-55f8-45a7-bbb3-d0cfa2fb6d10', '2024-12-09 08:00:00+00:00', 1800),
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', '19eae21d-cd9e-4cf7-9269-8a1adc9b416d', '2024-12-09 11:00:00+00:00', 1800),
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', '347a0fc6-0541-44b4-aead-c34f7f783f10', '2024-12-09 14:00:00+00:00', 1800),

-- Hall C (Dec 9)//all scetion wrong
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', '68f0c881-371f-4a2d-8ea4-03b23004a7f0', '2024-12-08 17:00:00+00:00', 1800),
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', 'aba38539-abdb-4db6-818a-df092ffb8601', '2024-12-09 02:00:00+00:00', 1500),
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', 'd6949d54-041e-4972-9348-28b52f49cc4b', '2024-12-09 05:00:00+00:00', 1500),
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', 'd349bc89-793e-4bed-a684-3bbc97162d51', '2024-12-09 08:00:00+00:00', 1800),
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', 'a616704c-9e54-47e3-a8ec-cb32398d1dbe', '2024-12-09 11:00:00+00:00', 1800),
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', '3d1fd545-0db9-4f54-914b-911e962d34b0', '2024-12-09 14:00:00+00:00', 1800),

-- Hall D (Dec 9)//all section wrong
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', '8312a1c5-f285-4602-b9ef-2ce88aa79062', '2024-12-08 17:00:00+00:00', 1800),
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', 'e33a67d8-eb0d-46f7-b895-3688679910ad', '2024-12-09 02:00:00+00:00', 1500),
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', 'a616704c-9e54-47e3-a8ec-cb32398d1dbe', '2024-12-09 05:00:00+00:00', 1500),
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', '11429350-41f3-4b4a-ab7c-4dbcf6f3dbba', '2024-12-09 08:00:00+00:00', 1800),
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', 'b91777df-7050-40a6-b5d2-1549b34e20ff', '2024-12-09 11:00:00+00:00', 1800),
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', '8b32f48d-6bc0-4891-a009-aeba59ee2c52', '2024-12-09 14:00:00+00:00', 1800),

-- Hall E (Dec 9)
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', 'a616704c-9e54-47e3-a8ec-cb32398d1dbe', '2024-12-08 17:00:00+00:00', 1800),
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', '11429350-41f3-4b4a-ab7c-4dbcf6f3dbba', '2024-12-09 02:00:00+00:00', 1500),
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', 'b91777df-7050-40a6-b5d2-1549b34e20ff', '2024-12-09 05:00:00+00:00', 1500),
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', '8b32f48d-6bc0-4891-a009-aeba59ee2c52', '2024-12-09 08:00:00+00:00', 1800),
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', '3d1fd545-0db9-4f54-914b-911e962d34b0', '2024-12-09 11:00:00+00:00', 1800),
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', 'c8c74caf-55f8-45a7-bbb3-d0cfa2fb6d10', '2024-12-09 14:00:00+00:00', 1800),

-- Hall F (Dec 9)
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', 'b91777df-7050-40a6-b5d2-1549b34e20ff', '2024-12-08 17:00:00+00:00', 1800),
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', '8b32f48d-6bc0-4891-a009-aeba59ee2c52', '2024-12-09 02:00:00+00:00', 1500),
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', '3d1fd545-0db9-4f54-914b-911e962d34b0', '2024-12-09 05:00:00+00:00', 1500),
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', 'c8c74caf-55f8-45a7-bbb3-d0cfa2fb6d10', '2024-12-09 08:00:00+00:00', 1800),
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', '19eae21d-cd9e-4cf7-9269-8a1adc9b416d', '2024-12-09 11:00:00+00:00', 1800),
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', '347a0fc6-0541-44b4-aead-c34f7f783f10', '2024-12-09 14:00:00+00:00', 1800);


INSERT INTO "Showings" (id, hall_id, movie_id, start_time, pricex100) VALUES
-- Hall A (Dec 10)
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', '19eae21d-cd9e-4cf7-9269-8a1adc9b416d', '2024-12-09 17:00:00+00:00', 1800),
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', '11429350-41f3-4b4a-ab7c-4dbcf6f3dbba', '2024-12-10 02:00:00+00:00', 1500),
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', '8b32f48d-6bc0-4891-a009-aeba59ee2c52', '2024-12-10 05:00:00+00:00', 1500),
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', 'c8c74caf-55f8-45a7-bbb3-d0cfa2fb6d10', '2024-12-10 08:00:00+00:00', 1800),
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', '347a0fc6-0541-44b4-aead-c34f7f783f10', '2024-12-10 11:00:00+00:00', 1800),
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', '68f0c881-371f-4a2d-8ea4-03b23004a7f0', '2024-12-10 14:00:00+00:00', 1800),

-- Hall B (Dec 10)
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', 'd349bc89-793e-4bed-a684-3bbc97162d51', '2024-12-09 17:00:00+00:00', 1800),
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', '3bbb4a0d-c774-443a-b44b-0ad7695a658b', '2024-12-10 02:00:00+00:00', 1500),
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', 'aba38539-abdb-4db6-818a-df092ffb8601', '2024-12-10 05:00:00+00:00', 1500),
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', '68f0c881-371f-4a2d-8ea4-03b23004a7f0', '2024-12-10 08:00:00+00:00', 1800),
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', 'd6949d54-041e-4972-9348-28b52f49cc4b', '2024-12-10 11:00:00+00:00', 1800),
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', '8312a1c5-f285-4602-b9ef-2ce88aa79062', '2024-12-10 14:00:00+00:00', 1800),

-- Hall C (Dec 10)
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', '8b32f48d-6bc0-4891-a009-aeba59ee2c52', '2024-12-09 17:00:00+00:00', 1800),
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', '3bbb4a0d-c774-443a-b44b-0ad7695a658b', '2024-12-10 02:00:00+00:00', 1500),
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', '11429350-41f3-4b4a-ab7c-4dbcf6f3dbba', '2024-12-10 05:00:00+00:00', 1500),
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', 'e33a67d8-eb0d-46f7-b895-3688679910ad', '2024-12-10 08:00:00+00:00', 1800),
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', '347a0fc6-0541-44b4-aead-c34f7f783f10', '2024-12-10 11:00:00+00:00', 1800),
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', 'b91777df-7050-40a6-b5d2-1549b34e20ff', '2024-12-10 14:00:00+00:00', 1800),

-- Hall D (Dec 10)
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', '3d1fd545-0db9-4f54-914b-911e962d34b0', '2024-12-09 17:00:00+00:00', 1800),
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', 'c8c74caf-55f8-45a7-bbb3-d0cfa2fb6d10', '2024-12-10 02:00:00+00:00', 1500),
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', '19eae21d-cd9e-4cf7-9269-8a1adc9b416d', '2024-12-10 05:00:00+00:00', 1500),
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', '347a0fc6-0541-44b4-aead-c34f7f783f10', '2024-12-10 08:00:00+00:00', 1800),
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', 'd349bc89-793e-4bed-a684-3bbc97162d51', '2024-12-10 11:00:00+00:00', 1800),
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', '3bbb4a0d-c774-443a-b44b-0ad7695a658b', '2024-12-10 14:00:00+00:00', 1800),

-- Hall E (Dec 10)
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', '19eae21d-cd9e-4cf7-9269-8a1adc9b416d', '2024-12-09 17:00:00+00:00', 1800),
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', '347a0fc6-0541-44b4-aead-c34f7f783f10', '2024-12-10 02:00:00+00:00', 1500),
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', 'd349bc89-793e-4bed-a684-3bbc97162d51', '2024-12-10 05:00:00+00:00', 1500),
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', '3bbb4a0d-c774-443a-b44b-0ad7695a658b', '2024-12-10 08:00:00+00:00', 1800),
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', 'aba38539-abdb-4db6-818a-df092ffb8601', '2024-12-10 11:00:00+00:00', 1800),
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', '68f0c881-371f-4a2d-8ea4-03b23004a7f0', '2024-12-10 14:00:00+00:00', 1800),

-- Hall F (Dec 10)
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', 'd349bc89-793e-4bed-a684-3bbc97162d51', '2024-12-09 17:00:00+00:00', 1800),
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', '3bbb4a0d-c774-443a-b44b-0ad7695a658b', '2024-12-10 02:00:00+00:00', 1500),
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', 'aba38539-abdb-4db6-818a-df092ffb8601', '2024-12-10 05:00:00+00:00', 1500),
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', '68f0c881-371f-4a2d-8ea4-03b23004a7f0', '2024-12-10 08:00:00+00:00', 1800),
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', 'd6949d54-041e-4972-9348-28b52f49cc4b', '2024-12-10 11:00:00+00:00', 1800),
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', '8312a1c5-f285-4602-b9ef-2ce88aa79062', '2024-12-10 14:00:00+00:00', 1800);


INSERT INTO "Showings" (id, hall_id, movie_id, start_time, pricex100) VALUES
-- Hall A (Dec 11)
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', 'aba38539-abdb-4db6-818a-df092ffb8601', '2024-12-10 17:00:00+00:00', 1800),
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', '347a0fc6-0541-44b4-aead-c34f7f783f10', '2024-12-11 02:00:00+00:00', 1500),
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', '347a0fc6-0541-44b4-aead-c34f7f783f10', '2024-12-11 05:00:00+00:00', 1500),
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', '68f0c881-371f-4a2d-8ea4-03b23004a7f0', '2024-12-11 08:00:00+00:00', 1800),
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', '3d1fd545-0db9-4f54-914b-911e962d34b0', '2024-12-11 11:00:00+00:00', 1800),
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', '3bbb4a0d-c774-443a-b44b-0ad7695a658b', '2024-12-11 14:00:00+00:00', 1800),

-- Hall B (Dec 11)
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', 'e33a67d8-eb0d-46f7-b895-3688679910ad', '2024-12-10 17:00:00+00:00', 1800),
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', 'a616704c-9e54-47e3-a8ec-cb32398d1dbe', '2024-12-11 02:00:00+00:00', 1500),
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', '8312a1c5-f285-4602-b9ef-2ce88aa79062', '2024-12-11 05:00:00+00:00', 1500),
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', 'e33a67d8-eb0d-46f7-b895-3688679910ad', '2024-12-11 08:00:00+00:00', 1800),
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', '11429350-41f3-4b4a-ab7c-4dbcf6f3dbba', '2024-12-11 11:00:00+00:00', 1800),
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', 'b91777df-7050-40a6-b5d2-1549b34e20ff', '2024-12-11 14:00:00+00:00', 1800),

-- Hall C (Dec 11)
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', '8312a1c5-f285-4602-b9ef-2ce88aa79062', '2024-12-10 17:00:00+00:00', 1800),
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', 'c8c74caf-55f8-45a7-bbb3-d0cfa2fb6d10', '2024-12-11 02:00:00+00:00', 1500),
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', 'b91777df-7050-40a6-b5d2-1549b34e20ff', '2024-12-11 05:00:00+00:00', 1500),
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', '8312a1c5-f285-4602-b9ef-2ce88aa79062', '2024-12-11 08:00:00+00:00', 1800),
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', '19eae21d-cd9e-4cf7-9269-8a1adc9b416d', '2024-12-11 11:00:00+00:00', 1800),
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', '68f0c881-371f-4a2d-8ea4-03b23004a7f0', '2024-12-11 14:00:00+00:00', 1800),

-- Hall D (Dec 11)
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', 'aba38539-abdb-4db6-818a-df092ffb8601', '2024-12-10 17:00:00+00:00', 1800),
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', '68f0c881-371f-4a2d-8ea4-03b23004a7f0', '2024-12-11 02:00:00+00:00', 1500),
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', 'aba38539-abdb-4db6-818a-df092ffb8601', '2024-12-11 05:00:00+00:00', 1500),
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', 'a616704c-9e54-47e3-a8ec-cb32398d1dbe', '2024-12-11 08:00:00+00:00', 1800),
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', '68f0c881-371f-4a2d-8ea4-03b23004a7f0', '2024-12-11 11:00:00+00:00', 1800),
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', 'aba38539-abdb-4db6-818a-df092ffb8601', '2024-12-11 14:00:00+00:00', 1800),

-- Hall E (Dec 11)
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', 'd6949d54-041e-4972-9348-28b52f49cc4b', '2024-12-10 17:00:00+00:00', 1800),
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', '8312a1c5-f285-4602-b9ef-2ce88aa79062', '2024-12-11 02:00:00+00:00', 1500),
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', '68f0c881-371f-4a2d-8ea4-03b23004a7f0', '2024-12-11 05:00:00+00:00', 1500),
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', 'aba38539-abdb-4db6-818a-df092ffb8601', '2024-12-11 08:00:00+00:00', 1800),
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', 'a616704c-9e54-47e3-a8ec-cb32398d1dbe', '2024-12-11 11:00:00+00:00', 1800),
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', '3d1fd545-0db9-4f54-914b-911e962d34b0', '2024-12-11 14:00:00+00:00', 1800),

-- Hall F (Dec 11)
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', 'e33a67d8-eb0d-46f7-b895-3688679910ad', '2024-12-10 17:00:00+00:00', 1800),
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', 'a616704c-9e54-47e3-a8ec-cb32398d1dbe', '2024-12-11 02:00:00+00:00', 1500),
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', 'a616704c-9e54-47e3-a8ec-cb32398d1dbe', '2024-12-11 05:00:00+00:00', 1500),
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', '3d1fd545-0db9-4f54-914b-911e962d34b0', '2024-12-11 08:00:00+00:00', 1800),
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', '3bbb4a0d-c774-443a-b44b-0ad7695a658b', '2024-12-11 11:00:00+00:00', 1800),
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', 'b91777df-7050-40a6-b5d2-1549b34e20ff', '2024-12-11 14:00:00+00:00', 1800);


INSERT INTO "Showings" (id, hall_id, movie_id, start_time, pricex100) VALUES
-- Hall A (Dec 12)
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', 'b91777df-7050-40a6-b5d2-1549b34e20ff', '2024-12-11 17:00:00+00:00', 1800),
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', 'd349bc89-793e-4bed-a684-3bbc97162d51', '2024-12-12 02:00:00+00:00', 1500),
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', '8312a1c5-f285-4602-b9ef-2ce88aa79062', '2024-12-12 05:00:00+00:00', 1500),
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', 'e33a67d8-eb0d-46f7-b895-3688679910ad', '2024-12-12 08:00:00+00:00', 1800),
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', 'd6949d54-041e-4972-9348-28b52f49cc4b', '2024-12-12 11:00:00+00:00', 1800),
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', '19eae21d-cd9e-4cf7-9269-8a1adc9b416d', '2024-12-12 14:00:00+00:00', 1800),

-- Hall B (Dec 12)
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', '8b32f48d-6bc0-4891-a009-aeba59ee2c52', '2024-12-11 17:00:00+00:00', 1800),
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', '3d1fd545-0db9-4f54-914b-911e962d34b0', '2024-12-12 02:00:00+00:00', 1500),
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', 'c8c74caf-55f8-45a7-bbb3-d0cfa2fb6d10', '2024-12-12 05:00:00+00:00', 1500),
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', '19eae21d-cd9e-4cf7-9269-8a1adc9b416d', '2024-12-12 08:00:00+00:00', 1800),
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', '347a0fc6-0541-44b4-aead-c34f7f783f10', '2024-12-12 11:00:00+00:00', 1800),
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', 'd349bc89-793e-4bed-a684-3bbc97162d51', '2024-12-12 14:00:00+00:00', 1800),

-- Hall C (Dec 12)
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', 'aba38539-abdb-4db6-818a-df092ffb8601', '2024-12-11 17:00:00+00:00', 1800),
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', 'd6949d54-041e-4972-9348-28b52f49cc4b', '2024-12-12 02:00:00+00:00', 1500),
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', 'd349bc89-793e-4bed-a684-3bbc97162d51', '2024-12-12 05:00:00+00:00', 1500),
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', 'a616704c-9e54-47e3-a8ec-cb32398d1dbe', '2024-12-12 08:00:00+00:00', 1800),
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', '3d1fd545-0db9-4f54-914b-911e962d34b0', '2024-12-12 11:00:00+00:00', 1800),
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', '8b32f48d-6bc0-4891-a009-aeba59ee2c52', '2024-12-12 14:00:00+00:00', 1800),

-- Hall D (Dec 12)
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', 'a616704c-9e54-47e3-a8ec-cb32398d1dbe', '2024-12-11 17:00:00+00:00', 1800),
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', '3d1fd545-0db9-4f54-914b-911e962d34b0', '2024-12-12 02:00:00+00:00', 1500),
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', '3bbb4a0d-c774-443a-b44b-0ad7695a658b', '2024-12-12 05:00:00+00:00', 1500),
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', 'b91777df-7050-40a6-b5d2-1549b34e20ff', '2024-12-12 08:00:00+00:00', 1800),
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', 'd349bc89-793e-4bed-a684-3bbc97162d51', '2024-12-12 11:00:00+00:00', 1800),
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', '8312a1c5-f285-4602-b9ef-2ce88aa79062', '2024-12-12 14:00:00+00:00', 1800),

-- Hall E (Dec 12)
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', '3bbb4a0d-c774-443a-b44b-0ad7695a658b', '2024-12-11 17:00:00+00:00', 1800),
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', 'b91777df-7050-40a6-b5d2-1549b34e20ff', '2024-12-12 02:00:00+00:00', 1500),
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', 'd349bc89-793e-4bed-a684-3bbc97162d51', '2024-12-12 05:00:00+00:00', 1500),
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', '8312a1c5-f285-4602-b9ef-2ce88aa79062', '2024-12-12 08:00:00+00:00', 1800),
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', 'e33a67d8-eb0d-46f7-b895-3688679910ad', '2024-12-12 11:00:00+00:00', 1800),
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', 'd6949d54-041e-4972-9348-28b52f49cc4b', '2024-12-12 14:00:00+00:00', 1800),

-- Hall F (Dec 12)
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', 'd349bc89-793e-4bed-a684-3bbc97162d51', '2024-12-11 17:00:00+00:00', 1800),
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', '8312a1c5-f285-4602-b9ef-2ce88aa79062', '2024-12-12 02:00:00+00:00', 1500),
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', 'e33a67d8-eb0d-46f7-b895-3688679910ad', '2024-12-12 05:00:00+00:00', 1500),
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', 'd6949d54-041e-4972-9348-28b52f49cc4b', '2024-12-12 08:00:00+00:00', 1800),
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', '19eae21d-cd9e-4cf7-9269-8a1adc9b416d', '2024-12-12 11:00:00+00:00', 1800),
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', '11429350-41f3-4b4a-ab7c-4dbcf6f3dbba', '2024-12-12 14:00:00+00:00', 1800);


INSERT INTO "Showings" (id, hall_id, movie_id, start_time, pricex100) VALUES
-- Hall A (Dec 13)
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', '11429350-41f3-4b4a-ab7c-4dbcf6f3dbba', '2024-12-12 17:00:00+00:00', 1800),
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', '8b32f48d-6bc0-4891-a009-aeba59ee2c52', '2024-12-13 02:00:00+00:00', 1500),
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', 'c8c74caf-55f8-45a7-bbb3-d0cfa2fb6d10', '2024-12-13 05:00:00+00:00', 1500),
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', '347a0fc6-0541-44b4-aead-c34f7f783f10', '2024-12-13 08:00:00+00:00', 1800),
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', '68f0c881-371f-4a2d-8ea4-03b23004a7f0', '2024-12-13 11:00:00+00:00', 1800),
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', 'aba38539-abdb-4db6-818a-df092ffb8601', '2024-12-13 14:00:00+00:00', 1800),

-- Hall B (Dec 13)
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', '3bbb4a0d-c774-443a-b44b-0ad7695a658b', '2024-12-12 17:00:00+00:00', 1800),
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', 'aba38539-abdb-4db6-818a-df092ffb8601', '2024-12-13 02:00:00+00:00', 1500),
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', '68f0c881-371f-4a2d-8ea4-03b23004a7f0', '2024-12-13 05:00:00+00:00', 1500),
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', 'd6949d54-041e-4972-9348-28b52f49cc4b', '2024-12-13 08:00:00+00:00', 1800),
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', '8312a1c5-f285-4602-b9ef-2ce88aa79062', '2024-12-13 11:00:00+00:00', 1800),
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', 'e33a67d8-eb0d-46f7-b895-3688679910ad', '2024-12-13 14:00:00+00:00', 1800),

-- Hall C (Dec 13)
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', '3bbb4a0d-c774-443a-b44b-0ad7695a658b', '2024-12-12 17:00:00+00:00', 1800),
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', '11429350-41f3-4b4a-ab7c-4dbcf6f3dbba', '2024-12-13 02:00:00+00:00', 1500),
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', 'e33a67d8-eb0d-46f7-b895-3688679910ad', '2024-12-13 05:00:00+00:00', 1500),
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', '347a0fc6-0541-44b4-aead-c34f7f783f10', '2024-12-13 08:00:00+00:00', 1800),
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', 'b91777df-7050-40a6-b5d2-1549b34e20ff', '2024-12-13 11:00:00+00:00', 1800),
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', '8312a1c5-f285-4602-b9ef-2ce88aa79062', '2024-12-13 14:00:00+00:00', 1800),

-- Hall D (Dec 13)
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', 'e33a67d8-eb0d-46f7-b895-3688679910ad', '2024-12-12 17:00:00+00:00', 1800),
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', 'd6949d54-041e-4972-9348-28b52f49cc4b', '2024-12-13 02:00:00+00:00', 1500),
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', '19eae21d-cd9e-4cf7-9269-8a1adc9b416d', '2024-12-13 05:00:00+00:00', 1500),
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', '11429350-41f3-4b4a-ab7c-4dbcf6f3dbba', '2024-12-13 08:00:00+00:00', 1800),
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', '8b32f48d-6bc0-4891-a009-aeba59ee2c52', '2024-12-13 11:00:00+00:00', 1800),
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', 'c8c74caf-55f8-45a7-bbb3-d0cfa2fb6d10', '2024-12-13 14:00:00+00:00', 1800),

-- Hall E (Dec 13)
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', '19eae21d-cd9e-4cf7-9269-8a1adc9b416d', '2024-12-12 17:00:00+00:00', 1800),
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', '11429350-41f3-4b4a-ab7c-4dbcf6f3dbba', '2024-12-13 02:00:00+00:00', 1500),
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', '8b32f48d-6bc0-4891-a009-aeba59ee2c52', '2024-12-13 05:00:00+00:00', 1500),
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', 'c8c74caf-55f8-45a7-bbb3-d0cfa2fb6d10', '2024-12-13 08:00:00+00:00', 1800),
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', '347a0fc6-0541-44b4-aead-c34f7f783f10', '2024-12-13 11:00:00+00:00', 1800),
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', '68f0c881-371f-4a2d-8ea4-03b23004a7f0', '2024-12-13 14:00:00+00:00', 1800),

-- Hall F (Dec 13)
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', '8b32f48d-6bc0-4891-a009-aeba59ee2c52', '2024-12-12 17:00:00+00:00', 1800),
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', 'c8c74caf-55f8-45a7-bbb3-d0cfa2fb6d10', '2024-12-13 02:00:00+00:00', 1500),
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', '347a0fc6-0541-44b4-aead-c34f7f783f10', '2024-12-13 05:00:00+00:00', 1500),
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', '68f0c881-371f-4a2d-8ea4-03b23004a7f0', '2024-12-13 08:00:00+00:00', 1800),
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', 'aba38539-abdb-4db6-818a-df092ffb8601', '2024-12-13 11:00:00+00:00', 1800),
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', 'a616704c-9e54-47e3-a8ec-cb32398d1dbe', '2024-12-13 14:00:00+00:00', 1800);


INSERT INTO "Showings" (id, hall_id, movie_id, start_time, pricex100) VALUES
-- Hall A (Dec 14)
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', 'a616704c-9e54-47e3-a8ec-cb32398d1dbe', '2024-12-13 17:00:00+00:00', 1800),
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', '3d1fd545-0db9-4f54-914b-911e962d34b0', '2024-12-14 02:00:00+00:00', 1500),
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', '3bbb4a0d-c774-443a-b44b-0ad7695a658b', '2024-12-14 05:00:00+00:00', 1500),
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', 'b91777df-7050-40a6-b5d2-1549b34e20ff', '2024-12-14 08:00:00+00:00', 1800),
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', 'd349bc89-793e-4bed-a684-3bbc97162d51', '2024-12-14 11:00:00+00:00', 1800),
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', '8312a1c5-f285-4602-b9ef-2ce88aa79062', '2024-12-14 14:00:00+00:00', 1800),

-- Hall B (Dec 14)
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', 'a616704c-9e54-47e3-a8ec-cb32398d1dbe', '2024-12-13 17:00:00+00:00', 1800),
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', '11429350-41f3-4b4a-ab7c-4dbcf6f3dbba', '2024-12-14 02:00:00+00:00', 1500),
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', 'b91777df-7050-40a6-b5d2-1549b34e20ff', '2024-12-14 05:00:00+00:00', 1500),
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', '8b32f48d-6bc0-4891-a009-aeba59ee2c52', '2024-12-14 08:00:00+00:00', 1800),
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', '3d1fd545-0db9-4f54-914b-911e962d34b0', '2024-12-14 11:00:00+00:00', 1800),
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', 'c8c74caf-55f8-45a7-bbb3-d0cfa2fb6d10', '2024-12-14 14:00:00+00:00', 1800),

-- Hall C (Dec 14)
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', 'c8c74caf-55f8-45a7-bbb3-d0cfa2fb6d10', '2024-12-13 17:00:00+00:00', 1800),
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', '19eae21d-cd9e-4cf7-9269-8a1adc9b416d', '2024-12-14 02:00:00+00:00', 1500),
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', '68f0c881-371f-4a2d-8ea4-03b23004a7f0', '2024-12-14 05:00:00+00:00', 1500),
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', 'aba38539-abdb-4db6-818a-df092ffb8601', '2024-12-14 08:00:00+00:00', 1800),
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', 'd6949d54-041e-4972-9348-28b52f49cc4b', '2024-12-14 11:00:00+00:00', 1800),
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', 'd349bc89-793e-4bed-a684-3bbc97162d51', '2024-12-14 14:00:00+00:00', 1800),

-- Hall D (Dec 14)
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', '347a0fc6-0541-44b4-aead-c34f7f783f10', '2024-12-13 17:00:00+00:00', 1800),
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', '68f0c881-371f-4a2d-8ea4-03b23004a7f0', '2024-12-14 02:00:00+00:00', 1500),
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', 'aba38539-abdb-4db6-818a-df092ffb8601', '2024-12-14 05:00:00+00:00', 1500),
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', 'a616704c-9e54-47e3-a8ec-cb32398d1dbe', '2024-12-14 08:00:00+00:00', 1800),
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', '3d1fd545-0db9-4f54-914b-911e962d34b0', '2024-12-14 11:00:00+00:00', 1800),
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', '3bbb4a0d-c774-443a-b44b-0ad7695a658b', '2024-12-14 14:00:00+00:00', 1800),

-- Hall E (Dec 14)
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', 'aba38539-abdb-4db6-818a-df092ffb8601', '2024-12-13 17:00:00+00:00', 1800),
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', 'a616704c-9e54-47e3-a8ec-cb32398d1dbe', '2024-12-14 02:00:00+00:00', 1500),
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', '3d1fd545-0db9-4f54-914b-911e962d34b0', '2024-12-14 05:00:00+00:00', 1500),
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', '3bbb4a0d-c774-443a-b44b-0ad7695a658b', '2024-12-14 08:00:00+00:00', 1800),
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', 'b91777df-7050-40a6-b5d2-1549b34e20ff', '2024-12-14 11:00:00+00:00', 1800),
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', 'd349bc89-793e-4bed-a684-3bbc97162d51', '2024-12-14 14:00:00+00:00', 1800),

-- Hall F (Dec 14)
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', '3d1fd545-0db9-4f54-914b-911e962d34b0', '2024-12-13 17:00:00+00:00', 1800),
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', '3bbb4a0d-c774-443a-b44b-0ad7695a658b', '2024-12-14 02:00:00+00:00', 1500),
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', 'b91777df-7050-40a6-b5d2-1549b34e20ff', '2024-12-14 05:00:00+00:00', 1500),
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', 'd349bc89-793e-4bed-a684-3bbc97162d51', '2024-12-14 08:00:00+00:00', 1800),
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', '8312a1c5-f285-4602-b9ef-2ce88aa79062', '2024-12-14 11:00:00+00:00', 1800),
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', 'e33a67d8-eb0d-46f7-b895-3688679910ad', '2024-12-14 14:00:00+00:00', 1800);


INSERT INTO "Showings" (id, hall_id, movie_id, start_time, pricex100) VALUES
-- Hall A (Dec 15)
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', 'e33a67d8-eb0d-46f7-b895-3688679910ad', '2024-12-14 17:00:00+00:00', 1800),
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', 'd6949d54-041e-4972-9348-28b52f49cc4b', '2024-12-15 02:00:00+00:00', 1500),
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', '19eae21d-cd9e-4cf7-9269-8a1adc9b416d', '2024-12-15 05:00:00+00:00', 1500),
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', '11429350-41f3-4b4a-ab7c-4dbcf6f3dbba', '2024-12-15 08:00:00+00:00', 1800),
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', '8b32f48d-6bc0-4891-a009-aeba59ee2c52', '2024-12-15 11:00:00+00:00', 1800),
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', 'c8c74caf-55f8-45a7-bbb3-d0cfa2fb6d10', '2024-12-15 14:00:00+00:00', 1800),

-- Hall B (Dec 15)
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', '19eae21d-cd9e-4cf7-9269-8a1adc9b416d', '2024-12-14 17:00:00+00:00', 1800),
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', '347a0fc6-0541-44b4-aead-c34f7f783f10', '2024-12-15 02:00:00+00:00', 1500),
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', 'd349bc89-793e-4bed-a684-3bbc97162d51', '2024-12-15 05:00:00+00:00', 1500),
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', '3bbb4a0d-c774-443a-b44b-0ad7695a658b', '2024-12-15 08:00:00+00:00', 1800),
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', 'aba38539-abdb-4db6-818a-df092ffb8601', '2024-12-15 11:00:00+00:00', 1800),
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', '68f0c881-371f-4a2d-8ea4-03b23004a7f0', '2024-12-15 14:00:00+00:00', 1800),

-- Hall C (Dec 15)
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', 'a616704c-9e54-47e3-a8ec-cb32398d1dbe', '2024-12-14 17:00:00+00:00', 1800),
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', '3d1fd545-0db9-4f54-914b-911e962d34b0', '2024-12-15 02:00:00+00:00', 1500),
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', '8b32f48d-6bc0-4891-a009-aeba59ee2c52', '2024-12-15 05:00:00+00:00', 1500),
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', '3bbb4a0d-c774-443a-b44b-0ad7695a658b', '2024-12-15 08:00:00+00:00', 1800),
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', '11429350-41f3-4b4a-ab7c-4dbcf6f3dbba', '2024-12-15 11:00:00+00:00', 1800),
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', 'e33a67d8-eb0d-46f7-b895-3688679910ad', '2024-12-15 14:00:00+00:00', 1800),

-- Hall D (Dec 15)
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', 'b91777df-7050-40a6-b5d2-1549b34e20ff', '2024-12-14 17:00:00+00:00', 1800),
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', 'd349bc89-793e-4bed-a684-3bbc97162d51', '2024-12-15 02:00:00+00:00', 1500),
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', '8312a1c5-f285-4602-b9ef-2ce88aa79062', '2024-12-15 05:00:00+00:00', 1500),
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', 'e33a67d8-eb0d-46f7-b895-3688679910ad', '2024-12-15 08:00:00+00:00', 1800),
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', 'd6949d54-041e-4972-9348-28b52f49cc4b', '2024-12-15 11:00:00+00:00', 1800),
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', '19eae21d-cd9e-4cf7-9269-8a1adc9b416d', '2024-12-15 14:00:00+00:00', 1800),

-- Hall E (Dec 15)
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', '8312a1c5-f285-4602-b9ef-2ce88aa79062', '2024-12-14 17:00:00+00:00', 1800),
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', 'e33a67d8-eb0d-46f7-b895-3688679910ad', '2024-12-15 02:00:00+00:00', 1500),
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', 'd6949d54-041e-4972-9348-28b52f49cc4b', '2024-12-15 05:00:00+00:00', 1500),
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', '19eae21d-cd9e-4cf7-9269-8a1adc9b416d', '2024-12-15 08:00:00+00:00', 1800),
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', '11429350-41f3-4b4a-ab7c-4dbcf6f3dbba', '2024-12-15 11:00:00+00:00', 1800),
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', '8b32f48d-6bc0-4891-a009-aeba59ee2c52', '2024-12-15 14:00:00+00:00', 1800),

-- Hall F (Dec 15)
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', 'd6949d54-041e-4972-9348-28b52f49cc4b', '2024-12-14 17:00:00+00:00', 1800),
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', '19eae21d-cd9e-4cf7-9269-8a1adc9b416d', '2024-12-15 02:00:00+00:00', 1500),
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', '11429350-41f3-4b4a-ab7c-4dbcf6f3dbba', '2024-12-15 05:00:00+00:00', 1500),
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', '8b32f48d-6bc0-4891-a009-aeba59ee2c52', '2024-12-15 08:00:00+00:00', 1800),
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', 'c8c74caf-55f8-45a7-bbb3-d0cfa2fb6d10', '2024-12-15 11:00:00+00:00', 1800),
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', '347a0fc6-0541-44b4-aead-c34f7f783f10', '2024-12-15 14:00:00+00:00', 1800);


INSERT INTO "Showings" (id, hall_id, movie_id, start_time, pricex100) VALUES
-- Hall A (Dec 16)
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', '347a0fc6-0541-44b4-aead-c34f7f783f10', '2024-12-15 17:00:00+00:00', 1800),
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', '68f0c881-371f-4a2d-8ea4-03b23004a7f0', '2024-12-16 02:00:00+00:00', 1500),
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', 'aba38539-abdb-4db6-818a-df092ffb8601', '2024-12-16 05:00:00+00:00', 1500),
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', '68f0c881-371f-4a2d-8ea4-03b23004a7f0', '2024-12-16 08:00:00+00:00', 1800),
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', 'aba38539-abdb-4db6-818a-df092ffb8601', '2024-12-16 11:00:00+00:00', 1800),
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', 'a616704c-9e54-47e3-a8ec-cb32398d1dbe', '2024-12-16 14:00:00+00:00', 1800),

-- Hall B (Dec 16)
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', 'd6949d54-041e-4972-9348-28b52f49cc4b', '2024-12-15 17:00:00+00:00', 1800),
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', '8312a1c5-f285-4602-b9ef-2ce88aa79062', '2024-12-16 02:00:00+00:00', 1500),
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', 'e33a67d8-eb0d-46f7-b895-3688679910ad', '2024-12-16 05:00:00+00:00', 1500),
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', 'aba38539-abdb-4db6-818a-df092ffb8601', '2024-12-16 08:00:00+00:00', 1800),
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', '68f0c881-371f-4a2d-8ea4-03b23004a7f0', '2024-12-16 11:00:00+00:00', 1800),
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', 'd6949d54-041e-4972-9348-28b52f49cc4b', '2024-12-16 14:00:00+00:00', 1800),

-- Hall C (Dec 16)
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', '347a0fc6-0541-44b4-aead-c34f7f783f10', '2024-12-15 17:00:00+00:00', 1800),
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', 'b91777df-7050-40a6-b5d2-1549b34e20ff', '2024-12-16 02:00:00+00:00', 1500),
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', '8312a1c5-f285-4602-b9ef-2ce88aa79062', '2024-12-16 05:00:00+00:00', 1500),
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', '11429350-41f3-4b4a-ab7c-4dbcf6f3dbba', '2024-12-16 08:00:00+00:00', 1800),
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', 'e33a67d8-eb0d-46f7-b895-3688679910ad', '2024-12-16 11:00:00+00:00', 1800),
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', '347a0fc6-0541-44b4-aead-c34f7f783f10', '2024-12-16 14:00:00+00:00', 1800),

-- Hall D (Dec 16)
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', '11429350-41f3-4b4a-ab7c-4dbcf6f3dbba', '2024-12-15 17:00:00+00:00', 1800),
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', '8b32f48d-6bc0-4891-a009-aeba59ee2c52', '2024-12-16 02:00:00+00:00', 1500),
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', 'c8c74caf-55f8-45a7-bbb3-d0cfa2fb6d10', '2024-12-16 05:00:00+00:00', 1500),
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', '68f0c881-371f-4a2d-8ea4-03b23004a7f0', '2024-12-16 08:00:00+00:00', 1800),
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', '3d1fd545-0db9-4f54-914b-911e962d34b0', '2024-12-16 11:00:00+00:00', 1800),
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', '8b32f48d-6bc0-4891-a009-aeba59ee2c52', '2024-12-16 14:00:00+00:00', 1800),

-- Hall E (Dec 16)
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', 'c8c74caf-55f8-45a7-bbb3-d0cfa2fb6d10', '2024-12-15 17:00:00+00:00', 1800),
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', '347a0fc6-0541-44b4-aead-c34f7f783f10', '2024-12-16 02:00:00+00:00', 1500),
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', '68f0c881-371f-4a2d-8ea4-03b23004a7f0', '2024-12-16 05:00:00+00:00', 1500),
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', 'b91777df-7050-40a6-b5d2-1549b34e20ff', '2024-12-16 08:00:00+00:00', 1800),
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', '8312a1c5-f285-4602-b9ef-2ce88aa79062', '2024-12-16 11:00:00+00:00', 1800),
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', '19eae21d-cd9e-4cf7-9269-8a1adc9b416d', '2024-12-16 14:00:00+00:00', 1800),

-- Hall F (Dec 16)
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', '68f0c881-371f-4a2d-8ea4-03b23004a7f0', '2024-12-15 17:00:00+00:00', 1800),
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', 'aba38539-abdb-4db6-818a-df092ffb8601', '2024-12-16 02:00:00+00:00', 1500),
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', '347a0fc6-0541-44b4-aead-c34f7f783f10', '2024-12-16 05:00:00+00:00', 1500),
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', '19eae21d-cd9e-4cf7-9269-8a1adc9b416d', '2024-12-16 08:00:00+00:00', 1800),
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', '68f0c881-371f-4a2d-8ea4-03b23004a7f0', '2024-12-16 11:00:00+00:00', 1800),
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', 'aba38539-abdb-4db6-818a-df092ffb8601', '2024-12-16 14:00:00+00:00', 1800);


INSERT INTO "Showings" (id, hall_id, movie_id, start_time, pricex100) VALUES
-- Hall A (Dec 17)
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', '3d1fd545-0db9-4f54-914b-911e962d34b0', '2024-12-16 17:00:00+00:00', 1800),
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', '3bbb4a0d-c774-443a-b44b-0ad7695a658b', '2024-12-17 02:00:00+00:00', 1500),
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', 'b91777df-7050-40a6-b5d2-1549b34e20ff', '2024-12-17 05:00:00+00:00', 1500),
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', 'd349bc89-793e-4bed-a684-3bbc97162d51', '2024-12-17 08:00:00+00:00', 1800),
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', '8312a1c5-f285-4602-b9ef-2ce88aa79062', '2024-12-17 11:00:00+00:00', 1800),
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', 'e33a67d8-eb0d-46f7-b895-3688679910ad', '2024-12-17 14:00:00+00:00', 1800),

-- Hall B (Dec 17)
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', '11429350-41f3-4b4a-ab7c-4dbcf6f3dbba', '2024-12-16 17:00:00+00:00', 1800),
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', 'b91777df-7050-40a6-b5d2-1549b34e20ff', '2024-12-17 02:00:00+00:00', 1500),
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', '8b32f48d-6bc0-4891-a009-aeba59ee2c52', '2024-12-17 05:00:00+00:00', 1500),
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', '3d1fd545-0db9-4f54-914b-911e962d34b0', '2024-12-17 08:00:00+00:00', 1800),
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', 'c8c74caf-55f8-45a7-bbb3-d0cfa2fb6d10', '2024-12-17 11:00:00+00:00', 1800),
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', '19eae21d-cd9e-4cf7-9269-8a1adc9b416d', '2024-12-17 14:00:00+00:00', 1800),

-- Hall C (Dec 17)
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', '19eae21d-cd9e-4cf7-9269-8a1adc9b416d', '2024-12-16 17:00:00+00:00', 1800),
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', '68f0c881-371f-4a2d-8ea4-03b23004a7f0', '2024-12-17 02:00:00+00:00', 1500),
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', 'aba38539-abdb-4db6-818a-df092ffb8601', '2024-12-17 05:00:00+00:00', 1500),
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', 'd6949d54-041e-4972-9348-28b52f49cc4b', '2024-12-17 08:00:00+00:00', 1800),
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', 'd349bc89-793e-4bed-a684-3bbc97162d51', '2024-12-17 11:00:00+00:00', 1800),
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', 'a616704c-9e54-47e3-a8ec-cb32398d1dbe', '2024-12-17 14:00:00+00:00', 1800),

-- Hall D (Dec 17)
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', '3bbb4a0d-c774-443a-b44b-0ad7695a658b', '2024-12-16 17:00:00+00:00', 1800),
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', '19eae21d-cd9e-4cf7-9269-8a1adc9b416d', '2024-12-17 02:00:00+00:00', 1500),
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', '68f0c881-371f-4a2d-8ea4-03b23004a7f0', '2024-12-17 05:00:00+00:00', 1500),
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', 'aba38539-abdb-4db6-818a-df092ffb8601', '2024-12-17 08:00:00+00:00', 1800),
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', 'd6949d54-041e-4972-9348-28b52f49cc4b', '2024-12-17 11:00:00+00:00', 1800),
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', 'd349bc89-793e-4bed-a684-3bbc97162d51', '2024-12-17 14:00:00+00:00', 1800),

-- Hall E (Dec 17)
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', '68f0c881-371f-4a2d-8ea4-03b23004a7f0', '2024-12-16 17:00:00+00:00', 1800),
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', 'aba38539-abdb-4db6-818a-df092ffb8601', '2024-12-17 02:00:00+00:00', 1500),
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', 'd6949d54-041e-4972-9348-28b52f49cc4b', '2024-12-17 05:00:00+00:00', 1500),
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', 'd349bc89-793e-4bed-a684-3bbc97162d51', '2024-12-17 08:00:00+00:00', 1800),
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', 'a616704c-9e54-47e3-a8ec-cb32398d1dbe', '2024-12-17 11:00:00+00:00', 1800),
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', '3d1fd545-0db9-4f54-914b-911e962d34b0', '2024-12-17 14:00:00+00:00', 1800),

-- Hall F (Dec 17)
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', 'd6949d54-041e-4972-9348-28b52f49cc4b', '2024-12-16 17:00:00+00:00', 1800),
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', 'd349bc89-793e-4bed-a684-3bbc97162d51', '2024-12-17 02:00:00+00:00', 1500),
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', 'a616704c-9e54-47e3-a8ec-cb32398d1dbe', '2024-12-17 05:00:00+00:00', 1500),
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', '3d1fd545-0db9-4f54-914b-911e962d34b0', '2024-12-17 08:00:00+00:00', 1800),
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', '8b32f48d-6bc0-4891-a009-aeba59ee2c52', '2024-12-17 11:00:00+00:00', 1800),
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', '3bbb4a0d-c774-443a-b44b-0ad7695a658b', '2024-12-17 14:00:00+00:00', 1800);


INSERT INTO "Showings" (id, hall_id, movie_id, start_time, pricex100) VALUES
-- Hall A (Dec 18)
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', 'd6949d54-041e-4972-9348-28b52f49cc4b', '2024-12-17 17:00:00+00:00', 1800),
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', '19eae21d-cd9e-4cf7-9269-8a1adc9b416d', '2024-12-18 02:00:00+00:00', 1500),
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', '11429350-41f3-4b4a-ab7c-4dbcf6f3dbba', '2024-12-18 05:00:00+00:00', 1500),
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', '8b32f48d-6bc0-4891-a009-aeba59ee2c52', '2024-12-18 08:00:00+00:00', 1800),
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', 'c8c74caf-55f8-45a7-bbb3-d0cfa2fb6d10', '2024-12-18 11:00:00+00:00', 1800),
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', '347a0fc6-0541-44b4-aead-c34f7f783f10', '2024-12-18 14:00:00+00:00', 1800),

-- Hall B (Dec 18)
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', '347a0fc6-0541-44b4-aead-c34f7f783f10', '2024-12-17 17:00:00+00:00', 1800),
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', 'd349bc89-793e-4bed-a684-3bbc97162d51', '2024-12-18 02:00:00+00:00', 1500),
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', '3bbb4a0d-c774-443a-b44b-0ad7695a658b', '2024-12-18 05:00:00+00:00', 1500),
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', 'aba38539-abdb-4db6-818a-df092ffb8601', '2024-12-18 08:00:00+00:00', 1800),
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', '68f0c881-371f-4a2d-8ea4-03b23004a7f0', '2024-12-18 11:00:00+00:00', 1800),
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', 'd6949d54-041e-4972-9348-28b52f49cc4b', '2024-12-18 14:00:00+00:00', 1800),

-- Hall C (Dec 18)
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', '3d1fd545-0db9-4f54-914b-911e962d34b0', '2024-12-17 17:00:00+00:00', 1800),
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', '8b32f48d-6bc0-4891-a009-aeba59ee2c52', '2024-12-18 02:00:00+00:00', 1500),
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', '3bbb4a0d-c774-443a-b44b-0ad7695a658b', '2024-12-18 05:00:00+00:00', 1500),
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', '11429350-41f3-4b4a-ab7c-4dbcf6f3dbba', '2024-12-18 08:00:00+00:00', 1800),
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', 'e33a67d8-eb0d-46f7-b895-3688679910ad', '2024-12-18 11:00:00+00:00', 1800),
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', '347a0fc6-0541-44b4-aead-c34f7f783f10', '2024-12-18 14:00:00+00:00', 1800),

-- Hall D (Dec 18)
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', 'a616704c-9e54-47e3-a8ec-cb32398d1dbe', '2024-12-17 17:00:00+00:00', 1800),
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', '3d1fd545-0db9-4f54-914b-911e962d34b0', '2024-12-18 02:00:00+00:00', 1500),
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', '8b32f48d-6bc0-4891-a009-aeba59ee2c52', '2024-12-18 05:00:00+00:00', 1500),
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', '3bbb4a0d-c774-443a-b44b-0ad7695a658b', '2024-12-18 08:00:00+00:00', 1800),
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', '11429350-41f3-4b4a-ab7c-4dbcf6f3dbba', '2024-12-18 11:00:00+00:00', 1800),
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', 'e33a67d8-eb0d-46f7-b895-3688679910ad', '2024-12-18 14:00:00+00:00', 1800),

-- Hall E (Dec 18)
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', '8b32f48d-6bc0-4891-a009-aeba59ee2c52', '2024-12-17 17:00:00+00:00', 1800),
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', '3bbb4a0d-c774-443a-b44b-0ad7695a658b', '2024-12-18 02:00:00+00:00', 1500),
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', '11429350-41f3-4b4a-ab7c-4dbcf6f3dbba', '2024-12-18 05:00:00+00:00', 1500),
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', 'e33a67d8-eb0d-46f7-b895-3688679910ad', '2024-12-18 08:00:00+00:00', 1800),
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', '347a0fc6-0541-44b4-aead-c34f7f783f10', '2024-12-18 11:00:00+00:00', 1800),
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', 'b91777df-7050-40a6-b5d2-1549b34e20ff', '2024-12-18 14:00:00+00:00', 1800),

-- Hall F (Dec 18)
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', '11429350-41f3-4b4a-ab7c-4dbcf6f3dbba', '2024-12-17 17:00:00+00:00', 1800),
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', 'e33a67d8-eb0d-46f7-b895-3688679910ad', '2024-12-18 02:00:00+00:00', 1500),
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', '347a0fc6-0541-44b4-aead-c34f7f783f10', '2024-12-18 05:00:00+00:00', 1500),
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', 'b91777df-7050-40a6-b5d2-1549b34e20ff', '2024-12-18 08:00:00+00:00', 1800),
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', '8312a1c5-f285-4602-b9ef-2ce88aa79062', '2024-12-18 11:00:00+00:00', 1800),
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', 'c8c74caf-55f8-45a7-bbb3-d0cfa2fb6d10', '2024-12-18 14:00:00+00:00', 1800);


INSERT INTO "Showings" (id, hall_id, movie_id, start_time, pricex100) VALUES
-- Hall A (Dec 19)
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', '68f0c881-371f-4a2d-8ea4-03b23004a7f0', '2024-12-18 17:00:00+00:00', 1800),
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', 'aba38539-abdb-4db6-818a-df092ffb8601', '2024-12-19 02:00:00+00:00', 1500),
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', 'a616704c-9e54-47e3-a8ec-cb32398d1dbe', '2024-12-19 05:00:00+00:00', 1500),
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', '3d1fd545-0db9-4f54-914b-911e962d34b0', '2024-12-19 08:00:00+00:00', 1800),
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', '3bbb4a0d-c774-443a-b44b-0ad7695a658b', '2024-12-19 11:00:00+00:00', 1800),
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', 'b91777df-7050-40a6-b5d2-1549b34e20ff', '2024-12-19 14:00:00+00:00', 1800),

-- Hall B (Dec 19)
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', '8312a1c5-f285-4602-b9ef-2ce88aa79062', '2024-12-18 17:00:00+00:00', 1800),
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', 'e33a67d8-eb0d-46f7-b895-3688679910ad', '2024-12-19 02:00:00+00:00', 1500),
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', 'a616704c-9e54-47e3-a8ec-cb32398d1dbe', '2024-12-19 05:00:00+00:00', 1500),
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', '11429350-41f3-4b4a-ab7c-4dbcf6f3dbba', '2024-12-19 08:00:00+00:00', 1800),
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', 'b91777df-7050-40a6-b5d2-1549b34e20ff', '2024-12-19 11:00:00+00:00', 1800),
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', '8b32f48d-6bc0-4891-a009-aeba59ee2c52', '2024-12-19 14:00:00+00:00', 1800),

-- Hall C (Dec 19)
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', 'b91777df-7050-40a6-b5d2-1549b34e20ff', '2024-12-18 17:00:00+00:00', 1800),
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', '8312a1c5-f285-4602-b9ef-2ce88aa79062', '2024-12-19 02:00:00+00:00', 1500),
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', 'c8c74caf-55f8-45a7-bbb3-d0cfa2fb6d10', '2024-12-19 05:00:00+00:00', 1500),
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', '19eae21d-cd9e-4cf7-9269-8a1adc9b416d', '2024-12-19 08:00:00+00:00', 1800),
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', '68f0c881-371f-4a2d-8ea4-03b23004a7f0', '2024-12-19 11:00:00+00:00', 1800),
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', 'aba38539-abdb-4db6-818a-df092ffb8601', '2024-12-19 14:00:00+00:00', 1800),

-- Hall D (Dec 19)
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', '347a0fc6-0541-44b4-aead-c34f7f783f10', '2024-12-18 17:00:00+00:00', 1800),
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', 'b91777df-7050-40a6-b5d2-1549b34e20ff', '2024-12-19 02:00:00+00:00', 1500),
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', '8312a1c5-f285-4602-b9ef-2ce88aa79062', '2024-12-19 05:00:00+00:00', 1500),
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', 'c8c74caf-55f8-45a7-bbb3-d0cfa2fb6d10', '2024-12-19 08:00:00+00:00', 1800),
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', '19eae21d-cd9e-4cf7-9269-8a1adc9b416d', '2024-12-19 11:00:00+00:00', 1800),
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', '68f0c881-371f-4a2d-8ea4-03b23004a7f0', '2024-12-19 14:00:00+00:00', 1800),

-- Hall E (Dec 19)
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', '8312a1c5-f285-4602-b9ef-2ce88aa79062', '2024-12-18 17:00:00+00:00', 1800),
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', 'c8c74caf-55f8-45a7-bbb3-d0cfa2fb6d10', '2024-12-19 02:00:00+00:00', 1500),
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', '19eae21d-cd9e-4cf7-9269-8a1adc9b416d', '2024-12-19 05:00:00+00:00', 1500),
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', '68f0c881-371f-4a2d-8ea4-03b23004a7f0', '2024-12-19 08:00:00+00:00', 1800),
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', 'aba38539-abdb-4db6-818a-df092ffb8601', '2024-12-19 11:00:00+00:00', 1800),
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', 'd6949d54-041e-4972-9348-28b52f49cc4b', '2024-12-19 14:00:00+00:00', 1800),

-- Hall F (Dec 19)
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', '19eae21d-cd9e-4cf7-9269-8a1adc9b416d', '2024-12-18 17:00:00+00:00', 1800),
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', '68f0c881-371f-4a2d-8ea4-03b23004a7f0', '2024-12-19 02:00:00+00:00', 1500),
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', 'aba38539-abdb-4db6-818a-df092ffb8601', '2024-12-19 05:00:00+00:00', 1500),
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', 'd6949d54-041e-4972-9348-28b52f49cc4b', '2024-12-19 08:00:00+00:00', 1800),
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', 'd349bc89-793e-4bed-a684-3bbc97162d51', '2024-12-19 11:00:00+00:00', 1800),
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', 'a616704c-9e54-47e3-a8ec-cb32398d1dbe', '2024-12-19 14:00:00+00:00', 1800);


INSERT INTO "Showings" (id, hall_id, movie_id, start_time, pricex100) VALUES
-- Hall A (Dec 20)
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', 'd349bc89-793e-4bed-a684-3bbc97162d51', '2024-12-19 17:00:00+00:00', 1800),
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', '8312a1c5-f285-4602-b9ef-2ce88aa79062', '2024-12-20 02:00:00+00:00', 1500),
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', 'e33a67d8-eb0d-46f7-b895-3688679910ad', '2024-12-20 05:00:00+00:00', 1500),
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', 'd6949d54-041e-4972-9348-28b52f49cc4b', '2024-12-20 08:00:00+00:00', 1800),
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', '19eae21d-cd9e-4cf7-9269-8a1adc9b416d', '2024-12-20 11:00:00+00:00', 1800),
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', '11429350-41f3-4b4a-ab7c-4dbcf6f3dbba', '2024-12-20 14:00:00+00:00', 1800),

-- Hall B (Dec 20)
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', '3d1fd545-0db9-4f54-914b-911e962d34b0', '2024-12-19 17:00:00+00:00', 1800),
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', 'c8c74caf-55f8-45a7-bbb3-d0cfa2fb6d10', '2024-12-20 02:00:00+00:00', 1500),
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', '19eae21d-cd9e-4cf7-9269-8a1adc9b416d', '2024-12-20 05:00:00+00:00', 1500),
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', '347a0fc6-0541-44b4-aead-c34f7f783f10', '2024-12-20 08:00:00+00:00', 1800),
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', 'd349bc89-793e-4bed-a684-3bbc97162d51', '2024-12-20 11:00:00+00:00', 1800),
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', '3bbb4a0d-c774-443a-b44b-0ad7695a658b', '2024-12-20 14:00:00+00:00', 1800),

-- Hall C (Dec 20)
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', 'd6949d54-041e-4972-9348-28b52f49cc4b', '2024-12-19 17:00:00+00:00', 1800),
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', 'd349bc89-793e-4bed-a684-3bbc97162d51', '2024-12-20 02:00:00+00:00', 1500),
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', 'a616704c-9e54-47e3-a8ec-cb32398d1dbe', '2024-12-20 05:00:00+00:00', 1500),
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', '3d1fd545-0db9-4f54-914b-911e962d34b0', '2024-12-20 08:00:00+00:00', 1800),
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', '8b32f48d-6bc0-4891-a009-aeba59ee2c52', '2024-12-20 11:00:00+00:00', 1800),
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', '3bbb4a0d-c774-443a-b44b-0ad7695a658b', '2024-12-20 14:00:00+00:00', 1800),

-- Hall D (Dec 20)
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', 'aba38539-abdb-4db6-818a-df092ffb8601', '2024-12-19 17:00:00+00:00', 1800),
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', 'd6949d54-041e-4972-9348-28b52f49cc4b', '2024-12-20 02:00:00+00:00', 1500),
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', 'd349bc89-793e-4bed-a684-3bbc97162d51', '2024-12-20 05:00:00+00:00', 1500),
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', 'a616704c-9e54-47e3-a8ec-cb32398d1dbe', '2024-12-20 08:00:00+00:00', 1800),
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', '3d1fd545-0db9-4f54-914b-911e962d34b0', '2024-12-20 11:00:00+00:00', 1800),
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', '8b32f48d-6bc0-4891-a009-aeba59ee2c52', '2024-12-20 14:00:00+00:00', 1800),

-- Hall E (Dec 20)
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', 'd349bc89-793e-4bed-a684-3bbc97162d51', '2024-12-19 17:00:00+00:00', 1800),
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', 'a616704c-9e54-47e3-a8ec-cb32398d1dbe', '2024-12-20 02:00:00+00:00', 1500),
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', '3d1fd545-0db9-4f54-914b-911e962d34b0', '2024-12-20 05:00:00+00:00', 1500),
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', '8b32f48d-6bc0-4891-a009-aeba59ee2c52', '2024-12-20 08:00:00+00:00', 1800),
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', '3bbb4a0d-c774-443a-b44b-0ad7695a658b', '2024-12-20 11:00:00+00:00', 1800),
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', '11429350-41f3-4b4a-ab7c-4dbcf6f3dbba', '2024-12-20 14:00:00+00:00', 1800),

-- Hall F (Dec 20)
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', '3d1fd545-0db9-4f54-914b-911e962d34b0', '2024-12-19 17:00:00+00:00', 1800),
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', '8b32f48d-6bc0-4891-a009-aeba59ee2c52', '2024-12-20 02:00:00+00:00', 1500),
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', '3bbb4a0d-c774-443a-b44b-0ad7695a658b', '2024-12-20 05:00:00+00:00', 1500),
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', '11429350-41f3-4b4a-ab7c-4dbcf6f3dbba', '2024-12-20 08:00:00+00:00', 1800),
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', 'e33a67d8-eb0d-46f7-b895-3688679910ad', '2024-12-20 11:00:00+00:00', 1800),
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', '347a0fc6-0541-44b4-aead-c34f7f783f10', '2024-12-20 14:00:00+00:00', 1800);


INSERT INTO "Showings" (id, hall_id, movie_id, start_time, pricex100) VALUES
-- Hall A (Dec 21)
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', '8b32f48d-6bc0-4891-a009-aeba59ee2c52', '2024-12-20 17:00:00+00:00', 1800),
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', 'c8c74caf-55f8-45a7-bbb3-d0cfa2fb6d10', '2024-12-21 02:00:00+00:00', 1500),
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', '347a0fc6-0541-44b4-aead-c34f7f783f10', '2024-12-21 05:00:00+00:00', 1500),
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', '68f0c881-371f-4a2d-8ea4-03b23004a7f0', '2024-12-21 08:00:00+00:00', 1800),
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', 'a616704c-9e54-47e3-a8ec-cb32398d1dbe', '2024-12-21 11:00:00+00:00', 1800),
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', '68f0c881-371f-4a2d-8ea4-03b23004a7f0', '2024-12-21 14:00:00+00:00', 1800),

-- Hall B (Dec 21)
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', 'aba38539-abdb-4db6-818a-df092ffb8601', '2024-12-20 17:00:00+00:00', 1800),
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', '68f0c881-371f-4a2d-8ea4-03b23004a7f0', '2024-12-21 02:00:00+00:00', 1500),
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', 'd6949d54-041e-4972-9348-28b52f49cc4b', '2024-12-21 05:00:00+00:00', 1500),
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', '8312a1c5-f285-4602-b9ef-2ce88aa79062', '2024-12-21 08:00:00+00:00', 1800),
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', '19eae21d-cd9e-4cf7-9269-8a1adc9b416d', '2024-12-21 11:00:00+00:00', 1800),
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', '347a0fc6-0541-44b4-aead-c34f7f783f10', '2024-12-21 14:00:00+00:00', 1800),

-- Hall C (Dec 21)
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', '11429350-41f3-4b4a-ab7c-4dbcf6f3dbba', '2024-12-20 17:00:00+00:00', 1800),
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', 'e33a67d8-eb0d-46f7-b895-3688679910ad', '2024-12-21 02:00:00+00:00', 1500),
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', '347a0fc6-0541-44b4-aead-c34f7f783f10', '2024-12-21 05:00:00+00:00', 1500),
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', 'b91777df-7050-40a6-b5d2-1549b34e20ff', '2024-12-21 08:00:00+00:00', 1800),
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', '68f0c881-371f-4a2d-8ea4-03b23004a7f0', '2024-12-21 11:00:00+00:00', 1800),
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', '3d1fd545-0db9-4f54-914b-911e962d34b0', '2024-12-21 14:00:00+00:00', 1800),

-- Hall D (Dec 21)
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', '3bbb4a0d-c774-443a-b44b-0ad7695a658b', '2024-12-20 17:00:00+00:00', 1800),
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', '11429350-41f3-4b4a-ab7c-4dbcf6f3dbba', '2024-12-21 02:00:00+00:00', 1500),
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', 'e33a67d8-eb0d-46f7-b895-3688679910ad', '2024-12-21 05:00:00+00:00', 1500),
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', '347a0fc6-0541-44b4-aead-c34f7f783f10', '2024-12-21 08:00:00+00:00', 1800),
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', '19eae21d-cd9e-4cf7-9269-8a1adc9b416d', '2024-12-21 11:00:00+00:00', 1800),
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', '347a0fc6-0541-44b4-aead-c34f7f783f10', '2024-12-21 14:00:00+00:00', 1800),

-- Hall E (Dec 21)
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', 'e33a67d8-eb0d-46f7-b895-3688679910ad', '2024-12-20 17:00:00+00:00', 1800),
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', '347a0fc6-0541-44b4-aead-c34f7f783f10', '2024-12-21 02:00:00+00:00', 1500),
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', 'b91777df-7050-40a6-b5d2-1549b34e20ff', '2024-12-21 05:00:00+00:00', 1500),
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', '8312a1c5-f285-4602-b9ef-2ce88aa79062', '2024-12-21 08:00:00+00:00', 1800),
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', '8312a1c5-f285-4602-b9ef-2ce88aa79062', '2024-12-21 11:00:00+00:00', 1800),
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', 'e33a67d8-eb0d-46f7-b895-3688679910ad', '2024-12-21 14:00:00+00:00', 1800),

-- Hall F (Dec 21)
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', 'b91777df-7050-40a6-b5d2-1549b34e20ff', '2024-12-20 17:00:00+00:00', 1800),
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', '8312a1c5-f285-4602-b9ef-2ce88aa79062', '2024-12-21 02:00:00+00:00', 1500),
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', 'c8c74caf-55f8-45a7-bbb3-d0cfa2fb6d10', '2024-12-21 05:00:00+00:00', 1500),
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', '19eae21d-cd9e-4cf7-9269-8a1adc9b416d', '2024-12-21 08:00:00+00:00', 1800),
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', '11429350-41f3-4b4a-ab7c-4dbcf6f3dbba', '2024-12-21 11:00:00+00:00', 1800),
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', 'b91777df-7050-40a6-b5d2-1549b34e20ff', '2024-12-21 14:00:00+00:00', 1800);


INSERT INTO "Showings" (id, hall_id, movie_id, start_time, pricex100) VALUES
-- Hall A (Dec 22)
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', 'aba38539-abdb-4db6-818a-df092ffb8601', '2024-12-21 17:00:00+00:00', 1800),
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', 'a616704c-9e54-47e3-a8ec-cb32398d1dbe', '2024-12-22 02:00:00+00:00', 1500),
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', '3d1fd545-0db9-4f54-914b-911e962d34b0', '2024-12-22 05:00:00+00:00', 1500),
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', '3bbb4a0d-c774-443a-b44b-0ad7695a658b', '2024-12-22 08:00:00+00:00', 1800),
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', 'b91777df-7050-40a6-b5d2-1549b34e20ff', '2024-12-22 11:00:00+00:00', 1800),
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', 'd349bc89-793e-4bed-a684-3bbc97162d51', '2024-12-22 14:00:00+00:00', 1800),

-- Hall B (Dec 22)
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', 'd349bc89-793e-4bed-a684-3bbc97162d51', '2024-12-21 17:00:00+00:00', 1800),
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', '3bbb4a0d-c774-443a-b44b-0ad7695a658b', '2024-12-22 02:00:00+00:00', 1500),
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', '11429350-41f3-4b4a-ab7c-4dbcf6f3dbba', '2024-12-22 05:00:00+00:00', 1500),
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', 'b91777df-7050-40a6-b5d2-1549b34e20ff', '2024-12-22 08:00:00+00:00', 1800),
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', '8b32f48d-6bc0-4891-a009-aeba59ee2c52', '2024-12-22 11:00:00+00:00', 1800),
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', '3d1fd545-0db9-4f54-914b-911e962d34b0', '2024-12-22 14:00:00+00:00', 1800),

-- Hall C (Dec 22)
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', '8b32f48d-6bc0-4891-a009-aeba59ee2c52', '2024-12-21 17:00:00+00:00', 1800),
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', '3bbb4a0d-c774-443a-b44b-0ad7695a658b', '2024-12-22 02:00:00+00:00', 1500),
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', '19eae21d-cd9e-4cf7-9269-8a1adc9b416d', '2024-12-22 05:00:00+00:00', 1500),
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', '68f0c881-371f-4a2d-8ea4-03b23004a7f0', '2024-12-22 08:00:00+00:00', 1800),
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', 'aba38539-abdb-4db6-818a-df092ffb8601', '2024-12-22 11:00:00+00:00', 1800),
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', 'd6949d54-041e-4972-9348-28b52f49cc4b', '2024-12-22 14:00:00+00:00', 1800),

-- Hall D (Dec 22)
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', 'd349bc89-793e-4bed-a684-3bbc97162d51', '2024-12-21 17:00:00+00:00', 1800),
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', '3bbb4a0d-c774-443a-b44b-0ad7695a658b', '2024-12-22 02:00:00+00:00', 1500),
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', '11429350-41f3-4b4a-ab7c-4dbcf6f3dbba', '2024-12-22 05:00:00+00:00', 1500),
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', 'b91777df-7050-40a6-b5d2-1549b34e20ff', '2024-12-22 08:00:00+00:00', 1800),
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', '8b32f48d-6bc0-4891-a009-aeba59ee2c52', '2024-12-22 11:00:00+00:00', 1800),
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', '3d1fd545-0db9-4f54-914b-911e962d34b0', '2024-12-22 14:00:00+00:00', 1800),

-- Hall E (Dec 22)
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', '11429350-41f3-4b4a-ab7c-4dbcf6f3dbba', '2024-12-21 17:00:00+00:00', 1800),
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', 'b91777df-7050-40a6-b5d2-1549b34e20ff', '2024-12-22 02:00:00+00:00', 1500),
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', '8b32f48d-6bc0-4891-a009-aeba59ee2c52', '2024-12-22 05:00:00+00:00', 1500),
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', '3d1fd545-0db9-4f54-914b-911e962d34b0', '2024-12-22 08:00:00+00:00', 1800),
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', 'c8c74caf-55f8-45a7-bbb3-d0cfa2fb6d10', '2024-12-22 11:00:00+00:00', 1800),
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', '19eae21d-cd9e-4cf7-9269-8a1adc9b416d', '2024-12-22 14:00:00+00:00', 1800),

-- Hall F (Dec 22)
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', '8b32f48d-6bc0-4891-a009-aeba59ee2c52', '2024-12-21 17:00:00+00:00', 1800),
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', '3d1fd545-0db9-4f54-914b-911e962d34b0', '2024-12-22 02:00:00+00:00', 1500),
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', 'c8c74caf-55f8-45a7-bbb3-d0cfa2fb6d10', '2024-12-22 05:00:00+00:00', 1500),
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', '19eae21d-cd9e-4cf7-9269-8a1adc9b416d', '2024-12-22 08:00:00+00:00', 1800),
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', '347a0fc6-0541-44b4-aead-c34f7f783f10', '2024-12-22 11:00:00+00:00', 1800),
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', 'd349bc89-793e-4bed-a684-3bbc97162d51', '2024-12-22 14:00:00+00:00', 1800);


INSERT INTO "Showings" (id, hall_id, movie_id, start_time, pricex100) VALUES
-- Hall A (Dec 23)
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', '8312a1c5-f285-4602-b9ef-2ce88aa79062', '2024-12-22 17:00:00+00:00', 1800),
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', 'e33a67d8-eb0d-46f7-b895-3688679910ad', '2024-12-23 02:00:00+00:00', 1500),
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', 'd6949d54-041e-4972-9348-28b52f49cc4b', '2024-12-23 05:00:00+00:00', 1500),
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', '19eae21d-cd9e-4cf7-9269-8a1adc9b416d', '2024-12-23 08:00:00+00:00', 1800),
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', '11429350-41f3-4b4a-ab7c-4dbcf6f3dbba', '2024-12-23 11:00:00+00:00', 1800),
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', '8b32f48d-6bc0-4891-a009-aeba59ee2c52', '2024-12-23 14:00:00+00:00', 1800),

-- Hall B (Dec 23)
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', 'c8c74caf-55f8-45a7-bbb3-d0cfa2fb6d10', '2024-12-22 17:00:00+00:00', 1800),
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', '19eae21d-cd9e-4cf7-9269-8a1adc9b416d', '2024-12-23 02:00:00+00:00', 1500),
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', '347a0fc6-0541-44b4-aead-c34f7f783f10', '2024-12-23 05:00:00+00:00', 1500),
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', 'd349bc89-793e-4bed-a684-3bbc97162d51', '2024-12-23 08:00:00+00:00', 1800),
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', '3bbb4a0d-c774-443a-b44b-0ad7695a658b', '2024-12-23 11:00:00+00:00', 1800),
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', 'aba38539-abdb-4db6-818a-df092ffb8601', '2024-12-23 14:00:00+00:00', 1800),

-- Hall C (Dec 23)
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', 'd349bc89-793e-4bed-a684-3bbc97162d51', '2024-12-22 17:00:00+00:00', 1800),
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', 'a616704c-9e54-47e3-a8ec-cb32398d1dbe', '2024-12-23 02:00:00+00:00', 1500),
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', '3d1fd545-0db9-4f54-914b-911e962d34b0', '2024-12-23 05:00:00+00:00', 1500),
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', '8b32f48d-6bc0-4891-a009-aeba59ee2c52', '2024-12-23 08:00:00+00:00', 1800),
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', '3bbb4a0d-c774-443a-b44b-0ad7695a658b', '2024-12-23 11:00:00+00:00', 1800),
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', '11429350-41f3-4b4a-ab7c-4dbcf6f3dbba', '2024-12-23 14:00:00+00:00', 1800),

-- Hall D (Dec 23)
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', 'c8c74caf-55f8-45a7-bbb3-d0cfa2fb6d10', '2024-12-22 17:00:00+00:00', 1800),
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', '19eae21d-cd9e-4cf7-9269-8a1adc9b416d', '2024-12-23 02:00:00+00:00', 1500),
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', '347a0fc6-0541-44b4-aead-c34f7f783f10', '2024-12-23 05:00:00+00:00', 1500),
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', 'd349bc89-793e-4bed-a684-3bbc97162d51', '2024-12-23 08:00:00+00:00', 1800),
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', '3bbb4a0d-c774-443a-b44b-0ad7695a658b', '2024-12-23 11:00:00+00:00', 1800),
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', 'aba38539-abdb-4db6-818a-df092ffb8601', '2024-12-23 14:00:00+00:00', 1800),

-- Hall E (Dec 23)
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', '347a0fc6-0541-44b4-aead-c34f7f783f10', '2024-12-22 17:00:00+00:00', 1800),
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', 'd349bc89-793e-4bed-a684-3bbc97162d51', '2024-12-23 02:00:00+00:00', 1500),
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', '3bbb4a0d-c774-443a-b44b-0ad7695a658b', '2024-12-23 05:00:00+00:00', 1500),
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', 'aba38539-abdb-4db6-818a-df092ffb8601', '2024-12-23 08:00:00+00:00', 1800),
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', '68f0c881-371f-4a2d-8ea4-03b23004a7f0', '2024-12-23 11:00:00+00:00', 1800),
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', 'd6949d54-041e-4972-9348-28b52f49cc4b', '2024-12-23 14:00:00+00:00', 1800),

-- Hall F (Dec 23)
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', '3bbb4a0d-c774-443a-b44b-0ad7695a658b', '2024-12-22 17:00:00+00:00', 1800),
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', 'aba38539-abdb-4db6-818a-df092ffb8601', '2024-12-23 02:00:00+00:00', 1500),
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', '68f0c881-371f-4a2d-8ea4-03b23004a7f0', '2024-12-23 05:00:00+00:00', 1500),
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', 'd6949d54-041e-4972-9348-28b52f49cc4b', '2024-12-23 08:00:00+00:00', 1800),
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', '8312a1c5-f285-4602-b9ef-2ce88aa79062', '2024-12-23 11:00:00+00:00', 1800),
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', 'e33a67d8-eb0d-46f7-b895-3688679910ad', '2024-12-23 14:00:00+00:00', 1800);


INSERT INTO "Showings" (id, hall_id, movie_id, start_time, pricex100) VALUES
-- Hall A (Dec 24)
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', 'c8c74caf-55f8-45a7-bbb3-d0cfa2fb6d10', '2024-12-23 17:00:00+00:00', 1800),
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', '347a0fc6-0541-44b4-aead-c34f7f783f10', '2024-12-24 02:00:00+00:00', 1500),
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', '68f0c881-371f-4a2d-8ea4-03b23004a7f0', '2024-12-24 05:00:00+00:00', 1500),
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', 'aba38539-abdb-4db6-818a-df092ffb8601', '2024-12-24 08:00:00+00:00', 1800),
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', 'a616704c-9e54-47e3-a8ec-cb32398d1dbe', '2024-12-24 11:00:00+00:00', 1800),
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', '3d1fd545-0db9-4f54-914b-911e962d34b0', '2024-12-24 14:00:00+00:00', 1800),

-- Hall B (Dec 24)
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', '68f0c881-371f-4a2d-8ea4-03b23004a7f0', '2024-12-23 17:00:00+00:00', 1800),
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', 'd6949d54-041e-4972-9348-28b52f49cc4b', '2024-12-24 02:00:00+00:00', 1500),
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', '8312a1c5-f285-4602-b9ef-2ce88aa79062', '2024-12-24 05:00:00+00:00', 1500),
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', 'e33a67d8-eb0d-46f7-b895-3688679910ad', '2024-12-24 08:00:00+00:00', 1800),
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', 'a616704c-9e54-47e3-a8ec-cb32398d1dbe', '2024-12-24 11:00:00+00:00', 1800),
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', '11429350-41f3-4b4a-ab7c-4dbcf6f3dbba', '2024-12-24 14:00:00+00:00', 1800),

-- Hall C (Dec 24)
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', 'e33a67d8-eb0d-46f7-b895-3688679910ad', '2024-12-23 17:00:00+00:00', 1800),
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', '347a0fc6-0541-44b4-aead-c34f7f783f10', '2024-12-24 02:00:00+00:00', 1500),
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', 'b91777df-7050-40a6-b5d2-1549b34e20ff', '2024-12-24 05:00:00+00:00', 1500),
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', '8312a1c5-f285-4602-b9ef-2ce88aa79062', '2024-12-24 08:00:00+00:00', 1800),
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', 'c8c74caf-55f8-45a7-bbb3-d0cfa2fb6d10', '2024-12-24 11:00:00+00:00', 1800),
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', '19eae21d-cd9e-4cf7-9269-8a1adc9b416d', '2024-12-24 14:00:00+00:00', 1800),

-- Hall D (Dec 24)
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', '68f0c881-371f-4a2d-8ea4-03b23004a7f0', '2024-12-23 17:00:00+00:00', 1800),
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', 'd6949d54-041e-4972-9348-28b52f49cc4b', '2024-12-24 02:00:00+00:00', 1500),
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', '8312a1c5-f285-4602-b9ef-2ce88aa79062', '2024-12-24 05:00:00+00:00', 1500),
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', 'e33a67d8-eb0d-46f7-b895-3688679910ad', '2024-12-24 08:00:00+00:00', 1800),
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', 'a616704c-9e54-47e3-a8ec-cb32398d1dbe', '2024-12-24 11:00:00+00:00', 1800),
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', '11429350-41f3-4b4a-ab7c-4dbcf6f3dbba', '2024-12-24 14:00:00+00:00', 1800),

-- Hall E (Dec 24)
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', '8312a1c5-f285-4602-b9ef-2ce88aa79062', '2024-12-23 17:00:00+00:00', 1800),
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', 'e33a67d8-eb0d-46f7-b895-3688679910ad', '2024-12-24 02:00:00+00:00', 1500),
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', 'a616704c-9e54-47e3-a8ec-cb32398d1dbe', '2024-12-24 05:00:00+00:00', 1500),
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', '11429350-41f3-4b4a-ab7c-4dbcf6f3dbba', '2024-12-24 08:00:00+00:00', 1800),
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', 'b91777df-7050-40a6-b5d2-1549b34e20ff', '2024-12-24 11:00:00+00:00', 1800),
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', '8b32f48d-6bc0-4891-a009-aeba59ee2c52', '2024-12-24 14:00:00+00:00', 1800),

-- Hall F (Dec 24)
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', 'a616704c-9e54-47e3-a8ec-cb32398d1dbe', '2024-12-23 17:00:00+00:00', 1800),
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', '11429350-41f3-4b4a-ab7c-4dbcf6f3dbba', '2024-12-24 02:00:00+00:00', 1500),
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', 'b91777df-7050-40a6-b5d2-1549b34e20ff', '2024-12-24 05:00:00+00:00', 1500),
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', '8b32f48d-6bc0-4891-a009-aeba59ee2c52', '2024-12-24 08:00:00+00:00', 1800),
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', '3d1fd545-0db9-4f54-914b-911e962d34b0', '2024-12-24 11:00:00+00:00', 1800),
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', 'c8c74caf-55f8-45a7-bbb3-d0cfa2fb6d10', '2024-12-24 14:00:00+00:00', 1800);


INSERT INTO "Showings" (id, hall_id, movie_id, start_time, pricex100) VALUES
-- Hall A (Dec 25)
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', '3bbb4a0d-c774-443a-b44b-0ad7695a658b', '2024-12-24 17:00:00+00:00', 1800),
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', 'b91777df-7050-40a6-b5d2-1549b34e20ff', '2024-12-25 02:00:00+00:00', 1500),
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', 'd349bc89-793e-4bed-a684-3bbc97162d51', '2024-12-25 05:00:00+00:00', 1500),
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', '8312a1c5-f285-4602-b9ef-2ce88aa79062', '2024-12-25 08:00:00+00:00', 1800),
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', 'e33a67d8-eb0d-46f7-b895-3688679910ad', '2024-12-25 11:00:00+00:00', 1800),
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', 'd6949d54-041e-4972-9348-28b52f49cc4b', '2024-12-25 14:00:00+00:00', 1800),

-- Hall B (Dec 25)
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', 'b91777df-7050-40a6-b5d2-1549b34e20ff', '2024-12-24 17:00:00+00:00', 1800),
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', '8b32f48d-6bc0-4891-a009-aeba59ee2c52', '2024-12-25 02:00:00+00:00', 1500),
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', '3d1fd545-0db9-4f54-914b-911e962d34b0', '2024-12-25 05:00:00+00:00', 1500),
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', 'c8c74caf-55f8-45a7-bbb3-d0cfa2fb6d10', '2024-12-25 08:00:00+00:00', 1800),
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', '19eae21d-cd9e-4cf7-9269-8a1adc9b416d', '2024-12-25 11:00:00+00:00', 1800),
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', '347a0fc6-0541-44b4-aead-c34f7f783f10', '2024-12-25 14:00:00+00:00', 1800),

-- Hall C (Dec 25)
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', '68f0c881-371f-4a2d-8ea4-03b23004a7f0', '2024-12-24 17:00:00+00:00', 1800),
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', 'aba38539-abdb-4db6-818a-df092ffb8601', '2024-12-25 02:00:00+00:00', 1500),
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', 'd6949d54-041e-4972-9348-28b52f49cc4b', '2024-12-25 05:00:00+00:00', 1500),
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', 'd349bc89-793e-4bed-a684-3bbc97162d51', '2024-12-25 08:00:00+00:00', 1800),
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', 'a616704c-9e54-47e3-a8ec-cb32398d1dbe', '2024-12-25 11:00:00+00:00', 1800),
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', '3d1fd545-0db9-4f54-914b-911e962d34b0', '2024-12-25 14:00:00+00:00', 1800),

-- Hall D (Dec 25)
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', 'b91777df-7050-40a6-b5d2-1549b34e20ff', '2024-12-24 17:00:00+00:00', 1800),
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', '8b32f48d-6bc0-4891-a009-aeba59ee2c52', '2024-12-25 02:00:00+00:00', 1500),
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', '3d1fd545-0db9-4f54-914b-911e962d34b0', '2024-12-25 05:00:00+00:00', 1500),
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', 'c8c74caf-55f8-45a7-bbb3-d0cfa2fb6d10', '2024-12-25 08:00:00+00:00', 1800),
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', '19eae21d-cd9e-4cf7-9269-8a1adc9b416d', '2024-12-25 11:00:00+00:00', 1800),
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', '347a0fc6-0541-44b4-aead-c34f7f783f10', '2024-12-25 14:00:00+00:00', 1800),

-- Hall E (Dec 25)
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', '3d1fd545-0db9-4f54-914b-911e962d34b0', '2024-12-24 17:00:00+00:00', 1800),
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', 'c8c74caf-55f8-45a7-bbb3-d0cfa2fb6d10', '2024-12-25 02:00:00+00:00', 1500),
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', '19eae21d-cd9e-4cf7-9269-8a1adc9b416d', '2024-12-25 05:00:00+00:00', 1500),
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', '347a0fc6-0541-44b4-aead-c34f7f783f10', '2024-12-25 08:00:00+00:00', 1800),
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', 'd349bc89-793e-4bed-a684-3bbc97162d51', '2024-12-25 11:00:00+00:00', 1800),
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', '3bbb4a0d-c774-443a-b44b-0ad7695a658b', '2024-12-25 14:00:00+00:00', 1800),

-- Hall F (Dec 25)
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', '19eae21d-cd9e-4cf7-9269-8a1adc9b416d', '2024-12-24 17:00:00+00:00', 1800),
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', '347a0fc6-0541-44b4-aead-c34f7f783f10', '2024-12-25 02:00:00+00:00', 1500),
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', 'd349bc89-793e-4bed-a684-3bbc97162d51', '2024-12-25 05:00:00+00:00', 1500),
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', '3bbb4a0d-c774-443a-b44b-0ad7695a658b', '2024-12-25 08:00:00+00:00', 1800),
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', 'aba38539-abdb-4db6-818a-df092ffb8601', '2024-12-25 11:00:00+00:00', 1800),
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', '68f0c881-371f-4a2d-8ea4-03b23004a7f0', '2024-12-25 14:00:00+00:00', 1800);


INSERT INTO "Showings" (id, hall_id, movie_id, start_time, pricex100) VALUES
-- Hall A (Dec 26)
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', '19eae21d-cd9e-4cf7-9269-8a1adc9b416d', '2024-12-25 17:00:00+00:00', 1800),
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', '11429350-41f3-4b4a-ab7c-4dbcf6f3dbba', '2024-12-26 02:00:00+00:00', 1500),
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', '8b32f48d-6bc0-4891-a009-aeba59ee2c52', '2024-12-26 05:00:00+00:00', 1500),
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', 'c8c74caf-55f8-45a7-bbb3-d0cfa2fb6d10', '2024-12-26 08:00:00+00:00', 1800),
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', '347a0fc6-0541-44b4-aead-c34f7f783f10', '2024-12-26 11:00:00+00:00', 1800),
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', 'aba38539-abdb-4db6-818a-df092ffb8601', '2024-12-26 14:00:00+00:00', 1800),

-- Hall B (Dec 26)
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', 'd349bc89-793e-4bed-a684-3bbc97162d51', '2024-12-25 17:00:00+00:00', 1800),
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', '3bbb4a0d-c774-443a-b44b-0ad7695a658b', '2024-12-26 02:00:00+00:00', 1500),
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', 'aba38539-abdb-4db6-818a-df092ffb8601', '2024-12-26 05:00:00+00:00', 1500),
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', '68f0c881-371f-4a2d-8ea4-03b23004a7f0', '2024-12-26 08:00:00+00:00', 1800),
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', 'd6949d54-041e-4972-9348-28b52f49cc4b', '2024-12-26 11:00:00+00:00', 1800),
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', 'b91777df-7050-40a6-b5d2-1549b34e20ff', '2024-12-26 14:00:00+00:00', 1800),

-- Hall C (Dec 26)
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', '8b32f48d-6bc0-4891-a009-aeba59ee2c52', '2024-12-25 17:00:00+00:00', 1800),
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', '3bbb4a0d-c774-443a-b44b-0ad7695a658b', '2024-12-26 02:00:00+00:00', 1500),
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', '11429350-41f3-4b4a-ab7c-4dbcf6f3dbba', '2024-12-26 05:00:00+00:00', 1500),
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', 'e33a67d8-eb0d-46f7-b895-3688679910ad', '2024-12-26 08:00:00+00:00', 1800),
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', '347a0fc6-0541-44b4-aead-c34f7f783f10', '2024-12-26 11:00:00+00:00', 1800),
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', '68f0c881-371f-4a2d-8ea4-03b23004a7f0', '2024-12-26 14:00:00+00:00', 1800),

-- Hall D (Dec 26)
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', 'd349bc89-793e-4bed-a684-3bbc97162d51', '2024-12-25 17:00:00+00:00', 1800),
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', '3bbb4a0d-c774-443a-b44b-0ad7695a658b', '2024-12-26 02:00:00+00:00', 1500),
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', 'aba38539-abdb-4db6-818a-df092ffb8601', '2024-12-26 05:00:00+00:00', 1500),
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', '68f0c881-371f-4a2d-8ea4-03b23004a7f0', '2024-12-26 08:00:00+00:00', 1800),
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', 'd6949d54-041e-4972-9348-28b52f49cc4b', '2024-12-26 11:00:00+00:00', 1800),
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', 'a616704c-9e54-47e3-a8ec-cb32398d1dbe', '2024-12-26 14:00:00+00:00', 1800),

-- Hall E (Dec 26)
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', 'aba38539-abdb-4db6-818a-df092ffb8601', '2024-12-25 17:00:00+00:00', 1800),
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', '68f0c881-371f-4a2d-8ea4-03b23004a7f0', '2024-12-26 02:00:00+00:00', 1500),
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', 'd6949d54-041e-4972-9348-28b52f49cc4b', '2024-12-26 05:00:00+00:00', 1500),
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', '8312a1c5-f285-4602-b9ef-2ce88aa79062', '2024-12-26 08:00:00+00:00', 1800),
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', 'e33a67d8-eb0d-46f7-b895-3688679910ad', '2024-12-26 11:00:00+00:00', 1800),
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', '347a0fc6-0541-44b4-aead-c34f7f783f10', '2024-12-26 14:00:00+00:00', 1800),

-- Hall F (Dec 26)
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', 'd6949d54-041e-4972-9348-28b52f49cc4b', '2024-12-25 17:00:00+00:00', 1800),
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', '8312a1c5-f285-4602-b9ef-2ce88aa79062', '2024-12-26 02:00:00+00:00', 1500),
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', 'e33a67d8-eb0d-46f7-b895-3688679910ad', '2024-12-26 05:00:00+00:00', 1500),
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', 'a616704c-9e54-47e3-a8ec-cb32398d1dbe', '2024-12-26 08:00:00+00:00', 1800),
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', '8312a1c5-f285-4602-b9ef-2ce88aa79062', '2024-12-26 11:00:00+00:00', 1800),
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', '3d1fd545-0db9-4f54-914b-911e962d34b0', '2024-12-26 14:00:00+00:00', 1800);


INSERT INTO "Showings" (id, hall_id, movie_id, start_time, pricex100) VALUES
-- Hall A (Dec 27)
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', 'a616704c-9e54-47e3-a8ec-cb32398d1dbe', '2024-12-26 17:00:00+00:00', 1800),
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', '68f0c881-371f-4a2d-8ea4-03b23004a7f0', '2024-12-27 02:00:00+00:00', 1500),
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', 'aba38539-abdb-4db6-818a-df092ffb8601', '2024-12-27 05:00:00+00:00', 1500),
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', 'a616704c-9e54-47e3-a8ec-cb32398d1dbe', '2024-12-27 08:00:00+00:00', 1800),
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', '3d1fd545-0db9-4f54-914b-911e962d34b0', '2024-12-27 11:00:00+00:00', 1800),
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', '3bbb4a0d-c774-443a-b44b-0ad7695a658b', '2024-12-27 14:00:00+00:00', 1800),

-- Hall B (Dec 27)
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', '8b32f48d-6bc0-4891-a009-aeba59ee2c52', '2024-12-26 17:00:00+00:00', 1800),
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', '3d1fd545-0db9-4f54-914b-911e962d34b0', '2024-12-27 02:00:00+00:00', 1500),
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', 'c8c74caf-55f8-45a7-bbb3-d0cfa2fb6d10', '2024-12-27 05:00:00+00:00', 1500),
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', 'a616704c-9e54-47e3-a8ec-cb32398d1dbe', '2024-12-27 08:00:00+00:00', 1800),
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', '11429350-41f3-4b4a-ab7c-4dbcf6f3dbba', '2024-12-27 11:00:00+00:00', 1800),
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', 'b91777df-7050-40a6-b5d2-1549b34e20ff', '2024-12-27 14:00:00+00:00', 1800),

-- Hall C (Dec 27)
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', 'aba38539-abdb-4db6-818a-df092ffb8601', '2024-12-26 17:00:00+00:00', 1800),
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', 'd6949d54-041e-4972-9348-28b52f49cc4b', '2024-12-27 02:00:00+00:00', 1500),
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', 'd349bc89-793e-4bed-a684-3bbc97162d51', '2024-12-27 05:00:00+00:00', 1500),
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', 'c8c74caf-55f8-45a7-bbb3-d0cfa2fb6d10', '2024-12-27 08:00:00+00:00', 1800),
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', '19eae21d-cd9e-4cf7-9269-8a1adc9b416d', '2024-12-27 11:00:00+00:00', 1800),
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', '68f0c881-371f-4a2d-8ea4-03b23004a7f0', '2024-12-27 14:00:00+00:00', 1800),

-- Hall D (Dec 27)
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', '68f0c881-371f-4a2d-8ea4-03b23004a7f0', '2024-12-26 17:00:00+00:00', 1800),
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', 'aba38539-abdb-4db6-818a-df092ffb8601', '2024-12-27 02:00:00+00:00', 1500),
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', 'a616704c-9e54-47e3-a8ec-cb32398d1dbe', '2024-12-27 05:00:00+00:00', 1500),
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', '3d1fd545-0db9-4f54-914b-911e962d34b0', '2024-12-27 08:00:00+00:00', 1800),
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', '3bbb4a0d-c774-443a-b44b-0ad7695a658b', '2024-12-27 11:00:00+00:00', 1800),
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', 'b91777df-7050-40a6-b5d2-1549b34e20ff', '2024-12-27 14:00:00+00:00', 1800),

-- Hall E (Dec 27)
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', '68f0c881-371f-4a2d-8ea4-03b23004a7f0', '2024-12-26 17:00:00+00:00', 1800),
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', '3d1fd545-0db9-4f54-914b-911e962d34b0', '2024-12-27 02:00:00+00:00', 1500),
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', '3bbb4a0d-c774-443a-b44b-0ad7695a658b', '2024-12-27 05:00:00+00:00', 1500),
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', 'b91777df-7050-40a6-b5d2-1549b34e20ff', '2024-12-27 08:00:00+00:00', 1800),
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', 'd349bc89-793e-4bed-a684-3bbc97162d51', '2024-12-27 11:00:00+00:00', 1800),
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', '8312a1c5-f285-4602-b9ef-2ce88aa79062', '2024-12-27 14:00:00+00:00', 1800),

-- Hall F (Dec 27)
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', '3bbb4a0d-c774-443a-b44b-0ad7695a658b', '2024-12-26 17:00:00+00:00', 1800),
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', 'b91777df-7050-40a6-b5d2-1549b34e20ff', '2024-12-27 02:00:00+00:00', 1500),
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', 'd349bc89-793e-4bed-a684-3bbc97162d51', '2024-12-27 05:00:00+00:00', 1500),
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', '8312a1c5-f285-4602-b9ef-2ce88aa79062', '2024-12-27 08:00:00+00:00', 1800),
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', 'e33a67d8-eb0d-46f7-b895-3688679910ad', '2024-12-27 11:00:00+00:00', 1800),
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', 'd6949d54-041e-4972-9348-28b52f49cc4b', '2024-12-27 14:00:00+00:00', 1800);


INSERT INTO "Showings" (id, hall_id, movie_id, start_time, pricex100) VALUES
-- Hall A (Dec 28)
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', 'b91777df-7050-40a6-b5d2-1549b34e20ff', '2024-12-27 17:00:00+00:00', 1800),
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', 'd349bc89-793e-4bed-a684-3bbc97162d51', '2024-12-28 02:00:00+00:00', 1500),
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', '8312a1c5-f285-4602-b9ef-2ce88aa79062', '2024-12-28 05:00:00+00:00', 1500),
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', 'e33a67d8-eb0d-46f7-b895-3688679910ad', '2024-12-28 08:00:00+00:00', 1800),
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', 'd6949d54-041e-4972-9348-28b52f49cc4b', '2024-12-28 11:00:00+00:00', 1800),
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', '19eae21d-cd9e-4cf7-9269-8a1adc9b416d', '2024-12-28 14:00:00+00:00', 1800),

-- Hall B (Dec 28)
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', '8b32f48d-6bc0-4891-a009-aeba59ee2c52', '2024-12-27 17:00:00+00:00', 1800),
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', '3d1fd545-0db9-4f54-914b-911e962d34b0', '2024-12-28 02:00:00+00:00', 1500),
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', 'c8c74caf-55f8-45a7-bbb3-d0cfa2fb6d10', '2024-12-28 05:00:00+00:00', 1500),
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', '19eae21d-cd9e-4cf7-9269-8a1adc9b416d', '2024-12-28 08:00:00+00:00', 1800),
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', '347a0fc6-0541-44b4-aead-c34f7f783f10', '2024-12-28 11:00:00+00:00', 1800),
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', 'd349bc89-793e-4bed-a684-3bbc97162d51', '2024-12-28 14:00:00+00:00', 1800),

-- Hall C (Dec 28)
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', 'aba38539-abdb-4db6-818a-df092ffb8601', '2024-12-27 17:00:00+00:00', 1800),
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', 'd6949d54-041e-4972-9348-28b52f49cc4b', '2024-12-28 02:00:00+00:00', 1500),
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', 'd349bc89-793e-4bed-a684-3bbc97162d51', '2024-12-28 05:00:00+00:00', 1500),
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', 'a616704c-9e54-47e3-a8ec-cb32398d1dbe', '2024-12-28 08:00:00+00:00', 1800),
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', '3d1fd545-0db9-4f54-914b-911e962d34b0', '2024-12-28 11:00:00+00:00', 1800),
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', '8b32f48d-6bc0-4891-a009-aeba59ee2c52', '2024-12-28 14:00:00+00:00', 1800),

-- Hall D (Dec 28)
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', 'd349bc89-793e-4bed-a684-3bbc97162d51', '2024-12-27 17:00:00+00:00', 1800),
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', '8312a1c5-f285-4602-b9ef-2ce88aa79062', '2024-12-28 02:00:00+00:00', 1500),
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', 'e33a67d8-eb0d-46f7-b895-3688679910ad', '2024-12-28 05:00:00+00:00', 1500),
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', 'd6949d54-041e-4972-9348-28b52f49cc4b', '2024-12-28 08:00:00+00:00', 1800),
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', '19eae21d-cd9e-4cf7-9269-8a1adc9b416d', '2024-12-28 11:00:00+00:00', 1800),
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', '11429350-41f3-4b4a-ab7c-4dbcf6f3dbba', '2024-12-28 14:00:00+00:00', 1800),

-- Hall E (Dec 28)
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', 'e33a67d8-eb0d-46f7-b895-3688679910ad', '2024-12-27 17:00:00+00:00', 1800),
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', 'd6949d54-041e-4972-9348-28b52f49cc4b', '2024-12-28 02:00:00+00:00', 1500),
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', '19eae21d-cd9e-4cf7-9269-8a1adc9b416d', '2024-12-28 05:00:00+00:00', 1500),
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', '11429350-41f3-4b4a-ab7c-4dbcf6f3dbba', '2024-12-28 08:00:00+00:00', 1800),
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', '8b32f48d-6bc0-4891-a009-aeba59ee2c52', '2024-12-28 11:00:00+00:00', 1800),
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', 'c8c74caf-55f8-45a7-bbb3-d0cfa2fb6d10', '2024-12-28 14:00:00+00:00', 1800),

-- Hall F (Dec 28)
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', '19eae21d-cd9e-4cf7-9269-8a1adc9b416d', '2024-12-27 17:00:00+00:00', 1800),
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', '11429350-41f3-4b4a-ab7c-4dbcf6f3dbba', '2024-12-28 02:00:00+00:00', 1500),
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', '8b32f48d-6bc0-4891-a009-aeba59ee2c52', '2024-12-28 05:00:00+00:00', 1500),
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', 'c8c74caf-55f8-45a7-bbb3-d0cfa2fb6d10', '2024-12-28 08:00:00+00:00', 1800),
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', '347a0fc6-0541-44b4-aead-c34f7f783f10', '2024-12-28 11:00:00+00:00', 1800),
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', '68f0c881-371f-4a2d-8ea4-03b23004a7f0', '2024-12-28 14:00:00+00:00', 1800);


INSERT INTO "Showings" (id, hall_id, movie_id, start_time, pricex100) VALUES
-- Hall A (Dec 29)
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', '11429350-41f3-4b4a-ab7c-4dbcf6f3dbba', '2024-12-28 17:00:00+00:00', 1800),
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', '8b32f48d-6bc0-4891-a009-aeba59ee2c52', '2024-12-29 02:00:00+00:00', 1500),
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', 'c8c74caf-55f8-45a7-bbb3-d0cfa2fb6d10', '2024-12-29 05:00:00+00:00', 1500),
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', '347a0fc6-0541-44b4-aead-c34f7f783f10', '2024-12-29 08:00:00+00:00', 1800),
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', '68f0c881-371f-4a2d-8ea4-03b23004a7f0', '2024-12-29 11:00:00+00:00', 1800),
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', 'aba38539-abdb-4db6-818a-df092ffb8601', '2024-12-29 14:00:00+00:00', 1800),

-- Hall B (Dec 29)
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', '3bbb4a0d-c774-443a-b44b-0ad7695a658b', '2024-12-28 17:00:00+00:00', 1800),
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', 'aba38539-abdb-4db6-818a-df092ffb8601', '2024-12-29 02:00:00+00:00', 1500),
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', '68f0c881-371f-4a2d-8ea4-03b23004a7f0', '2024-12-29 05:00:00+00:00', 1500),
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', 'd6949d54-041e-4972-9348-28b52f49cc4b', '2024-12-29 08:00:00+00:00', 1800),
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', '8312a1c5-f285-4602-b9ef-2ce88aa79062', '2024-12-29 11:00:00+00:00', 1800),
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', 'e33a67d8-eb0d-46f7-b895-3688679910ad', '2024-12-29 14:00:00+00:00', 1800),

-- Hall C (Dec 29)
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', '3bbb4a0d-c774-443a-b44b-0ad7695a658b', '2024-12-28 17:00:00+00:00', 1800),
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', '11429350-41f3-4b4a-ab7c-4dbcf6f3dbba', '2024-12-29 02:00:00+00:00', 1500),
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', 'e33a67d8-eb0d-46f7-b895-3688679910ad', '2024-12-29 05:00:00+00:00', 1500),
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', '347a0fc6-0541-44b4-aead-c34f7f783f10', '2024-12-29 08:00:00+00:00', 1800),
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', 'b91777df-7050-40a6-b5d2-1549b34e20ff', '2024-12-29 11:00:00+00:00', 1800),
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', '8312a1c5-f285-4602-b9ef-2ce88aa79062', '2024-12-29 14:00:00+00:00', 1800),

-- Hall D (Dec 29)
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', '8b32f48d-6bc0-4891-a009-aeba59ee2c52', '2024-12-28 17:00:00+00:00', 1800),
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', 'c8c74caf-55f8-45a7-bbb3-d0cfa2fb6d10', '2024-12-29 02:00:00+00:00', 1500),
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', '347a0fc6-0541-44b4-aead-c34f7f783f10', '2024-12-29 05:00:00+00:00', 1500),
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', '68f0c881-371f-4a2d-8ea4-03b23004a7f0', '2024-12-29 08:00:00+00:00', 1800),
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', 'aba38539-abdb-4db6-818a-df092ffb8601', '2024-12-29 11:00:00+00:00', 1800),
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', 'a616704c-9e54-47e3-a8ec-cb32398d1dbe', '2024-12-29 14:00:00+00:00', 1800),

-- Hall E (Dec 29)
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', '347a0fc6-0541-44b4-aead-c34f7f783f10', '2024-12-28 17:00:00+00:00', 1800),
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', '68f0c881-371f-4a2d-8ea4-03b23004a7f0', '2024-12-29 02:00:00+00:00', 1500),
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', 'aba38539-abdb-4db6-818a-df092ffb8601', '2024-12-29 05:00:00+00:00', 1500),
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', 'a616704c-9e54-47e3-a8ec-cb32398d1dbe', '2024-12-29 08:00:00+00:00', 1800),
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', '3d1fd545-0db9-4f54-914b-911e962d34b0', '2024-12-29 11:00:00+00:00', 1800),
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', '3bbb4a0d-c774-443a-b44b-0ad7695a658b', '2024-12-29 14:00:00+00:00', 1800),

-- Hall F (Dec 29)
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', 'aba38539-abdb-4db6-818a-df092ffb8601', '2024-12-28 17:00:00+00:00', 1800),
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', 'a616704c-9e54-47e3-a8ec-cb32398d1dbe', '2024-12-29 02:00:00+00:00', 1500),
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', '3d1fd545-0db9-4f54-914b-911e962d34b0', '2024-12-29 05:00:00+00:00', 1500),
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', '3bbb4a0d-c774-443a-b44b-0ad7695a658b', '2024-12-29 08:00:00+00:00', 1800),
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', 'b91777df-7050-40a6-b5d2-1549b34e20ff', '2024-12-29 11:00:00+00:00', 1800),
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', 'd349bc89-793e-4bed-a684-3bbc97162d51', '2024-12-29 14:00:00+00:00', 1800);


INSERT INTO "Showings" (id, hall_id, movie_id, start_time, pricex100) VALUES
-- Hall A (Dec 30)
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', 'a616704c-9e54-47e3-a8ec-cb32398d1dbe', '2024-12-29 17:00:00+00:00', 1800),
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', '3d1fd545-0db9-4f54-914b-911e962d34b0', '2024-12-30 02:00:00+00:00', 1500),
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', '3bbb4a0d-c774-443a-b44b-0ad7695a658b', '2024-12-30 05:00:00+00:00', 1500),
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', 'b91777df-7050-40a6-b5d2-1549b34e20ff', '2024-12-30 08:00:00+00:00', 1800),
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', 'd349bc89-793e-4bed-a684-3bbc97162d51', '2024-12-30 11:00:00+00:00', 1800),
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', '8312a1c5-f285-4602-b9ef-2ce88aa79062', '2024-12-30 14:00:00+00:00', 1800),

-- Hall B (Dec 30)
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', 'a616704c-9e54-47e3-a8ec-cb32398d1dbe', '2024-12-29 17:00:00+00:00', 1800),
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', '11429350-41f3-4b4a-ab7c-4dbcf6f3dbba', '2024-12-30 02:00:00+00:00', 1500),
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', 'b91777df-7050-40a6-b5d2-1549b34e20ff', '2024-12-30 05:00:00+00:00', 1500),
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', '8b32f48d-6bc0-4891-a009-aeba59ee2c52', '2024-12-30 08:00:00+00:00', 1800),
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', '3d1fd545-0db9-4f54-914b-911e962d34b0', '2024-12-30 11:00:00+00:00', 1800),
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', 'c8c74caf-55f8-45a7-bbb3-d0cfa2fb6d10', '2024-12-30 14:00:00+00:00', 1800),

-- Hall C (Dec 30)
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', 'c8c74caf-55f8-45a7-bbb3-d0cfa2fb6d10', '2024-12-29 17:00:00+00:00', 1800),
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', '19eae21d-cd9e-4cf7-9269-8a1adc9b416d', '2024-12-30 02:00:00+00:00', 1500),
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', '68f0c881-371f-4a2d-8ea4-03b23004a7f0', '2024-12-30 05:00:00+00:00', 1500),
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', 'aba38539-abdb-4db6-818a-df092ffb8601', '2024-12-30 08:00:00+00:00', 1800),
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', 'd6949d54-041e-4972-9348-28b52f49cc4b', '2024-12-30 11:00:00+00:00', 1800),
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', 'd349bc89-793e-4bed-a684-3bbc97162d51', '2024-12-30 14:00:00+00:00', 1800),

-- Hall D (Dec 30)
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', '3d1fd545-0db9-4f54-914b-911e962d34b0', '2024-12-29 17:00:00+00:00', 1800),
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', '3bbb4a0d-c774-443a-b44b-0ad7695a658b', '2024-12-30 02:00:00+00:00', 1500),
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', 'b91777df-7050-40a6-b5d2-1549b34e20ff', '2024-12-30 05:00:00+00:00', 1500),
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', 'd349bc89-793e-4bed-a684-3bbc97162d51', '2024-12-30 08:00:00+00:00', 1800),
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', '8312a1c5-f285-4602-b9ef-2ce88aa79062', '2024-12-30 11:00:00+00:00', 1800),
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', 'e33a67d8-eb0d-46f7-b895-3688679910ad', '2024-12-30 14:00:00+00:00', 1800),

-- Hall E (Dec 30)
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', 'b91777df-7050-40a6-b5d2-1549b34e20ff', '2024-12-29 17:00:00+00:00', 1800),
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', 'd349bc89-793e-4bed-a684-3bbc97162d51', '2024-12-30 02:00:00+00:00', 1500),
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', '8312a1c5-f285-4602-b9ef-2ce88aa79062', '2024-12-30 05:00:00+00:00', 1500),
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', 'e33a67d8-eb0d-46f7-b895-3688679910ad', '2024-12-30 08:00:00+00:00', 1800),
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', 'd6949d54-041e-4972-9348-28b52f49cc4b', '2024-12-30 11:00:00+00:00', 1800),
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', '19eae21d-cd9e-4cf7-9269-8a1adc9b416d', '2024-12-30 14:00:00+00:00', 1800),

-- Hall F (Dec 30)
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', '8312a1c5-f285-4602-b9ef-2ce88aa79062', '2024-12-29 17:00:00+00:00', 1800),
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', 'e33a67d8-eb0d-46f7-b895-3688679910ad', '2024-12-30 02:00:00+00:00', 1500),
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', 'd6949d54-041e-4972-9348-28b52f49cc4b', '2024-12-30 05:00:00+00:00', 1500),
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', '19eae21d-cd9e-4cf7-9269-8a1adc9b416d', '2024-12-30 08:00:00+00:00', 1800),
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', '11429350-41f3-4b4a-ab7c-4dbcf6f3dbba', '2024-12-30 11:00:00+00:00', 1800),
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', '8b32f48d-6bc0-4891-a009-aeba59ee2c52', '2024-12-30 14:00:00+00:00', 1800);


INSERT INTO "Showings" (id, hall_id, movie_id, start_time, pricex100) VALUES
-- Hall A (Dec 31)
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', 'e33a67d8-eb0d-46f7-b895-3688679910ad', '2024-12-30 17:00:00+00:00', 1800),
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', 'd6949d54-041e-4972-9348-28b52f49cc4b', '2024-12-31 02:00:00+00:00', 1500),
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', '19eae21d-cd9e-4cf7-9269-8a1adc9b416d', '2024-12-31 05:00:00+00:00', 1500),
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', '11429350-41f3-4b4a-ab7c-4dbcf6f3dbba', '2024-12-31 08:00:00+00:00', 1800),
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', '8b32f48d-6bc0-4891-a009-aeba59ee2c52', '2024-12-31 11:00:00+00:00', 1800),
(gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', 'c8c74caf-55f8-45a7-bbb3-d0cfa2fb6d10', '2024-12-31 14:00:00+00:00', 1800),

-- Hall B (Dec 31)
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', '19eae21d-cd9e-4cf7-9269-8a1adc9b416d', '2024-12-30 17:00:00+00:00', 1800),
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', '347a0fc6-0541-44b4-aead-c34f7f783f10', '2024-12-31 02:00:00+00:00', 1500),
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', 'd349bc89-793e-4bed-a684-3bbc97162d51', '2024-12-31 05:00:00+00:00', 1500),
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', '3bbb4a0d-c774-443a-b44b-0ad7695a658b', '2024-12-31 08:00:00+00:00', 1800),
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', 'aba38539-abdb-4db6-818a-df092ffb8601', '2024-12-31 11:00:00+00:00', 1800),
(gen_random_uuid(), '827465c3-a1fe-4245-b4bd-326b8371a502', '68f0c881-371f-4a2d-8ea4-03b23004a7f0', '2024-12-31 14:00:00+00:00', 1800),

-- Hall C (Dec 31)
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', 'a616704c-9e54-47e3-a8ec-cb32398d1dbe', '2024-12-30 17:00:00+00:00', 1800),
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', '3d1fd545-0db9-4f54-914b-911e962d34b0', '2024-12-31 02:00:00+00:00', 1500),
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', '8b32f48d-6bc0-4891-a009-aeba59ee2c52', '2024-12-31 05:00:00+00:00', 1500),
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', '3bbb4a0d-c774-443a-b44b-0ad7695a658b', '2024-12-31 08:00:00+00:00', 1800),
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', '11429350-41f3-4b4a-ab7c-4dbcf6f3dbba', '2024-12-31 11:00:00+00:00', 1800),
(gen_random_uuid(), '5aa22443-5fc6-46a6-9fe6-0261c015251e', 'e33a67d8-eb0d-46f7-b895-3688679910ad', '2024-12-31 14:00:00+00:00', 1800),

-- Hall D (Dec 31)
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', 'd6949d54-041e-4972-9348-28b52f49cc4b', '2024-12-30 17:00:00+00:00', 1800),
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', '19eae21d-cd9e-4cf7-9269-8a1adc9b416d', '2024-12-31 02:00:00+00:00', 1500),
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', '11429350-41f3-4b4a-ab7c-4dbcf6f3dbba', '2024-12-31 05:00:00+00:00', 1500),
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', '8b32f48d-6bc0-4891-a009-aeba59ee2c52', '2024-12-31 08:00:00+00:00', 1800),
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', 'c8c74caf-55f8-45a7-bbb3-d0cfa2fb6d10', '2024-12-31 11:00:00+00:00', 1800),
(gen_random_uuid(), 'b7f76a6d-f8c3-404e-b20f-fce253237a28', '347a0fc6-0541-44b4-aead-c34f7f783f10', '2024-12-31 14:00:00+00:00', 1800),

-- Hall E (Dec 31)
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', '11429350-41f3-4b4a-ab7c-4dbcf6f3dbba', '2024-12-30 17:00:00+00:00', 1800),
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', '8b32f48d-6bc0-4891-a009-aeba59ee2c52', '2024-12-31 02:00:00+00:00', 1500),
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', 'c8c74caf-55f8-45a7-bbb3-d0cfa2fb6d10', '2024-12-31 05:00:00+00:00', 1500),
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', '347a0fc6-0541-44b4-aead-c34f7f783f10', '2024-12-31 08:00:00+00:00', 1800),
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', '68f0c881-371f-4a2d-8ea4-03b23004a7f0', '2024-12-31 11:00:00+00:00', 1800),
(gen_random_uuid(), 'f826f9d7-a64b-4db5-ac9a-08e6e568fbe0', 'aba38539-abdb-4db6-818a-df092ffb8601', '2024-12-31 14:00:00+00:00', 1800),

-- Hall F (Dec 31)
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', 'c8c74caf-55f8-45a7-bbb3-d0cfa2fb6d10', '2024-12-30 17:00:00+00:00', 1800),
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', '347a0fc6-0541-44b4-aead-c34f7f783f10', '2024-12-31 02:00:00+00:00', 1500),
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', '68f0c881-371f-4a2d-8ea4-03b23004a7f0', '2024-12-31 05:00:00+00:00', 1500),
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', 'aba38539-abdb-4db6-818a-df092ffb8601', '2024-12-31 08:00:00+00:00', 1800),
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', 'a616704c-9e54-47e3-a8ec-cb32398d1dbe', '2024-12-31 11:00:00+00:00', 1800),
(gen_random_uuid(), 'b3ba36ff-39f1-4325-8a23-d93f09996e49', '347a0fc6-0541-44b4-aead-c34f7f783f10', '2024-12-31 14:00:00+00:00', 1800);


--Insert Showings
-- INSERT INTO "Showings" (id, hall_id, movie_id, start_time, pricex100) VALUES
-- (gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', '3d1fd545-0db9-4f54-914b-911e962d34b0', '2024-01-20 15:30:00+00:00', 1800),
-- (gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', '3d1fd545-0db9-4f54-914b-911e962d34b0', '2024-01-20 15:30:00+00:00', 1800),
-- (gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', '3d1fd545-0db9-4f54-914b-911e962d34b0', '2024-01-20 15:30:00+00:00', 1800),
-- (gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', '3d1fd545-0db9-4f54-914b-911e962d34b0', '2024-01-20 15:30:00+00:00', 1800),
-- ...........more rows
-- (gen_random_uuid(), '06704009-4cda-4207-809b-d211cea25edd', '3d1fd545-0db9-4f54-914b-911e962d34b0', '2024-01-20 15:30:00+00:00', 1800);


-- Insert users with hashed passwords (password123)
INSERT INTO "Users" (id, username, email, phone, first_name, last_name, date_of_registration, last_modified_date, password)
VALUES 
    (gen_random_uuid(), 'user1', 'user1@example.com', '0122223333', 'User', 'One', '2024-01-15 10:00:00+00', '2024-01-15 10:00:00+00', '$2b$12$JrEq/AYYXV0gd2srNwk5i.YMmyx6MHA5ArfZ4OYnckSmki/U5MiVa'),
    (gen_random_uuid(), 'user2', 'user2@example.com', '0133334444', 'User', 'Two', '2024-02-01 14:30:00+00', '2024-02-01 14:30:00+00', '$2b$12$31a.BZPw1Z/yk/MFDPI42eijpffUuSEplOl1s.SXM09C3yx8gUS.W'),
    (gen_random_uuid(), 'user3', 'user3@example.com', '0144445555', 'User', 'Three', '2024-02-01 14:30:00+00', '2024-02-01 14:30:00+00', '$2b$12$Lsq0XiuKn6Vf/8mhzcwEWe7Gm7dTTVzrF6OJHAjnLaGsEh5txjm2i');