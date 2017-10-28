Create Function [dbo].[DateAddNoSunday]
	(@number as integer, @date as smalldatetime)
RETURNS smalldatetime
AS
BEGIN
DECLARE @int as integer
DECLARE @Return as smalldatetime
SET @Return=@Date
SET @int=0
WHILE @int < @number
BEGIN
   IF datepart(dw,DateAdd(day,1,@Return))=7
      set @Return=DateAdd(day,2,@Return)
   ELSE
      set @Return=DateAdd(day,1,@Return)
set @int=@int+1
END
RETURN @Return
END
