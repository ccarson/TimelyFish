 Create Proc SCM_1052_AvgCst_SiteUpdt
	@ComputerName	Varchar(21),		-- Computer Name
	@CpnyID		Varchar(10),		-- Company ID
        @ScrnNbr 	Varchar (8),         	-- Prog_Name
        @UserName	Varchar (10),        	-- User_Name
        @DirAmt         Float,               	-- Direct Amount
        @DirPct         Float,               	-- Direct Percent
	@DirBox		VarChar (1),		-- Direct Box
        @DecPlPrcCst    SmallInt,
	@PendingDate	Smalldatetime

As
/*
	Update ItemSite for AvgCst...

	Returns:	@True = 1	The procedure executed properly.
			@False = 0	An error occurred.
*/

	Declare	@SQLErrNbr	SmallInt
	Select	@SQLErrNbr	= 0

	Declare	@True		Bit,
		@False		Bit
	Select	@True 		= 1,
		@False 		= 0

SET NOCOUNT ON

UPDATE ItemSite SET

	PDirStdCst = Case When AvgCost <> 0 and @DirBox = '1'
                          Then Case When @Dirpct <> 0
				    Then Case When Round((AvgCost * (1 + (@Dirpct/100))), @DecPlPrcCst) < 0
					      Then 0
					      Else Round((AvgCost * (1 + (@Dirpct/100))), @DecPlPrcCst)
					 End	 -- Neg val chk
				    Else Case When Round((AvgCost + @DirAmt), @DecPlPrcCst) < 0
					      Then 0
					      Else Round((AvgCost + @DirAmt), @DecPlPrcCst)
					 End	 -- Neg val chk
			       End
			  Else PDirStdCst /* AvgCost = 0 or @DirBox <> '1' */
                     End,
	        PStdCst =   (Case When AvgCost <> 0 and @DirBox = '1'
                           Then Case When @Dirpct <> 0
                                     Then Case When Round((AvgCost * (1 + (@Dirpct/100))), @DecPlPrcCst) < 0
					        Then 0
						Else Round((AvgCost * (1 + (@Dirpct/100))), @DecPlPrcCst)
					  End -- Neg val chk
                                     Else Case When Round((AvgCost + @DirAmt), @DecPlPrcCst) < 0
						Then 0
						Else Round((AvgCost + @DirAmt), @DecPlPrcCst)
					  End -- Neg val chk
                                 End
			   Else PStdCst /* AvgCost = 0 or @DirBox <> '1' */
                     End) + (PFOvhStdCst + PVOvhStdCst),

	PStdCostDate = @PendingDate,

	LUpd_DateTime = GetDate(),
        LUpd_Prog = @ScrnNbr,
        LUpd_User = @UserName

FROM 	ItemSite, IN10520_Wrk
WHERE 	ItemSite.InvtId = IN10520_Wrk.InvtId
  And 	IN10520_Wrk.ComputerName = @ComputerName
  And	ItemSite.CpnyID = @CpnyID

	Select @SQLErrNbr = @@Error
	If @SQLErrNbr <> 0
	Begin
		Goto Abort
	End

Goto Finish

Abort:
	Return @False

Finish:
	Return @True



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SCM_1052_AvgCst_SiteUpdt] TO [MSDSL]
    AS [dbo];

