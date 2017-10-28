
create proc XDDARDoc_CusRef_INDMFI_D
	@CustID		varchar(15),
	@RefNbr		varchar(10)
AS
SELECT * FROM ARDoc
WHERE CustID = @CustID and DocType IN ('IN', 'DM', 'FI') and OpenDoc = 1 and RefNbr LIKE @RefNbr
ORDER BY RefNbr DESC

GO
GRANT CONTROL
    ON OBJECT::[dbo].[XDDARDoc_CusRef_INDMFI_D] TO [MSDSL]
    AS [dbo];

