
CREATE FUNCTION PJfMask_s (@maskString VARCHAR(255), @sValue VARCHAR(255))
RETURNS VARCHAR(255)
AS
BEGIN
    -- This function and the dependent functions (PJfMask_acct, PJfMask_project, PJfMask_pjt_entity)
    -- were written to facilitate inline application of the wildcard masks in the project allocation method steps.

    -- Checks the mask for 's' characters and substitutes the appropriate character from the value parameter

    declare @ptr integer = 0
    declare @returnLength integer = case when len(@maskString) > len(@sValue) then len(@maskString) else len(@sValue) end
    -- By putting spaces and ending it with a colon (:) we force sql to keep the spaces in the varchar variable
    declare @returnString varchar(256) = space(@returnLength) + ':'

    set @maskString = @maskString + space(@returnLength - len(@maskString)) + ':'
    set @sValue = @sValue + space(@returnLength - len(@sValue)) + ':'

    -- Anyplace in the mask that has a wildcard, swap in the appropriate character in that position from the values parameters
    while @ptr < @returnLength
        select @ptr = @ptr + 1,
               @returnString = stuff(@returnString, @ptr, 1, substring(
                                    case -- NOTE: The collate tag tells it to distinquish between upper and lower case
                                      when substring(@maskString, @ptr, 1) = 's' collate SQL_Latin1_General_CP1_CS_AS
                                        then @sValue
                                      else @maskString
                                    end, @ptr, 1))

    return (left(@returnString, @returnlength))
END


GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJfMask_s] TO [MSDSL]
    AS [dbo];

