 Create Proc SCM_1052_StdCst_SiteVar
        @ComputerName   VarChar(21),
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
        Where 	ItemSite.InvtId = IN10520_Wrk.InvtId
          And 	IN10520_Wrk.ComputerName = @ComputerName
	  And	ItemSite.CpnyID = @CpnyID
	  AND
		(
			(Case When @DirAmt <> 0
                              Then Round((DirStdCst + @DirAmt), @DecPlPrcCst)
                              Else Case When DirStdCst <> 0 and @Dirpct <> 0
                                        Then Round((DirStdCst * (1 + (@Dirpct/100))), @DecPlPrcCst)
                                        Else DirStdCst
                                   End
                         End) < 0 /* PDirStdCst < 0 */
			OR
            		(Case When @FixAmt <> 0
                               Then Round((FOvhStdCst + @FixAmt), @DecPlPrcCst)
                               Else Case When FOvhStdCst <> 0 and @Fixpct <> 0
                                         Then Round((FOvhStdCst * (1 + (@Fixpct/100))), @DecPlPrcCst)
                                         Else FOvhStdCst
                                    End
                          End) < 0 /*PFOvhStdCst < 0 */
			OR
            		(Case When @VarAmt <> 0
                               Then Round((VOvhStdCst + @VarAmt), @DecPlPrcCst)
                               Else Case When VOvhStdCst <> 0 and @Varpct <> 0
                                         Then Round((VOvhStdCst * (1 + (@Varpct/100))), @DecPlPrcCst)
                                         Else VOvhStdCst
                                    End
                          End) < 0 /* PVOvhStdCst < 0 */
			OR
            		((Case When @DirAmt <> 0
                               Then Round((DirStdCst + @DirAmt), @DecPlPrcCst)
                               Else Case When DirStdCst <> 0 and @Dirpct <> 0
                                         Then Round((DirStdCst * (1 + (@Dirpct/100))), @DecPlPrcCst)
                                         Else DirStdCst
                                    End
                           End)
                    	+ (Case When @FixAmt <> 0
                                Then Round((FOvhStdCst + @FixAmt), @DecPlPrcCst)
                                Else Case When FOvhStdCst <> 0 and @Fixpct <> 0
                                          Then Round((FOvhStdCst * (1 + (@Fixpct/100))), @DecPlPrcCst)
                                          Else FOvhStdCst
                                     End
                           End)
                    	+ (Case When @VarAmt <> 0
                                Then Round((VOvhStdCst + @VarAmt), @DecPlPrcCst)
                                Else Case When VOvhStdCst <> 0 and @Varpct <> 0
                                          Then Round((VOvhStdCst * (1 + (@Varpct/100))), @DecPlPrcCst)
                                          Else VOvhStdCst
                                     End
                           End)) < 0 /* PStdCst < 0 */
			)



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SCM_1052_StdCst_SiteVar] TO [MSDSL]
    AS [dbo];

