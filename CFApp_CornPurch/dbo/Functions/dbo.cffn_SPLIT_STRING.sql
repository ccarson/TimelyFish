-- ===================================================================
-- Author:	Andrew Derco
-- Create date: 10/03/2008
-- Description:	Parses a delimited string and returns a table of the values.
-- ===================================================================
CREATE FUNCTION [dbo].[cffn_SPLIT_STRING] (
  @DelimitedList varchar(8000),
  @Delimiter char  
) 
RETURNS @tblListValues table (Value varchar(100))
AS

BEGIN
  DECLARE @intDelimiterPos int 
  DECLARE @strListValue varchar(1000)

  IF LEN(LTRIM(RTRIM(@DelimitedList))) > 0
  BEGIN
    SET @DelimitedList = @DelimitedList + @Delimiter

    -- parse the list...
    WHILE PATINDEX('%' + @Delimiter + '%', @DelimitedList) <> 0
    BEGIN
      -- determine the location of the next delimiter...
      SELECT @intDelimiterPos = PATINDEX('%' + @Delimiter + '%', @DelimitedList)

      -- retrieve the next value...
      SELECT @strListValue = LEFT(@DelimitedList, @intDelimiterPos - 1)

      -- insert the extracted value into the return table...
      INSERT @tblListValues VALUES (@strListValue)

      -- prepare the delimited string for the next pass...
      SELECT @DelimitedList = STUFF(@DelimitedList, 1, @intDelimiterPos, '')
    END
  END

  RETURN
END

