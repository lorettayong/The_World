SELECT *
FROM TheWorld..EntirePopulation
ORDER BY Country

-- 1. Ranking of countries based on population size in 2020
SELECT *
FROM TheWorld..EntirePopulation
ORDER BY Population DESC

-- 2. Ranking of countries based on population size in 2019
-- To see how the population size has altered since the start of the pandemic
-- Formula used: Population in 2019 = Population in 2020 - Net Change
SELECT Country, Population, Yearly_Change, Net_Change, (Population - Net_Change) AS Population_2019
FROM TheWorld..EntirePopulation
ORDER BY Population_2019 DESC

-- 3. Countries that experienced population reduction (i.e. more deaths than births) in 2020
-- When running query 2, the negative figures for Japan caught my eye, and I got curious.
SELECT Country, Population, Net_Change
FROM TheWorld..EntirePopulation
WHERE Net_Change < 0
ORDER BY Net_Change

-- 4A. To double check on how the calculation of Density was done
-- Note: Holy See was removed from the data as her Land_Area was stated as 0 in the dataset
SELECT Country, Population, Land_Area, Density, (Population / Land_Area) AS Density_Calculated
FROM TheWorld..EntirePopulation
WHERE Land_Area > 0
ORDER BY Density_Cal DESC

--4B. Ranking of countries based on population density
-- Not surprisingly, Singapore is in the list of top 3 countries. Next, I got curious about the largest countries from the spatial perspective.
SELECT Country, Population, Land_Area, Density
FROM TheWorld..EntirePopulation
ORDER BY Density DESC

-- 5. Ranking of countries based on land area size
-- Russia's land is so vast that their density is just 9 persons / km²!
SELECT Country, Population, Land_Area, Density
FROM TheWorld..EntirePopulation
ORDER BY Land_Area DESC

-- 6. Net migrants to population ratio
SELECT Country, Population, ISNULL(Net_Migrants, 0) AS Net_Migrants, (Net_Migrants / Population) * 100 AS Net_Migrants_to_Population_Ratio
FROM TheWorld..EntirePopulation
ORDER BY Net_Migrants_to_Population_Ratio DESC

--7. Which countries were experiencing low fertility rates in 2020?
SELECT Country, Population, Median_Age, Fertility_Rate
FROM TheWorld..EntirePopulation
WHERE Fertility_Rate IS NOT NULL
ORDER BY Fertility_Rate

-- 8A. Ranking of countries based on median age (higher = population is aging more than others)
-- Interestingly, the median age difference between the top two most populous countries is 10 years!
SELECT Country, Population, Median_Age
FROM TheWorld..EntirePopulation
ORDER BY Median_Age DESC

-- 8B. The world's highest and lowest median age
SELECT MAX(Median_Age) AS Max_Med_Age
FROM TheWorld..EntirePopulation

SELECT MIN(Median_Age) AS Min_Med_Age
FROM TheWorld..EntirePopulation

-- 9. Which country had the biggest urban population size?
SELECT Country, Population, CAST((Urban_Population * Population) AS INT) AS Urban_Pop_Size
FROM TheWorld..EntirePopulation
ORDER BY Urban_Pop_Size DESC
