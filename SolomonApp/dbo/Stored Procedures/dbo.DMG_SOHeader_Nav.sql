 CREATE PROCEDURE DMG_SOHeader_Nav
	@CpnyID varchar(10),
	@OrdNbr varchar(15)
AS
	SELECT *
	FROM SOHeader
	WHERE CpnyID = @CpnyID
	   AND OrdNbr LIKE @OrdNbr
	ORDER BY OrdNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_SOHeader_Nav] TO [MSDSL]
    AS [dbo];

