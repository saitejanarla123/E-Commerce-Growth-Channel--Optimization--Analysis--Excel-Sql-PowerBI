# Business Context

## Problem Statement

Maven Fuzzy Factory is a growing e-commerce business selling plush toy products online. Over its first several years of operation, the company scaled its traffic across multiple marketing channels (paid search, paid social, direct, and organic) and expanded its product catalog beyond a single flagship item.

Leadership needs a clear, data-driven view of how the business has actually grown — not just in raw traffic, but in the quality of that traffic and its conversion into revenue. Without this, marketing spend and product decisions are being made on assumption rather than evidence. Specifically, the business needs to understand:

- Whether growth in website sessions is translating into proportional growth in orders, or whether conversion efficiency is changing over time
- Which marketing channels and campaigns are actually driving profitable traffic, versus which are underperforming despite volume
- Whether revenue growth is coming from more orders, larger orders, or both
- How exposed the business is to concentration risk in a single product

This analysis uses website session, order, order item, refund, and product data spanning the company's early growth period to answer these questions with SQL-based analysis and an interactive Power BI dashboard.

## Goals

1. **Quantify traffic and order growth** — Establish the trend in monthly website sessions and order volume to size the overall growth trajectory of the business.

2. **Measure conversion efficiency** — Calculate the session-to-order conversion rate over time to determine whether the business is getting better or worse at turning visitors into customers, independent of traffic volume.

3. **Evaluate marketing channel performance** — Break down sessions, conversion rate, and revenue by `utm_source`, `utm_campaign`, and `utm_content` to identify which channels deserve more investment and which are underperforming.

4. **Track revenue efficiency** — Analyze how revenue per order and revenue per session have evolved, to distinguish growth driven by order volume from growth driven by order value or channel mix.

5. **Surface risk and data quality issues** — Identify concentration risk (e.g., reliance on a single product for the majority of revenue) and flag any data inconsistencies before findings are shared externally.

6. **Deliver a recruiter-ready portfolio artifact** — Package the analysis as a clean, well-documented GitHub repository (SQL scripts, README, Power BI dashboard) that demonstrates end-to-end analytics capability: data cleaning, business-question-driven SQL analysis, and executive-level dashboard storytelling.

## Scope

- **Data sources:** `website_sessions`, `website_pageviews`, `orders`, `order_items`, `order_item_refunds`, `products` (public-domain Maven Analytics e-commerce dataset, ~1.7M records across 6 relational tables)
- **Tools:** MySQL (business analysis queries), Power BI (dashboard and DAX measures), Excel (data cleaning and preparation)
- **Out of scope:** Predictive modeling, customer lifetime value forecasting, and external market benchmarking are not covered in this phase of analysis.
