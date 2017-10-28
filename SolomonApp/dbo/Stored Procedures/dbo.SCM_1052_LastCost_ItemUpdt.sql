 Create Proc SCM_1052_LastCost_ItemUpdt
	@ComputerName	Varchar(21),		-- Computer Name
        @ScrnNbr 	Varchar (8),         	-- Prog_Name
        @UserName	Varchar (10),        	-- User_Name
        @DirAmt         Float,               	-- Direct Amount
        @DirPct         Float,               	-- Direct Percent
        @DirBox 	VarChar(1),          	-- Direct Box
        @DecPlPrcCst    SmallInt,
	@PendingDate	Smalldatetime
As

/*
	Update Inventory for Last Cost ...
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

	PDirStdCost = Case When LastCost <> 0 and @DirBox = '1'
                           Then Case When @Dirpct <> 0
                                     Then Case When Round((LastCost * (1 + (@Dirpct/100))), @DecPlPrcCst) < 0
						Then 0
						Else Round((LastCost * (1 + (@Dirpct/100))), @DecPlPrcCst)
					  End	--Neg Val Chk
                                     Else Case When Round((LastCost + @DirAmt), @DecPlPrcCst) < 0
					  	Then 0
						Else Round((LastCost + @DirAmt), @DecPlPrcCst)
                                          End	--Neg Val Chk
				End
			   Else PDirStdCost /* LastCost = 0 or @DirBox <> '1' */
                      End,

    	PStdCost = (Case When LastCost <> 0 and @DirBox = '1'
                         Then Case When @Dirpct <> 0
                                   Then Case When Round((LastCost * (1 + (@Dirpct/100))), @DecPlPrcCst) < 0
					     Then 0
					     Else Round((LastCost * (1 + (@Dirpct/100))), @DecPlPrcCst)
					End
                                   Else Case When Round((LastCost + @DirAmt), @DecPlPrcCst) < 0
					     Then 0
					     Else Round((LastCost + @DirAmt), @DecPlPrcCst)
					End
                              End
			 Else PStdCost /* LastCost = 0 or @DirBox <> '1' */
                    End)+ (PFOvhStdCost + PVOvhStdCost),

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
    ON OBJECT::[dbo].[SCM_1052_LastCost_ItemUpdt] TO [MSDSL]
    AS [dbo];

