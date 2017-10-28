
/****** Object:  User Defined Function dbo.GetWeekofdate    Script Date: 4/13/2005 10:25:09 AM ******/

/****** Object:  User Defined Function dbo.GetWeekofdate   ******/

CREATE     FUNCTION [dbo].[GetWeekofdate]
(@DateB AS smalldatetime)


RETURNS smalldatetime
AS
BEGIN
DECLARE @DaysW AS smalldatetime
DECLARE @DayT AS smalldatetime
DECLARE @Days AS Decimal(5,0)

SET @DayT = @DateB
SET @Days = DatePart(dw,@DayT)
		IF @Days = 7 
			BEGIN
			SET @DaysW = @DayT
			END
		ELSE
			BEGIN
			SET @Days = - @Days + 1
			SET @DaysW = DATEADD(day, @Days, @DayT)
			END
RETURN @DaysW

END






GO
GRANT CONTROL
    ON OBJECT::[dbo].[GetWeekofdate] TO [MSDSL]
    AS [dbo];

