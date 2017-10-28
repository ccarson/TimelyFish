
CREATE FUNCTION PJfMask (@maskString VARCHAR(255), @sValue VARCHAR(255), @eValue VARCHAR(255), @pValue VARCHAR(255), @tValue VARCHAR(255))
RETURNS VARCHAR(255)
AS
BEGIN
    -- This function and the dependent functions (PJfMask_cpnyid, PJfMask_gl_subacct)
    -- were written to facilitate inline application of the wildcard masks in the project allocation method steps.

    -- Checks the mask for 's', 'e', 'p', or 't' characters and substitutes the appropriate character from the appropriate value parameter

    declare @ptr integer = 0
    declare @maskLength integer = len(@maskString)
    declare @sLength integer = len(@sValue)
    declare @eLength integer = len(@eValue)
    declare @pLength integer = len(@pValue)
    declare @tLength integer = len(@tValue)
    declare @returnString varchar(255) = @maskString

    -- Anyplace in the mask that has a wildcard, swap in the appropriate character in that position from the values parameters
    while @ptr < @maskLength
        select @ptr = @ptr + 1,
                @returnString = stuff(@returnString, @ptr, 1, substring(
                                    case -- If the value parameter is not long enough don't use it (matches the PAPRO50.bas.vb maskSubAcct() sub)
                                        -- NOTE: The collate tag tells it to distinquish between upper and lower case
                                      when @sLength >= @ptr and (substring(@maskString, @ptr, 1) = 's' collate SQL_Latin1_General_CP1_CS_AS)
                                        then @sValue
                                      when @eLength >= @ptr and (substring(@maskString, @ptr, 1) = 'e' collate SQL_Latin1_General_CP1_CS_AS)
                                        then @eValue
                                      when @pLength >= @ptr and (substring(@maskString, @ptr, 1) = 'p' collate SQL_Latin1_General_CP1_CS_AS)
                                        then @pValue
                                      when @tLength >= @ptr and (substring(@maskString, @ptr, 1) = 't' collate SQL_Latin1_General_CP1_CS_AS)
                                        then @tValue
                                      else @maskString
                                    end, @ptr, 1))
    return (@returnString)
END


GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJfMask] TO [MSDSL]
    AS [dbo];

