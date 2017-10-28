 Create Procedure DMG_SOLine_InvtID_OrdNbr1
	@CpnyID varchar(10),
	@InvtID varchar(30),
    @gNoPostProject VarChar(16),
	@OrdNbr varchar(15)
as

     SELECT *
       FROM vp_SOLinePO
      WHERE CpnyID = @CpnyID
        AND InvtID = @InvtID
        AND ProjectID <> ' ' AND ProjectID <> @gNoPostProject
        AND OrdNbr LIKE @OrdNbr
      ORDER BY CpnyID, InvtID, OrdNbr


GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_SOLine_InvtID_OrdNbr1] TO [MSDSL]
    AS [dbo];

