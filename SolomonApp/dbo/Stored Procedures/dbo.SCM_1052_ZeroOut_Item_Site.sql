 Create Proc SCM_1052_ZeroOut_Item_Site
	@ComputerName	Varchar(21),		-- Computer Name
        @ScrnNbr 	Varchar (8),         	-- Prog_Name
        @UserName	Varchar (10),        	-- User_Name
        @DirBox 	Varchar (1),        	-- Direct Box
        @FixBox 	Varchar (1),        	-- Fixed Box
        @VarBox 	Varchar (1)       	-- Variable Box

As
/*
	ZeroOut Inventory and ItemSite std cost...
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

	---Update Inventory
        UPDATE Inventory SET

                   PDirStdCost  = Case When @DirBox = '1'
                                       Then 0
                                       Else PDirStdCost
                                  End,
                   PFOvhStdCost = Case When @FixBox = '1'
                                       Then 0
                                       Else PFOvhStdCost
                                  End,
                   PVOvhStdCost = Case When @VarBox = '1'
                                       Then 0
                                       Else PVOvhStdCost
                                  End,
                   PStdCost =    (Case When @DirBox = '1'
                                       Then 0
                                       Else PDirStdCost
                                  End)
                               + (Case When @FixBox = '1'
                                       Then 0
                                       Else PFOvhStdCost
                                  End)
                               + (Case When @VarBox = '1'
                                       Then 0
                                       Else PVOvhStdCost
                                  End),
                   LUpd_DateTime = GetDate(),
                   LUpd_Prog = @ScrnNbr,
                   LUpd_User = @UserName
	FROM Inventory,IN10520_Wrk
	Where Inventory.InvtId = IN10520_Wrk.InvtId
                And IN10520_Wrk.ComputerName = @ComputerName

	    Select @SQLErrNbr = @@Error
	    If @SQLErrNbr <> 0
	    Begin
		Goto Abort
  	    End

	---Update ItemSite
        UPDATE ItemSite SET
               	   PDirStdCst  = Case When @DirBox = '1'
                                      Then 0
                                      Else PDirStdCst
                                 End,
                   PFOvhStdCst = Case When @FixBox = '1'
                                      Then 0
                                      Else PFOvhStdCst /* Check this should be Inventory.PFOvhStdCost */
                                 End,
                   PVOvhStdCst = Case When @VarBox = '1'
                                      Then 0
                                      Else PVOvhStdCst
                                 End,
                   PStdCst    = (Case When @DirBox = '1'
                                      Then 0
                                      Else PDirStdCst
                                 End)
                              + (Case When @FixBox = '1'
                                      Then 0
                                      Else PFOvhStdCst
                                 End)
                              + (Case When @VarBox = '1'
                                      Then 0
                                      Else PVOvhStdCst
                                 End),
                   LUpd_DateTime = GetDate(),
                   LUpd_Prog = @ScrnNbr,
                   LUpd_User = @UserName
	From ItemSite, IN10520_Wrk
	Where ItemSite.InvtId = IN10520_Wrk.InvtId
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
    ON OBJECT::[dbo].[SCM_1052_ZeroOut_Item_Site] TO [MSDSL]
    AS [dbo];

