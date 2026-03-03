Data-Driven Sales Performance Dashboard

Project Overview

This project presents a comprehensive Sales & Profitability Analytics Dashboard built using:
-MySQL (Data Warehouse)
-Python (Data Cleaning & Advanced Visualizations)
-Power BI (Interactive Dashboard)
The goal is to transform raw transactional sales data into meaningful business insights using data warehousing and business intelligence techniques.

System Architecture

Raw Sales Data
        ↓
MySQL Data Warehouse (Star Schema)
        ↓
Python (Data Cleaning & Advanced Analytics)
        ↓
Power BI Interactive Dashboard

Database Design (Star Schema)
-Fact Table
-fact_sales
-Dimension Tables
-dim_customer
-dim_product
-dim_date
-dim_employee
-dim_channel
Primary and foreign key relationships ensure data integrity:

-Data Cleaning & Processing (Python)
-Key preprocessing steps:
-Removed duplicate records
-Handled missing values
-Created calculated metrics (Profit, Profit Margin %)
-Aggregated sales data

Generated advanced analytical visualizations

Power BI Dashboard Pages
-Page 1 – Executive Overview

KPI Cards (Revenue, Profit, Margin, Quantity)
-Annual Sales Trend
-Category Sales Distribution
-Channel Contribution

Page 2 – Category & Market Analysis
-Segment Performance
-Product Sales Analysis
-City-wise Sales Distribution

Page 3 – Sales Performance Insights
-Employee Performance
-Department Analysis
-Regional Sales

Page 4 – Profit & Regional Analysis
-Profit by Product
-Profit by City & Channel

Page 5 – Advanced Analytics
-Pair Plot
-Violin Plot
-3D Scatter Plot
-Network Graph
-Advanced Correlation Heatmap

Advanced Analytics Visualizations (Python)
-Visualization	Purpose
-Pair Plot	Correlation analysis between numerical variables
-Violin Plot	Distribution comparison across categories
-3D Scatter Plot	Relationship between Sales, Profit & Quantity
-Network Graph	Customer–Product relationship mapping
-Heatmap	Advanced correlation analysis

Key Insights
-2023 showed higher sales growth compared to previous years.
-Corporate segment contributes the highest revenue.
-Discount levels significantly impact profit margins.
-Regional sales performance varies across locations.
-Certain product categories yield higher profitability.

Technologies Used
-MySQL
-Python (Pandas, Seaborn, Matplotlib, NetworkX)
-Power BI Desktop

Project Structure
-SQL_Scripts
-Python_Analysis
-PowerBI_Dashboard
-README.md

Future Enhancements
-Machine Learning-based Sales Forecasting
-Real-time data integration
-Cloud deployment
-Role-based access dashboard
