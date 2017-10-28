
create proc XDDARDoc_RefNbr_INDMFI_D
	@RefNbr		varchar(10)
AS
SELECT * FROM ARDoc WHERE DocType IN ('IN', 'DM', 'FI') and OpenDoc = 1 and RefNbr LIKE @RefNbr ORDER BY RefNbr DESC

GO
GRANT CONTROL
    ON OBJECT::[dbo].[XDDARDoc_RefNbr_INDMFI_D] TO [MSDSL]
    AS [dbo];

