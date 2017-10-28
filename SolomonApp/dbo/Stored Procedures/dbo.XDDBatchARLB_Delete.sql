
CREATE PROCEDURE XDDBatchARLB_Delete
	@BatNbr		varchar( 10 ),
	@FileName	varchar( 80 ),
	@FileDate	smalldatetime
AS

	SET @FileName = rtrim(@FileName)
	
	if @FileName = ''
	BEGIN

		-- Deleting Whole Batch
		-- Delete from Applic first, so it can relate batch to Payments (XDDBatchARLB)
		DELETE		XDDBatchARLBApplic
		FROM		XDDBatchARLBApplic LEFT OUTER JOIN XDDBatchARLB
				ON XDDBatchARLBApplic.PmtRecordID = XDDBatchARLB.RecordID
		WHERE		XDDBatchARLB.LBBatNbr = @BatNbr
	
		DELETE	
		FROM		XDDBatchARLB
		WHERE		LBBatNbr = @BatNbr
				
		DELETE	
		FROM		XDDBatchARLBErrors
		WHERE		LBBatNbr = @BatNbr
	
	END
	else
	BEGIN
		-- Delete from Applic first, so it can relate batch to Payments (XDDBatchARLB)
		DELETE		XDDBatchARLBApplic
		FROM		XDDBatchARLBApplic LEFT OUTER JOIN XDDBatchARLB
				ON XDDBatchARLBApplic.PmtRecordID = XDDBatchARLB.RecordID
		WHERE		XDDBatchARLB.LBBatNbr = @BatNbr
				and CHARINDEX(@FileName, XDDBatchARLB.FilePathName) > 0
				and XDDBatchARLB.FileDate = @FileDate
	
		DELETE	
		FROM		XDDBatchARLB
		WHERE		LBBatNbr = @BatNbr
				and CHARINDEX(@FileName, FilePathName) > 0
				and FileDate = @FileDate
				
		DELETE	
		FROM		XDDBatchARLBErrors
		WHERE		LBBatNbr = @BatNbr
				and CHARINDEX(@FileName, FilePathName) > 0
				and FileDate = @FileDate
	END

GO
GRANT CONTROL
    ON OBJECT::[dbo].[XDDBatchARLB_Delete] TO [MSDSL]
    AS [dbo];

