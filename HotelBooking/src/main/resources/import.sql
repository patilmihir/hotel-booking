INSERT INTO category (id, name) VALUES (1, 'Luxury'),(2, 'Apartment Hotel');

INSERT INTO room_type (id, description, occupancy) VALUES (1, 'Single', 1),(2, 'Double', 2),(3, 'Studio', 2),(4, 'Presidential Suite', 6);

INSERT INTO authority (id, role) VALUES (1, 'ROLE_USER'),(2, 'ROLE_HOTEL_MANAGER');


insert into user (id, email, name, password, username, authority_id) values (1, 'patilmihir@ymail.com', 'Mihir Patil', 'pass', 'mihir', 1);
insert into user (id, email, name, password, username, authority_id) values (2, 'pushkarkhedekar@gmail.com', 'Pushkar Khedekar', 'pass', 'pushkar', 1);
insert into user (id, email, name, password, username, authority_id) values (3, 'vivekshetye7@gmail.com', 'Vivek Shetye', 'pass', 'vivek', 1);

insert into user (id, email, name, password, username, authority_id) values (4, 'manager1@gmail.com', 'Cristiano Ronaldo', 'pass', 'cristiano', 2);
insert into user (id, email, name, password, username, authority_id) values (5, 'manager2@gmail.com', 'Lionel Messi', 'pass', 'lionel', 2);
insert into user (id, email, name, password, username, authority_id) values (6, 'manager3@gmail.com', 'Neymar', 'pass', 'neymar', 2);
insert into user (id, email, name, password, username, authority_id) values (7, 'manager4@gmail.com', 'Petr Cech', 'pass', 'peter', 2);


INSERT INTO hotel (id, address, name, rating, category_id, manager_id, status) VALUES (1, 'Rajasthan, India','The Oberoi Rajvilas', 5, 1, 4, true),(2, 'Mumbai, India','The Taj Mahal Palace', 5, 1, 5, true),(3, 'Shimla, India','Wildflower Hall', 2, 2, 6, true),(4, 'Dubai', 'Burj Al Arab', 5, 1, 7, true);


insert into comment (id, date, text, hotel_id, user_id) VALUES (1, '2017-04-21 14:05:00','TEST 1', 1, 1);
insert into comment (id, date, text, hotel_id, user_id) VALUES (2, '2017-04-21 15:10:00','TEST 2', 1, 1);
insert into comment (id, date, text, hotel_id, user_id) VALUES (3, '2017-04-21 16:43:00','TEST 3', 1, 1);
insert into comment (id, date, text, hotel_id, user_id) VALUES (4, '2017-04-21 20:12:00','TEST 4', 2, 1);
insert into comment (id, date, text, hotel_id, user_id) VALUES (5, '2017-04-21 21:55:00','TEST 5', 3, 2);
insert into comment (id, date, text, hotel_id, user_id) VALUES (6, '2017-04-21 21:55:00','TEST 6', 4, 2);
insert into comment (id, date, text, hotel_id, user_id) values (7, '2017-04-22 07:51:47', 'AAA', 4, 2);
insert into comment (id, date, text, hotel_id, user_id) values (8, '2017-04-23 20:32:02', 'BBB', 2, 3);
insert into comment (id, date, text, hotel_id, user_id) values (9, '2017-04-23 21:37:56', 'CCC', 2, 3);
insert into comment (id, date, text, hotel_id, user_id) values (10, '2017-04-23 21:51:10', 'DDD', 4, 2);
insert into comment (id, date, text, hotel_id, user_id) values (11, '2017-04-24 22:12:37', 'EEE', 1, 4);
insert into comment (id, date, text, hotel_id, user_id) values (12, '2017-04-25 18:38:51', 'FFF', 1, 6);
insert into comment (id, date, text, hotel_id, user_id) values (13, '2017-04-25 18:57:42', 'GGG', 1, 3);
insert into comment (id, date, text, hotel_id, user_id) values (14, '2016-04-25 19:35:37', 'HHH', 3, 7);
insert into comment (id, date, text, hotel_id, user_id) values (15, '2016-04-25 20:04:13', 'III', 1, 2);
insert into comment (id, date, text, hotel_id, user_id) values (16, '2016-04-25 20:02:23', 'JJJ', 2, 3);
insert into comment (id, date, text, hotel_id, user_id) values (17, '2016-04-25 21:28:37', 'KKK', 2, 1);
insert into comment (id, date, text, hotel_id, user_id) values (18, '2016-04-25 21:30:14', 'LLL', 4, 1);
insert into comment (id, date, text, hotel_id, user_id) values (19, '2016-04-25 22:49:18', 'MMM', 3, 4);
insert into comment (id, date, text, hotel_id, user_id) values (20, '2016-04-25 23:01:13', 'NNN', 1, 5);
insert into comment (id, date, text, hotel_id, user_id) values (21, '2016-04-25 23:39:19', 'OOO', 4, 2);





insert into room (id, floor, room_number, hotel_id, type_id, price) values (1, 1, '101', 1, 1, 1000);
insert into room (id, floor, room_number, hotel_id, type_id, price) values (2, 1, '102', 1, 2, 1500);
insert into room (id, floor, room_number, hotel_id, type_id, price) values (3, 1, '103', 1, 3, 1700);
insert into room (id, floor, room_number, hotel_id, type_id, price) values (4, 1, '104', 1, 4, 2000);
insert into room (id, floor, room_number, hotel_id, type_id, price) values (5, 1, '105', 1, 1, 1000);
insert into room (id, floor, room_number, hotel_id, type_id, price) values (6, 2, '201', 1, 2, 1500);
insert into room (id, floor, room_number, hotel_id, type_id, price) values (7, 2, '202', 1, 3, 1700);
insert into room (id, floor, room_number, hotel_id, type_id, price) values (8, 2, '203', 1, 4, 2000);
insert into room (id, floor, room_number, hotel_id, type_id, price) values (9, 2, '204', 1, 1, 1000);
insert into room (id, floor, room_number, hotel_id, type_id, price) values (10, 2, '205', 1, 2, 1500);
insert into room (id, floor, room_number, hotel_id, type_id, price) values (11, 1, '101', 2, 1, 1000);
insert into room (id, floor, room_number, hotel_id, type_id, price) values (12, 1, '102', 2, 2, 1500);
insert into room (id, floor, room_number, hotel_id, type_id, price) values (13, 1, '103', 2, 3, 1700);
insert into room (id, floor, room_number, hotel_id, type_id, price) values (14, 1, '104', 2, 4, 2000);
insert into room (id, floor, room_number, hotel_id, type_id, price) values (15, 1, '105', 2, 1, 1000);
insert into room (id, floor, room_number, hotel_id, type_id, price) values (16, 2, '201', 2, 2, 1500);
insert into room (id, floor, room_number, hotel_id, type_id, price) values (17, 2, '202', 2, 3, 1700);
insert into room (id, floor, room_number, hotel_id, type_id, price) values (18, 2, '203', 2, 4, 2000);
insert into room (id, floor, room_number, hotel_id, type_id, price) values (19, 2, '204', 2, 1, 1000);
insert into room (id, floor, room_number, hotel_id, type_id, price) values (20, 2, '205', 2, 2, 1500);
insert into room (id, floor, room_number, hotel_id, type_id, price) values (21, 1, '101', 3, 1, 1000);
insert into room (id, floor, room_number, hotel_id, type_id, price) values (22, 1, '102', 3, 2, 1500);
insert into room (id, floor, room_number, hotel_id, type_id, price) values (23, 1, '103', 3, 3, 1700);
insert into room (id, floor, room_number, hotel_id, type_id, price) values (24, 1, '104', 3, 4, 2000);
insert into room (id, floor, room_number, hotel_id, type_id, price) values (25, 1, '105', 3, 1, 1000);
insert into room (id, floor, room_number, hotel_id, type_id, price) values (26, 2, '201', 3, 2, 1500);
insert into room (id, floor, room_number, hotel_id, type_id, price) values (27, 2, '202', 3, 3, 1700);
insert into room (id, floor, room_number, hotel_id, type_id, price) values (28, 2, '203', 3, 4, 2000);
insert into room (id, floor, room_number, hotel_id, type_id, price) values (29, 2, '204', 3, 1, 1000);
insert into room (id, floor, room_number, hotel_id, type_id, price) values (30, 2, '205', 3, 2, 1500);
insert into room (id, floor, room_number, hotel_id, type_id, price) values (31, 1, '101', 4, 1, 1000);
insert into room (id, floor, room_number, hotel_id, type_id, price) values (32, 1, '102', 4, 2, 1500);
insert into room (id, floor, room_number, hotel_id, type_id, price) values (33, 1, '103', 4, 3, 1700);
insert into room (id, floor, room_number, hotel_id, type_id, price) values (34, 1, '104', 4, 4, 2000);
insert into room (id, floor, room_number, hotel_id, type_id, price) values (35, 1, '105', 4, 1, 1000);
insert into room (id, floor, room_number, hotel_id, type_id, price) values (36, 2, '201', 4, 2, 1500);
insert into room (id, floor, room_number, hotel_id, type_id, price) values (37, 2, '202', 4, 3, 1700);
insert into room (id, floor, room_number, hotel_id, type_id, price) values (38, 2, '203', 4, 4, 2000);
insert into room (id, floor, room_number, hotel_id, type_id, price) values (39, 2, '204', 4, 1, 1000);
insert into room (id, floor, room_number, hotel_id, type_id, price) values (40, 2, '205', 4, 2, 1500);




INSERT INTO image (id, insertion_date, hotel_id, path) VALUES (1, '2015-10-22 15:00:00', 4, 'burj1.jpg'),(2, '2015-10-22 15:00:00', 4, 'burj2.jpeg'),(3, '2015-10-22 15:00:00', 4,'burj3.jpeg'),(4, '2015-10-22 15:00:00', 4, 'burj4.jpg'),(5, '2015-10-22 15:00:00', 1, 'rajvillas1.jpg'),(6, '2015-10-22 15:00:00', 1, 'rajvillas2.jpg'),(7, '2015-10-22 15:00:00', 1, 'rajvillas3.jpg'),(8, '2015-10-22 15:00:00', 2, 'taj1.jpg'),(9, '2015-10-22 15:00:00', 2, 'taj2.jpg'),(10, '2015-10-22 15:00:00', 2, 'taj3.jpg'),(11, '2015-10-22 15:00:00', 3, 'wildflower1.jpg'),(12, '2015-10-22 15:00:00', 3, 'wildflower2.jpg'),(13, '2015-10-22 15:00:00', 3, 'wildflower3.jpg');

insert into booking (id, begin_date, end_date, state, user_id) values (1, '2017-04-18 12:00:00', '2017-04-20 12:00:00', TRUE, 1);
insert into booking (id, begin_date, end_date, state, user_id) values (2, '2017-04-19 12:00:00', '2017-04-21 12:00:00', TRUE, 1);
insert into booking (id, begin_date, end_date, state, user_id) values (3, '2017-05-29 14:00:00', '2017-05-29 11:00:00', TRUE, 1);
insert into booking (id, begin_date, end_date, state, user_id) values (4, '2017-04-27 02:16:13', '2017-04-29 05:30:55', TRUE,2);
insert into booking (id, begin_date, end_date, state, user_id) values (5, '2017-04-29 16:53:12', '2017-04-30 14:04:27', TRUE,2);
insert into booking (id, begin_date, end_date, state, user_id) values (6, '2017-05-28 15:43:32', '2017-05-30 21:49:40', TRUE,2);
insert into booking (id, begin_date, end_date, state, user_id) values (7, '2017-04-27 20:22:39', '2017-04-28 16:22:16', true, 3);
insert into booking (id, begin_date, end_date, state, user_id) values (8, '2017-04-26 08:12:25', '2017-04-27 05:40:48', true, 4);
insert into booking (id, begin_date, end_date, state, user_id) values (9, '2017-05-25 08:48:20', '2017-05-25 10:16:14', true, 5);
insert into booking (id, begin_date, end_date, state, user_id) values (10, '2017-04-30 01:27:44', '2017-05-01 05:31:19', true, 7);
insert into booking (id, begin_date, end_date, state, user_id) values (11, '2017-04-29 09:44:00', '2017-05-02 00:10:38', true, 6);
insert into booking (id, begin_date, end_date, state, user_id) values (12, '2017-04-26 21:35:09', '2017-04-29 10:18:16', true, 5);
insert into booking (id, begin_date, end_date, state, user_id) values (13, '2017-04-17 20:26:30', '2017-04-18 05:10:56', true, 3);

insert into booking_room (bookings_id, rooms_id) values (1, 1);
insert into booking_room (bookings_id, rooms_id) values (2, 2);
insert into booking_room (bookings_id, rooms_id) values (3, 5);
insert into booking_room (bookings_id, rooms_id) values (4, 7);
insert into booking_room (bookings_id, rooms_id) values (5, 12);
insert into booking_room (bookings_id, rooms_id) values (6, 13);
insert into booking_room (bookings_id, rooms_id) values (7, 18);
insert into booking_room (bookings_id, rooms_id) values (8, 19);
insert into booking_room (bookings_id, rooms_id) values (9, 25);
insert into booking_room (bookings_id, rooms_id) values (10, 26);
insert into booking_room (bookings_id, rooms_id) values (11, 27);
insert into booking_room (bookings_id, rooms_id) values (12, 31);
insert into booking_room (bookings_id, rooms_id) values (13, 33);
insert into booking_room (bookings_id, rooms_id) values (4, 9);
insert into booking_room (bookings_id, rooms_id) values (5, 15);
insert into booking_room (bookings_id, rooms_id) values (6, 11);