-- ============================================================
-- PlatinumRx Assignment | Clinic Management System
-- File: 04_Clinic_Queries.sql
-- Description: Part B – Queries Q1 through Q5
-- ============================================================

-- Set the target year once (change as needed)
SET @target_year  = 2023;
SET @target_month = 4;   -- April; adjust for Q4 and Q5

-- ------------------------------------------------------------
-- Q1. Find the revenue we got from each sales channel
--     in a given year
-- ------------------------------------------------------------

SELECT
    sales_channel,
    SUM(amount)              AS total_revenue,
    COUNT(oid)               AS total_orders
FROM clinic_sales
WHERE YEAR(datetime) = @target_year
GROUP BY sales_channel
ORDER BY total_revenue DESC;


-- ------------------------------------------------------------
-- Q2. Find the top 10 most valuable customers for a given year
-- ------------------------------------------------------------

SELECT
    cs.uid,
    c.name                   AS customer_name,
    SUM(cs.amount)           AS total_spend,
    COUNT(cs.oid)            AS total_orders
FROM clinic_sales cs
JOIN customer c ON cs.uid = c.uid
WHERE YEAR(cs.datetime) = @target_year
GROUP BY cs.uid, c.name
ORDER BY total_spend DESC
LIMIT 10;


-- ------------------------------------------------------------
-- Q3. Find month-wise revenue, expense, profit and status
--     (profitable / not-profitable) for a given year
-- ------------------------------------------------------------

WITH monthly_revenue AS (
    SELECT
        MONTH(datetime)     AS month_num,
        MONTHNAME(datetime) AS month_name,
        SUM(amount)         AS total_revenue
    FROM clinic_sales
    WHERE YEAR(datetime) = @target_year
    GROUP BY MONTH(datetime), MONTHNAME(datetime)
),
monthly_expense AS (
    SELECT
        MONTH(datetime)     AS month_num,
        SUM(amount)         AS total_expense
    FROM expenses
    WHERE YEAR(datetime) = @target_year
    GROUP BY MONTH(datetime)
)
SELECT
    r.month_num,
    r.month_name,
    COALESCE(r.total_revenue, 0)                         AS revenue,
    COALESCE(e.total_expense, 0)                         AS expense,
    COALESCE(r.total_revenue, 0) - COALESCE(e.total_expense, 0) AS profit,
    CASE
        WHEN COALESCE(r.total_revenue, 0) - COALESCE(e.total_expense, 0) >= 0
        THEN 'Profitable'
        ELSE 'Not-Profitable'
    END                                                  AS status
FROM monthly_revenue r
LEFT JOIN monthly_expense e ON r.month_num = e.month_num
ORDER BY r.month_num;


-- ------------------------------------------------------------
-- Q4. For each city find the most profitable clinic
--     for a given month
-- ------------------------------------------------------------

WITH clinic_profit AS (
    SELECT
        cl.cid,
        cl.clinic_name,
        cl.city,
        COALESCE(SUM(cs.amount), 0) - COALESCE(SUM(ex.amount), 0) AS profit
    FROM clinics cl
    LEFT JOIN clinic_sales cs
           ON cl.cid = cs.cid
          AND YEAR(cs.datetime)  = @target_year
          AND MONTH(cs.datetime) = @target_month
    LEFT JOIN expenses ex
           ON cl.cid = ex.cid
          AND YEAR(ex.datetime)  = @target_year
          AND MONTH(ex.datetime) = @target_month
    GROUP BY cl.cid, cl.clinic_name, cl.city
),
ranked AS (
    SELECT
        city,
        cid,
        clinic_name,
        profit,
        RANK() OVER (PARTITION BY city ORDER BY profit DESC) AS rnk
    FROM clinic_profit
)
SELECT
    city,
    cid,
    clinic_name,
    profit  AS most_profitable_clinic_profit
FROM ranked
WHERE rnk = 1
ORDER BY city;


-- ------------------------------------------------------------
-- Q5. For each state find the second least profitable clinic
--     for a given month
-- ------------------------------------------------------------

WITH clinic_profit AS (
    SELECT
        cl.cid,
        cl.clinic_name,
        cl.state,
        COALESCE(SUM(cs.amount), 0) - COALESCE(SUM(ex.amount), 0) AS profit
    FROM clinics cl
    LEFT JOIN clinic_sales cs
           ON cl.cid = cs.cid
          AND YEAR(cs.datetime)  = @target_year
          AND MONTH(cs.datetime) = @target_month
    LEFT JOIN expenses ex
           ON cl.cid = ex.cid
          AND YEAR(ex.datetime)  = @target_year
          AND MONTH(ex.datetime) = @target_month
    GROUP BY cl.cid, cl.clinic_name, cl.state
),
ranked AS (
    SELECT
        state,
        cid,
        clinic_name,
        profit,
        DENSE_RANK() OVER (PARTITION BY state ORDER BY profit ASC) AS rnk
    FROM clinic_profit
)
SELECT
    state,
    cid,
    clinic_name,
    profit  AS second_least_profitable_profit
FROM ranked
WHERE rnk = 2
ORDER BY state;
