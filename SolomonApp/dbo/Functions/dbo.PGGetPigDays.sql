
/****** Object:  User Defined Function dbo.PGGetPigDays    Script Date: 3/7/2005 3:42:51 PM ******/

CREATE   FUNCTION [dbo].[PGGetPigDays]
(@PigGroupID AS VARCHAR(5), @DateE AS smalldatetime, @DateB AS smalldatetime)


RETURNS DECIMAL(8,2)
AS
BEGIN
DECLARE @Days AS Decimal(5,0)
DECLARE @DaysTotal AS Decimal(8,0)
DECLARE @DayT AS smalldatetime

SET @Days = 0
SET @DaysTotal = 0
SET @DayT = @DateB

While @DayT <> @DateE
	BEGIN
		SET @Days = (SELECT sum(tr.InvEffect*tr.Qty) FROM dbo.cftPGInvTran tr Where PigGroupID=@PigGroupID AND tr.Reversal<>'1' AND tr.trandate <=@DayT)
		
		SET @DaysTotal = @DaysTotal + @Days
		SET @DayT=DateAdd(day,1,@DayT)
        END
RETURN @DaysTotal

END




GO
GRANT CONTROL
    ON OBJECT::[dbo].[PGGetPigDays] TO [MSDSL]
    AS [dbo];

