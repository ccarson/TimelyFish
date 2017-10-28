 Create Proc SCM_1052_StdCost_ClassUpdt
	@ComputerName	Varchar(21),		-- Computer Name
        @ScrnNbr 	Varchar (8),         	-- Prog_Name
        @UserName	Varchar (10),        	-- User_Name
        @FixAmt         Float,               	-- Fixed Amount
        @VarAmt         Float,               	-- Variable Amount
        @FixPct         Float,               	-- Fixed Percent
        @VarPct         Float,               	-- Variance Percent
        @DecPlPrcCst    SmallInt

As
/*
	Update ProductClass for std cost...
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

UPDATE ProductClass SET
		PFOvhMatlRate = Case When CFOvhMatlRate <> 0 and @FixAmt <> 0
                                     Then Case When Round((CFOvhMatlRate + @FixAmt), @DecPlPrcCst) < 0
						Then 0
						Else Round((CFOvhMatlRate + @FixAmt), @DecPlPrcCst)
					  End
                                     Else Case When CFOvhMatlRate <> 0 and @FixPct <> 0
                                               Then Case When Round((CFOvhMatlRate * (1 + (@FixPct/100))), @DecPlPrcCst) <0
							 Then 0
							 Else Round((CFOvhMatlRate * (1 + (@FixPct/100))), @DecPlPrcCst)
						    End
                                               Else CFOvhMatlRate
                                          End
                                 End,
            	PVOvhMatlRate = Case When CVOvhMatlRate <> 0 and @VarAmt <> 0
                                     Then Case When Round((CVOvhMatlRate + @VarAmt), @DecPlPrcCst) < 0
						Then 0
						Else Round((CVOvhMatlRate + @VarAmt), @DecPlPrcCst)
					  End
                                     Else Case When CVOvhMatlRate <> 0 and @VarPct <> 0
                                               Then Case When Round((CVOvhMatlRate * (1 + (@VarPct/100))), @DecPlPrcCst) < 0
							 Then 0
							 Else Round((CVOvhMatlRate * (1 + (@VarPct/100))), @DecPlPrcCst)
						    End
                                               Else CVOvhMatlRate
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
    ON OBJECT::[dbo].[SCM_1052_StdCost_ClassUpdt] TO [MSDSL]
    AS [dbo];

