Select * From projectcovid..covidDeaths
order by 3,4

Select * From proj..covidVaccination
order by 3,4

Select *
From projectcovid..covidDeaths
Where continent is not null 
order by 3,4



-- Select Data that we are going to be starting with

Select Location, date, total_cases, new_cases, total_deaths, population
From projectcovid..covidDeaths
Where continent is not null 
order by 1,2


-- Total Cases vs Total Deaths
-- Shows likelihood of dying if you contract covid in your country
SELECT 
    Location, 
    date, 
    total_cases, 
    total_deaths, 
    CASE 
        WHEN TRY_CAST(total_cases AS INT) IS NOT NULL AND TRY_CAST(total_cases AS INT) > 0
            THEN (CAST(total_deaths AS FLOAT) / CAST(total_cases AS INT)) * 100
        ELSE NULL
    END AS DeathPercentage
FROM 
    projectcovid..covidDeaths
WHERE 
    location LIKE '%states%'
    AND continent IS NOT NULL 
ORDER BY 
    Location, date;



-- Total Cases vs Population
-- Shows what percentage of population infected with Covid
SELECT 
    Location, 
    date, 
    Population, 
    total_cases, 
    CASE 
        WHEN TRY_CAST(total_cases AS FLOAT) IS NOT NULL AND TRY_CAST(population AS INT) IS NOT NULL AND TRY_CAST(population AS INT) > 0
            THEN (CAST(total_cases AS FLOAT) / CAST(population AS INT)) * 100
        ELSE NULL
    END AS PercentPopulationInfected
FROM 
    projectcovid..covidDeaths
-- WHERE location LIKE '%states%'
ORDER BY 
    Location, date;




-- Countries with Highest Infection Rate compared to Population
SELECT 
    Location, 
    Population, 
    MAX(total_cases) as HighestInfectionCount,  
    MAX((CAST(total_cases AS FLOAT) / population)) * 100 as PercentPopulationInfected
FROM 
    projectcovid..covidDeaths
-- WHERE location like '%states%'
GROUP BY 
    Location, Population
ORDER BY 
    PercentPopulationInfected desc;












	

-- Countries with Highest Infection Rate compared to Population
SELECT 
    Location, 
    Population, 
	date,
    MAX(total_cases) as HighestInfectionCount,  
    MAX((CAST(total_cases AS FLOAT) / population)) * 100 as PercentPopulationInfected
FROM 
    projectcovid..covidDeaths
-- WHERE location like '%states%'
GROUP BY 
    Location, Population,date
ORDER BY 
    PercentPopulationInfected desc;






-- Countries with Highest Death Count per Population

Select Location, MAX(cast(Total_deaths as int)) as TotalDeathCount
From projectcovid..covidDeaths
--Where location like '%states%'
Where continent is not null AND Location NOT LIKE '%High income%' AND Location NOT LIKE '%Upper middle income%'
Group by Location
HAVING
    Location <> 'world' 
order by TotalDeathCount desc







-- BREAKING THINGS DOWN BY CONTINENT

-- Showing contintents with the highest death count per population

Select location,SUM(cast(new_deaths as int)) as TotalDeathCount
From projectcovid..covidDeaths
Where continent is null
and location not in ('world', 'European Union', 'International')
Group by location
order by TotalDeathCount desc







-- BREAKING THINGS DOWN BY CONTINENT

-- Showing contintents with the highest death count per population

Select continent, MAX(cast(Total_deaths as int)) as TotalDeathCount
From  projectcovid..covidDeaths
--Where location like '%states%'
Where continent is not null  AND continent <> ''
Group by continent
order by TotalDeathCount desc



-- GLOBAL NUMBE
-- GLOBAL NUMBERS
-- GLOBAL NUMBERS
SELECT 
    SUM(CAST(new_cases AS BIGINT)) as total_cases, 
    SUM(CAST(new_deaths AS BIGINT)) as total_deaths, 
    CASE
        WHEN SUM(CAST(new_cases AS BIGINT)) > 0 
        THEN (SUM(CAST(new_deaths AS FLOAT)) * 100.0) / SUM(CAST(new_cases AS FLOAT))
        ELSE 0
    END as DeathPercentage
FROM  
   projectcovid..covidDeaths
WHERE 
    continent IS NOT NULL
order by 1,2




-- Total Population vs Vaccinations
-- Shows Percentage of Population that has recieved at least one Covid Vaccine
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(bigint,new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From  projectcovid..covidDeaths dea
Join  projectcovid..covidVaccanations vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null 
order by 2,3


-- Using CTE to perform Calculation on Partition By in previous query

With PopvsVac (Continent, Location, Date, Population, New_Vaccinations, RollingPeopleVaccinated)
as
(
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(bigint,new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From  projectcovid..covidDeaths dea
Join  projectcovid..covidVaccanations vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null 
--order by 2,3
)
Select *, (RollingPeopleVaccinated/Population)*100
From PopvsVac



-- Using Temp Table to perform Calculation on Partition By in previous query
DROP TABLE IF EXISTS #PercentPopulationVaccinated;

CREATE TABLE #PercentPopulationVaccinated (
    Continent nvarchar(255),
    Location nvarchar(255),
    Date datetime,
    Population numeric,
    New_vaccinations numeric,
    RollingPeopleVaccinated numeric
);

INSERT INTO #PercentPopulationVaccinated
SELECT
    dea.continent,
    dea.location,
    dea.date,
    dea.population,
    TRY_CAST(vac.new_vaccinations AS NUMERIC(18, 2)),  -- Adjust the numeric precision and scale as needed
    SUM(TRY_CAST(vac.new_vaccinations AS NUMERIC(18, 2))) OVER (PARTITION BY dea.Location ORDER BY dea.location, dea.Date) as RollingPeopleVaccinated
FROM
    projectcovid..covidDeaths dea
JOIN
    projectcovid..covidVaccanations vac
    ON dea.location = vac.location
    AND dea.date = vac.date;

SELECT
    *,
    CASE
        WHEN Population > 0 THEN (RollingPeopleVaccinated / Population) * 100
        ELSE NULL
    END AS VaccinationPercentage
FROM
    #PercentPopulationVaccinated;

