 CREATE PROCEDURE DMG_SOSched_RowNbr
	@CpnyID		varchar(10),
	@OrdNbr		varchar(15),
	@LineRef	varchar(5),
	@SchedRef	varchar(5)
AS
	SELECT	COUNT (*)
	FROM	SOSched (NOLOCK)
	WHERE	CpnyID = @CpnyID
	  AND	OrdNbr = @OrdNbr
	  AND 	(LineRef < @LineRef OR (LineRef = @LineRef AND SchedRef <= @SchedRef))



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_SOSched_RowNbr] TO [MSDSL]
    AS [dbo];

