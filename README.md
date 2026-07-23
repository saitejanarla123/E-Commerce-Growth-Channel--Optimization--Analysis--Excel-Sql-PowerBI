# E-Commerce Growth & Channel Optimization Analysis – Maven Fuzzy Factory

_Analyzing website traffic, marketing channel performance, and sales growth for an e-commerce startup using Excel, MySQL, and Power BI._

---

## 📌 Table of Contents
- <a href="#Project overview">Overview</a>
- <a href="#business-problem">Business Problem</a>
- <a href="#dataset">Dataset</a>
- <a href="#tools--technologies">Tools & Technologies</a> 
- <a href="#project-structure">Project Structure</a>
- <a href="#data-cleaning--preparation">Data Cleaning & Preparation</a>
- <a href="#exploratory-data-analysis-eda">Exploratory Data Analysis (EDA)</a>
- <a href="#research-questions--key-findings">Research Questions & Key Findings</a>
- <a href="#dashboard">Dashboard</a>
- <a href="#how-to-run-this-project">How to Run This Project</a>
- <a href="#final-recommendations">Final Recommendations</a>
- <a href="#author--contact">Author & Contact</a>

---
<h2><a class="anchor" id="overview"></a>Project Overview</h2>

Maven Fuzzy Factory is a e-commerce startup selling teddy bears, launched to simulate a real analytics engagement. This project analyzes three years of website session, order, and marketing data to uncover growth trends, evaluate channel performance, and support strategic decisions on where to invest marketing spend. A complete pipeline was built using Excel for data cleaning, MySQL for analysis, and Power BI for a two-page interactive dashboard covering Marketing/Traffic and Sales/Revenue.

---
<h2><a class="anchor" id="business-problem"></a>Business Problem</h2>

The CEO needed a data-driven growth story to present to the board and secure the company's next funding round. This project aims to:
- Track the trend in website sessions and order volume over time
- Measure the session-to-order conversion rate and how it has changed
- Identify which marketing channels drive the most sessions and revenue
- Evaluate how revenue per order and revenue per session have evolved
- Understand the impact of new product launches on overall sales

---
<h2><a class="anchor" id="dataset"></a>Dataset Description</h2>

📊 Dataset Description

The analysis is driven by six main relational tables:

website_sessions: Website traffic sourcevisitor, and device information.
website_session_id, created_at, user_id, is_repeat_session, utm_source, utm_campaign, utm_content, device_type, http_referer

website_pageviews: User navigation and page visit details within each session.
website_pageview_id, created_at, website_session_id, pageview_url

orders: Customer purchase transactions, order value, and product details.
order_id, created_at, website_session_id, user_id, primary_product_id, items_purchased, price_usd, cogs_usd

order_items: Individual products purchased within each order along with pricing and cost.
order_item_id, created_at, order_id, product_id, is_primary_item, price_usd, cogs_usd

order_item_refunds: Refund transactions for returned order items.
order_item_refund_id, created_at, order_item_id, order_id, refund_amount_usd

products: Product catalog containing product identifiers and names.
product_id, created_at, product_name
- Source: Maven Analytics
- License: Public Domain

---
<h2><a class="anchor" id="tools--technologies"></a>Tools & Technologies</h2>

- Excel (data cleaning and preprocessing)
- MySQL (schema design, joins, CTEs, aggregation queries, business analysis)
- Power BI (DAX measures, data modeling, interactive dashboard)
- GitHub

---
<h2><a class="anchor" id="project-structure"></a>Project Structure</h2>

```
E-Commerce-Growth-Channel-Optimization-Analysis-Maven-Fuzzy-Factory/

├── data/                        # Raw and cleaned data exports
│  ├── raw/
│  └── cleaned/                 # Cleaned Data 
│
├── sql/                         # MySQL analysis queries
│  └── business_analysis_queries.sql
│
├── dashboard/                   # Power BI dashboard file
│  └──  E-Commerce Growth Channel Optimization Analysis.pbix
│  └──  Marketing & Traffic Page-1
│  └──  Sales & Revenue Page-2
│  └──  Business Recommendations Final Page
│ 
└── docs/                        # Problem statement + goals
│  └── +-- business_context.md
│
└── .gitignore
└── LICENSE
└── README.md
└── requirements.txt
```
    
---
<h2><a class="anchor" id="data-cleaning--preparation"></a>Data Cleaning & Preparation</h2>

- Cleaned raw session, order, and pageview data in Excel before loading into MySQL
- Handled datetime formatting issues to ensure charts rendered correctly in Power BI
- Built a MySQL schema and load script to structure the six core tables
- Defined relationships between sessions, orders, and products in the Power BI data model
- Resolved ambiguous relationship paths and circular filter errors in the model

---
<h2><a class="anchor" id="exploratory-data-analysis-eda"></a>Exploratory Data Analysis (EDA)</h2>

**Traffic & Conversion:**
- Website sessions and order volume both trended upward over the analysis period
- Session-to-order conversion rate improved significantly across the timeline

**Channel Mix:**
- Paid and free (organic/direct) traffic sources analyzed separately to compare efficiency
- Brand vs. non-brand campaign performance compared within paid channels

**Revenue Trends:**
- Revenue per order and revenue per session tracked over time
- Repeat session revenue analyzed to understand returning customer value

---
<h2><a class="anchor" id="research-questions--key-findings"></a>Research Questions & Key Findings</h2>

1. **Session & Order Growth**: Both website sessions and order volume show consistent upward growth over the three-year period
2. **Conversion Rate**: Session-to-order conversion rate rose sharply, reflecting the impact of ongoing website and funnel optimization
3. **Top Marketing Channels**: A small set of paid and organic channels account for the majority of sessions and revenue
4. **Revenue per Order/Session**: Both metrics increased over time, partly driven by new product launches and pricing changes
5. **Product Launch Impact**: New product introductions correspond with measurable lifts in order volume and average order value

---
<h2><a class="anchor" id="dashboard"></a>Dashboard</h2>

- Power BI dashboard:
  - **Page 1 – Marketing/Traffic**: sessions by channel, conversion funnel, campaign performance
  ![alt text](<Dashboard/Marketing & Traffic Page-1.png>)
  - **Page 2 – Sales/Revenue**: revenue trends, revenue per order/session, product performance
  ![alt text](<Dashboard/Sales & Revenue Page-2.png>)
  -  **Page 3 – Business Recommendations**:![alt text](<Dashboard/Business Recommendations Final Page.png>)


---
<h2><a class="anchor" id="how-to-run-this-project"></a>How to Run This Project</h2>

1. Clone the repository:
```bash
git clone https://github.com/saitejanarla123/E-Commerce-Growth-Channel-Optimization-Analysis-Maven-Fuzzy-Factory.git
```
2. Set up the MySQL database using the schema script:
```bash
mysql -u your_username -p < sql/schema_and_load.sql
```
3. Review/apply the cleaning steps in the Excel workbook:
   - `excel/data_cleaning.xlsx`
4. Run the business analysis queries in MySQL:
```bash
mysql -u your_username -p your_database < sql/business_analysis_queries.sql
```
5. Open the Power BI dashboard:
   - `dashboard/maven_fuzzy_factory_dashboard.pbix`

---
<h2><a class="anchor" id="final-recommendations"></a>Final Recommendations</h2>

- Double down on the top-performing marketing channels driving the bulk of conversions
- Continue funnel optimization work given its measurable lift in conversion rate
- Time future product launches around periods of strong traffic to maximize impact
- Monitor revenue per session as a leading indicator of overall channel health
- Reduce reliance on any single channel to protect against traffic volatility

---
<h2><a class="anchor" id="author--contact"></a>Author & Contact</h2>

**Narla Sai Teja**
Data Analyst

Email: saitejanarla123@gmail.com
🔗 Linkedin:https://www.linkedin.com/in/saiteja-narla
🔗 [GitHub](https://github.com/saitejanarla123)
