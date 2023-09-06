

--  Select * 
-- From covid_deaths 
-- Orber by 1,2 

-- Select Data that were going to be analyzing 

SELECT location, date, total_cases, new_cases, total_deaths, population
FROM covid_us
ORDER BY 1,2; 


-- Looking at Total Cases vs Total Deaths 
-- Show likelihood of dying if contracted Covid 

SELECT location, date , total_cases, total_deaths, (total_deaths/total_cases) * 100 AS DeathPercentage
FROM covid_us
WHERE location LIKE '%states%'
ORDER BY 1,2; 



-- Total Cases Vs. Population 
-- Shows what percentage of the population got Covid 
SELECT location, date , total_cases, population,(total_cases/population) * 100 AS DeathPercentage
FROM covid_us
WHERE location LIKE '%states%'
ORDER BY 1,2; 

--  Rate of Infection Conpared the population 
SELECT location, population, MAX(total_cases) as HighestInfectionCount, Max(total_cases/population) * 100 as PercentageInfected
FROM covid_us
WHERE location LIKE '%states'
GROUP BY location, population 
ORDER BY PercentageInfected;


-- Highest Death Count per the population 
SELECT location, MAX(total_deaths) as TotalDeathCount
FROM covid_us
WHERE location LIKE '%states'
GROUP BY location 
ORDER BY TotalDeathCount;


-- Total Deaths By Continent 

SELECT continent, MAX(total_deaths) as TotalDeathCount
FROM covid_deaths
WHERE continent is not null
GROUP BY continent 
ORDER BY TotalDeathCount desc; 


-- SUM % of Total Cases vs Total Deaths Across Continents
SELECT continent, SUM(total_cases) as NewCases, SUM(total_deaths) as TotalDeaths, SUM(total_deaths) / SUM(total_cases)*100 as DeathPercentage
FROM covid_deaths
WHERE continent is not null
GROUP BY continent 
ORDER BY TotalDeaths desc; 

-- Total Population Vs. Vaccinations

SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, 
SUM(new_vaccinations) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) as RollingPeopleVaccinated
-- RollingPeopleVaccinated/population)*100
FROM covid_deaths dea 
Join covid_vaccinations vac
	On dea.location = vac.location 
    and dea.date = vac.date
WHERE dea.continent is not null
ORDER BY 2,3


-- With CTE 



