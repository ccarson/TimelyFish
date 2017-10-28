
create proc XDDARDoc_RefNbr_All_D
	@RefNbr		varchar(10)
AS
SELECT * FROM ARDoc WHERE RefNbr LIKE @RefNbr ORDER BY RefNbr DESC  

GO
GRANT CONTROL
    ON OBJECT::[dbo].[XDDARDoc_RefNbr_All_D] TO [MSDSL]
    AS [dbo];

