-- ============================================================
-- PlatinumRx Assignment | Hotel Management System
-- File: 01_Hotel_Schema_Setup.sql
-- Description: Table creation + sample data insertion
-- ============================================================

-- Drop tables if they already exist (safe re-run)
DROP TABLE IF EXISTS booking_commercials;
DROP TABLE IF EXISTS bookings;
DROP TABLE IF EXISTS items;
DROP TABLE IF EXISTS users;

-- ------------------------------------------------------------
-- Table: users
-- ------------------------------------------------------------
CREATE TABLE users (
    user_id         VARCHAR(50)  PRIMARY KEY,
    name            VARCHAR(100) NOT NULL,
    phone_number    VARCHAR(20),
    mail_id         VARCHAR(100),
    billing_address TEXT
);

-- ------------------------------------------------------------
-- Table: items
-- ------------------------------------------------------------
CREATE TABLE items (
    item_id    VARCHAR(50) PRIMARY KEY,
    item_name  VARCHAR(100) NOT NULL,
    item_rate  DECIMAL(10,2) NOT NULL
);

-- ------------------------------------------------------------
-- Table: bookings
-- ------------------------------------------------------------
CREATE TABLE bookings (
    booking_id   VARCHAR(50) PRIMARY KEY,
    booking_date DATETIME     NOT NULL,
    room_no      VARCHAR(50),
    user_id      VARCHAR(50),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- ------------------------------------------------------------
-- Table: booking_commercials
-- ------------------------------------------------------------
CREATE TABLE booking_commercials (
    id            VARCHAR(50) PRIMARY KEY,
    booking_id    VARCHAR(50),
    bill_id       VARCHAR(50),
    bill_date     DATETIME,
    item_id       VARCHAR(50),
    item_quantity DECIMAL(10,2),
    FOREIGN KEY (booking_id) REFERENCES bookings(booking_id),
    FOREIGN KEY (item_id)    REFERENCES items(item_id)
);

-- ============================================================
-- SAMPLE DATA INSERTION
-- ============================================================

-- users
INSERT INTO users (user_id, name, phone_number, mail_id, billing_address) VALUES
('21wrcxuy-67erfn', 'John Doe',    '97XXXXXXXX', 'john.doe@example.com', 'XX, Street Y, ABC City'),
('usr-abc123-xyz',  'Jane Smith',  '98XXXXXXXX', 'jane.smith@example.com', '10, Main Road, DEF City'),
('usr-def456-pqr',  'Bob Johnson', '99XXXXXXXX', 'bob.j@example.com',    '5, Park Ave, GHI City'),
('usr-ghi789-mno',  'Alice Brown', '91XXXXXXXX', 'alice.b@example.com',  '22, Lake View, JKL City'),
('usr-jkl012-stu',  'Charlie Lee', '92XXXXXXXX', 'charlie.l@example.com','7, Hill Road, MNO City');

-- items
INSERT INTO items (item_id, item_name, item_rate) VALUES
('itm-a9e8-q8fu', 'Tawa Paratha',    18.00),
('itm-a07vh-aer8','Mix Veg',         89.00),
('itm-w978-23u4', 'Dal Makhani',    120.00),
('itm-b12c-34de', 'Butter Naan',     30.00),
('itm-c56d-78ef', 'Paneer Tikka',   180.00),
('itm-d90e-12fg', 'Mineral Water',   20.00),
('itm-e34f-56gh', 'Cold Coffee',     60.00),
('itm-f78g-90hi', 'Room Service',   250.00);

-- bookings  (spread across 2021 to cover all query date ranges)
INSERT INTO bookings (booking_id, booking_date, room_no, user_id) VALUES
('bk-09f3e-95hj', '2021-09-23 07:36:48', 'rm-bhf9-aerjn', '21wrcxuy-67erfn'),
('bk-q034-q4o',   '2021-10-05 14:22:00', 'rm-x100-abcd',  'usr-abc123-xyz'),
('bk-r045-r5p',   '2021-10-12 09:10:00', 'rm-x101-efgh',  'usr-def456-pqr'),
('bk-s056-s6q',   '2021-10-20 11:45:00', 'rm-x102-ijkl',  'usr-ghi789-mno'),
('bk-t067-t7r',   '2021-11-03 08:30:00', 'rm-x103-mnop',  'usr-jkl012-stu'),
('bk-u078-u8s',   '2021-11-10 16:00:00', 'rm-x104-qrst',  '21wrcxuy-67erfn'),
('bk-v089-v9t',   '2021-11-18 12:15:00', 'rm-x105-uvwx',  'usr-abc123-xyz'),
('bk-w090-w0u',   '2021-12-01 10:00:00', 'rm-x106-yz12',  'usr-def456-pqr'),
('bk-x101-x1v',   '2021-12-15 09:00:00', 'rm-x107-3456',  'usr-ghi789-mno'),
('bk-y112-y2w',   '2021-12-28 18:00:00', 'rm-x108-7890',  'usr-jkl012-stu');

-- booking_commercials
INSERT INTO booking_commercials (id, booking_id, bill_id, bill_date, item_id, item_quantity) VALUES
-- Sep 2021 booking
('q34r-3q4o8-q34u', 'bk-09f3e-95hj', 'bl-0a87y-q340', '2021-09-23 12:03:22', 'itm-a9e8-q8fu',  3),
('q3o4-ahf32-o2u4', 'bk-09f3e-95hj', 'bl-0a87y-q340', '2021-09-23 12:03:22', 'itm-a07vh-aer8', 1),
('134lr-oyfo8-3qk4','bk-q034-q4o',   'bl-34qhd-r7h8', '2021-09-23 12:05:37', 'itm-w978-23u4',  0.5),
-- Oct 2021 billing (for Q2 and Q3)
('bc-oct-001',      'bk-q034-q4o',   'bl-oct-001',    '2021-10-05 14:30:00', 'itm-a9e8-q8fu',  5),
('bc-oct-002',      'bk-q034-q4o',   'bl-oct-001',    '2021-10-05 14:30:00', 'itm-a07vh-aer8', 3),
('bc-oct-003',      'bk-r045-r5p',   'bl-oct-002',    '2021-10-12 10:00:00', 'itm-c56d-78ef',  4),
('bc-oct-004',      'bk-r045-r5p',   'bl-oct-002',    '2021-10-12 10:00:00', 'itm-b12c-34de',  6),
('bc-oct-005',      'bk-s056-s6q',   'bl-oct-003',    '2021-10-20 12:00:00', 'itm-f78g-90hi',  5),
('bc-oct-006',      'bk-s056-s6q',   'bl-oct-003',    '2021-10-20 12:00:00', 'itm-e34f-56gh',  2),
('bc-oct-007',      'bk-s056-s6q',   'bl-oct-004',    '2021-10-20 15:00:00', 'itm-d90e-12fg', 10),
-- Nov 2021 billing (for Q1 and Q2)
('bc-nov-001',      'bk-t067-t7r',   'bl-nov-001',    '2021-11-03 09:00:00', 'itm-c56d-78ef',  3),
('bc-nov-002',      'bk-t067-t7r',   'bl-nov-001',    '2021-11-03 09:00:00', 'itm-a07vh-aer8', 5),
('bc-nov-003',      'bk-u078-u8s',   'bl-nov-002',    '2021-11-10 17:00:00', 'itm-f78g-90hi',  2),
('bc-nov-004',      'bk-u078-u8s',   'bl-nov-002',    '2021-11-10 17:00:00', 'itm-b12c-34de',  4),
('bc-nov-005',      'bk-v089-v9t',   'bl-nov-003',    '2021-11-18 13:00:00', 'itm-e34f-56gh',  3),
('bc-nov-006',      'bk-v089-v9t',   'bl-nov-003',    '2021-11-18 13:00:00', 'itm-a9e8-q8fu',  7),
-- Dec 2021
('bc-dec-001',      'bk-w090-w0u',   'bl-dec-001',    '2021-12-01 11:00:00', 'itm-c56d-78ef',  2),
('bc-dec-002',      'bk-w090-w0u',   'bl-dec-001',    '2021-12-01 11:00:00', 'itm-f78g-90hi',  3),
('bc-dec-003',      'bk-x101-x1v',   'bl-dec-002',    '2021-12-15 10:00:00', 'itm-a07vh-aer8', 4),
('bc-dec-004',      'bk-y112-y2w',   'bl-dec-003',    '2021-12-28 19:00:00', 'itm-d90e-12fg',  6);
