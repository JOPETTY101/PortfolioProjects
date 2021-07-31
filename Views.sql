
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

