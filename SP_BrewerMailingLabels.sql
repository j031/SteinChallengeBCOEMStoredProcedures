DELIMITER $$
CREATE DEFINER=`<<db user>>`@`<<ip>>` PROCEDURE `BrewerMailingLabels`()
BEGIN
	SELECT 
		distinct 
		b.brewerLastName
		, b.brewerFirstName
        , b.brewerAddress
		, b.brewerCity
		, b.brewerState
		, b.brewerZip
		, (select count(*) from bcoem_brewing beerTotal where beerTotal.brewBrewerId = beer.brewBrewerID) as Entries
	FROM bcoem_brewer b
	INNER JOIN bcoem_brewing beer on b.id = beer.brewBrewerID
	WHERE 
		beer.brewReceived = 1
	ORDER BY b.brewerLastName, b.brewerFirstName;
END$$
DELIMITER ;
