# Sales-Forecasting-Revenue-Planning
A consumer goods company wants to understand what drives daily revenue across 3 regions: West, Central, and East. How do orders, average order value, weekends, holidays, promotions, and marketing spend affect revenue - and how should we forecast future revenue and allocate marketing budget?
README: Regional Revenue Forecasting and Marketing ROI Analysis
Project Title: Forecasting Revenue and Optimizing Marketing Spend Across Regions

Business Case:
This R code builds a full analytics workflow using daily regional revenue data, marketing spend, order volume, average order value, weekend/holiday flags, promotion flags, regression modeling, time-series forecasting, ARIMAX forecasting with external drivers, and region-level marketing ROI allocation. The dataset is created with daily observations for revenue, orders, average order value, marketing spend, weekend flags, holiday flags, and promotion flags across regions.

Problem
The project answers five core business questions:
Which regions generate the most revenue? Are weekends stronger than weekdays? Are holidays and promotions associated with higher revenue? Is revenue more driven by orders or average order value? How should the company forecast revenue and allocate marketing budget?

Dataset
Dataset Structure
Each row represents a:
date × region observation
The dataset includes: 3 regions: West, Central, East, Daily data from January 1 to January 21, 2024, Revenue, orders, average order value, marketing spend, weekend flags, holiday flags, and promotion flags.

Method
Revenue and Orders Trend Analysis: The first step visualizes revenue and orders over time by region, 
Weekend Analysis: Do weekends produce higher revenue and order volume than weekdays? The code calculates average revenue, orders, and marketing spend by region and weekend status.
Holiday Analysis: Are holiday days meaningfully stronger than normal days?
Revenue Formula Decomposition: it checks whether revenue is more strongly correlated with orders or average order value. If revenue is mostly driven by orders, the company should focus on traffic, conversion, marketing, and promotions. If revenue is mostly driven by average order value, the company should focus on upselling, bundling, pricing, and premium mix.

Key Findings
Finding 1: West is the strongest revenue region. West generated the highest total and average revenue.
Finding 2: Central is the weakest region. Central had the lowest total revenue and lowest average daily revenue.
This does not automatically mean Central is a bad market. It may mean: Lower baseline demand, Lower order volume, Lower marketing investment, Lower average order value, Weaker promo performance, or Different customer behavior.
Finding 3: Revenue is mostly an order-volume story. The strongest relationship is between revenue and orders. Revenue is primarily driven by how many orders the business gets, not by small changes in average order value. This makes sense because the average order value stays within a fairly narrow band, while order volume changes more noticeably.
Finding 4: Weekends are much stronger than weekdays. Weekend demand is stronger, but weekend marketing spend is also higher, so the business needs to separate natural weekend demand from marketing-driven lift.
Finding 5: Holidays and promotions appear higher-performing, but they overlap. In this dataset, holiday days and promotion days appear to overlap. The holiday and promo flags have the same pattern. Holiday lift and promotion lift may be mixed together. We should be careful before saying the promotion alone caused the revenue increase.
Insights
Insight 1: Orders matter more than average order value A beginner analyst might assume average order value is the big revenue driver.
But in this dataset, revenue is much more strongly tied to orders than to AOV.
Surprising takeaway: The fastest way to grow revenue here is likely to drive more orders, not just increase basket size.

Insight 2: Promotions and holidays are hard to separate Holiday days and promo-active days appear to occur together in the dataset. That means promotion performance may look strong partly because promotions are scheduled on naturally strong shopping days.
Surprising takeaway: The promotion may be getting credit for demand that the holiday would have generated anyway.

Insight 3: Marketing looks powerful, but some of that power may be timing Marketing spend is higher on stronger demand days. For example, weekend marketing spend is higher than weekday spend, and weekend revenue is also higher. Surprising takeaway: Marketing may be working, but part of the apparent effect may come from placing spend on days that were already likely to perform well.

Insight 4: West is the largest market, but not automatically the only investment priority West has the highest revenue, but that does not always mean West should get all incremental marketing dollars. A smaller region may have a better marginal return on marketing.
Surprising takeaway: The biggest region is not always the best place for the next dollar of spend. That is why the region ROI model is useful.

Metric Story
Main Metric: Revenue
What metric changed? Revenue increased on weekends, holidays, and promotion days.
The highest daily revenue occurred on a holiday/promotion day, while the lowest value is partly affected by the date issue in the dataset.

What should we do?
The business should focus on increasing profitable order volume.
Recommended actions:
Increase marketing during high-conversion periods, especially weekends.
Test whether weekday marketing can create incremental demand or only shifts demand.
Separate holiday effects from promotion effects in future data.
Forecast revenue using weekly seasonality.
Allocate marketing dollars based on marginal ROI, not just total region size.

Business Impact
Revenue Planning Impact
This project gives the business a way to forecast the next 14 days of revenue using historical patterns.
The base ARIMA model answers: What will revenue look like if the past pattern continues? The ARIMAX model improves this by adding marketing spend and weekend indicators. Business impact: The company can plan inventory, staffing, marketing, and revenue targets using forecasted demand instead of guessing.

Marketing Budget Impact The regional ROI model estimates how much revenue response each region gets from marketing spend. The final allocation logic takes a $5,000 budget and assigns more spend to regions with stronger estimated ROI. Business impact: Marketing dollars can be shifted from equal allocation to performance-based allocation. That is what makes the project business-oriented rather than just statistical.

Recommendations
Separate holiday and promotion effects
Future data should include: Holiday with no promotion, Promotion with no holiday, Holiday with promotion, and Normal day with no promotion
Allocate marketing budget by marginal ROI
Do not split marketing evenly across regions. Allocate more dollars to regions where each dollar is expected to generate more revenue. However, this should be validated with more historical data before using it for major budget decisions.

Final Executive Summary

This project analyzes daily revenue across West, Central, and East regions to understand what drives sales performance and how the business should forecast revenue and allocate marketing spend.

The analysis shows that West is the highest-revenue region, Central is the lowest-revenue region, weekends outperform weekdays, and revenue is driven much more strongly by order volume than by average order value. Marketing spend is strongly associated with revenue, but because spend is higher on weekends and promotion/holiday days, the business should avoid assuming marketing alone caused the revenue lift.

The project also builds a 14-day revenue forecast using ARIMA and an improved ARIMAX model with marketing spend and weekend indicators. Finally, it estimates region-level marketing ROI and creates a budget allocation framework for a $5,000 marketing plan.

Final Recommendations
Use orders as the primary growth metric.
Use average order value as a secondary optimization lever.
Separate holiday effects from promotion effects in future tests.
Use ARIMAX forecasting for planning because it includes business drivers.
Allocate marketing budget based on marginal ROI, not equal splits.
Validate the region ROI model with more data before making large spend decisions.




























































