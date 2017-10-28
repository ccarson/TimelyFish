
CREATE PROC checkIndividualModuleYear @Poststring VARCHAR(180)
AS
		DECLARE @return_value INT, @temp_year INT, @temp_count INT, @module VARCHAR(2), @length INT
		

	    select @length = Len(@Poststring)
	    set @return_value = 0
	    
	    
	    While @length >= 2 and @return_value <> 1
	    Begin
	    
	    --Get 2 letter module ID--
	    select @module = SUBSTRING(@Poststring,1,2)
	    
	   	--Take first module ID out of the string--    
	    IF @length > 2
	    BEGIN
			SET @length = @length - 3
			SET @Poststring = Right(@Poststring, @length)
	    END
		ELSE IF @length <= 2
	    BEGIN
			SET @length = 0
	    END
	    
			--Test to see if there is an unreleased batch in Prior Years--
	    	SELECT @return_value = 0
			EXEC @temp_year = getModulePeriod @Module, 0
			SELECT @temp_year = @temp_year/100
			EXEC @temp_count = checkModuleYear @Module, @temp_year, 0 
			IF @temp_count > 0
			SELECT @return_value = 1
						
			
	    End
			SELECT @return_value

GO
GRANT CONTROL
    ON OBJECT::[dbo].[checkIndividualModuleYear] TO [MSDSL]
    AS [dbo];

