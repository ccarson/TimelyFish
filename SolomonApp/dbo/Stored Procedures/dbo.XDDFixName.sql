
CREATE PROCEDURE XDDFixName
	@VendName	varchar(60),
	@VendNameOut	varchar(60) OUTPUT
AS

    	declare @TildeIndex		tinyint

	-- Berge~Karen                                                 
	SET @TildeIndex = CharIndex('~', @VendName)
	if @TildeIndex > 0
		SET @VendNameOut = Substring(@VendName, @TildeIndex + 1,  len(@VendName) - @TildeIndex) + ' ' + left(@VendName, @TildeIndex-1)
	else
		SET @VendNameOut = @VendName

GO
GRANT CONTROL
    ON OBJECT::[dbo].[XDDFixName] TO [MSDSL]
    AS [dbo];

