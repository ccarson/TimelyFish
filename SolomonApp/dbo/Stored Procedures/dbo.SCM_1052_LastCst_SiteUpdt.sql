 /*
	Update ItemSite for LastCost
*/

Create Proc SCM_1052_LastCst_SiteUpdt
	@ComputerName	Varchar(21),		-- Computer Name
	@CpnyID		Varchar(10),
        @ScrnNbr 	Varchar (8),         	-- Prog_Name
        @UserName	Varchar (10),        	-- User_Name
        @DirAmt         Float,               	-- Direct Amount
        @DirPct         Float,               	-- Direct Percent
        @DirBox 	Varchar(1),          	-- Direct Box
        @DecPlPrcCst    SmallInt,
	@PendingDate	Smalldatetime
	As
/*
	Update ItemSite for Last cost...
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

	PDirStdCst = Case When ItemSite.LastCost <> 0 and @DirBox = '1'
    	   		  Then Case When @Dirpct <> 0
           			    Then Case When Round((ItemSite.LastCost * (1 + (@Dirpct/100))), @DecPlPrcCst) < 0
					      Then 0
					      Else Round((ItemSite.LastCost * (1 + (@Dirpct/100))), @DecPlPrcCst)
					 End
           			    Else Case When Round((ItemSite.LastCost + @DirAmt), @DecPlPrcCst) < 0
					      Then 0
					      Else Round((ItemSite.LastCost + @DirAmt), @DecPlPrcCst)
					 End
       			       End
    			  Else
      		               Case When Inventory.LastCost <> 0 and @DirBox = '1'
          			    Then Case When @Dirpct <> 0
                   			      Then Case When Round((Inventory.LastCost * (1 + (@Dirpct/100))), @DecPlPrcCst) < 0
						        Then 0
							Else Round((Inventory.LastCost * (1 + (@Dirpct/100))), @DecPlPrcCst)
						   End
                   			      Else Case When Round((Inventory.LastCost + @DirAmt), @DecPlPrcCst) < 0
							Then 0
						   	Else Round((Inventory.LastCost + @DirAmt), @DecPlPrcCst)
						   End
               			         End
				    Else PDirStdCst /* ItemSite and Inventory LastCost = 0 or @DirBox <> '1' */
                               End
                      End,
	    	PStdCst = (Case When ItemSite.LastCost <> 0 and @DirBox = '1'
    			Then Case When @Dirpct <> 0
        			  Then Case When Round((ItemSite.LastCost * (1 + (@Dirpct/100))), @DecPlPrcCst) < 0
					    Then 0
					    Else Round((ItemSite.LastCost * (1 + (@Dirpct/100))), @DecPlPrcCst)
					End
        			  Else Case When Round((ItemSite.LastCost + @DirAmt), @DecPlPrcCst) < 0
					    Then 0
					    Else Round((ItemSite.LastCost + @DirAmt), @DecPlPrcCst)
					End
    			     End
    			Else
    			     Case When Inventory.LastCost <> 0 and @DirBox = '1'
       			          Then Case When @Dirpct <> 0
                		     	    Then Case When Round((Inventory.LastCost * (1 + (@Dirpct/100))), @DecPlPrcCst) < 0
							Then 0
							Else Round((Inventory.LastCost * (1 + (@Dirpct/100))), @DecPlPrcCst)
						 End
                			    Else Case When Round((Inventory.LastCost + @DirAmt), @DecPlPrcCst) < 0
						 	Then 0
						 	Else Round((Inventory.LastCost + @DirAmt), @DecPlPrcCst)
						 End
            			       End
				  Else PStdCst /* ItemSite and Inventory LastCost = 0 or @DirBox <> '1' */
    			     End
    		    End) + (PFOvhStdCst + PVOvhStdCst),

	PStdCostDate = @PendingDate,

        LUpd_DateTime = GetDate(),
        LUpd_Prog = @ScrnNbr,
        LUpd_User = @UserName

FROM ItemSite, Inventory, IN10520_Wrk
WHERE 	ItemSite.InvtId = Inventory.InvtId
  AND 	Inventory.InvtId = IN10520_Wrk.InvtId
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
    ON OBJECT::[dbo].[SCM_1052_LastCst_SiteUpdt] TO [MSDSL]
    AS [dbo];

