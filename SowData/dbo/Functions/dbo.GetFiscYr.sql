CREATE FUNCTION [dbo].[GetFiscYr] 
     (@InputDate as smalldatetime)  
RETURNS SMALLINT
AS
	BEGIN 
		DECLARE @FiscYr smallint
		SET @FiscYr = (Select FiscalYear From [$(CentralData)].dbo.FiscalPeriodDefinition Where @InputDate Between BeginDate and EndDate)  -- removed the earth reference 20130905 smr saturn retirement
		RETURN @FiscYr
	END
