
-- ===================================================================
-- Author:	Brian Diehl
-- Create date: 11/06/2011
-- Description:	Parses a delimited string and returns a string with each token in parenthesis and separated by commas
-- ===================================================================
CREATE FUNCTION [dbo].[cff_IN_STRING_SPLIT] (
  @DelimitedList varchar(8000),
  @Delimiter char  
) 
RETURNS varchar(4000)
AS

BEGIN
  DECLARE @intDelimiterPos int 
  DECLARE @First int
  DECLARE @strListValue varchar(1000)
  DECLARE @ValList varchar(4000)

  SET @First = 0
  IF LEN(LTRIM(RTRIM(@DelimitedList))) > 0
  BEGIN
    SET @ValList = ''''
    SET @First = 1
    
    SET @DelimitedList = @DelimitedList + @Delimiter

    -- parse the list...
    WHILE PATINDEX('%' + @Delimiter + '%', @DelimitedList) <> 0
    BEGIN
      -- determine the location of the next delimiter...
      SELECT @intDelimiterPos = PATINDEX('%' + @Delimiter + '%', @DelimitedList)

      -- retrieve the next value...
      SELECT @strListValue = LEFT(@DelimitedList, @intDelimiterPos - 1)

      -- Append values to the list
      IF @First = 1
      BEGIN
        SET @ValList = @ValList + @strListValue
        SET @First = 0
      END
      ELSE
        SET @ValList = @ValList + ''',''' + @strListValue 
      
      -- prepare the delimited string for the next pass...
      SELECT @DelimitedList = STUFF(@DelimitedList, 1, @intDelimiterPos, '')
    END
    
    SET @ValList = @ValList + ''''
  END

  RETURN @ValList
END;



GO
GRANT CONTROL
    ON OBJECT::[dbo].[cff_IN_STRING_SPLIT] TO [MSDSL]
    AS [dbo];

