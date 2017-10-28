CREATE PROC [dbo].[pFarmGroupBulkInsert_remove] As
	BULK INSERT dbo.[PCGroup]
	   FROM '\\Saturn\ImportFiles\ISO\PCGroup.txt'
	   WITH 
	      (
		 DATAFILETYPE = 'char',
	         FIELDTERMINATOR = '|',
	         ROWTERMINATOR = '\n',
		 KEEPNULLS
	      )

	BULK INSERT dbo.[PCGroupInventoryEvent]
	   FROM '\\Saturn\ImportFiles\ISO\PCGroupInventoryEvent.txt'
	   WITH 
	      (
		 DATAFILETYPE = 'char',
	         FIELDTERMINATOR = '|',
	         ROWTERMINATOR = '\n',
		 KEEPNULLS
	      )

	BULK INSERT dbo.[PCGroupEndEvent]
	   FROM '\\Saturn\ImportFiles\ISO\PCGroupEndEvent.txt'
	   WITH 
	      (
		 DATAFILETYPE = 'char',
	         FIELDTERMINATOR = '|',
	         ROWTERMINATOR = '\n',
		 KEEPNULLS,
		 FIRE_TRIGGERS    --THIS Updates PCGroup.CloseDate Field
	      )

	BULK INSERT dbo.[PCGroupGeneralEvent]
	   FROM '\\Saturn\ImportFiles\ISO\PCGroupGeneralEvent.txt'
	   WITH 
	      (
		 DATAFILETYPE = 'char',
	         FIELDTERMINATOR = '|',
	         ROWTERMINATOR = '\n',
		 KEEPNULLS
	      )

		 --FIRE_TRIGGERS  -- flag to tell SQL to fire trigger events

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[pFarmGroupBulkInsert_remove] TO [se\analysts]
    AS [dbo];


GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[pFarmGroupBulkInsert_remove] TO [se\analysts]
    AS [dbo];

