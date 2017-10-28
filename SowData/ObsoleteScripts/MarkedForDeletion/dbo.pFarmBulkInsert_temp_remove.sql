
CREATE PROC [dbo].[pFarmBulkInsert_temp_remove] As
	BULK INSERT dbo.[Sow]
	   FROM 'C:\temp\PigChamp\Sow.txt'
	   WITH 
	      (
		 DATAFILETYPE = 'char',
	         FIELDTERMINATOR = '|',
	         ROWTERMINATOR = '\n',
		 KEEPNULLS
	      )
	BULK INSERT dbo.[SowFarrowEvent]
	   FROM 'C:\temp\PigChamp\SowFarrowEvent.txt'
	   WITH 
	      (
		 DATAFILETYPE = 'char',
	         FIELDTERMINATOR = '|',
	         ROWTERMINATOR = '\n',
		 KEEPNULLS
	      )
	BULK INSERT dbo.[SowPregExamEvent]
	   FROM 'C:\temp\PigChamp\SowPregExamEvent.txt'
	   WITH 
	      (
		 DATAFILETYPE = 'char',
	         FIELDTERMINATOR = '|',
	         ROWTERMINATOR = '\n',
		 KEEPNULLS
	      )
	BULK INSERT dbo.[SowParity]
	   FROM 'C:\temp\PigChamp\SowParity.txt'
	   WITH 
	      (
		 DATAFILETYPE = 'char',
	         FIELDTERMINATOR = '|',
	         ROWTERMINATOR = '\n',
		 KEEPNULLS
	      )
	BULK INSERT dbo.[SowGroupEvent]
	   FROM 'C:\temp\PigChamp\SowGroupEvent.txt'
	   WITH 
	      (
		 DATAFILETYPE = 'char',
	         FIELDTERMINATOR = '|',
	         ROWTERMINATOR = '\n',
		 KEEPNULLS
	      )
	BULK INSERT dbo.[SowMatingEvent]
	   FROM 'C:\temp\PigChamp\SowMatingEvent.txt'
	   WITH 
	      (
		 DATAFILETYPE = 'char',
	         FIELDTERMINATOR = '|',
	         ROWTERMINATOR = '\n',
		 KEEPNULLS
	      )
	BULK INSERT dbo.[SowLocationEvent]
	   FROM 'C:\temp\PigChamp\SowLocationEvent.txt'
	   WITH 
	      (
		 DATAFILETYPE = 'char',
	         FIELDTERMINATOR = '|',
	         ROWTERMINATOR = '\n',
		 KEEPNULLS
	      )
	BULK INSERT dbo.[SowPigletDeathEvent]
	   FROM 'C:\temp\PigChamp\SowPigletDeathEvent.txt'
	   WITH 
	      (
		 DATAFILETYPE = 'char',
	         FIELDTERMINATOR = '|',
	         ROWTERMINATOR = '\n',
		 KEEPNULLS
	      )
/*	BULK INSERT dbo.[SowFosterEvent]
	   FROM 'C:\temp\PigChamp\SowFosterEvent.txt'
	   WITH 
	      (
		 DATAFILETYPE = 'char',
	         FIELDTERMINATOR = '|',
	         ROWTERMINATOR = '\n',
		 KEEPNULLS
	      )*/
	BULK INSERT dbo.[SowNurseEvent]
	   FROM 'C:\temp\PigChamp\SowNurseEvent.txt'
	   WITH 
	      (
		 DATAFILETYPE = 'char',
	         FIELDTERMINATOR = '|',
	         ROWTERMINATOR = '\n',
		 KEEPNULLS
	      )
	BULK INSERT dbo.[SowWeanEvent]
	   FROM 'C:\temp\PigChamp\SowWeanEvent.txt'
	   WITH 
	      (
		 DATAFILETYPE = 'char',
	         FIELDTERMINATOR = '|',
	         ROWTERMINATOR = '\n',
		 KEEPNULLS
	      )
	BULK INSERT dbo.[SowFalloutEvent]
	   FROM 'C:\temp\PigChamp\SowFalloutEvent.txt'
	   WITH 
	      (
		 DATAFILETYPE = 'char',
	         FIELDTERMINATOR = '|',
	         ROWTERMINATOR = '\n',
		 KEEPNULLS
	      )
	BULK INSERT dbo.[SowNonServiceEvent]
	   FROM 'C:\temp\PigChamp\SowNonServiceEvent.txt'
	   WITH 
	      (
		 DATAFILETYPE = 'char',
	         FIELDTERMINATOR = '|',
	         ROWTERMINATOR = '\n',
		 KEEPNULLS
	      )
	BULK INSERT dbo.[SowRemoveEvent]
	   FROM 'C:\temp\PigChamp\SowRemoveEvent.txt'
	   WITH 
	      (
		 DATAFILETYPE = 'char',
	         FIELDTERMINATOR = '|',
	         ROWTERMINATOR = '\n',
		 KEEPNULLS,
		 FIRE_TRIGGERS
	      )

