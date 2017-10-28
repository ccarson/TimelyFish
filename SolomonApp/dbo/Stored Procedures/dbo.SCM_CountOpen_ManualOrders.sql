 CREATE PROC SCM_CountOpen_ManualOrders
	@CpnyID		VARCHAR(10)
AS
	SELECT COUNT(DISTINCT ordnbr)
		FROM soheader JOIN sotype ON (soheader.sotypeid=sotype.sotypeid)
		WHERE soheader.status = 'O'
		and sotype.behavior = 'MO'
		and soheader.cpnyid = @CpnyId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SCM_CountOpen_ManualOrders] TO [MSDSL]
    AS [dbo];

