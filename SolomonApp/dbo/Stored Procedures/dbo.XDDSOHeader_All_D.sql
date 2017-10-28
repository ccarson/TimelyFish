
create proc XDDSOHeader_All_D
	@OrdNbr		varchar(15)
AS
SELECT * FROM SOHeader  
WHERE OrdNbr LIKE @OrdNbr  
ORDER BY OrdNbr DESC  

GO
GRANT CONTROL
    ON OBJECT::[dbo].[XDDSOHeader_All_D] TO [MSDSL]
    AS [dbo];

