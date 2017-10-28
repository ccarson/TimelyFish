 Create Proc pp_10520_Process_Items
            @Parm1 VARCHAR (21),        -- ComputerName
            @Parm2 VARCHAR (8),         -- Prog_Name
            @Parm3 VARCHAR (10),        -- User_Name
            @Parm4 VARCHAR (1),         -- All Items
            @Parm5 VARCHAR (1),         -- Selection Option
            @Parm6 Float,               -- Percent
            @Parm7 Float,               -- Fixed Percent
            @Parm8 Float,               -- Variance Percent
            @Parm9 Float,               -- Amount
            @Parm10 Float,               -- Fixed Amount
            @Parm11 Float,              -- Variable Amount
            @Parm12 VARCHAR (1),        -- Direct Box
            @Parm13 VARCHAR (1),        -- Fixed Box
            @Parm14 VARCHAR (1) As      -- Variable Box

    DECLARE @Process_Flag    CHAR(1)
    DECLARE @DecPlPrcCst     Int

    SELECT @Process_Flag = '0'
--  Process Inventory Revaluation and ItemSite Cost Updates
    SELECT @DecPlPrcCst     = (Select DecPlPrcCst From INSetup)

    BEGIN TRANSACTION

--  Update Pending Standard Costs
    IF @Parm4 = '1'                             -- All Items
        BEGIN
            IF @Parm5 = 'P'                     -- By Pending Standard Costs
                BEGIN
                    Update Inventory
                           Set PDirStdCost = Case When @Parm9 <> 0
                                                 Then Round((PDirStdCost + @Parm9), @DecPlPrcCst)
                                                 Else Case When PDirStdCost <> 0 and @Parm6 <> 0
                                                          Then Round((PDirStdCost * (1 + (@Parm6/100))), @DecPlPrcCst)
                                                          Else PDirStdCost
                                                      End
                                             End,
                               PFOvhStdCost = Case When @Parm10 <> 0
                                                 Then Round((PFOvhStdCost + @Parm10), @DecPlPrcCst)
                                                 Else Case When PFOvhStdCost <> 0 and @Parm7 <> 0
                                                          Then Round((PFOvhStdCost * (1 + (@Parm7/100))), @DecPlPrcCst)
                                                          Else PFOvhStdCost
                                                      End
                                             End,
                               PVOvhStdCost = Case When @Parm11 <> 0
                                                 Then Round((PVOvhStdCost + @Parm11), @DecPlPrcCst)
                                                 Else Case When PVOvhStdCost <> 0 and @Parm8 <> 0
                                                          Then Round((PVOvhStdCost * (1 + (@Parm8/100))), @DecPlPrcCst)
                                                          Else PVOvhStdCost
                                                      End
                                             End,
                               PStdCost = (Case When @Parm9 <> 0
                                                 Then Round((PDirStdCost + @Parm9), @DecPlPrcCst)
                                                 Else Case When PDirStdCost <> 0 and @Parm6 <> 0
                                                          Then Round((PDirStdCost * (1 + (@Parm6/100))), @DecPlPrcCst)
                                                          Else PDirStdCost
                                                      End
                                             End)
                                        + (Case When @Parm10 <> 0
                                                 Then Round((PFOvhStdCost + @Parm10), @DecPlPrcCst)
                                                 Else Case When PFOvhStdCost <> 0 and @Parm7 <> 0
  Then Round((PFOvhStdCost * (1 + (@Parm7/100))), @DecPlPrcCst)
                                                          Else PFOvhStdCost
                                                      End
                                             End)
                                        + (Case When @Parm11 <> 0
                                                 Then Round((PVOvhStdCost + @Parm11), @DecPlPrcCst)
                                                 Else Case When PVOvhStdCost <> 0 and @Parm8 <> 0
                                                          Then Round((PVOvhStdCost * (1 + (@Parm8/100))), @DecPlPrcCst)
                                                          Else PVOvhStdCost
                                                      End
                                             End),
                               LUpd_DateTime = GetDate(),
                               LUpd_Prog = @Parm2,
                               LUpd_User = @Parm3
                           From Inventory
                          Where ValMthd = 'T'
                    IF @@ERROR <> 0 GOTO ABORT

                    Update ItemSite
                           Set PDirStdCst = Case When @Parm9 <> 0
                                                Then Round((PDirStdCst + @Parm9), @DecPlPrcCst)
                                                Else Case When PDirStdCst <> 0 and @Parm6 <> 0
                                                         Then Round((PDirStdCst * (1 + (@Parm6/100))), @DecPlPrcCst)
                                                         Else PDirStdCst
                                                     End
                                            End,
                               PFOvhStdCst = Case When @Parm10 <> 0
                                                Then Round((PFOvhStdCst + @Parm10), @DecPlPrcCst)
                                                Else Case When PFOvhStdCst <> 0 and @Parm7 <> 0
                                                         Then Round((PFOvhStdCst * (1 + (@Parm7/100))), @DecPlPrcCst)
                                                         Else PFOvhStdCst
                                                     End
                                             End,
                               PVOvhStdCst = Case When @Parm11 <> 0
                                                 Then Round((PVOvhStdCst + @Parm11), @DecPlPrcCst)
                                                 Else Case When PVOvhStdCst <> 0 and @Parm8 <> 0
                                                          Then Round((PVOvhStdCst * (1 + (@Parm8/100))), @DecPlPrcCst)
                                                          Else PVOvhStdCst
                                                      End
                                             End,
                               PStdCst = (Case When @Parm9 <> 0
                                                Then Round((PDirStdCst + @Parm9), @DecPlPrcCst)
                                                Else Case When PDirStdCst <> 0 and @Parm6 <> 0
                                                         Then Round((PDirStdCst * (1 + (@Parm6/100))), @DecPlPrcCst)
                                                         Else PDirStdCst
                                                     End
                                          End)
                                       + (Case When @Parm10 <> 0
                                                Then Round((PFOvhStdCst + @Parm10), @DecPlPrcCst)
                                                Else Case When PFOvhStdCst <> 0 and @Parm7 <> 0
                                                         Then Round((PFOvhStdCst * (1 + (@Parm7/100))), @DecPlPrcCst)
                                                         Else PFOvhStdCst
                                                     End
          End)
                                       + (Case When @Parm11 <> 0
                                                Then Round((PVOvhStdCst + @Parm11), @DecPlPrcCst)
                                                Else Case When PVOvhStdCst <> 0 and @Parm8 <> 0
                                                         Then Round((PVOvhStdCst * (1 + (@Parm8/100))), @DecPlPrcCst)
                                                         Else PVOvhStdCst
                                                     End
                                          End),
                               LUpd_DateTime = GetDate(),
                               LUpd_Prog = @Parm2,
                               LUpd_User = @Parm3
                           From ItemSite, Inventory
                           Where ItemSite.InvtId = Inventory.InvtId
                             And ValMthd = 'T'
                    IF @@ERROR <> 0 GOTO ABORT
                END                           -- IF @Parm5 <> 'P' (By Pending Standard Costs)

            IF @Parm5 = 'S' -- By Current Standard Costs
                BEGIN
                    Update Inventory
                           Set PDirStdCost = Case When @Parm9 <> 0
                                                 Then Round((DirStdCost + @Parm9), @DecPlPrcCst)
                                                 Else Case When DirStdCost <> 0 and @Parm6 <> 0
                                                          Then Round((DirStdCost * (1 + (@Parm6/100))), @DecPlPrcCst)
                                                          Else DirStdCost
                                                      End
                                             End,
                               PFOvhStdCost = Case When @Parm10 <> 0
                                                 Then Round((FOvhStdCost + @Parm10), @DecPlPrcCst)
                                                 Else Case When FOvhStdCost <> 0 and @Parm7 <> 0
                                                          Then Round((FOvhStdCost * (1 + (@Parm7/100))), @DecPlPrcCst)
                                                          Else FOvhStdCost
                                                      End
                                             End,
                               PVOvhStdCost = Case When @Parm11 <> 0
                                                 Then Round((VOvhStdCost + @Parm11), @DecPlPrcCst)
                                                 Else Case When VOvhStdCost <> 0 and @Parm8 <> 0
                                                          Then Round((VOvhStdCost * (1 + (@Parm8/100))), @DecPlPrcCst)
                                                          Else VOvhStdCost
                                                      End
                                             End,
                               PStdCost = (Case When @Parm9 <> 0
                                                 Then Round((DirStdCost + @Parm9), @DecPlPrcCst)
                                                 Else Case When DirStdCost <> 0 and @Parm6 <> 0
                                                          Then Round((DirStdCost * (1 + (@Parm6/100))), @DecPlPrcCst)
                                                          Else DirStdCost
                                                      End
                                             End)
                                        + (Case When @Parm10 <> 0
                                                 Then Round((FOvhStdCost + @Parm10), @DecPlPrcCst)
                                                 Else Case When FOvhStdCost <> 0 and @Parm7 <> 0
                                                          Then Round((FOvhStdCost * (1 + (@Parm7/100))), @DecPlPrcCst)
                                                          Else FOvhStdCost
  End
                                             End)
                                        + (Case When @Parm11 <> 0
                                                 Then Round((VOvhStdCost + @Parm11), @DecPlPrcCst)
                                                 Else Case When VOvhStdCost <> 0 and @Parm8 <> 0
                                                          Then Round((VOvhStdCost * (1 + (@Parm8/100))), @DecPlPrcCst)
                                                          Else VOvhStdCost
                                                      End
                                             End),
                               LUpd_DateTime = GetDate(),
                               LUpd_Prog = @Parm2,
                               LUpd_User = @Parm3
                           From Inventory
                          Where ValMthd = 'T'
                    IF @@ERROR <> 0 GOTO ABORT

                    Update ItemSite
                           Set PDirStdCst = Case When @Parm9 <> 0
                                                Then Round((DirStdCst + @Parm9), @DecPlPrcCst)
                                                Else Case When DirStdCst <> 0 and @Parm6 <> 0
                                                         Then Round((DirStdCst * (1 + (@Parm6/100))), @DecPlPrcCst)
                                                         Else DirStdCst
                                                     End
                                            End,
                               PFOvhStdCst = Case When @Parm10 <> 0
                                                Then Round((FOvhStdCst + @Parm10), @DecPlPrcCst)
                                                Else Case When FOvhStdCst <> 0 and @Parm7 <> 0
                                                         Then Round((FOvhStdCst * (1 + (@Parm7/100))), @DecPlPrcCst)
                                                         Else FOvhStdCst
                                                     End
                                             End,
                               PVOvhStdCst = Case When @Parm11 <> 0
                                                 Then Round((VOvhStdCst + @Parm11), @DecPlPrcCst)
                                                 Else Case When VOvhStdCst <> 0 and @Parm8 <> 0
                                                          Then Round((VOvhStdCst * (1 + (@Parm8/100))), @DecPlPrcCst)
                                                          Else VOvhStdCst
                                                      End
                                             End,
                               PStdCst = (Case When @Parm9 <> 0
                                                Then Round((DirStdCst + @Parm9), @DecPlPrcCst)
                                                Else Case When DirStdCst <> 0 and @Parm6 <> 0
                                                         Then Round((DirStdCst * (1 + (@Parm6/100))), @DecPlPrcCst)
                                                         Else DirStdCst
                                                     End
                                          End)
                                       + (Case When @Parm10 <> 0
                                                Then Round((FOvhStdCst + @Parm10), @DecPlPrcCst)
                                                Else Case When FOvhStdCst <> 0 and @Parm7 <> 0
                                                         Then Round((FOvhStdCst * (1 + (@Parm7/100))), @DecPlPrcCst)
                                                         Else FOvhStdCst
                                                     End
                                          End)
                                       + (Case When @Parm11 <> 0
                                                Then Round((VOvhStdCst + @Parm11), @DecPlPrcCst)
             Else Case When VOvhStdCst <> 0 and @Parm8 <> 0
                                                         Then Round((VOvhStdCst * (1 + (@Parm8/100))), @DecPlPrcCst)
                                                         Else VOvhStdCst
                                                     End
                                          End),
                               LUpd_DateTime = GetDate(),
                               LUpd_Prog = @Parm2,
                               LUpd_User = @Parm3
                           From ItemSite, Inventory
                           Where ItemSite.InvtId = Inventory.InvtId
                             And ValMthd = 'T'
                    IF @@ERROR <> 0 GOTO ABORT
                END                           -- IF @Parm5 <> 'S' (By Current Standard Costs)

            IF @Parm5 = 'Z' -- Zero Out Pending Standard Costs
                BEGIN
                    Update Inventory
                           Set PDirStdCost = Case When @Parm12 = '1'
                                                Then 0
                                                Else PDirStdCost
                                            End,
                               PFOvhStdCost = Case When @Parm13 = '1'
                                                Then 0
                                                Else PFOvhStdCost
                                              End,
                               PVOvhStdCost = Case When @Parm14 = '1'
                                                Then 0
                                                Else PVOvhStdCost
                                              End,
                               PStdCost = (Case When @Parm12 = '1'
                                                Then 0
                                                Else PDirStdCost
                                           End)
                                        + (Case When @Parm13 = '1'
                                                Then 0
                                                Else PFOvhStdCost
                                           End)
                                        + (Case When @Parm14 = '1'
                                                Then 0
                                                Else PVOvhStdCost
                                           End),
                               LUpd_DateTime = GetDate(),
                               LUpd_Prog = @Parm2,
                               LUpd_User = @Parm3
                           From Inventory
                          Where ValMthd = 'T'
                    IF @@ERROR <> 0 GOTO ABORT

                    Update ItemSite
                           Set PDirStdCst = Case When @Parm12 = '1'
                                                Then 0
                                                Else PDirStdCst
                                            End,
                               PFOvhStdCst = Case When @Parm13 = '1'
                                                Then 0
                                                Else PFOvhStdCost
                                             End,
                               PVOvhStdCst = Case When @Parm14 = '1'
                                                Then 0
                                                Else PVOvhStdCst
                                             End,
                               PStdCst = (Case When @Parm12 = '1'
                                                Then 0
                                                Else PDirStdCst
                                           End)
           + (Case When @Parm13 = '1'
                                                Then 0
                                                Else PFOvhStdCst
                                           End)
                                        + (Case When @Parm14 = '1'
                                                Then 0
                                                Else PVOvhStdCst
                                           End),
                               LUpd_DateTime = GetDate(),
                               LUpd_Prog = @Parm2,
                               LUpd_User = @Parm3
                           From ItemSite, Inventory
                           Where ItemSite.InvtId = Inventory.InvtId
                             And ValMthd = 'T'
                    IF @@ERROR <> 0 GOTO ABORT

                END                           -- IF @Parm5 <> 'Z' (Zero Out Pending Standard Costs)

            IF @Parm5 = 'A' -- By Pending Standard Costs
                BEGIN
                    Update ItemSite
                           Set PDirStdCst = Case When AvgCost <> 0 and @Parm12 = '1'
                                                Then Case When @Parm6 <> 0
                                                          Then Round((AvgCost * (1 + (@Parm6/100))), @DecPlPrcCst)
                                                          Else Round((AvgCost + @Parm9), @DecPlPrcCst)
                                                     End
                                            End,
                               PStdCst = (Case When AvgCost <> 0 and @Parm12 = '1'
                                                Then Case When @Parm6 <> 0
                                                         Then Round((AvgCost * (1 + (@Parm6/100))), @DecPlPrcCst)
                                                         Else Round((AvgCost + @Parm9), @DecPlPrcCst)
                                                     End
                                          End)
                                          + (PFOvhStdCst + PVOvhStdCst),
                               LUpd_DateTime = GetDate(),
                               LUpd_Prog = @Parm2,
                               LUpd_User = @Parm3
                           From ItemSite, Inventory
                           Where ItemSite.InvtId = Inventory.InvtId
                             And ValMthd = 'T'
                    IF @@ERROR <> 0 GOTO ABORT
                END                           -- IF @Parm5 <> 'A' (By Average Costs)

            IF @Parm5 = 'L' -- By Last Cost
                BEGIN
                    Update Inventory
                           Set PDirStdCost = Case When LastCost <> 0 and @Parm12 = '1'
                                                 Then Case When @Parm6 <> 0
                                                          Then Round((LastCost * (1 + (@Parm6/100))), @DecPlPrcCst)
                                                          Else Round((LastCost + @Parm9), @DecPlPrcCst)
                                                      End
                                             End,
                               PStdCost = (Case When LastCost <> 0 and @Parm12 = '1'
                                               Then Case When @Parm6 <> 0
                                                        Then Round((LastCost * (1 + (@Parm6/100))), @DecPlPrcCst)
                                                        Else Round((LastCost + @Parm9), @DecPlPrcCst)
                                                    End
                                           End)
                                        + (PFOvhStdCost + PVOvhStdCost),
                               LUpd_DateTime = GetDate(),
                               LUpd_Prog = @Parm2,
                               LUpd_User = @Parm3
                           From Inventory
                          Where ValMthd = 'T'
                    IF @@ERROR <> 0 GOTO ABORT

                    Update ItemSite
                           Set PDirStdCst = Case When ItemSite.LastCost <> 0 and @Parm12 = '1'
                                                Then Case When @Parm6 <> 0
                                                         Then Round((ItemSite.LastCost * (1 + (@Parm6/100))), @DecPlPrcCst)
                                                         Else Round((ItemSite.LastCost + @Parm9), @DecPlPrcCst)
                                                     End
                                                Else
                                                    Case When Inventory.LastCost <> 0 and @Parm12 = '1'
                                                        Then Case When @Parm6 <> 0
                                                                 Then Round((Inventory.LastCost * (1 + (@Parm6/100))), @DecPlPrcCst)
                                                                 Else Round((Inventory.LastCost + @Parm9), @DecPlPrcCst)
                                                             End
                                                    End
                                            End,
                               PStdCst = (Case When ItemSite.LastCost <> 0 and @Parm12 = '1'
                                             Then Case When @Parm6 <> 0
                                                      Then Round((ItemSite.LastCost * (1 + (@Parm6/100))), @DecPlPrcCst)
                                                      Else Round((ItemSite.LastCost + @Parm9), @DecPlPrcCst)
                                                  End
                                             Else
                                                 Case When Inventory.LastCost <> 0 and @Parm12 = '1'
                                                     Then Case When @Parm6 <> 0
                                                              Then Round((Inventory.LastCost * (1 + (@Parm6/100))), @DecPlPrcCst)
                                                              Else Round((Inventory.LastCost + @Parm9), @DecPlPrcCst)
                                                          End
                                                 End
                                         End)
                                         + (PFOvhStdCst + PVOvhStdCst),
                               LUpd_DateTime = GetDate(),
                               LUpd_Prog = @Parm2,
                               LUpd_User = @Parm3
                           From ItemSite, Inventory
                           Where ItemSite.InvtId = Inventory.InvtId
                             And ValMthd = 'T'
                    IF @@ERROR <> 0 GOTO ABORT
                END                           -- IF @Parm5 <> 'L' (by Last Cost)

        END                                   -- IF @Parm4 = '1' (All Items)

    IF @Parm4 <> '1'                          -- Selected Items
        BEGIN
            IF @Parm5 = 'P'                   -- By Pending Standard Costs
                BEGIN
                    Update Inventory
                           Set PDirStdCost = Case When @Parm9 <> 0
                                                 Then Round((PDirStdCost + @Parm9), @DecPlPrcCst)
                                                 Else Case When PDirStdCost <> 0 and @Parm6 <> 0
                                                          Then Round((PDirStdCost * (1 + (@Parm6/100))), @DecPlPrcCst)
                                                          Else PDirStdCost
                                                      End
                                             End,
                 PFOvhStdCost = Case When @Parm10 <> 0
                                                 Then Round((PFOvhStdCost + @Parm10), @DecPlPrcCst)
                                                 Else Case When PFOvhStdCost <> 0 and @Parm7 <> 0
                                                          Then Round((PFOvhStdCost * (1 + (@Parm7/100))), @DecPlPrcCst)
                                                          Else PFOvhStdCost
                                                      End
                                             End,
                               PVOvhStdCost = Case When @Parm11 <> 0
                                                 Then Round((PVOvhStdCost + @Parm11), @DecPlPrcCst)
                                                 Else Case When PVOvhStdCost <> 0 and @Parm8 <> 0
                                                          Then Round((PVOvhStdCost * (1 + (@Parm8/100))), @DecPlPrcCst)
                                                          Else PVOvhStdCost
                                                      End
                                             End,
                               PStdCost = (Case When @Parm9 <> 0
                                                 Then Round((PDirStdCost + @Parm9), @DecPlPrcCst)
                                                 Else Case When PDirStdCost <> 0 and @Parm6 <> 0
                                                          Then Round((PDirStdCost * (1 + (@Parm6/100))), @DecPlPrcCst)
                                                          Else PDirStdCost
                                                      End
                                             End)
                                        + (Case When @Parm10 <> 0
                                                 Then Round((PFOvhStdCost + @Parm10), @DecPlPrcCst)
                                                 Else Case When PFOvhStdCost <> 0 and @Parm7 <> 0
                                                          Then Round((PFOvhStdCost * (1 + (@Parm7/100))), @DecPlPrcCst)
                                                          Else PFOvhStdCost
                                                      End
                                             End)
                                        + (Case When @Parm11 <> 0
                                                 Then Round((PVOvhStdCost + @Parm11), @DecPlPrcCst)
                                                 Else Case When PVOvhStdCost <> 0 and @Parm8 <> 0
                                                          Then Round((PVOvhStdCost * (1 + (@Parm8/100))), @DecPlPrcCst)
                                                          Else PVOvhStdCost
                                                      End
                                             End),
                               LUpd_DateTime = GetDate(),
                               LUpd_Prog = @Parm2,
                               LUpd_User = @Parm3
                           From Inventory, IN10520_Wrk
                          Where ValMthd = 'T'
                            And @Parm1 = IN10520_Wrk.ComputerName
                            And Inventory.InvtId = IN10520_Wrk.InvtId
                    IF @@ERROR <> 0 GOTO ABORT

                    Update ItemSite
                           Set PDirStdCst = Case When @Parm9 <> 0
                                                Then Round((PDirStdCst + @Parm9), @DecPlPrcCst)
                                                Else Case When PDirStdCst <> 0 and @Parm6 <> 0
                                                         Then Round((PDirStdCst * (1 + (@Parm6/100))), @DecPlPrcCst)
                                                         Else PDirStdCst
                                                     End
                                            End,
                               PFOvhStdCst = Case When @Parm10 <> 0
                                                Then Round((PFOvhStdCst + @Parm10), @DecPlPrcCst)
                                                Else Case When PFOvhStdCst <> 0 and @Parm7 <> 0
                                                         Then Round((PFOvhStdCst * (1 + (@Parm7/100))), @DecPlPrcCst)
                                                         Else PFOvhStdCst
                                                     End
                                             End,
                               PVOvhStdCst = Case When @Parm11 <> 0
                                                Then Round((PVOvhStdCst + @Parm11), @DecPlPrcCst)
                                                Else Case When PVOvhStdCst <> 0 and @Parm8 <> 0
                                                         Then Round((PVOvhStdCst * (1 + (@Parm8/100))), @DecPlPrcCst)
                                                         Else PVOvhStdCst
                                                     End
                                             End,
                               PStdCst = (Case When @Parm9 <> 0
                                                Then Round((PDirStdCst + @Parm9), @DecPlPrcCst)
                                                Else Case When PDirStdCst <> 0 and @Parm6 <> 0
                                                         Then Round((PDirStdCst * (1 + (@Parm6/100))), @DecPlPrcCst)
                                                         Else PDirStdCst
                                                     End
                                          End)
                                       + (Case When @Parm10 <> 0
                                                Then Round((PFOvhStdCst + @Parm10), @DecPlPrcCst)
                                                Else Case When PFOvhStdCst <> 0 and @Parm7 <> 0
                                                         Then Round((PFOvhStdCst * (1 + (@Parm7/100))), @DecPlPrcCst)
                                                         Else PFOvhStdCst
                                                     End
                                          End)
                                       + (Case When @Parm11 <> 0
                                                Then Round((PVOvhStdCst + @Parm11), @DecPlPrcCst)
                                                Else Case When PVOvhStdCst <> 0 and @Parm8 <> 0
                                                         Then Round((PVOvhStdCst * (1 + (@Parm8/100))), @DecPlPrcCst)
                                                         Else PVOvhStdCst
                                                     End
                                          End),
                               LUpd_DateTime = GetDate(),
                               LUpd_Prog = @Parm2,
                               LUpd_User = @Parm3
                           From ItemSite, Inventory, IN10520_Wrk
                           Where ItemSite.InvtId = Inventory.InvtId
                             And ValMthd = 'T'
                             And @Parm1 = IN10520_Wrk.ComputerName
                             And Inventory.InvtId = IN10520_Wrk.InvtId
                    IF @@ERROR <> 0 GOTO ABORT

                END                           -- IF @Parm5 <> 'P' (Pending Standard Costs)

            IF @Parm5 = 'S'                   -- By Current Standard Costs
                BEGIN
                    Update Inventory
                           Set PDirStdCost = Case When @Parm9 <> 0
                                                 Then Round((DirStdCost + @Parm9), @DecPlPrcCst)
                                                 Else Case When DirStdCost <> 0 and @Parm6 <> 0
                                                          Then Round((DirStdCost * (1 + (@Parm6/100))), @DecPlPrcCst)
                                                          Else DirStdCost
                                                      End
                                             End,
                               PFOvhStdCost = Case When @Parm10 <> 0
                                                 Then Round((FOvhStdCost + @Parm10), @DecPlPrcCst)
                                                 Else Case When FOvhStdCost <> 0 and @Parm7 <> 0
                                                          Then Round((FOvhStdCost * (1 + (@Parm7/100))), @DecPlPrcCst)
                                                          Else FOvhStdCost
                                                      End
                                             End,
                               PVOvhStdCost = Case When @Parm11 <> 0
                                                 Then Round((VOvhStdCost + @Parm11), @DecPlPrcCst)
                                                 Else Case When VOvhStdCost <> 0 and @Parm8 <> 0
                                                          Then Round((VOvhStdCost * (1 + (@Parm8/100))), @DecPlPrcCst)
                                                          Else VOvhStdCost
                                                      End
                                             End,
                               PStdCost = (Case When @Parm9 <> 0
                                                 Then Round((DirStdCost + @Parm9), @DecPlPrcCst)
                                                 Else Case When DirStdCost <> 0 and @Parm6 <> 0
                                                          Then Round((DirStdCost * (1 + (@Parm6/100))), @DecPlPrcCst)
                                                          Else DirStdCost
                                                      End
                                             End)
                                        + (Case When @Parm10 <> 0
                                                 Then Round((FOvhStdCost + @Parm10), @DecPlPrcCst)
                                                 Else Case When FOvhStdCost <> 0 and @Parm7 <> 0
                                                          Then Round((FOvhStdCost * (1 + (@Parm7/100))), @DecPlPrcCst)
                                                          Else FOvhStdCost
                                                      End
                                             End)
                                        + (Case When @Parm11 <> 0
                                                 Then Round((VOvhStdCost + @Parm11), @DecPlPrcCst)
                                                 Else Case When VOvhStdCost <> 0 and @Parm8 <> 0
                                                          Then Round((VOvhStdCost * (1 + (@Parm8/100))), @DecPlPrcCst)
                                                          Else VOvhStdCost
                                                      End
                                             End),
                               LUpd_DateTime = GetDate(),
                               LUpd_Prog = @Parm2,
                               LUpd_User = @Parm3
                           From Inventory, IN10520_Wrk
                          Where ValMthd = 'T'
                            And @Parm1 = IN10520_Wrk.ComputerName
                            And Inventory.InvtId = IN10520_Wrk.InvtId
                    IF @@ERROR <> 0 GOTO ABORT

                    Update ItemSite
                           Set PDirStdCst = Case When @Parm9 <> 0
                                                Then Round((DirStdCst + @Parm9), @DecPlPrcCst)
                                                Else Case When DirStdCst <> 0 and @Parm6 <> 0
                                                         Then Round((DirStdCst * (1 + (@Parm6/100))), @DecPlPrcCst)
                                                         Else DirStdCst
                                                     End
                                            End,
                               PFOvhStdCst = Case When @Parm10 <> 0
                                                Then Round((FOvhStdCst + @Parm10), @DecPlPrcCst)
                                                Else Case When FOvhStdCst <> 0 and @Parm7 <> 0
                                                         Then Round((FOvhStdCst * (1 + (@Parm7/100))), @DecPlPrcCst)
                                                         Else FOvhStdCst
                                                     End
                                             End,
                               PVOvhStdCst = Case When @Parm11 <> 0
                                                Then Round((VOvhStdCst + @Parm11), @DecPlPrcCst)
                                                Else Case When VOvhStdCst <> 0 and @Parm8 <> 0
                                                         Then Round((VOvhStdCst * (1 + (@Parm8/100))), @DecPlPrcCst)
                                                         Else VOvhStdCst
                                                     End
                                             End,
                               PStdCst = (Case When @Parm9 <> 0
                                                Then Round((DirStdCst + @Parm9), @DecPlPrcCst)
                                                Else Case When DirStdCst <> 0 and @Parm6 <> 0
                                                         Then Round((DirStdCst * (1 + (@Parm6/100))), @DecPlPrcCst)
                                                         Else DirStdCst
                                                     End
                                          End)
                                       + (Case When @Parm10 <> 0
                                                Then Round((FOvhStdCst + @Parm10), @DecPlPrcCst)
                                                Else Case When FOvhStdCst <> 0 and @Parm7 <> 0
                                                         Then Round((FOvhStdCst * (1 + (@Parm7/100))), @DecPlPrcCst)
                                                         Else FOvhStdCst
                                                     End
                                          End)
                                       + (Case When @Parm11 <> 0
                                                Then Round((VOvhStdCst + @Parm11), @DecPlPrcCst)
                                                Else Case When VOvhStdCst <> 0 and @Parm8 <> 0
                                                         Then Round((VOvhStdCst * (1 + (@Parm8/100))), @DecPlPrcCst)
                                                         Else VOvhStdCst
                                                     End
                                          End),
                               LUpd_DateTime = GetDate(),
                               LUpd_Prog = @Parm2,
                               LUpd_User = @Parm3
                           From ItemSite, Inventory, IN10520_Wrk
                           Where ItemSite.InvtId = Inventory.InvtId
                             And ValMthd = 'T'
                             And @Parm1 = IN10520_Wrk.ComputerName
                             And Inventory.InvtId = IN10520_Wrk.InvtId
                    IF @@ERROR <> 0 GOTO ABORT

                END                            -- IF @Parm5 <> 'S' (Current Standard Costs)

            IF @Parm5 = 'Z'                     -- Zero Out Pending Standard Costs
                BEGIN
                    Update Inventory
                           Set PDirStdCost = Case When @Parm12 = '1'
                                                Then 0
                                                Else PDirStdCost
                                            End,
                               PFOvhStdCost = Case When @Parm13 = '1'
                         Then 0
                                                Else PFOvhStdCost                                            End,
                               PVOvhStdCost = Case When @Parm14 = '1'
                                                Then 0
                                                Else PVOvhStdCost                                            End,
                               PStdCost = (PDirStdCost + PFOvhStdCost + PVOvhStdCost),
                               LUpd_DateTime = GetDate(),
                               LUpd_Prog = @Parm2,
                               LUpd_User = @Parm3
                           From Inventory, IN10520_Wrk
                          Where ValMthd = 'T'
                            And @Parm1 = IN10520_Wrk.ComputerName
                            And Inventory.InvtId = IN10520_Wrk.InvtId
                    IF @@ERROR <> 0 GOTO ABORT

                    Update ItemSite
                           Set PDirStdCst = Case When @Parm12 = '1'
                                                Then 0
                                                Else PDirStdCst
                                            End,
                               PFOvhStdCst = Case When @Parm13 = '1'
                                                Then 0
                                                Else PFOvhStdCost                                            End,
                               PVOvhStdCst = Case When @Parm14 = '1'
                                                Then 0
                                                Else PVOvhStdCst                                            End,
                               PStdCst = (PDirStdCst + PFOvhStdCost + PVOvhStdCst),
                               LUpd_DateTime = GetDate(),
                               LUpd_Prog = @Parm2,
                               LUpd_User = @Parm3
                           From ItemSite, Inventory, IN10520_Wrk
                           Where ItemSite.InvtId = Inventory.InvtId
                             And ValMthd = 'T'
                             And @Parm1 = IN10520_Wrk.ComputerName
                             And Inventory.InvtId = IN10520_Wrk.InvtId
                    IF @@ERROR <> 0 GOTO ABORT

                END                             -- IF @Parm5 <> 'Z' (Zero Out Pending Standard Costs)

            IF @Parm5 = 'A' -- By Average Cost
                BEGIN
                    Update ItemSite
                           Set PDirStdCst = Case When AvgCost <> 0 and @Parm9 <> 0
                                                Then Round((AvgCost + @Parm9), @DecPlPrcCst)
                                                Else Case When AvgCost <> 0 and @Parm6 <> 0
                                                         Then Round((AvgCost * (1 + (@Parm6/100))), @DecPlPrcCst)
                                                         Else AvgCost
                                                     End
                                            End,
                               PStdCst = (Case When AvgCost <> 0 and @Parm9 <> 0
                                                Then Round((AvgCost + @Parm9), @DecPlPrcCst)
                                                Else Case When AvgCost <> 0 and @Parm6 <> 0
                                                         Then Round((AvgCost * (1 + (@Parm6/100))), @DecPlPrcCst)
                                                         Else AvgCost
                                                     End
                                          End)
                                       + (PFOvhStdCst + PFOvhStdCst),
                               LUpd_DateTime = GetDate(),
                               LUpd_Prog = @Parm2,
                               LUpd_User = @Parm3
                           From ItemSite, Inventory, IN10520_Wrk
                           Where ItemSite.InvtId = Inventory.InvtId
                             And ValMthd = 'T'
                             And @Parm1 = IN10520_Wrk.ComputerName
                             And Inventory.InvtId = IN10520_Wrk.InvtId
                    IF @@ERROR <> 0 GOTO ABORT

                END                           -- IF @Parm5 <> 'A' (Average Costs)

            IF @Parm5 = 'L' -- By Last Cost
                BEGIN
                    Update Inventory
                           Set PDirStdCost = Case When LastCost <> 0 and @Parm12 = '1'
                                                 Then Case When @Parm6 <> 0
                                                          Then Round((LastCost * (1 + (@Parm6/100))), @DecPlPrcCst)
                                                          Else Round((LastCost + @Parm9), @DecPlPrcCst)
                                                      End
                                             End,
                               PStdCost = (Case When LastCost <> 0 and @Parm12 = '1'
                                               Then Case When @Parm6 <> 0
                                                        Then Round((LastCost * (1 + (@Parm6/100))), @DecPlPrcCst)
                                                        Else Round((LastCost + @Parm9), @DecPlPrcCst)
                                                    End
                                           End)
                                        + (PFOvhStdCost + PVOvhStdCost),
                               LUpd_DateTime = GetDate(),
                               LUpd_Prog = @Parm2,
                               LUpd_User = @Parm3
                           From Inventory, IN10520_Wrk
                          Where ValMthd = 'T'
                            And @Parm1 = IN10520_Wrk.ComputerName
                            And Inventory.InvtId = IN10520_Wrk.InvtId
                    IF @@ERROR <> 0 GOTO ABORT

                    Update ItemSite
                           Set PDirStdCst = Case When ItemSite.LastCost <> 0 and @Parm12 = '1'
                                                Then Case When @Parm6 <> 0
                                                         Then Round((ItemSite.LastCost * (1 + (@Parm6/100))), @DecPlPrcCst)
                                                         Else Round((ItemSite.LastCost + @Parm9), @DecPlPrcCst)
                                                     End
                                                Else
                                                    Case When Inventory.LastCost <> 0 and @Parm12 = '1'
                                                        Then Case When @Parm6 <> 0
                                                                 Then Round((Inventory.LastCost * (1 + (@Parm6/100))), @DecPlPrcCst)
                                                                 Else Round((Inventory.LastCost + @Parm9), @DecPlPrcCst)
                                                             End
                                                    End
                                            End,
                               PStdCst = (Case When ItemSite.LastCost <> 0 and @Parm12 = '1'
                                             Then Case When @Parm6 <> 0
                                                      Then Round((ItemSite.LastCost * (1 + (@Parm6/100))), @DecPlPrcCst)
                                                      Else Round((ItemSite.LastCost + @Parm9), @DecPlPrcCst)
                                                  End
                                             Else
                                                 Case When Inventory.LastCost <> 0 and @Parm12 = '1'
                                                     Then Case When @Parm6 <> 0
     Then Round((Inventory.LastCost * (1 + (@Parm6/100))), @DecPlPrcCst)
                                                              Else Round((Inventory.LastCost + @Parm9), @DecPlPrcCst)
                                                          End
                                                 End
                                         End)
                                         + (PFOvhStdCst + PVOvhStdCst),
                               LUpd_DateTime = GetDate(),
                               LUpd_Prog = @Parm2,
                               LUpd_User = @Parm3
                           From ItemSite, Inventory, IN10520_Wrk
                           Where ItemSite.InvtId = Inventory.InvtId
                             And ValMthd = 'T'
                             And @Parm1 = IN10520_Wrk.ComputerName
                             And Inventory.InvtId = IN10520_Wrk.InvtId
                    IF @@ERROR <> 0 GOTO ABORT
                END                           -- IF @Parm5 <> 'L' (by Last Cost)

        END                                   -- IF @Parm4 <> '1' (Selected Items)

    COMMIT TRANSACTION
    Goto Finish

ABORT:
    ROLLBACK TRANSACTION

Finish:
-- Purge Work Records
    DELETE FROM IN10520_Wrk
          WHERE ComputerName = @Parm1
--             Or Crtd_DateTime < GetDate() - 1

--   Select @Process_Flag


