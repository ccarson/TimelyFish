 Create Procedure DMG_SOLine_OrdNbr_LineRef1
	@CpnyID varchar(10),
	@InvtID varchar(30),
	@OrdNbr varchar(15),
    @gNoPostProject VarChar(16),
	@LineRef varchar(5)
as
     SELECT *
       FROM SOLine
      WHERE CpnyID = @CpnyID
        AND InvtID = @InvtID
        AND QtyOrd >= 0
        AND OrdNbr = @OrdNbr
        AND ProjectID <> ' ' AND ProjectID <> @gNoPostProject
        AND LineRef like @LineRef
      ORDER BY CpnyID, OrdNbr, LineRef


GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_SOLine_OrdNbr_LineRef1] TO [MSDSL]
    AS [dbo];

