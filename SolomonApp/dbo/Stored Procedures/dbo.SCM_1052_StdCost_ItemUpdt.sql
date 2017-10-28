 /*
	Fetch Inventory Std Cost
*/

Create Proc SCM_1052_StdCost_ItemUpdt
	@ComputerName	Varchar(21),		-- Computer Name
        @ScrnNbr 	Varchar (8),         	-- Prog_Name
        @UserName	Varchar (10),        	-- User_Name
        @DirAmt         Float,               	-- Amount
        @FixAmt         Float,               	-- Fixed Amount
        @VarAmt         Float,               	-- Variable Amount
        @DirPct         Float,               	-- Percent
        @FixPct         Float,               	-- Fixed Percent
        @VarPct         Float,               	-- Variance Percent
        @DecPlPrcCst    SmallInt,
	@PendingDate	Smalldatetime

As

/*
	Update Inventory for std cost...
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
                               Then Case When Round((DirStdCost + @DirAmt), @DecPlPrcCst) < 0
					 Then 0
					 Else Round((DirStdCost + @DirAmt), @DecPlPrcCst)
				    End
                               Else Case When DirStdCost <> 0 and @Dirpct <> 0
                                         Then Case When Round((DirStdCost * (1 + (@Dirpct/100))), @DecPlPrcCst) < 0
						   Then 0
						   Else Round((DirStdCost * (1 + (@Dirpct/100))), @DecPlPrcCst)
					      End
                                         Else DirStdCost
                                    End
                               End,
            PFOvhStdCost = Case When @FixAmt <> 0
                                Then Case When Round((FOvhStdCost + @FixAmt), @DecPlPrcCst) < 0
					  Then 0
					  Else Round((FOvhStdCost + @FixAmt), @DecPlPrcCst)
				     End
                                Else Case When FOvhStdCost <> 0 and @Fixpct <> 0
                                          Then Case When Round((FOvhStdCost * (1 + (@Fixpct/100))), @DecPlPrcCst) < 0
						    Then 0
						    Else Round((FOvhStdCost * (1 + (@Fixpct/100))), @DecPlPrcCst)
						End
                                          Else FOvhStdCost
                                     End
                           End,
            PVOvhStdCost = Case When @VarAmt <> 0
                                Then Case When Round((VOvhStdCost + @VarAmt), @DecPlPrcCst) < 0
					  Then 0
					  Else Round((VOvhStdCost + @VarAmt), @DecPlPrcCst)
				     End
                                Else Case When VOvhStdCost <> 0 and @Varpct <> 0
                                          Then Case When Round((VOvhStdCost * (1 + (@Varpct/100))), @DecPlPrcCst) < 0
						    Then 0
						    Else Round((VOvhStdCost * (1 + (@Varpct/100))), @DecPlPrcCst)
						End
                                          Else VOvhStdCost
                                     End
                           End,
            PStdCost =    (Case When @DirAmt <> 0
                                Then Case When Round((DirStdCost + @DirAmt), @DecPlPrcCst) < 0
					  Then 0
					  Else Round((DirStdCost + @DirAmt), @DecPlPrcCst)
				     End
                                Else Case When DirStdCost <> 0 and @Dirpct <> 0
                                          Then Case When Round((DirStdCost * (1 + (@Dirpct/100))), @DecPlPrcCst) < 0
						    Then 0
						    Else Round((DirStdCost * (1 + (@Dirpct/100))), @DecPlPrcCst)
					       End
                                          Else DirStdCost
                                     End
                           End)
                        + (Case When @FixAmt <> 0
                                Then Case When Round((FOvhStdCost + @FixAmt), @DecPlPrcCst) < 0
					  Then 0
					  Else Round((FOvhStdCost + @FixAmt), @DecPlPrcCst)
				     End
                                Else Case When FOvhStdCost <> 0 and @Fixpct <> 0
                                          Then Case When Round((FOvhStdCost * (1 + (@Fixpct/100))), @DecPlPrcCst) < 0
						    Then 0
						    Else Round((FOvhStdCost * (1 + (@Fixpct/100))), @DecPlPrcCst)
					       End
                                          Else FOvhStdCost
                                     End
                           End)
                        + (Case When @VarAmt <> 0
                                Then Case When Round((VOvhStdCost + @VarAmt), @DecPlPrcCst) < 0
					  Then 0
					  Else Round((VOvhStdCost + @VarAmt), @DecPlPrcCst)
				     End
                                Else Case When VOvhStdCost <> 0 and @Varpct <> 0
                                          Then Case When Round((VOvhStdCost * (1 + (@Varpct/100))), @DecPlPrcCst) < 0
						    Then 0
						    Else Round((VOvhStdCost * (1 + (@Varpct/100))), @DecPlPrcCst)
					       End
                                          Else VOvhStdCost
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
    ON OBJECT::[dbo].[SCM_1052_StdCost_ItemUpdt] TO [MSDSL]
    AS [dbo];

