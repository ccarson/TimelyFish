 /*
	Fetch ItemSite Pending cost
*/

Create Proc SCM_1052_PendCst_SiteVar
        @ComputerName  	VarChar(21),
	@CpnyID		VarChar(10),
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
        From ItemSite(NoLock), IN10520_Wrk
        Where ItemSite.InvtId = IN10520_Wrk.InvtId
          And 	IN10520_Wrk.ComputerName = @ComputerName
	  And	ItemSite.CpnyID = @CpnyID
	  AND
		(
		   	(Case When @DirAmt <> 0
                                 Then Round((PDirStdCst + @DirAmt), @DecPlPrcCst)
                                 Else Case When PDirStdCst <> 0 and @Dirpct <> 0
                                           Then Round((PDirStdCst * (1 + (@Dirpct/100))), @DecPlPrcCst)
                                           Else PDirStdCst
                                      End
                         End) < 0 /* PDirStdCst < 0 */
		OR
               		(Case When @FixAmt <> 0
                                  Then Round((PFOvhStdCst + @FixAmt), @DecPlPrcCst)
                                  Else Case When PFOvhStdCst <> 0 and @Fixpct <> 0
                                            Then Round((PFOvhStdCst * (1 + (@Fixpct/100))), @DecPlPrcCst)
                                            Else PFOvhStdCst
                                       End
                             End) < 0 /* PFOvhStdCst < 0 */
		OR
               		(Case When @VarAmt <> 0
                                 Then Round((PVOvhStdCst + @VarAmt), @DecPlPrcCst)
                                 Else Case When PVOvhStdCst <> 0 and @Varpct <> 0
                                           Then Round((PVOvhStdCst * (1 + (@Varpct/100))), @DecPlPrcCst)
                                           Else PVOvhStdCst
                                      End
                             End) < 0 /* PVOvhStdCst < 0 */
		OR
               		((Case When @DirAmt <> 0
                                  Then Round((PDirStdCst + @DirAmt), @DecPlPrcCst)
                                  Else Case When PDirStdCst <> 0 and @Dirpct <> 0
                                            Then Round((PDirStdCst * (1 + (@Dirpct/100))), @DecPlPrcCst)
                                            Else PDirStdCst
                                       End
                             End)
                          + (Case When @FixAmt <> 0
                                  Then Round((PFOvhStdCst + @FixAmt), @DecPlPrcCst)
                                  Else Case When PFOvhStdCst <> 0 and @Fixpct <> 0
                                            Then Round((PFOvhStdCst * (1 + (@Fixpct/100))), @DecPlPrcCst)
                                            Else PFOvhStdCst
                                       End
                             End)
                          + (Case When @VarAmt <> 0
                                  Then Round((PVOvhStdCst + @VarAmt), @DecPlPrcCst)
                                  Else Case When PVOvhStdCst <> 0 and @Varpct <> 0
                                            Then Round((PVOvhStdCst * (1 + (@Varpct/100))), @DecPlPrcCst)
                                            Else PVOvhStdCst
                                       End
                             End)) < 0 /*PStdCst < 0 */
		)



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SCM_1052_PendCst_SiteVar] TO [MSDSL]
    AS [dbo];

