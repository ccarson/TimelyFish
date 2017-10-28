
CREATE PROCEDURE XDDBatchARLBApplic_DocType_RefNbr
	@PmtRecordID	int,
	@DocType	varchar(2),
	@RefNbr		varchar(10)
	
AS
	SELECT		*
	FROM		XDDBatchARLBApplic (nolock)
	WHERE		PmtRecordID = @PmtRecordID
			and DocType = @DocType
			and RefNbr = @RefNbr

GO
GRANT CONTROL
    ON OBJECT::[dbo].[XDDBatchARLBApplic_DocType_RefNbr] TO [MSDSL]
    AS [dbo];

