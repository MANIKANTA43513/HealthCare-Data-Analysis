-- ============================================================
-- PlatinumRx Assignment | Hotel Management System
-- File: 02_Hotel_Queries.sql
-- Description: Part A – Queries Q1 through Q5
-- ============================================================

-- ------------------------------------------------------------
-- Q1. For every user in the system, get the user_id and
--     last booked room_no
-- ------------------------------------------------------------
-- Logic: Join users → bookings, rank bookings per user by
--        booking_date DESC, keep rank = 1.
-- ------------------------------------------------------------

SELECT
    u.user_id,
    u.name,
    b.room_no          AS last_booked_room_no,
    b.booking_date     AS last_booking_date
FROM users u
LEFT JOIN (
    SELECT
        user_id,
        room_no,
        booking_date,
        ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY booking_date DESC) AS rn
    FROM bookings
) b ON u.user_id = b.user_id AND b.rn = 1
ORDER BY u.user_id;


-- ------------------------------------------------------------
-- Q2. Get booking_id and total billing amount of every
--     booking created in November 2021
-- ------------------------------------------------------------
-- Logic: Filter bookings where booking_date falls in Nov 2021,
--        join booking_commercials + items, compute qty * rate.
-- ------------------------------------------------------------

SELECT
    b.booking_id,
    SUM(bc.item_quantity * i.item_rate)  AS total_billing_amount
FROM bookings b
JOIN booking_commercials bc ON b.booking_id = bc.booking_id
JOIN items i                ON bc.item_id   = i.item_id
WHERE YEAR(b.booking_date)  = 2021
  AND MONTH(b.booking_date) = 11
GROUP BY b.booking_id
ORDER BY total_billing_amount DESC;


-- ------------------------------------------------------------
-- Q3. Get bill_id and bill amount of all bills raised in
--     October 2021 having bill amount > 1000
-- ------------------------------------------------------------
-- Logic: Filter booking_commercials by Oct 2021 bill_date,
--        compute SUM(qty*rate) per bill_id, filter > 1000
--        using HAVING.
-- ------------------------------------------------------------

SELECT
    bc.bill_id,
    SUM(bc.item_quantity * i.item_rate) AS bill_amount
FROM booking_commercials bc
JOIN items i ON bc.item_id = i.item_id
WHERE YEAR(bc.bill_date)  = 2021
  AND MONTH(bc.bill_date) = 10
GROUP BY bc.bill_id
HAVING SUM(bc.item_quantity * i.item_rate) > 1000
ORDER BY bill_amount DESC;


-- ------------------------------------------------------------
-- Q4. Determine the most ordered and least ordered item
--     of each month of year 2021
-- ------------------------------------------------------------
-- Logic: Aggregate total quantity per (month, item), then use
--        RANK() to find rank 1 (most) and last rank (least)
--        within each month partition.
-- ------------------------------------------------------------

WITH monthly_item_totals AS (
    SELECT
        MONTH(bc.bill_date)           AS bill_month,
        MONTHNAME(bc.bill_date)       AS month_name,
        i.item_id,
        i.item_name,
        SUM(bc.item_quantity)         AS total_qty
    FROM booking_commercials bc
    JOIN items i ON bc.item_id = i.item_id
    WHERE YEAR(bc.bill_date) = 2021
    GROUP BY MONTH(bc.bill_date), MONTHNAME(bc.bill_date), i.item_id, i.item_name
),
ranked AS (
    SELECT
        bill_month,
        month_name,
        item_id,
        item_name,
        total_qty,
        RANK() OVER (PARTITION BY bill_month ORDER BY total_qty DESC) AS rank_desc,
        RANK() OVER (PARTITION BY bill_month ORDER BY total_qty ASC)  AS rank_asc
    FROM monthly_item_totals
)
SELECT
    bill_month,
    month_name,
    MAX(CASE WHEN rank_desc = 1 THEN item_name END) AS most_ordered_item,
    MAX(CASE WHEN rank_desc = 1 THEN total_qty  END) AS most_ordered_qty,
    MAX(CASE WHEN rank_asc  = 1 THEN item_name END) AS least_ordered_item,
    MAX(CASE WHEN rank_asc  = 1 THEN total_qty  END) AS least_ordered_qty
FROM ranked
GROUP BY bill_month, month_name
ORDER BY bill_month;


-- ------------------------------------------------------------
-- Q5. Find the customers with the second highest bill value
--     of each month of year 2021
-- ------------------------------------------------------------
-- Logic: Compute total bill per (month, user), rank users by
--        bill DESC within each month, filter rank = 2.
-- ------------------------------------------------------------

WITH user_monthly_bill AS (
    SELECT
        MONTH(bc.bill_date)                           AS bill_month,
        MONTHNAME(bc.bill_date)                       AS month_name,
        b.user_id,
        u.name                                        AS customer_name,
        SUM(bc.item_quantity * i.item_rate)           AS total_bill
    FROM booking_commercials bc
    JOIN bookings b ON bc.booking_id = b.booking_id
    JOIN users u    ON b.user_id     = u.user_id
    JOIN items i    ON bc.item_id    = i.item_id
    WHERE YEAR(bc.bill_date) = 2021
    GROUP BY MONTH(bc.bill_date), MONTHNAME(bc.bill_date), b.user_id, u.name
),
ranked AS (
    SELECT
        bill_month,
        month_name,
        user_id,
        customer_name,
        total_bill,
        DENSE_RANK() OVER (PARTITION BY bill_month ORDER BY total_bill DESC) AS rnk
    FROM user_monthly_bill
)
SELECT
    bill_month,
    month_name,
    user_id,
    customer_name,
    total_bill  AS second_highest_bill
FROM ranked
WHERE rnk = 2
ORDER BY bill_month;
