 /*
	Fetch Inventory Pending Cost...
*/
Create Proc SCM_1052_PendCost_ItemVar
    	@ComputerName   VarChar(21),
        @DirAmt         Float,               -- Direct Amount
        @FixAmt         Float,               -- Fixed Amount
        @VarAmt         Float,               -- Variable Amount
        @DirPct         Float,               -- Direct Percent
        @FixPct         Float,               -- Fixed Percent
        @VarPct         Float,               -- Variance Percent
        @DecPlPrcCst    SmallInt

As

Set NoCount ON

	Select	Count(*)
	FROM Inventory(NoLock),IN10520_Wrk
        Where Inventory.InvtId = IN10520_Wrk.InvtId
                And IN10520_Wrk.ComputerName = @ComputerName
		AND(

			(Case When @DirAmt <> 0
                               Then Round((PDirStdCost + @DirAmt), @DecPlPrcCst)
                               Else Case When PDirStdCost <> 0 and @DirPct <> 0
                                         Then Round((PDirStdCost * (1 + (@DirPct/100))), @DecPlPrcCst)
                                         Else PDirStdCost
                                    End
                          End) < 0 /* PDirStdCost < 0 */
			OR
            		(Case When @FixAmt <> 0
                                Then Round((PFOvhStdCost + @FixAmt), @DecPlPrcCst)
                                Else Case When PFOvhStdCost <> 0 and @FixPct <> 0
                                          Then Round((PFOvhStdCost * (1 + (@FixPct/100))), @DecPlPrcCst)
                                          Else PFOvhStdCost
                                     End
                           End) < 0 /*PFOvhStdCost < 0 */
			OR
            		(Case When @VarAmt <> 0
                                Then Round((PVOvhStdCost + @VarAmt), @DecPlPrcCst)
                                Else Case When PVOvhStdCost <> 0 and @VarPct <> 0
                                          Then Round((PVOvhStdCost * (1 + (@VarPct/100))), @DecPlPrcCst)
                                          Else PVOvhStdCost
                                       End
                              End) < 0 /*PVOvhStdCost < 0 */
			OR
            		((Case When @DirAmt <> 0
                                  Then Round((PDirStdCost + @DirAmt), @DecPlPrcCst)
                                  Else Case When PDirStdCost <> 0 and @DirPct <> 0
                                           Then Round((PDirStdCost * (1 + (@DirPct/100))), @DecPlPrcCst)
                                           Else PDirStdCost
                                       End
                              End)
                          +(Case When @FixAmt <> 0
                                  Then Round((PFOvhStdCost + @FixAmt), @DecPlPrcCst)
                                  Else Case When PFOvhStdCost <> 0 and @FixPct <> 0
                                           Then Round((PFOvhStdCost * (1 + (@FixPct/100))), @DecPlPrcCst)
                                           Else PFOvhStdCost
                                       End
                              End)
                          +(Case When @VarAmt <> 0
                                  Then Round((PVOvhStdCost + @VarAmt), @DecPlPrcCst)
                                  Else Case When PVOvhStdCost <> 0 and @VarPct <> 0
                                           Then Round((PVOvhStdCost * (1 + (@VarPct/100))), @DecPlPrcCst)
                                           Else PVOvhStdCost
                                       End
                              End)) < 0 /* PStdCost < 0 */
			)



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SCM_1052_PendCost_ItemVar] TO [MSDSL]
    AS [dbo];

