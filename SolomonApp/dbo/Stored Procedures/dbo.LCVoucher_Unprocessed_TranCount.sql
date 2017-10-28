 CREATE PROCEDURE LCVoucher_Unprocessed_TranCount
	@cpnyid		VARCHAR(10),
	@apbatnbr	VARCHAR(10),
	@aplineref	CHAR(5),
	@aprefnbr	VARCHAR(10)
AS
	SELECT 	Count(*)
	FROM 	LCVoucher
	WHERE 	cpnyid = @cpnyid
	and 	apbatnbr = @apbatnbr
	and 	aplineref = @aplineref
	and	aprefnbr = @aprefnbr
	AND 	transtatus = 'U'



GO
GRANT CONTROL
    ON OBJECT::[dbo].[LCVoucher_Unprocessed_TranCount] TO [MSDSL]
    AS [dbo];

