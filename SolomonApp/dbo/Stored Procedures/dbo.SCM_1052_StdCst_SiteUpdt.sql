 Create Proc SCM_1052_StdCst_SiteUpdt
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
	Update  ItemSite for std cost...
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
                              Then Case When Round((DirStdCst + @DirAmt), @DecPlPrcCst) < 0
					Then 0
					Else Round((DirStdCst + @DirAmt), @DecPlPrcCst)
				   End
                              Else Case When DirStdCst <> 0 and @Dirpct <> 0
                                        Then Case When Round((DirStdCst * (1 + (@Dirpct/100))), @DecPlPrcCst) < 0
						  Then 0
						  Else Round((DirStdCst * (1 + (@Dirpct/100))), @DecPlPrcCst)
					     End
                                        Else DirStdCst
                                   End
                         End,
            PFOvhStdCst = Case When @FixAmt <> 0
                               Then Case When Round((FOvhStdCst + @FixAmt), @DecPlPrcCst) < 0
					Then 0
					Else Round((FOvhStdCst + @FixAmt), @DecPlPrcCst)
				   End
                               Else Case When FOvhStdCst <> 0 and @Fixpct <> 0
                                         Then Case When Round((FOvhStdCst * (1 + (@Fixpct/100))), @DecPlPrcCst) < 0
						   Then 0
						   Else Round((FOvhStdCst * (1 + (@Fixpct/100))), @DecPlPrcCst)
					      End
                                         Else FOvhStdCst
                                    End
                          End,
            PVOvhStdCst = Case When @VarAmt <> 0
                               Then Case When Round((VOvhStdCst + @VarAmt), @DecPlPrcCst) < 0
					Then 0
					Else Round((VOvhStdCst + @VarAmt), @DecPlPrcCst)
				   End
                               Else Case When VOvhStdCst <> 0 and @Varpct <> 0
                                         Then Case When Round((VOvhStdCst * (1 + (@Varpct/100))), @DecPlPrcCst) < 0
						   Then 0
						   Else Round((VOvhStdCst * (1 + (@Varpct/100))), @DecPlPrcCst)
					      End
                                         Else VOvhStdCst
                                    End
                          End,
            PStdCst = (Case When @DirAmt <> 0
                            Then Case When Round((DirStdCst + @DirAmt), @DecPlPrcCst) < 0
				      Then 0
				      Else Round((DirStdCst + @DirAmt), @DecPlPrcCst)
				 End
                            Else Case When DirStdCst <> 0 and @Dirpct <> 0
                                      Then Case When Round((DirStdCst * (1 + (@Dirpct/100))), @DecPlPrcCst) < 0
						Then 0
						Else Round((DirStdCst * (1 + (@Dirpct/100))), @DecPlPrcCst)
					   End
                                      Else DirStdCst
                                 End
                        End)
                    + (Case When @FixAmt <> 0
                            Then Case When Round((FOvhStdCst + @FixAmt), @DecPlPrcCst) < 0
				      Then 0
				      Else Round((FOvhStdCst + @FixAmt), @DecPlPrcCst)
				 End
                            Else Case When FOvhStdCst <> 0 and @Fixpct <> 0
                                      Then Case When Round((FOvhStdCst * (1 + (@Fixpct/100))), @DecPlPrcCst) < 0
						Then 0
						Else Round((FOvhStdCst * (1 + (@Fixpct/100))), @DecPlPrcCst)
					   End
                                      Else FOvhStdCst
                                 End
                       End)
                    + (Case When @VarAmt <> 0
                            Then Case When Round((VOvhStdCst + @VarAmt), @DecPlPrcCst) < 0
				      Then 0
				      Else Round((VOvhStdCst + @VarAmt), @DecPlPrcCst)
				 End
                            Else Case When VOvhStdCst <> 0 and @Varpct <> 0
                                      Then Case When Round((VOvhStdCst * (1 + (@Varpct/100))), @DecPlPrcCst) < 0
						Then 0
						Else Round((VOvhStdCst * (1 + (@Varpct/100))), @DecPlPrcCst)
					   End
                                      Else VOvhStdCst
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
    ON OBJECT::[dbo].[SCM_1052_StdCst_SiteUpdt] TO [MSDSL]
    AS [dbo];

