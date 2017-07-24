call BeerJudgeLabels();DELIMITER $$
CREATE DEFINER=`<<db user>>`@`<<ip>>` PROCEDURE `BeerJudgeLabels`()
BEGIN
	/*
	 =============================================
	 Author:      Joel Taylor
	 Description: Select information for generating
                  score sheet stickers with beer 
                  information
	 Input: None
	 Output: list of values needed for beer competition
	 NOTE: Only contains beer judging fields
	 =============================================
	 */
	SELECT 
	b.id, b.brewJudgingNumber, b.brewName, b.brewCategorySort, b.brewSubCategory, b.brewStyle
	, b.brewInfo, b.brewComments, b.brewOther, f.flightTable, t.tableName
	FROM steincha_bcome.bcoem_judging_flights f
	INNER JOIN steincha_bcome.bcoem_brewing b on b.id = f.flightEntryID
	INNER JOIN steincha_bcome.bcoem_judging_tables t on f.flightTable = t.id
	WHERE b.brewReceived = 1
	ORDER BY f.flightTable;
END$$
DELIMITER ;
