# 🚀 Econometrics Project: Do Training & Equipment Investments Drive Firm Profits?

Welcome to the repository for my **Applied Econometrics for Business** project at the **University of Limerick**. This project explores whether firms can increase profits through investments in employee training and capital equipment upgrades.

---

## 📌 Project Highlights

- **Data:** 962 firms from Manufacturing, Services, and ICT sectors  
- **Period:** Training & Equipment investments (2020–2023) vs. 2024 profits  
- **Model:** Multiple linear regression with robust standard errors  
- **Controls:** Firm size, innovation, R&D, export status, industry  
- **Comparisons:** Effects analyzed for small, medium, and large firms  

---

## 🔬 Methodology

The estimated model:

\[
\log(\text{Profits}_i) = \alpha + \beta_1 \log(\text{Training}_i) + \beta_2 \log(\text{Equipment}_i) + \beta X_i' + u_i
\]

where:

- \( \log(\text{Profits}_i) \): log of firm profits in 2024  
- \( \log(\text{Training}_i) \), \( \log(\text{Equipment}_i) \): log of cumulative investments (2020–2023)  
- \( X_i' \): controls (size, innovation, R&D, export, sector)  
- \( u_i \): error term  

Robust standard errors are used to handle heteroskedasticity.

---

## 📈 Key Findings

- Equipment investment has a strong positive effect on profits, especially for medium and large firms.  
- Training investment positively impacts profits, more so for small firms and varies across sectors.  
- Innovation and R&D significantly boost profit outcomes, underscoring strategic investment importance.  

---

## 📂 Repository Contents

| File               | Description                                   |
|--------------------|-----------------------------------------------|
| `report.pdf`       | Final project report detailing analysis and results |
| `R_script.R`       | Complete R script with data processing and modeling |
| `project_data.csv` | Cleaned dataset used for the econometric analysis |
| `README.md`        | Project overview and documentation (this file) |

---

## 📋 How to Use

1. Clone or download this repository  
2. Open `R_script.R` in RStudio or your preferred R environment  
3. Run the script to reproduce all analyses and figures  
4. Refer to `report.pdf` for detailed interpretation of results  

---

Thank you for visiting!  
_Data-driven insights for effective business investment strategies._
