-- ============================================================
-- PlatinumRx Assignment | Clinic Management System
-- File: 03_Clinic_Schema_Setup.sql
-- Description: Table creation + sample data insertion
-- ============================================================

DROP TABLE IF EXISTS expenses;
DROP TABLE IF EXISTS clinic_sales;
DROP TABLE IF EXISTS customer;
DROP TABLE IF EXISTS clinics;

-- ------------------------------------------------------------
-- Table: clinics
-- ------------------------------------------------------------
CREATE TABLE clinics (
    cid          VARCHAR(50) PRIMARY KEY,
    clinic_name  VARCHAR(100) NOT NULL,
    city         VARCHAR(100),
    state        VARCHAR(100),
    country      VARCHAR(100)
);

-- ------------------------------------------------------------
-- Table: customer
-- ------------------------------------------------------------
CREATE TABLE customer (
    uid    VARCHAR(50) PRIMARY KEY,
    name   VARCHAR(100) NOT NULL,
    mobile VARCHAR(20)
);

-- ------------------------------------------------------------
-- Table: clinic_sales
-- ------------------------------------------------------------
CREATE TABLE clinic_sales (
    oid           VARCHAR(50) PRIMARY KEY,
    uid           VARCHAR(50),
    cid           VARCHAR(50),
    amount        DECIMAL(12,2),
    datetime      DATETIME,
    sales_channel VARCHAR(50),
    FOREIGN KEY (uid) REFERENCES customer(uid),
    FOREIGN KEY (cid) REFERENCES clinics(cid)
);

-- ------------------------------------------------------------
-- Table: expenses
-- ------------------------------------------------------------
CREATE TABLE expenses (
    eid         VARCHAR(50) PRIMARY KEY,
    cid         VARCHAR(50),
    description TEXT,
    amount      DECIMAL(12,2),
    datetime    DATETIME,
    FOREIGN KEY (cid) REFERENCES clinics(cid)
);

-- ============================================================
-- SAMPLE DATA
-- ============================================================

-- clinics
INSERT INTO clinics VALUES
('cnc-0100001', 'XYZ Clinic',    'lorem',    'ipsum',    'dolor'),
('cnc-0100002', 'ABC Health',    'Mumbai',   'Maharashtra','India'),
('cnc-0100003', 'MediCare Plus', 'Delhi',    'Delhi',    'India'),
('cnc-0100004', 'Sunshine Clinic','Chennai', 'Tamil Nadu','India'),
('cnc-0100005', 'CityMed',       'Hyderabad','Telangana', 'India'),
('cnc-0100006', 'Green Health',  'Mumbai',   'Maharashtra','India'),
('cnc-0100007', 'LifeCare',      'Delhi',    'Delhi',    'India');

-- customers
INSERT INTO customer VALUES
('bk-09f3e-95hj', 'Jon Doe',     '97XXXXXXXX'),
('cust-002',      'Priya Sharma','98XXXXXXXX'),
('cust-003',      'Rahul Verma', '99XXXXXXXX'),
('cust-004',      'Anjali Singh','91XXXXXXXX'),
('cust-005',      'Deepak Nair', '92XXXXXXXX'),
('cust-006',      'Sneha Patel', '93XXXXXXXX'),
('cust-007',      'Amit Kumar',  '94XXXXXXXX'),
('cust-008',      'Kavya Reddy', '95XXXXXXXX'),
('cust-009',      'Vikram Joshi','96XXXXXXXX'),
('cust-010',      'Meera Iyer',  '90XXXXXXXX'),
('cust-011',      'Sanjay Das',  '88XXXXXXXX'),
('cust-012',      'Pooja Mehta', '87XXXXXXXX');

-- clinic_sales (mix of 2023 channels and clinics)
INSERT INTO clinic_sales VALUES
('ord-00100-00100','bk-09f3e-95hj','cnc-0100001', 24999,'2023-01-15 12:03:22','sodat'),
('ord-00100-00101','cust-002',     'cnc-0100002', 15000,'2023-01-20 10:00:00','online'),
('ord-00100-00102','cust-003',     'cnc-0100003', 32000,'2023-01-25 11:00:00','walk-in'),
('ord-00100-00103','cust-004',     'cnc-0100004', 18500,'2023-02-05 09:30:00','sodat'),
('ord-00100-00104','cust-005',     'cnc-0100005', 45000,'2023-02-10 14:00:00','online'),
('ord-00100-00105','cust-006',     'cnc-0100001', 22000,'2023-02-15 16:00:00','walk-in'),
('ord-00100-00106','cust-007',     'cnc-0100002', 60000,'2023-03-01 09:00:00','sodat'),
('ord-00100-00107','cust-008',     'cnc-0100003', 11000,'2023-03-10 10:30:00','online'),
('ord-00100-00108','cust-009',     'cnc-0100004', 75000,'2023-03-20 15:00:00','walk-in'),
('ord-00100-00109','cust-010',     'cnc-0100005', 28000,'2023-04-05 11:00:00','sodat'),
('ord-00100-00110','cust-011',     'cnc-0100006', 13000,'2023-04-15 08:00:00','online'),
('ord-00100-00111','cust-012',     'cnc-0100007', 90000,'2023-04-20 17:00:00','walk-in'),
('ord-00100-00112','bk-09f3e-95hj','cnc-0100006', 37000,'2023-05-02 12:00:00','sodat'),
('ord-00100-00113','cust-002',     'cnc-0100007', 14500,'2023-05-18 13:00:00','online'),
('ord-00100-00114','cust-003',     'cnc-0100001', 58000,'2023-06-01 09:00:00','walk-in'),
('ord-00100-00115','cust-004',     'cnc-0100002', 21000,'2023-06-12 10:00:00','sodat'),
('ord-00100-00116','cust-005',     'cnc-0100003', 33000,'2023-07-07 11:00:00','online'),
('ord-00100-00117','cust-006',     'cnc-0100004', 47000,'2023-07-20 14:00:00','walk-in'),
('ord-00100-00118','cust-007',     'cnc-0100005', 19000,'2023-08-08 09:30:00','sodat'),
('ord-00100-00119','cust-008',     'cnc-0100006', 82000,'2023-08-22 16:00:00','online'),
('ord-00100-00120','cust-009',     'cnc-0100007', 26000,'2023-09-05 10:00:00','walk-in'),
('ord-00100-00121','cust-010',     'cnc-0100001', 41000,'2023-09-18 15:00:00','sodat'),
('ord-00100-00122','cust-011',     'cnc-0100002', 16000,'2023-10-10 08:00:00','online'),
('ord-00100-00123','cust-012',     'cnc-0100003', 70000,'2023-10-25 12:00:00','walk-in'),
('ord-00100-00124','bk-09f3e-95hj','cnc-0100004', 53000,'2023-11-05 09:00:00','sodat'),
('ord-00100-00125','cust-002',     'cnc-0100005', 29000,'2023-11-15 11:00:00','online'),
('ord-00100-00126','cust-003',     'cnc-0100006', 38000,'2023-12-01 14:00:00','walk-in'),
('ord-00100-00127','cust-004',     'cnc-0100007', 67000,'2023-12-20 10:00:00','sodat');

-- expenses
INSERT INTO expenses VALUES
('exp-0100-00100','cnc-0100001','first-aid supplies',    557,'2023-01-15 07:36:48'),
('exp-0100-00101','cnc-0100002','staff salaries',      50000,'2023-01-31 00:00:00'),
('exp-0100-00102','cnc-0100003','rent',                30000,'2023-01-31 00:00:00'),
('exp-0100-00103','cnc-0100004','medicines',            8000,'2023-02-05 00:00:00'),
('exp-0100-00104','cnc-0100005','utilities',            5000,'2023-02-10 00:00:00'),
('exp-0100-00105','cnc-0100001','equipment maintenance',12000,'2023-02-28 00:00:00'),
('exp-0100-00106','cnc-0100002','staff salaries',      50000,'2023-02-28 00:00:00'),
('exp-0100-00107','cnc-0100003','rent',                30000,'2023-02-28 00:00:00'),
('exp-0100-00108','cnc-0100006','cleaning supplies',    2000,'2023-03-10 00:00:00'),
('exp-0100-00109','cnc-0100007','insurance',           15000,'2023-03-15 00:00:00'),
('exp-0100-00110','cnc-0100004','medicines',           10000,'2023-03-20 00:00:00'),
('exp-0100-00111','cnc-0100005','utilities',            5500,'2023-04-10 00:00:00'),
('exp-0100-00112','cnc-0100001','staff salaries',      45000,'2023-04-30 00:00:00'),
('exp-0100-00113','cnc-0100006','rent',                20000,'2023-05-02 00:00:00'),
('exp-0100-00114','cnc-0100007','equipment purchase',  25000,'2023-05-18 00:00:00'),
('exp-0100-00115','cnc-0100002','medicines',            7000,'2023-06-01 00:00:00'),
('exp-0100-00116','cnc-0100003','staff salaries',      40000,'2023-06-30 00:00:00'),
('exp-0100-00117','cnc-0100004','utilities',            4800,'2023-07-07 00:00:00'),
('exp-0100-00118','cnc-0100005','rent',                22000,'2023-07-31 00:00:00'),
('exp-0100-00119','cnc-0100001','insurance',           18000,'2023-08-08 00:00:00'),
('exp-0100-00120','cnc-0100006','staff salaries',      55000,'2023-08-31 00:00:00'),
('exp-0100-00121','cnc-0100007','medicines',            9000,'2023-09-05 00:00:00'),
('exp-0100-00122','cnc-0100002','rent',                30000,'2023-09-30 00:00:00'),
('exp-0100-00123','cnc-0100003','utilities',            6000,'2023-10-10 00:00:00'),
('exp-0100-00124','cnc-0100004','staff salaries',      48000,'2023-10-31 00:00:00'),
('exp-0100-00125','cnc-0100005','cleaning supplies',    3000,'2023-11-05 00:00:00'),
('exp-0100-00126','cnc-0100006','rent',                20000,'2023-11-30 00:00:00'),
('exp-0100-00127','cnc-0100007','insurance',           15000,'2023-12-01 00:00:00');
