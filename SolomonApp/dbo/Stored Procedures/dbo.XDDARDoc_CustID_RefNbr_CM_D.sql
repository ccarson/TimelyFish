
create proc XDDARDoc_CustID_RefNbr_CM_D
	@CustID		varchar(15),
	@RefNbr		varchar(10)
AS
SELECT * FROM ARDoc
WHERE CustID = @CustID and DocType = 'CM' and OpenDoc = 1 and RefNbr LIKE @RefNbr
ORDER BY RefNbr DESC

GO
GRANT CONTROL
    ON OBJECT::[dbo].[XDDARDoc_CustID_RefNbr_CM_D] TO [MSDSL]
    AS [dbo];

