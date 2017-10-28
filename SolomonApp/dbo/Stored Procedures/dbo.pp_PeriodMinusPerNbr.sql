 CREATE PROC pp_PeriodMinusPerNbr @period VarChar(6), @PerToSub INT, @OutPerNbr VarChar(6) OUTPUT
AS
DECLARE @NumPerNbr INT, @NumYr INT, @WholeYr INT, @Remain INT
    SET @NumYR = CONVERT(INT,SUBSTRING(@Period,1,4))
    SET @NumPerNbr = CONVERT(INT,SUBSTRING(@Period,5,2))

SELECT @WholeYr = CONVERT(INT,@PerToSub / NbrPer) ,@Remain =  @PerToSub % NbrPer  FROM GLSETUP (NOLOCK)

IF @Remain >= @NumPerNbr
   BEGIN
      SELECT @NumYr = @NumYr - @WholeYr - 1
      SELECT @NumPerNbr = @NumPerNbr + NbrPer - @Remain
        FROM GLSETUP (NOLOCK)
   END
ELSE
   BEGIN
      SELECT @NumPerNbr = @NumPerNbr - @Remain
      SELECT @NumYr     = @NumYr     - @WholeYr
   END

SELECT @OutPerNbr = CONVERT(VARCHAR(6),(@NumYr*100 + @NumPerNbr))



GO
GRANT CONTROL
    ON OBJECT::[dbo].[pp_PeriodMinusPerNbr] TO [MSDSL]
    AS [dbo];

