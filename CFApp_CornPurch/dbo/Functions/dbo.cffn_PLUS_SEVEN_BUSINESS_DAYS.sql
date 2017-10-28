-- ===================================================================
-- Author:  Sergey Neskin
-- Create date: 10/03/2008
-- Description: Plus Seven Business Days
-- ===================================================================
CREATE FUNCTION [dbo].[cffn_PLUS_SEVEN_BUSINESS_DAYS] (
  @Date datetime
) 
RETURNS datetime
AS

BEGIN

	DECLARE @increment int
	SET @increment = 0

	SELECT @increment =
	 CASE (DATEPART(WEEKDAY, @Date)+@@DATEFIRST)%7
	  WHEN 2 THEN 9 -- Monday
	  WHEN 3 THEN 9 -- Tuesday
	  WHEN 4 THEN 9 -- Wednesday
	  WHEN 5 THEN 9 -- Thursday
	  WHEN 6 THEN 11 -- Friday
	 END
  

  SELECT @Date = DATEADD(day, @increment - 1, @Date)

  RETURN @Date

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cffn_PLUS_SEVEN_BUSINESS_DAYS] TO [db_sp_exec]
    AS [dbo];

