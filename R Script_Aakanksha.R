#Skeleton code for Data Analysis Project: EC:6062

#Student Name: Aakanksha Chourasiya
#Student ID:24169935

# The project focuses on multiple regression analysis, using firm level data.
# To complete the project, you need to have the following packages installed.


#Step 1 Install packages 
# Please note, the installations are commented out with # (take this out and the codes will run)

install.packages("tidyverse")
install.packages("magrittr")
install.packages("stargazer")
install.packages ("dplyr")
install.packages("writexl")
install.packages("car")
install.packages("lmtest")
install.packages("RCurl")
install.packages("readxl")
install.packages("expss")
install.packages("maditr")
install.packages("broom") 
install.packages("mosaic")



# Step 2: Loading packages (library command)
library(tidyverse)
library(magrittr)
library(stargazer)
library(dplyr)
library(writexl)
library(lmtest)
library (car)
library(readxl)
library(expss)
library(maditr)
library(broom) 
library(mosaic)
library(ggplot2)

# import the function to calculate Robust Standard Erro from the Repo.

url_robust <- "https://raw.githubusercontent.com/IsidoreBeautrelet/economictheoryblog/master/robust_summary.R"
eval(parse(text = getURL(url_robust, ssl.verifypeer = FALSE)),
     envir=.GlobalEnv)


#don't worry if you get an error message. If you have an object names url_robust, you are okay!


# Step 3: set your directory and load the data (Ensure to save the data file in this folder)
getwd()
setwd("/Users/aakanksha/Documents/Econometrics Project")

list.files()  #Do you see the data file?

data <- read_excel("Firm-profits_Data.xlsx")

# Overview of the dataset
glimpse(data)

# Step 3: Apply Labels
data = apply_labels(data, 
                    ID = "Unique Identifier",
                    log_profits = "Firms profits in 2024 in Natural Logs",
                    log_training = "Total investments in Training between 2022 and 2023 in Logs",
                    log_equipment = "Total investments in Capital Equipment between 2022 and 2023 in Logs",
                    Enterprise_Group = "Does the firm belong to an Enterprise Group, 1 = Yes",
                    Firm_Age = "Year of the firm since registration to 2024",
                    Export_yes_no = "The firm is an exporting firm, 1= Yes",
                    Small_Firm = "The firm has fewer than 50 employees",
                    Industrial_sector = "Industrial Sector codes",
                    innovation_yes = "The firm introduced new products or services to market during 2022 ans 2023",
                    Employees_log = "Total number of employees in logs in 2024",
                    R_D_yes = "The firm invested in RD during 2022 and 2023, 1 = yes"
)

# Step 4: Data Exploration
skim(data)  # Provides detailed descriptive statistics

# Checking for extreme values and negative profits
summary(data$log_profits)
table(data$log_profits <= 0)

# Remove firms with zero or negative profits
cleaned_data <- subset(data, log_profits > 0)

# Identify outliers using IQR
Q1 <- quantile(cleaned_data$log_profits, 0.25, na.rm = TRUE)
Q3 <- quantile(cleaned_data$log_profits, 0.75, na.rm = TRUE)
IQR_value <- Q3 - Q1
lower_bound <- Q1 - 1.5 * IQR_value
upper_bound <- Q3 + 1.5 * IQR_value
outliers <- cleaned_data %>% filter(log_profits < lower_bound | log_profits > upper_bound)

# Visualizing outliers
ggplot(cleaned_data, aes(x = "", y = log_profits)) +
  geom_boxplot(fill = "lightblue", color = "darkblue") +
  geom_point(data = outliers, aes(x = "", y = log_profits), color = "red", size = 2) +
  labs(title = "Boxplot of Log Profits with Outliers", x = "", y = "Log Profits") +
  theme_minimal()

# Step 5: Correlation Analysis
numeric_vars <- data %>% select(where(is.numeric))
cor_matrix <- cor(numeric_vars, use = "complete.obs")
corrplot(cor_matrix, method = "color", addCoef.col = "black", tl.col = "black", tl.srt = 45)

# Step 6: Regression Models
model1 <- lm(log_profits ~ log_training, data = cleaned_data)
model2 <- lm(log_profits ~ log_equipment, data = cleaned_data)
model3 <- lm(log_profits ~ log_training + log_equipment, data = cleaned_data)
model4 <- lm(log_profits ~ log_training + log_equipment + Employees_log + Firm_Age + 
               Export_yes_no + Small_Firm + R_D_yes + innovation_yes, data = cleaned_data)

# Function to display regression results with robust SEs
robust_se <- function(model) {
  coeftest(model, vcov = vcovHC(model, type = "HC1"))
}

# Display models with robust standard errors
robust_se(model1)
robust_se(model2)
robust_se(model3)
robust_se(model4)

# Step 7: Heteroskedasticity Test
bptest(model4)

# Residual Plot
ggplot(cleaned_data, aes(x = fitted(model4), y = residuals(model4))) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE, color = "red") +
  labs(title = "Residual Plot", x = "Fitted Values", y = "Residuals") +
  theme_minimal()

# Step 8: Regression Table with Robust SEs
stargazer(model1, model2, model3, model4, 
          type = "text", title = "Regression Results with Robust Standard Errors", digits = 3,
          se = list(coef(summary(model1, robust=T))[, 2],
                    coef(summary(model2, robust=T))[, 2],
                    coef(summary(model3, robust=T))[, 2],
                    coef(summary(model4, robust=T))[, 2])
)

print("Analysis complete. Please review your report before submission.")