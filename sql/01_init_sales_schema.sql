-- E-commerce Sales Dataset
-- PostgreSQL table structure reference.
--
-- The sales_data table was imported from the source CSV
-- using pgAdmin's Import/Export functionality.
--
-- This script documents the imported table structure.
-- It does not drop, recreate or overwrite existing data.

CREATE TABLE IF NOT EXISTS sales_data (
    invoice VARCHAR(100),
    stockcode VARCHAR(100),
    description VARCHAR(255),
    quantity NUMERIC,
    invoicedate VARCHAR(100),
    price NUMERIC(12, 4),
    customer_id NUMERIC,
    country VARCHAR(100),
    customer_age NUMERIC,
    gender VARCHAR(50),
    signup_date VARCHAR(100),
    last_login_date VARCHAR(100),
    customer_segment VARCHAR(100),
    marketing_channel VARCHAR(100),
    category VARCHAR(100),
    subcategory VARCHAR(100),
    cost NUMERIC(12, 4),
    discount_applied NUMERIC,
    payment_method VARCHAR(100),
    promo_applied NUMERIC,
    delivery_time_days NUMERIC,
    revenue NUMERIC(12, 4),
    profit NUMERIC(12, 4),
    churn_flag NUMERIC
);