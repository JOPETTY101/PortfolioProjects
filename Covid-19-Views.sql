-- View of Global Death Percentage

DROP VIEW IF EXISTS TotalGlobalDeathPercentage
CREATE VIEW TotalGlobalDeathPercentage AS

SELECT SUM(new_cases) as total_cases, 
SUM( cast( new_deaths as numeric ) ) as total_deaths, 
SUM( cast( new_deaths as numeric ) ) / SUM( New_Cases ) *100 as DeathPercentage
FROM TestDB..Covid_Deaths
WHERE continent IS NOT NULL

-- View of Death Percentage by Continent and Location

DROP VIEW IF EXISTS DeathPercentagebyContinentandLocation
CREATE VIEW DeathPercentagebyContinentandLocation AS

SELECT continent, location, SUM(new_cases) as total_cases, 
SUM( cast( new_deaths as numeric ) ) as total_deaths, 
SUM( cast( new_deaths as numeric ) ) / SUM( New_Cases ) *100 as DeathPercentage
FROM TestDB..Covid_Deaths
WHERE continent IS NOT NULL
GROUP BY continent, [location]


-- View of Total Tests By Continent

DROP VIEW IF EXISTS TotalTests_By_Continent 
CREATE VIEW TotalTests_By_Continent AS

SELECT dea.continent, 
    SUM( CONVERT( numeric, dea.population ) ) as TotalPopulation, 
    SUM( CONVERT( numeric, dea.new_cases ) ) as TotalCases, 
    SUM( CONVERT( numeric, vac.total_tests ) ) as TotalTests,
    SUM( CONVERT( numeric, vac.total_tests ) ) / SUM(CONVERT( numeric, dea.population ) ) as TestsPerPopulation
FROM TestDB..Covid_Deaths dea
JOIN TestDB..Covid_Vaccinations vac
    ON dea.[date] = vac.[date]
    AND dea.[location] = vac.[location]
WHERE dea.continent IS NOT NULL
GROUP BY dea.continent

-- View of Total Tests Per Thousand By Continent

DROP VIEW IF EXISTS TotalTestsPerThousand_By_Continent
CREATE VIEW TotalTestsPerThousand_By_Continent AS

SELECT dea.continent, 
    SUM( CONVERT( numeric, dea.new_cases ) ) as TotalCases, 
    SUM( CONVERT( numeric, vac.total_tests_per_thousand ) ) as TotalTestsPerThousand
FROM TestDB..Covid_Deaths dea
JOIN TestDB..Covid_Vaccinations vac
    ON dea.[date] = vac.[date]
    AND dea.[location] = vac.[location]
WHERE dea.continent IS NOT NULL
GROUP BY dea.continent

-- View of Total Tests Per Thousand By Continent and Location

DROP VIEW IF EXISTS TotalTestsPerThousand_By_Location
CREATE VIEW TotalTestsPerThousand_By_Location AS

SELECT dea.continent, dea.location, 
    SUM( CONVERT( numeric, dea.new_cases ) ) as TotalCases, 
    SUM( CONVERT( numeric, vac.total_tests_per_thousand ) ) as TotalTestsPerThousand
FROM TestDB..Covid_Deaths dea
JOIN TestDB..Covid_Vaccinations vac
    ON dea.[date] = vac.[date]
    AND dea.[location] = vac.[location]
WHERE dea.continent IS NOT NULL
GROUP BY dea.location, dea.continent

-- View of ICU Patients % By Continent

DROP VIEW IF EXISTS ICUPatientPercentage_By_Continent 
CREATE VIEW ICUPatientPercentage_By_Continent  AS

SELECT continent, 
SUM( CONVERT( numeric, icu_patients ) ) as ICUPatients, 
SUM( CONVERT( numeric, hosp_patients ) ) as TotalPatients,
( SUM( CONVERT( numeric, icu_patients ) ) / SUM( CONVERT( numeric, hosp_patients ) ) )as ICUPatientPercentage
FROM TestDB..Covid_Deaths
WHERE icu_patients IS NOT NULL
AND hosp_patients IS NOT NULL
GROUP BY continent
