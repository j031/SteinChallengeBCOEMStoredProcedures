DELIMITER $$
CREATE DEFINER=`<<db user>>`@`<<ip>>` PROCEDURE `InterestingFactsForAwards`()
BEGIN
/*
	 =============================================
	 Author:      Joel Taylor
	 Description: Get a list of facts to be action
                  announced during the awards 
                  ceremony.
	 Input: None
	 Output: 
		 1. # of entrants by state 
		 2. # of entries by state
		 3. Avg Number of entries per entrant
	 
	 =============================================
	 */

	 
	/*DROP table IF EXISTS tmpEntries;*/

	CREATE TEMPORARY TABLE tmpEntries(
		Id int NOT NULL AUTO_INCREMENT
		, EntrantId int
		, EntryId int
		, Recieved bit
		, State varchar(2)
		, PRIMARY KEY (Id)
	 );
	 
	 CREATE  INDEX brewerid ON tmpEntries(EntrantId);  
	 
	 /*DROP table IF EXISTS tmpEntrants;*/
     
	  CREATE TEMPORARY TABLE tmpEntrants(
		Id int NOT NULL AUTO_INCREMENT
		, EntrantId int
		, State varchar(2)
		, PRIMARY KEY (Id)
	 );
	 
	 CREATE  INDEX brewerid ON tmpEntrants(EntrantId);  
	 
	 
	 INSERT INTO tmpEntries (EntrantId, EntryId, Recieved, State)
	 /* values */
	   (  SELECT brewer.id, beer.id, brewReceived, brewer.brewerState
		  FROM bcoem_brewer as brewer
		  INNER JOIN bcoem_brewing as beer on brewer.id = beer.brewBrewerId
		);
	  
	 INSERT INTO tmpEntrants (EntrantId, State) 
	 /* values */ 
		( SELECT distinct e.EntrantId, e.State
		  FROM tmpEntries e
		  Where e.Recieved=1
		);
	  
	  /* Entrants by state */
	  Select Count(e.State) Entrants, e.State 
	  from tmpEntrants e 
	  group by e.State
	  order by Count(e.State) desc;
		
	  /* Entries by state */
	  Select Count(e.State) Entries, e.State
	  from tmpEntries as e
	  where e.Recieved = 1
	   group by e.State
	  order by Count(e.State) desc;
	  
	  /* Entries per entrant */
	 set @TotalEntries = (select Count(*) from tmpEntries where Recieved = 1);
	 set @TotalEntrants = (select Count(*) from tmpEntrants);

	 select @TotalEntries;
	 select @TotalEntrants;
	 select (@TotalEntries/@TotalEntrants);
  
END$$
DELIMITER ;
