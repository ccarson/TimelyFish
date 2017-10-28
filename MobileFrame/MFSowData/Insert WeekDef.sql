USE [MobileFrame]
GO

INSERT INTO [dbo].[CFT_WEEKDEFINITION]
           ([ID]
           ,[FISCALPERIOD]
           ,[FISCALYEAR]
           ,[PICWEEK]
           ,[PICYEAR]
           ,[WEEKENDDATE]
           ,[WEEKOFDATE]
           ,[GROUPNAME])

          
SELECT NewID()
	  ,[FiscalPeriod]
      ,[FiscalYear]
      ,[PICWeek]
      ,[PICYear]
      ,[WeekEndDate]
      ,[WeekOfDate]
	  ,RIGHT(CAST([PICYear] AS VARCHAR(4)),2) +  RIGHT('00'+CAST([PICWEEK] AS VARCHAR(2)),2)
      
      
  FROM [SolomonApp].[dbo].[cftWeekDefinition]



