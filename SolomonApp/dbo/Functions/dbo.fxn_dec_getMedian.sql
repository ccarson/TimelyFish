

CREATE  FUNCTION [dbo].[fxn_dec_getMedian] 
     (@sstrValue VARCHAR(50))  
RETURNS DECIMAL(10,2) 
AS
	BEGIN 

		     DECLARE @pdecReturn DECIMAL(10,2)
	IF len(@sstrValue)>0 
		BEGIN
		    IF ( CHARINDEX('-', @sstrValue) > 0 )
		         BEGIN
		              SELECT @pdecReturn = CAST(SUBSTRING(@sstrValue, 1, CHARINDEX('-', @sstrValue) - 1) AS DECIMAL)
					  IF RTRIM(SUBSTRING(@sstrValue, CHARINDEX('-', @sstrValue) + 1, LEN(@sstrValue)))>''
							BEGIN
								SELECT @pdecReturn=(@pdecReturn + CAST(SUBSTRING(@sstrValue, CHARINDEX('-', @sstrValue) + 1, LEN(@sstrValue)) as DECIMAL))/2
							END
		         END
			
			
		    ELSE
		         SELECT @pdecReturn = CAST(@sstrValue AS DECIMAL)
		END
	 else
	        BEGIN 
		    Select @pdecReturn=0
		END

	 RETURN @pdecReturn
END



GO
GRANT CONTROL
    ON OBJECT::[dbo].[fxn_dec_getMedian] TO [MSDSL]
    AS [dbo];

