 /*
	Fetch ItemSite records for -ve LastCost update
*/

Create Proc SCM_1052_LastCst_SiteVar
        @ComputerName     	VarChar(21),
	@CpnyID			VarChar(10),
        @DirAmt         	Float,               -- Direct Amount
        @DirPct         	Float,               -- Direct Percent
        @DirBox 		Varchar(1),          -- Direct Box
        @DecPlPrcCst    	SmallInt
As

Set NoCount ON

	Select	Count(*)
        From ItemSite (NoLock), Inventory (NoLock), IN10520_Wrk
      	Where ItemSite.InvtId = Inventory.InvtId
        	AND Inventory.InvtId = IN10520_Wrk.InvtId
        	And IN10520_Wrk.ComputerName = @ComputerName
		And ItemSite.CpnyID = @CpnyID
		AND
		(
			(Case When ItemSite.LastCost <> 0 and @DirBox = '1'
    	   		      Then Case When @Dirpct <> 0
           			        Then Round((ItemSite.LastCost * (1 + (@Dirpct/100))), @DecPlPrcCst)
           			        Else Round((ItemSite.LastCost + @DirAmt), @DecPlPrcCst)
       			 	   End
    			      Else
      		                   Case When Inventory.LastCost <> 0 and @DirBox = '1'
          			        Then Case When @Dirpct <> 0
                   			          Then Round((Inventory.LastCost * (1 + (@Dirpct/100))), @DecPlPrcCst)
                   			          Else Round((Inventory.LastCost + @DirAmt), @DecPlPrcCst)
               			             End
					Else PDirStdCst /* ItemSite and Inventory LastCost = 0 or @DirBox <> '1' */
                                   End
                    	 End) < 0 /* If PDirStdCst < 0 */
			OR
    			((Case When ItemSite.LastCost <> 0 and @DirBox = '1'
    			       Then Case When @Dirpct <> 0
        			    	 Then Round((ItemSite.LastCost * (1 + (@Dirpct/100))), @DecPlPrcCst)
        			    	 Else Round((ItemSite.LastCost + @DirAmt), @DecPlPrcCst)
    			     	    End
    			       Else
    			     	    Case When Inventory.LastCost <> 0 and @DirBox = '1'
       			    		 Then Case When @Dirpct <> 0
                		     	           Then Round((Inventory.LastCost * (1 + (@Dirpct/100))), @DecPlPrcCst)
                			           Else Round((Inventory.LastCost + @DirAmt), @DecPlPrcCst)
            			   	      End
					 Else PStdCst /* ItemSite and Inventory LastCost = 0 or @DirBox <> '1' */
    			     	    End
    		      	  End) + (PFOvhStdCst + PVOvhStdCst)) < 0 /* PStdCst < 0 */

	         )



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SCM_1052_LastCst_SiteVar] TO [MSDSL]
    AS [dbo];

