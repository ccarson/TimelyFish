 Create Proc SCM_1052_PendCost_ItemUpdt
	@ComputerName	Varchar(21),		-- Computer Name
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
	Update Inventory for Pending cost....
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

UPDATE Inventory SET

	PDirStdCost = Case When @DirAmt <> 0
                           Then Case When Round((PDirStdCost + @DirAmt), @DecPlPrcCst) < 0
				     Then 0
				     Else Round((PDirStdCost + @DirAmt), @DecPlPrcCst)
				     End
                           Else Case When PDirStdCost <> 0 and @DirPct <> 0
                                     Then Case  When Round((PDirStdCost * (1 + (@DirPct/100))), @DecPlPrcCst) < 0
						Then 0
						Else Round((PDirStdCost * (1 + (@DirPct/100))), @DecPlPrcCst)
					        End
                                     Else PDirStdCost
                                     End
                           End,
        PFOvhStdCost = Case When @FixAmt <> 0
                            Then Case When Round((PFOvhStdCost + @FixAmt), @DecPlPrcCst) < 0
				      Then 0
				      Else Round((PFOvhStdCost + @FixAmt), @DecPlPrcCst)
				      End
                            Else Case When PFOvhStdCost <> 0 and @FixPct <> 0
                                      Then Case When Round((PFOvhStdCost * (1 + (@FixPct/100))), @DecPlPrcCst) <0
						Then 0
					   	Else Round((PFOvhStdCost * (1 + (@FixPct/100))), @DecPlPrcCst)
					        End
                                      Else PFOvhStdCost
                                      End
                            End,
        PVOvhStdCost = Case When @VarAmt <> 0
                                Then Case When Round((PVOvhStdCost + @VarAmt), @DecPlPrcCst) < 0
					  Then 0
					  Else Round((PVOvhStdCost + @VarAmt), @DecPlPrcCst)
				     End
                                Else Case When PVOvhStdCost <> 0 and @VarPct <> 0
                                          Then Case When Round((PVOvhStdCost * (1 + (@VarPct/100))), @DecPlPrcCst) < 0
						    Then 0
						    Else Round((PVOvhStdCost * (1 + (@VarPct/100))), @DecPlPrcCst)
						End
                                          Else PVOvhStdCost
                                     End
                       End,
        PStdCost =     (Case When @DirAmt <> 0
                             Then Case When Round((PDirStdCost + @DirAmt), @DecPlPrcCst) < 0
					Then 0
					Else Round((PDirStdCost + @DirAmt), @DecPlPrcCst)
				  End
                             Else Case When PDirStdCost <> 0 and @DirPct <> 0
                                       Then Case When Round((PDirStdCost * (1 + (@DirPct/100))), @DecPlPrcCst) < 0
						 Then 0
						 Else Round((PDirStdCost * (1 + (@DirPct/100))), @DecPlPrcCst)
					    End
                                       Else PDirStdCost
                                  End
                        End)
                         +(Case When @FixAmt <> 0
                                Then Case When Round((PFOvhStdCost + @FixAmt), @DecPlPrcCst) < 0
					  Then 0
					  Else Round((PFOvhStdCost + @FixAmt), @DecPlPrcCst)
				     End
                                Else Case When PFOvhStdCost <> 0 and @FixPct <> 0
                                          Then Case When Round((PFOvhStdCost * (1 + (@FixPct/100))), @DecPlPrcCst) < 0
						    Then 0
						    Else Round((PFOvhStdCost * (1 + (@FixPct/100))), @DecPlPrcCst)
						End
                                          Else PFOvhStdCost
                                     End
                           End)
                          +(Case When @VarAmt <> 0
                                 Then Case When Round((PVOvhStdCost + @VarAmt), @DecPlPrcCst) < 0
					   Then 0
					   Else Round((PVOvhStdCost + @VarAmt), @DecPlPrcCst)
				      End
                                 Else Case When PVOvhStdCost <> 0 and @VarPct <> 0
                                           Then Case When Round((PVOvhStdCost * (1 + (@VarPct/100))), @DecPlPrcCst) < 0
						     Then 0
						     Else Round((PVOvhStdCost * (1 + (@VarPct/100))), @DecPlPrcCst)
						End
                                           Else PVOvhStdCost
                                      End
                            End),

	PStdCostDate = @PendingDate,

        LUpd_DateTime = GetDate(),
        LUpd_Prog = @ScrnNbr,
        LUpd_User = @UserName

FROM Inventory,IN10520_Wrk
WHERE Inventory.InvtId = IN10520_Wrk.InvtId
                And IN10520_Wrk.ComputerName = @ComputerName

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
    ON OBJECT::[dbo].[SCM_1052_PendCost_ItemUpdt] TO [MSDSL]
    AS [dbo];

