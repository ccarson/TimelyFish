 CREATE PROCEDURE DMG_SOLine_COIS
	@CpnyID		varchar(10),
	@OrdNbr		varchar(15),
	@InvtIDParm	varchar(30),
	@SiteIDParm	varchar(10)
AS
	SELECT *
	FROM SOLine
	WHERE CpnyID = @CpnyID
	   AND OrdNbr = @OrdNbr
	   AND	InvtID like @InvtIDParm
	   AND	SiteID like @SiteIDParm
	ORDER BY CpnyID,
	   OrdNbr,
	   LineRef



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_SOLine_COIS] TO [MSDSL]
    AS [dbo];

