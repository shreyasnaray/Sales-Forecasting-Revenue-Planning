library(dplyr)
library(tidyverse)
library(ggplot2)
library(lubridate)
library(forecast)
date <- as.Date(c('2024-01-01', '2024-01-02', '2024-01-03', '2024-01-04', '2024-01-05',
                  '2024-01-06', '2024-01-07', '2024-01-08', '2024-01-09', '2024-01-10',
                  '2024-01-11', '2024-01-12', '2024-01-13', '2024-01-14', '2024-01-15',
                  '2024-01-16', '2024-01-17', '2024-01-18', '2024-01-19', '2024-01-20',
                  '2024-01-21', '2024-01-01', '2024-01-02', '2024-01-03', '2024-01-04',
                  '2024-01-05', '2024-01-06', '2024-01-07', '2024-01-08', '2024-01-08',
                  '2024-01-10', '2024-01-11', '2024-01-12', '2024-01-13', '2024-01-14',
                  '2024-01-15', '2024-01-16', '2024-01-17', '2024-01-18', '2024-01-19',
                  '2024-01-20', '2024-01-21', '2024-01-01', '2024-01-02', '2024-01-03', 
                  '2024-01-04','2024-01-05', '2024-01-06', '2024-01-07', '2024-01-08', 
                  '2024-01-09', '2024-01-10', '2024-01-11', '2024-01-12', '2024-01-13', 
                  '2024-01-14','2024-01-15', '2024-01-16', '2024-01-17', '2024-01-18', 
                  '2024-01-19', '2024-01-20', '2024-01-21'))
region <- c('West', 'West', 'West', 'West', 'West', 'West', 'West',
            'West', 'West', 'West', 'West', 'West', 'West', 'West',
            'West', 'West', 'West', 'West', 'West', 'West', 'West',
            'Central', 'Central', 'Central', 'Central', 'Central', 'Central', 'Central',
            'Central', 'Central', 'Central', 'Central', 'Central', 'Central', 'Central',
            'Central', 'Central', 'Central', 'Central', 'Central', 'Central', 'Central',
            'East', 'East', 'East', 'East', 'East', 'East', 'East',
            'East', 'East', 'East', 'East', 'East', 'East', 'East',
            'East', 'East', 'East', 'East', 'East', 'East', 'East')
revenue <- c(5200, 4800, 5000, 5100, 5300, 6200, 6400,
             5100, 4950, 5050, 5200, 5400, 6500, 6600,
             7000, 5300, 5200, 5150, 5400, 6700, 6800,
             4200, 3900, 4000, 4100, 4300, 5000, 5100,
             4200, 4100, 4150, 4300, 4400, 5200, 5300,
             5800, 4300, 4200, 4150, 4400, 5400, 5500,
             4600, 4300, 4400, 4500, 4700, 5500, 5600,
             4600, 4500, 4550, 4700, 4800, 5600, 5700,
             6200, 4700, 4600, 4550, 4800, 5800, 5900)
orders <- c(95, 88, 92, 93, 98, 110, 115, 
            94, 90, 91, 96, 100, 118, 120,
            130, 97, 95, 94, 100, 122, 125,
            80, 75, 78, 79, 83, 95, 97,
            81, 79, 80, 83, 85, 100, 102,
            110, 82, 80, 79, 84, 103, 105,
            85, 80, 82, 83, 87, 100, 102,
            85, 83, 84, 87, 89, 103, 105,
            115, 87, 85, 84, 89, 107, 109)
avg_order_value <- c(54.7, 54.5, 54.3, 54.8, 54.1, 56.3, 55.6,
                     54.3, 55.0, 55.5, 54.2, 54.0, 55.1, 55.0,
                     53.8, 54.6, 54.7, 54.8, 54.0, 54.9, 54.4,
                     52.5, 52.0, 51.3, 51.9, 51.8, 52.6, 52.6,
                     51.8, 51.9, 51.9, 51.8, 51.8, 52.0, 52.0,
                     52.7, 52.4, 52.5, 52.5, 52.4, 52.4, 52.4,
                     54.1, 53.8, 53.7, 54.2, 54.0, 55.0, 54.9,
                     54.1, 54.2, 54.2, 54.0, 53.9, 54.4, 54.3,
                     53.9, 54.0, 54.1, 54.2, 53.9, 54.2, 54.1)
marketing_spend <- c(1200, 900, 950, 1000, 1100, 1300, 1350,
                     950, 900, 920, 1000, 1100, 1400, 1450,
                     1600, 1000, 980, 970, 1100, 1450, 1500,
                     900, 700, 750, 800, 850, 1000, 1050, 
                     780, 750, 760, 820, 880, 1050, 1100, 
                     1200, 800, 780, 770, 850, 1100, 1150,
                     1000, 800, 850, 900, 950, 1100, 1150, 
                     850, 820, 830, 900, 950, 1150, 1200, 
                     1300, 900, 880, 870, 950, 1200, 1250)
is_weekend <- c(0, 0, 0, 0, 0, 1, 1, 
                0, 0, 0, 0, 0, 1, 1,
                0, 0, 0, 0, 0, 1, 1,
                0, 0, 0, 0, 0, 1, 1,
                0, 0, 0, 0, 0, 1, 1,
                0, 0, 0, 0, 0, 1, 1,
                0, 0, 0, 0, 0, 1, 1,
                0, 0, 0, 0, 0, 1, 1,
                0, 0, 0, 0, 0, 1, 1)
is_holiday <- c(1, 0, 0, 0, 0, 0, 0,
                0, 0, 0, 0, 0, 0, 0,
                1, 0, 0, 0, 0, 0, 0,
                1, 0, 0, 0, 0, 0, 0,
                0, 0, 0, 0, 0, 0, 0,
                1, 0, 0, 0, 0, 0, 0,
                1, 0, 0, 0, 0, 0, 0,
                0, 0, 0, 0, 0, 0, 0,
                1, 0, 0, 0, 0, 0, 0)
promo_active <- c(1, 0, 0, 0, 0, 0, 0,
                  0, 0, 0, 0, 0, 0, 0,
                  1, 0, 0, 0, 0, 0, 0,
                  1, 0, 0, 0, 0, 0, 0,
                  0, 0, 0, 0, 0, 0, 0,
                  1, 0, 0, 0, 0, 0, 0,
                  1, 0, 0, 0, 0, 0, 0,
                  0, 0, 0, 0, 0, 0, 0,
                  1, 0, 0, 0, 0, 0, 0)
df <- data.frame(date = date, region = region, revenue = revenue, orders = orders,
           avg_order_value = avg_order_value, marketing_spend = marketing_spend,
           is_weekend = is_weekend, is_holiday = is_holiday, promo_active = promo_active)

df
# Revenue over time
ggplot(df, aes(x = as.Date(date), y = revenue, color = region)) +
  geom_line(alpha = 0.4) +
  geom_point() +
  theme_minimal() +
  labs(
    title = 'Revenue by Date across Region', 
    x = 'Date', 
    y = 'Revenue'
  ) +
  theme(plot.title = element_text(hjust = 0.5))

# Orders over time
ggplot(df, aes(x = as.Date(date), y = orders, color = region)) +
  geom_line(alpha = 0.4) +
  geom_point() +
  theme_minimal() +
  labs(
    title = 'Orders by Date across Region',
    x = 'Date', 
    y = 'Orders'
  ) +
  theme(plot.title = element_text(hjust = 0.5))

df <- df %>%
  mutate(
    weekend = ifelse(is_weekend == 1, 'Weekend', 'Weekday'),
    holiday = ifelse(is_holiday == 1, 'Holiday', 'Non-Holiday'),
    promo = ifelse(promo_active == 1, 'Promotion', 'Non-Promotion')
  )


weekend_stats <- df %>%
  group_by(region, is_weekend) %>%
  summarise(
    count = n(),
    avg_revenue = mean(revenue),
    avg_orders = mean(orders),
    avg_marketing_spend = mean(marketing_spend)
  )
# Revenue and Orders by Region and Day Type
weekend_stats %>%
  pivot_longer(cols = c(avg_revenue, avg_orders),
               names_to = 'metric',
               values_to = 'value') %>%
  ggplot(aes(x = region, y = value, fill = metric)) +
  geom_col(position = 'dodge') +
  facet_grid(metric ~ is_weekend, scales = 'free_y') +
  labs(
    title = 'Revenue and Orders by Region',
    x = 'Region',
    y = 'Value',
    fill = 'Metric'
  ) +
  theme(plot.title = element_text(hjust = 0.5))

# Average Revenue by Region
ggplot(weekend_stats, aes(x = region, y = avg_revenue, fill = factor(is_weekend))) +
  geom_col(position = 'dodge') +
  labs(title = 'Average Revenue by Region',
       x = 'Region', 
       y = 'Average Revenue',
      fill = 'Day Type') +
  theme(plot.title = element_text(hjust = 0.5))

# Scatter plot between orders and revenue
ggplot(df, aes(x = orders, y = revenue, color = region)) +
  geom_point(size = 3, alpha = 0.7) +
  facet_wrap(~is_weekend) +
  labs(
    title = 'Revenue vs Orders by Region',
    x = 'Orders', 
    y = 'Revenue', 
    color = 'Region'
  ) +
  theme(plot.title = element_text(hjust = 0.5))


holiday_stats <- df %>%
  group_by(region, is_holiday) %>%
  summarise(
    count = n(),
    avg_revenue = mean(revenue),
    avg_orders = mean(orders),
    avg_marketing_spend = mean(marketing_spend)
  )

holiday_stats

ggplot(holiday_stats, aes(x = region, y = avg_revenue, fill = factor(is_holiday))) +
  geom_col(position = 'dodge') +
  labs(title = 'Average Revenue by Region',
       x = 'Region',
       y = 'Average Revenue',
       fill = 'Holiday Type') +
  theme(plot.title = element_text(hjust = 0.5))

# Revenue = Orders * Avg_Order_Value
df %>%
  summarise(
    corr_orders = cor(revenue, orders),
    corr_aov = cor(revenue, avg_order_value)
  )

# Marketing Spend vs Revenue
ggplot(df, aes(x = marketing_spend, y = revenue, color = region)) +
  geom_point(alpha = 0.7) +
  geom_smooth(method = 'lm', se = FALSE) +
  labs(title = 'Revenue vs. Marketing Spend') +
  theme(plot.title = element_text(hjust = 0.5))

df <- df %>%
  mutate(
    day_of_week = wday(date, label = TRUE),
    week = week(date)
  )

# Regression Model ()
model <- lm(revenue ~ orders + avg_order_value +
              marketing_spend + is_weekend + is_holiday +
              promo_active + region + day_of_week, data = df)
summary(model)

# Marketing is more effective on the weekends
model_interaction <- lm(revenue ~ marketing_spend * is_weekend +
                          orders + avg_order_value + promo_active, 
                        data = df)
summary(model_interaction)

ts_df <- df %>%
  group_by(date) %>%
  summarise(revenue = sum(revenue), 
            orders = sum(orders),
            aov = sum(revenue) / sum(orders),
            marketing_spend = sum(marketing_spend),
            is_weekend = max(is_weekend),
            is_holiday = max(is_holiday),
            promo_active = max(promo_active),
            .groups = 'drop') %>%
  arrange(date)

ts_df

sales_ts <- ts(ts_df$revenue, frequency = 7) # weekly seasonality

fit <- auto.arima(sales_ts)
summary(fit)

forecast_14 <- forecast(fit, h = 14)
plot(forecast_14)

forecast_df <- data.frame(
  da_te = seq(max(ts_df$date) + 1, by = 'day', length.out = 14),
  predicted = as.numeric(forecast_14$mean),
  lower_95 = as.numeric(forecast_14$lower[, 2]),
  upper_95 = as.numeric(forecast_14$upper[, 2])
)

forecast_df

ggplot(forecast_df, aes(x = da_te, y = predicted)) +
  geom_line(linewidth = 1.3) +
  geom_point(size = 2) +
  labs(
    title = 'Future Predicted Revenue by Date',
    x = 'Date', 
    y = 'Future Revenue'
  ) +
  theme(plot.title = element_text(hjust = 0.5))


baseline_revenue <- sum(forecast_14$mean)
baseline_revenue



# Forecast with Drivers (ARIMAX)
xreg <- ts_df %>%
  select(marketing_spend, is_weekend) %>%
  as.matrix()

fit_x <- auto.arima(sales_ts, xreg = xreg)

# create a simple future plan
future_xreg <- data.frame(
  marketing_spend = rep(mean(ts_df$marketing_spend), 14),
  is_weekend = rep(c(0, 0, 0, 0, 0, 1, 1), length.out = 14)
) %>% as.matrix()

fc_x_14 <- forecast(fit_x, xreg = future_xreg, h = 14)
autoplot(fc_x_14) + ggplot2::labs(title = '14-Day Forecast (with Drivers)')


region_roi_model <- lm(
  revenue ~ marketing_spend * region + is_weekend + promo_active, 
  data = df
)
coefs <- coef(region_roi_model)
roi_region <- data.frame(
  region = c('Central', 'East', 'West'),
  roi = c(
    coefs['marketing_spend'],
    coefs['marketing_spend'] + coefs['marketing_spend:regionEast'],
    coefs['marketing_spend'] + coefs['marketing_spend:regionWest']
  )
)
roi_region

budget <- 5000

allocation <- roi_region %>%
  mutate(
    weight = roi/sum(roi),
    spend = budget * weight,
    expected_revenue = spend * roi
  )
allocation





