 Create Proc SCM_1052_PendCst_SiteUpdt
	@ComputerName	Varchar(21),		-- Computer Name
	@CpnyID		Varchar(10),		-- Company ID
        @ScrnNbr 	Varchar (8),         	-- Prog_Name
        @UserName	Varchar (10),        	-- User_Name
        @DirAmt         Float,               	-- Direct Amount
        @FixAmt         Float,               	-- Fixed Amount
        @VarAmt         Float,               	-- Variable Amount
        @DirPct         Float,               	-- Direct Percent
        @FixPct         Float,               	-- Fixed Percent
        @VarPct         Float,               	-- Variance Percent
        @DecPlPrcCst    SmallInt,
	@PendingDate	Smalldatetime

As
/*
	Update Site for Std Cost...
	Returns:	@True = 1	The procedure executed properly.
			@False = 0	An error occurred.
*/

	Declare	@SQLErrNbr	SmallInt
	Select	@SQLErrNbr	= 0

	Declare	@True		Bit,
		@False		Bit
	Select	@True 		= 1,
		@False 		= 0

	Set	NoCount On

UPDATE ItemSite SET

	PDirStdCst = Case When @DirAmt <> 0
                          Then Case When Round((PDirStdCst + @DirAmt), @DecPlPrcCst) < 0
				    Then 0
				    Else Round((PDirStdCst + @DirAmt), @DecPlPrcCst)
			       End
                          Else Case When PDirStdCst <> 0 and @Dirpct <> 0
                                    Then Case When Round((PDirStdCst * (1 + (@Dirpct/100))), @DecPlPrcCst) < 0
					      Then 0
					      Else Round((PDirStdCst * (1 + (@Dirpct/100))), @DecPlPrcCst)
					 End
                                    Else PDirStdCst
                               End
                     End,
        PFOvhStdCst = Case When @FixAmt <> 0
                                  Then Case When Round((PFOvhStdCst + @FixAmt), @DecPlPrcCst) < 0
					    Then 0
					    Else Round((PFOvhStdCst + @FixAmt), @DecPlPrcCst)
					End
                                  Else Case When PFOvhStdCst <> 0 and @Fixpct <> 0
                                            Then Case When Round((PFOvhStdCst * (1 + (@Fixpct/100))), @DecPlPrcCst) < 0
						      Then 0
						      Else Round((PFOvhStdCst * (1 + (@Fixpct/100))), @DecPlPrcCst)
						 End
                                            Else PFOvhStdCst
                                       End
                             End,
        PVOvhStdCst = Case When @VarAmt <> 0
                           Then Case When Round((PVOvhStdCst + @VarAmt), @DecPlPrcCst) < 0
				     Then 0
				     Else Round((PVOvhStdCst + @VarAmt), @DecPlPrcCst)
				End
                           Else Case When PVOvhStdCst <> 0 and @Varpct <> 0
                                     Then Case When Round((PVOvhStdCst * (1 + (@Varpct/100))), @DecPlPrcCst) < 0
						Then 0
						Else Round((PVOvhStdCst * (1 + (@Varpct/100))), @DecPlPrcCst)
					  End
                                     Else PVOvhStdCst
                                End
                           End,
        PStdCst =    (Case When @DirAmt <> 0
                           Then Case When Round((PDirStdCst + @DirAmt), @DecPlPrcCst) < 0
				     Then 0
				     Else Round((PDirStdCst + @DirAmt), @DecPlPrcCst)
				End
                           Else Case When PDirStdCst <> 0 and @Dirpct <> 0
                                     Then Case When Round((PDirStdCst * (1 + (@Dirpct/100))), @DecPlPrcCst) < 0
						Then 0
						Else Round((PDirStdCst * (1 + (@Dirpct/100))), @DecPlPrcCst)
					  End
                                     Else PDirStdCst
                                End
                      End)
                   + (Case When @FixAmt <> 0
                           Then Case When Round((PFOvhStdCst + @FixAmt), @DecPlPrcCst) < 0
				     Then 0
				     Else Round((PFOvhStdCst + @FixAmt), @DecPlPrcCst)
				End
                           Else Case When PFOvhStdCst <> 0 and @Fixpct <> 0
                                     Then Case When Round((PFOvhStdCst * (1 + (@Fixpct/100))), @DecPlPrcCst) < 0
						Then 0
						Else Round((PFOvhStdCst * (1 + (@Fixpct/100))), @DecPlPrcCst)
					  End
                                     Else PFOvhStdCst
                                End
                      End)
                   + (Case When @VarAmt <> 0
                           Then Case When Round((PVOvhStdCst + @VarAmt), @DecPlPrcCst) < 0
				     Then 0
				     Else Round((PVOvhStdCst + @VarAmt), @DecPlPrcCst)
				End
                           Else Case When PVOvhStdCst <> 0 and @Varpct <> 0
                                     Then Case When Round((PVOvhStdCst * (1 + (@Varpct/100))), @DecPlPrcCst) < 0
						Then 0
						Else Round((PVOvhStdCst * (1 + (@Varpct/100))), @DecPlPrcCst)
					  End
                                     Else PVOvhStdCst
                                End
                      End),

	PStdCostDate = @PendingDate,

        LUpd_DateTime = GetDate(),
        LUpd_Prog = @ScrnNbr,
        LUpd_User = @UserName

FROM ItemSite, IN10520_Wrk
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
    ON OBJECT::[dbo].[SCM_1052_PendCst_SiteUpdt] TO [MSDSL]
    AS [dbo];

