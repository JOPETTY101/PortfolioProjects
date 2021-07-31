SELECT TOP (1000) [continent]
      ,[TotalPopulation]
      ,[TotalCases]
      ,[TotalTests]
      ,[TestsPerPopulation]
  FROM [TestDB].[dbo].[TotalTests_By_Continent]
  ORDER BY TestsPerPopulation DESC