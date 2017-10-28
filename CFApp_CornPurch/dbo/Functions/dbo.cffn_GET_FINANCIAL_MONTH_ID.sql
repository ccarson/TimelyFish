-- ===================================================================
-- Author:  Andrew Derco
-- Create date: 10/03/2008
-- Description: Return FinacialMonthID base on the input month number
-- ===================================================================
CREATE FUNCTION [dbo].[cffn_GET_FINANCIAL_MONTH_ID] (
  @Month int
) 
RETURNS int
WITH   SCHEMABINDING 
AS

BEGIN

  DECLARE @Result int
  SELECT @Result = 
  CASE @Month
    WHEN 1 THEN 1 
    WHEN 2 THEN 1
    WHEN 3 THEN 2
    WHEN 4 THEN 2
    WHEN 5 THEN 3
    WHEN 6 THEN 3
    WHEN 7 THEN 4
    WHEN 8 THEN 4             
    WHEN 9 THEN 5
    WHEN 10 THEN 5
    WHEN 11 THEN 5
    WHEN 12 THEN 1
  END 
  RETURN @Result
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cffn_GET_FINANCIAL_MONTH_ID] TO [db_sp_exec]
    AS [dbo];

