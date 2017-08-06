DELIMITER $$
CREATE DEFINER=`<<user name>>`@`<<ip>>` PROCEDURE `MidwestHomeBrewerOfYearReport`()
BEGIN

/* MWHBOY Reporting */
SELECT  `brewing`.`id` ,  `brewName` ,  `brewStyle` 
,  `brewCategory` ,  `brewCategorySort` ,  `brewSubCategory` , judging_tables.id tableNumber, judging_tables.tableName
,`brewBrewerFirstName` ,  `brewBrewerLastName` ,  `brewCoBrewer` 
, `judging_scores`.`scorePlace` AS  'Place'
,  `judging_scores_bos`.`scorePlace` AS  'BOSPlace'
FROM  `bcoem_brewing` brewing
LEFT JOIN  `bcoem_judging_scores` judging_scores ON  `brewing`.`id` =  `judging_scores`.`eid` 
LEFT JOIN  `bcoem_judging_scores_bos` judging_scores_bos ON  `brewing`.`id` =  `judging_scores_bos`.`eid` 
LEFT JOIN bcoem_judging_tables judging_tables on judging_tables.id = judging_scores.scoreTable

Where `brewReceived` = 1 AND `brewPaid` = 1
Order by judging_tables.id;

END$$
DELIMITER ;
