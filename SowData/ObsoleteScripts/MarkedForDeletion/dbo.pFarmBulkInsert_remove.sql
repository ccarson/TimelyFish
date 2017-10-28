CREATE PROC [dbo].[pFarmBulkInsert_remove] As
	BULK INSERT dbo.[Sow]
	   FROM '\\Saturn\ImportFiles\Sow\Sow.txt'
	   WITH 
	      (
		 DATAFILETYPE = 'char',
	         FIELDTERMINATOR = '|',
	         ROWTERMINATOR = '\n',
		 KEEPNULLS
	      )
	BULK INSERT dbo.[SowFarrowEvent]
	   FROM '\\Saturn\ImportFiles\Sow\SowFarrowEvent.txt'
	   WITH 
	      (
		 DATAFILETYPE = 'char',
	         FIELDTERMINATOR = '|',
	         ROWTERMINATOR = '\n',
		 KEEPNULLS
	      )
	BULK INSERT dbo.[SowPregExamEvent]
	   FROM '\\Saturn\ImportFiles\Sow\SowPregExamEvent.txt'
	   WITH 
	      (
		 DATAFILETYPE = 'char',
	         FIELDTERMINATOR = '|',
	         ROWTERMINATOR = '\n',
		 KEEPNULLS
	      )
	BULK INSERT dbo.[SowParity]
	   FROM '\\Saturn\ImportFiles\Sow\SowParity.txt'
	   WITH 
	      (
		 DATAFILETYPE = 'char',
	         FIELDTERMINATOR = '|',
	         ROWTERMINATOR = '\n',
		 KEEPNULLS
	      )
	BULK INSERT dbo.[SowGroupEvent]
	   FROM '\\Saturn\ImportFiles\Sow\SowGroupEvent.txt'
	   WITH 
	      (
		 DATAFILETYPE = 'char',
	         FIELDTERMINATOR = '|',
	         ROWTERMINATOR = '\n',
		 KEEPNULLS
	      )
	BULK INSERT dbo.[SowMatingEvent]
	   FROM '\\Saturn\ImportFiles\Sow\SowMatingEvent.txt'
	   WITH 
	      (
		 DATAFILETYPE = 'char',
	         FIELDTERMINATOR = '|',
	         ROWTERMINATOR = '\n',
		 KEEPNULLS
	      )
	BULK INSERT dbo.[SowLocationEvent]
	   FROM '\\Saturn\ImportFiles\Sow\SowLocationEvent.txt'
	   WITH 
	      (
		 DATAFILETYPE = 'char',
	         FIELDTERMINATOR = '|',
	         ROWTERMINATOR = '\n',
		 KEEPNULLS
	      )
	BULK INSERT dbo.[SowPigletDeathEvent]
	   FROM '\\Saturn\ImportFiles\Sow\SowPigletDeathEvent.txt'
	   WITH 
	      (
		 DATAFILETYPE = 'char',
	         FIELDTERMINATOR = '|',
	         ROWTERMINATOR = '\n',
		 KEEPNULLS
	      )
	BULK INSERT dbo.[SowFosterEvent]
	   FROM '\\Saturn\ImportFiles\Sow\SowFosterEvent.txt'
	   WITH 
	      (
		 DATAFILETYPE = 'char',
	         FIELDTERMINATOR = '|',
	         ROWTERMINATOR = '\n',
		 KEEPNULLS
	      )
	BULK INSERT dbo.[SowNurseEvent]
	   FROM '\\Saturn\ImportFiles\Sow\SowNurseEvent.txt'
	   WITH 
	      (
		 DATAFILETYPE = 'char',
	         FIELDTERMINATOR = '|',
	         ROWTERMINATOR = '\n',
		 KEEPNULLS
	      )
	BULK INSERT dbo.[SowWeanEvent]
	   FROM '\\Saturn\ImportFiles\Sow\SowWeanEvent.txt'
	   WITH 
	      (
		 DATAFILETYPE = 'char',
	         FIELDTERMINATOR = '|',
	         ROWTERMINATOR = '\n',
		 KEEPNULLS
	      )
	BULK INSERT dbo.[SowFalloutEvent]
	   FROM '\\Saturn\ImportFiles\Sow\SowFalloutEvent.txt'
	   WITH 
	      (
		 DATAFILETYPE = 'char',
	         FIELDTERMINATOR = '|',
	         ROWTERMINATOR = '\n',
		 KEEPNULLS
	      )
	BULK INSERT dbo.[SowNonServiceEvent]
	   FROM '\\Saturn\ImportFiles\Sow\SowNonServiceEvent.txt'
	   WITH 
	      (
		 DATAFILETYPE = 'char',
	         FIELDTERMINATOR = '|',
	         ROWTERMINATOR = '\n',
		 KEEPNULLS
	      )
	BULK INSERT dbo.[SowRemoveEvent]
	   FROM '\\Saturn\ImportFiles\Sow\SowRemoveEvent.txt'
	   WITH 
	      (
		 DATAFILETYPE = 'char',
	         FIELDTERMINATOR = '|',
	         ROWTERMINATOR = '\n',
		 KEEPNULLS,
		 FIRE_TRIGGERS
	      )

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[pFarmBulkInsert_remove] TO [se\analysts]
    AS [dbo];


GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[pFarmBulkInsert_remove] TO [se\analysts]
    AS [dbo];

