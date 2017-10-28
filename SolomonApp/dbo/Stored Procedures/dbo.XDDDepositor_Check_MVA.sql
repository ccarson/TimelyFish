
CREATE PROCEDURE XDDDepositor_Check_MVA
AS
	SELECT 	convert(smallint,count(*)) from xdddepositor D1
	WHERE	(SELECT count(*) from xdddepositor D2 where D2.VendID = D1.VendID) > 1

GO
GRANT CONTROL
    ON OBJECT::[dbo].[XDDDepositor_Check_MVA] TO [MSDSL]
    AS [dbo];

