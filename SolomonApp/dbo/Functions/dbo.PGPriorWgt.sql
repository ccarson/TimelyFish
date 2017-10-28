
/****** Object:  User Defined Function dbo.PGPriorWgt    Script Date: 12/8/2005 4:49:26 PM ******/
CREATE  FUNCTION dbo.PGPriorWgt
(
      @Gender VARCHAR(6), @PriorFeed FLOAT
)

RETURNS FLOAT
AS
BEGIN

DECLARE @A FLOAT
DECLARE @B FLOAT
DECLARE @C FLOAT
DECLARE @Send FLOAT
SET @Send = 0



IF @Gender='B' or @Gender='BARROW' or @Gender='BOAR'
	BEGIN
		SET @A= 0.0054
		SET @B = 1.1052
		SET @C = -7.7576

	END
ELSE IF @Gender ='G' or @Gender='M'
	BEGIN
		SET @A= 0.0054
		SET @B = 1.1052
		SET @C = -7.7576
	END	
ELSE
	BEGIN
		SET @A= 0
		SET @B = 0
		SET @C = 0
	END

	SET @Send = (SQRT((@B * @B) - (4*@A*@C) + (4*@A*@PriorFeed))-@B)/ (2 * @A)



RETURN @Send

END










