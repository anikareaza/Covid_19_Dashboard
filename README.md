# Project Overview
This end-to-end project explored global COVID-19 case and mortality data across continents using Python, SQL, and Tableau. The goal was to uncover disparities in infection rates, mortality patterns, and regional trends to support public health decision-making through interactive data visualizations.
Created a COVID-19 Analysis Dashboard utilizing SQL for data management and Tableau for visualization.

[Link to Interactive Dashboard](https://public.tableau.com/app/profile/anika.reza/viz/CovidDataAnalysis_16927800428170/Dashboard5)

[Link to SQL queries](https://github.com/anikareaza/Covid_19_Dashboard/blob/main/Query.sql)

# Tools Used
-  MySQL
-  Tableau
-  Visual Studio code
-  GitHub for version control and documentation
  
# Executive Summary
This project analyzed over 150,000 COVID-19 case records across continents to explore infection and mortality patterns. Data was transformed using Python and SQL, and insights were visualized using a Tableau dashboard. The analysis revealed that North and South America accounted for 62% of global COVID-19 deaths, with mortality in North America nearly 50× higher than in Oceania. Key findings informed region-specific health responses and highlighted the value of dynamic, data-driven storytelling in public health.

# Overview of Findings
- **Mortality Disparities:** North and South America combined contributed to over 62% of global deaths.

- **Continental Trends:** North America’s death count was disproportionately higher than other regions.

- **Country-Level Insights:** Canada and the U.S. showed distinct spikes during specific phases of the pandemic.

- **Public Health Visualization:** Tableau dashboards enabled filtering by country and timeframe, promoting accessible health intelligence for policymakers and the public.

# Key Discoveries & Methods
- **Data Collection & Cleaning (Python + Excel):** Used Python (pandas) to load and clean raw Excel datasets, handle missing values, unify inconsistent date/number formats, and extract relevant fields for analysis. This ensured a clean, analysis-ready dataset before importing to SQL.

- **Data Transformation (SQL)**: Imported the cleaned dataset into MySQL and used advanced SQL queries to transform and aggregate COVID-19 data for analysis and visualization. Key transformations included:

  - Continent-wise Aggregation: Calculated total cases and total deaths per continent, identifying regions with the highest mortality burden.
  
  - Global Metrics: Computed global totals and death percentages to measure worldwide pandemic impact.
  
  - Country-Level Infection Rates: Determined the percentage of population infected per country using total_cases / population, highlighting countries with the highest exposure.
  
  - Vaccination Tracking: Joined death and vaccination datasets to compute rolling totals of vaccinated individuals using window functions (SUM(...) OVER), then calculated the percentage of population vaccinated.
  
  - Time-Based Trends: Leveraged GROUP BY and CTEs to track infection progression and vaccination rollout over time at global and regional levels.
  
  - Temporary Tables: Used temp tables to store intermediate results for complex calculations, such as vaccination percentages by date, supporting efficient dashboard performance.

These aggregated insights were then visualized in Tableau to support public health reporting and decision-making. 

-  **Statistical Analysis:** Identified critical insights such as:

    -  North and South America accounted for 62% of global COVID-19 deaths.
  
    -  North America’s death count was ~50x higher than Oceania.
  
    -  Continent mortality and infection rates are visualized to reveal trends over time.

-  **Time-Series Analysis:** Tracked average percent population infected per country from 2020 to 2025 to show infection progression.

-  **Dashboard Development:** Created an interactive Tableau dashboard with:

    -  Global numbers summary
  
    -  Deaths per continent
    
    -  Average percentage of people infected per country
  
    -  Interactive map (country-level infection rates)
  
    -  Time-series death forecasting for selected countries

# Recommendations
-  **Focus Resources on High-Mortality Regions**: Prioritize healthcare funding, vaccination drives, and timely lockdown measures in North and South America, which account for over 60% of global deaths. Early containment strategies can significantly reduce further spread and mortality.
- **Prepare for Seasonal Infection Spikes**: Use historical trends to anticipate and mitigate future waves, especially during high-risk months.


# Assumptions and Caveats
-  **Missing Data**: Some missing months (e.g., February) were filled using the mode to preserve continuity.

- **Temporal Coverage:** Dashboard focuses on 2020–2025 data, excluding future projections.


![Screen Shot 2024-01-08 at 1 41 10 PM](https://github.com/anikareaza/Covid_19_Dashboard/assets/101680746/a4ceadbb-d02f-45b9-ae08-de8844b601cc)

[Visualization on Tableau](https://public.tableau.com/app/profile/anika.reza/viz/CovidDataAnalysis_16927800428170/Dashboard5)
