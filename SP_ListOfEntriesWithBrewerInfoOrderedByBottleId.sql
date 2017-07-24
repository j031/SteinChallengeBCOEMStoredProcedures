DELIMITER $$
CREATE DEFINER=`<<db user>>`@`<<IP>>` PROCEDURE `ListOfEntriesWithBrewerInfoOrderByBottleId`()
BEGIN
	SELECT 
		distinct 
		b.brewerLastName
		, b.brewerFirstName
		, b.brewerCity
		, b.brewerState
		, b.brewerZip
		, (select count(*) from bcoem_brewing beerTotal where beerTotal.brewBrewerId = beer.brewBrewerID) as TotalEntries
		, beer.brewJudgingNumber as JudgeIdOnBottle
        , beer.id as beerId
	FROM bcoem_brewer b
	INNER JOIN bcoem_brewing beer on b.id = beer.brewBrewerID
	WHERE 
		beer.brewReceived = 1
	ORDER BY beer.brewJudgingNumber;
END$$
DELIMITER ;
