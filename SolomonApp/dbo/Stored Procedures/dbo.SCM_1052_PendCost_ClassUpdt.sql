 /*
	Fetch ProductClass Pending Cost...
*/
Create Proc SCM_1052_PendCost_ClassUpdt
	@ComputerName	Varchar(21),		-- Computer Name
        @ScrnNbr 	Varchar (8),         	-- Prog_Name
        @UserName	Varchar (10),        	-- User_Name
        @FixAmt         Float,               	-- Fixed Amount
        @VarAmt         Float,              	-- Variable Amount
        @FixPct         Float,               	-- Fixed Percent
        @VarPct         Float,               	-- Variance Percent
        @DecPlPrcCst    SmallInt

As

/*
	Update ProductClass for Pending cost...
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

UPDATE PRODUCTCLASS SET

  		PFOvhMatlRate = Case When PFOvhMatlRate <> 0 and @FixAmt <> 0
                                     Then Case When (Round((PFOvhMatlRate + @FixAmt), @DecPlPrcCst)) < 0
					       Then 0
					       Else Round((PFOvhMatlRate + @FixAmt), @DecPlPrcCst)
					       End	--Neg Val chk
                                     Else Case When PFOvhMatlRate <> 0 and @FixPct <> 0
                                               Then Case When Round((PFOvhMatlRate * (1 + (@FixPct/100))), @DecPlPrcCst) < 0
							 Then 0
							 Else Round((PFOvhMatlRate * (1 + (@FixPct/100))), @DecPlPrcCst)
						         End	 --Neg Val chk
                                               Else PFOvhMatlRate
                                               End
				     End,
                PVOvhMatlRate = Case When PVOvhMatlRate <> 0 and @VarAmt <> 0
                                     Then Case When Round((PVOvhMatlRate + @VarAmt), @DecPlPrcCst) < 0
					       Then 0
					       Else Round((PVOvhMatlRate + @VarAmt), @DecPlPrcCst)
					       End	--Neg Val chk
                                     Else Case When PVOvhMatlRate <> 0 and @VarPct <> 0
                                               Then Case When Round((PVOvhMatlRate * (1 + (@VarPct/100))), @DecPlPrcCst) < 0
							 Then 0
							 Else Round((PVOvhMatlRate * (1 + (@VarPct/100))), @DecPlPrcCst)
						         End	--Neg Val chk
                                               Else PVOvhMatlRate
					       End
                                     End,
                LUpd_DateTime = GetDate(),
                LUpd_Prog = @ScrnNbr,
                LUpd_User = @UserName

FROM ProductClass, IN10520_Wrk
WHERE @ComputerName = IN10520_Wrk.ComputerName
            	And ProductClass.ClassId = IN10520_Wrk.ClassId


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
    ON OBJECT::[dbo].[SCM_1052_PendCost_ClassUpdt] TO [MSDSL]
    AS [dbo];

