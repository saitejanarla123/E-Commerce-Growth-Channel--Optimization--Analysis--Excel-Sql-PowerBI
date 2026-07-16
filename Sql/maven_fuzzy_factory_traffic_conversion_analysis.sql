-- ============================================================================
-- MAVEN FUZZY FACTORY - TRAFFIC & CONVERSION ANALYSIS
-- ============================================================================
-- Author: Sai Teja Narla
-- Purpose: Recommended analysis covering website traffic, order volume,
--          conversion rate, marketing channel performance, and revenue trends
-- Tables used: website_sessions, orders, order_items, order_item_refunds, products
-- ============================================================================


-- ============================================================================
-- OPTIONAL SETUP: Add a proper created_at column to orders
-- ============================================================================
-- The raw Orders1.csv file stores date and time in two separate columns
-- (Order_Date, Time) instead of one combined timestamp like the other tables.
-- Run this once after loading the orders table so it matches the created_at
-- convention used by website_sessions, order_items, and order_item_refunds.
-- Skip this block if your orders table already has a created_at column.

-- ALTER TABLE orders ADD COLUMN created_at DATETIME;
-- UPDATE orders SET created_at = CONCAT(Order_Date, ' ', Time);


-- ============================================================================
-- 1. TREND IN WEBSITE SESSIONS AND ORDER VOLUME (MONTHLY)
-- ============================================================================
SELECT
    YEAR(ws.created_at)  AS yr,
    MONTH(ws.created_at) AS mo,
    COUNT(DISTINCT ws.website_session_id) AS sessions,
    COUNT(DISTINCT o.order_id)            AS orders
FROM website_sessions ws
    LEFT JOIN orders o
        ON ws.website_session_id = o.website_session_id
GROUP BY
    YEAR(ws.created_at),
    MONTH(ws.created_at)
ORDER BY yr, mo;


-- ============================================================================
-- 2. SESSION-TO-ORDER CONVERSION RATE (MONTHLY TREND)
-- ============================================================================
SELECT
    YEAR(ws.created_at)  AS yr,
    MONTH(ws.created_at) AS mo,
    COUNT(DISTINCT ws.website_session_id) AS sessions,
    COUNT(DISTINCT o.order_id)            AS orders,
    ROUND(
        COUNT(DISTINCT o.order_id) / COUNT(DISTINCT ws.website_session_id) * 100,
        2
    ) AS conv_rate_pct
FROM website_sessions ws
    LEFT JOIN orders o
        ON ws.website_session_id = o.website_session_id
GROUP BY
    YEAR(ws.created_at),
    MONTH(ws.created_at)
ORDER BY yr, mo;


-- ============================================================================
-- 3a. MARKETING CHANNEL PERFORMANCE (DETAILED: source / campaign / content)
-- ============================================================================
SELECT
    ws.utm_source,
    ws.utm_campaign,
    ws.utm_content,
    COUNT(DISTINCT ws.website_session_id) AS sessions,
    COUNT(DISTINCT o.order_id)            AS orders,
    ROUND(
        COUNT(DISTINCT o.order_id) / COUNT(DISTINCT ws.website_session_id) * 100,
        2
    ) AS conv_rate_pct,
    ROUND(SUM(o.price_usd), 2) AS total_revenue,
    ROUND(
        SUM(o.price_usd) / COUNT(DISTINCT ws.website_session_id),
        2
    ) AS revenue_per_session
FROM website_sessions ws
    LEFT JOIN orders o
        ON ws.website_session_id = o.website_session_id
GROUP BY
    ws.utm_source,
    ws.utm_campaign,
    ws.utm_content
ORDER BY sessions DESC;


-- ============================================================================
-- 3b. MARKETING CHANNEL PERFORMANCE (GROUPED: paid search / paid social / etc.)
-- ============================================================================
SELECT
    CASE
        WHEN ws.utm_source = 'gsearch' THEN 'Paid Search - Google'
        WHEN ws.utm_source = 'bsearch' THEN 'Paid Search - Bing'
        WHEN ws.utm_source = 'socialbook' THEN 'Paid Social'
        WHEN ws.utm_source IS NULL AND ws.http_referer IS NOT NULL THEN 'Organic/Referral'
        WHEN ws.utm_source IS NULL AND ws.http_referer IS NULL THEN 'Direct Traffic'
        ELSE 'Other'
    END AS channel_group,
    COUNT(DISTINCT ws.website_session_id) AS sessions,
    COUNT(DISTINCT o.order_id)            AS orders,
    ROUND(
        COUNT(DISTINCT o.order_id) / COUNT(DISTINCT ws.website_session_id) * 100,
        2
    ) AS conv_rate_pct,
    ROUND(SUM(o.price_usd), 2) AS total_revenue
FROM website_sessions ws
    LEFT JOIN orders o
        ON ws.website_session_id = o.website_session_id
GROUP BY channel_group
ORDER BY sessions DESC;


-- ============================================================================
-- 4a. REVENUE PER ORDER AND REVENUE PER SESSION (MONTHLY TREND, GROSS)
-- ============================================================================
SELECT
    YEAR(ws.created_at)  AS yr,
    MONTH(ws.created_at) AS mo,
    COUNT(DISTINCT ws.website_session_id) AS sessions,
    COUNT(DISTINCT o.order_id)            AS orders,
    ROUND(SUM(o.price_usd), 2) AS total_revenue,
    ROUND(
        SUM(o.price_usd) / COUNT(DISTINCT o.order_id),
        2
    ) AS revenue_per_order,
    ROUND(
        SUM(o.price_usd) / COUNT(DISTINCT ws.website_session_id),
        2
    ) AS revenue_per_session
FROM website_sessions ws
    LEFT JOIN orders o
        ON ws.website_session_id = o.website_session_id
GROUP BY
    YEAR(ws.created_at),
    MONTH(ws.created_at)
ORDER BY yr, mo;


-- ============================================================================
-- 4b. REVENUE PER ORDER AND REVENUE PER SESSION (MONTHLY TREND, NET OF REFUNDS)
-- ============================================================================
SELECT
    YEAR(ws.created_at)  AS yr,
    MONTH(ws.created_at) AS mo,
    COUNT(DISTINCT ws.website_session_id) AS sessions,
    COUNT(DISTINCT o.order_id)            AS orders,
    ROUND(SUM(o.price_usd), 2)                                   AS gross_revenue,
    ROUND(COALESCE(r.total_refunds, 0), 2)                       AS total_refunds,
    ROUND(SUM(o.price_usd) - COALESCE(r.total_refunds, 0), 2)    AS net_revenue,
    ROUND(
        (SUM(o.price_usd) - COALESCE(r.total_refunds, 0)) / COUNT(DISTINCT o.order_id),
        2
    ) AS net_revenue_per_order,
    ROUND(
        (SUM(o.price_usd) - COALESCE(r.total_refunds, 0)) / COUNT(DISTINCT ws.website_session_id),
        2
    ) AS net_revenue_per_session
FROM website_sessions ws
    LEFT JOIN orders o
        ON ws.website_session_id = o.website_session_id
    LEFT JOIN (
        SELECT
            YEAR(created_at)  AS yr,
            MONTH(created_at) AS mo,
            SUM(refund_amount_usd) AS total_refunds
        FROM order_item_refunds
        GROUP BY YEAR(created_at), MONTH(created_at)
    ) r
        ON YEAR(ws.created_at) = r.yr
        AND MONTH(ws.created_at) = r.mo
GROUP BY
    YEAR(ws.created_at),
    MONTH(ws.created_at)
ORDER BY yr, mo;
