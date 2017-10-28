 Create Proc SCM_1052_ZeroOut_Class
	@ComputerName	Varchar(21),		-- Computer Name
        @ScrnNbr 	Varchar (8),         	-- Prog_Name
        @UserName	Varchar (10),        	-- User_Name
        @FixBox 	Varchar (1),        	-- Fixed Box
        @VarBox 	Varchar (1)       	-- Variable Box

As
/*
	ZeroOut ProductClass std cost.........
	Returns:	@True = 1	The procedure executed properly.
			@False = 0	An error occurred.
	*/

	Declare	@SQLErrNbr	SmallInt
	Select	@SQLErrNbr	= 0

	Declare	@True			Bit,
			@False		Bit
	Select	@True 		= 1,
			@False 		= 0

	Set	NoCount On

	UPDATE ProductClass SET
      		PFOvhMatlRate = Case When @FixBox = '1'
                                     Then 0
                                     Else PFOvhMatlRate
                                End,
                PVOvhMatlRate = Case When @VarBox = '1'
                                     Then 0
                                     Else PVOvhMatlRate
                                End,
                LUpd_DateTime = GetDate(),
                LUpd_Prog = @ScrnNbr,
                LUpd_User = @UserName
	From ProductClass, IN10520_Wrk
	Where @ComputerName = IN10520_Wrk.ComputerName
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
    ON OBJECT::[dbo].[SCM_1052_ZeroOut_Class] TO [MSDSL]
    AS [dbo];

