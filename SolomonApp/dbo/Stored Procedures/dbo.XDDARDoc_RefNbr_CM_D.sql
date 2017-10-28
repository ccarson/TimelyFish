create proc XDDARDoc_RefNbr_CM_D
	@RefNbr		varchar(10)
AS
SELECT * FROM ARDoc WHERE DocType = 'CM' and OpenDoc = 1 and RefNbr LIKE @RefNbr ORDER BY RefNbr DESC

GO
GRANT CONTROL
    ON OBJECT::[dbo].[XDDARDoc_RefNbr_CM_D] TO [MSDSL]
    AS [dbo];

