 CREATE PROCEDURE Physical_Invt_QtyTotal
	@PIID VarChar(10)

AS
 Select Sum(Physqty)
	From PIDetail
	Where PIDetail.PIID = @PIID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Physical_Invt_QtyTotal] TO [MSDSL]
    AS [dbo];

