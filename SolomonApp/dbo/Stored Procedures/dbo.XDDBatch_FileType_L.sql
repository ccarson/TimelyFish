

CREATE PROCEDURE XDDBatch_FileType_L
	@BatNbr		varchar(10)
	
AS
	SELECT		*
	FROM		XDDBatch
	WHERE		FileType = 'L'
			and BatNbr LIKE @BatNbr
	ORDER BY	BatNbr Desc


GO
GRANT CONTROL
    ON OBJECT::[dbo].[XDDBatch_FileType_L] TO [MSDSL]
    AS [dbo];

