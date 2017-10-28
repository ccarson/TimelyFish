
CREATE PROCEDURE XDDBatchARLB_FileName_Date_Lookup
	@FileName	varchar( 80 ),
	@FileDate	smalldatetime
AS

	Declare @BatNbr	varchar(10)

	SET @FileName = rtrim(@FileName)
	
	SELECT		@BatNbr = LBBatNbr
	FROM		XDDBatchARLB (nolock)
	WHERE		CHARINDEX(@FileName, FilePathName) > 0
			and FileDate = @FileDate
	
	If @BatNbr IS NULL 		
		SELECT		@BatNbr = LBBatNbr
		FROM		XDDBatchARLBErrors (nolock)
		WHERE		CHARINDEX(@FileName, FilePathName) > 0
				and FileDate = @FileDate

	if @BatNbr IS NULL
		SET @BatNBr = ''
		
	Select @BatNbr


GO
GRANT CONTROL
    ON OBJECT::[dbo].[XDDBatchARLB_FileName_Date_Lookup] TO [MSDSL]
    AS [dbo];

