 Create Proc pp_10520_Process_Class
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
    IF @Parm4 = '1'                           -- Selected Items
        BEGIN
            IF @Parm5 = 'P'                   -- By Pending OverHead Rates

                BEGIN
                    Update ProductClass
                           Set PFOvhMatlRate = Case When PFOvhMatlRate <> 0 and @Parm10 <> 0
                                                 Then Round((PFOvhMatlRate + @Parm10), @DecPlPrcCst)
                                                 Else Case When PFOvhMatlRate <> 0 and @Parm7 <> 0
                                                          Then Round((PFOvhMatlRate * (1 + (@Parm7/100))), @DecPlPrcCst)
                                                          Else PFOvhMatlRate
                                                      End
                                             End,
                               PVOvhMatlRate = Case When PVOvhMatlRate <> 0 and @Parm11 <> 0
                                                 Then Round((PVOvhMatlRate + @Parm11), @DecPlPrcCst)
                                                 Else Case When PVOvhMatlRate <> 0 and @Parm8 <> 0
                                                          Then Round((PVOvhMatlRate * (1 + (@Parm8/100))), @DecPlPrcCst)
                                                          Else PVOvhMatlRate                                                      End
                                             End,
                               LUpd_DateTime = GetDate(),
                               LUpd_Prog = @Parm2,
                               LUpd_User = @Parm3
                           From ProductClass
                    IF @@ERROR <> 0 GOTO ABORT

                END                           -- IF @Parm5 = 'P' (By Pending OverHead Rates)

            IF @Parm5 = 'S'                   -- By Current Standard Costs
                BEGIN
                    Update ProductClass
                           Set PFOvhMatlRate = Case When CFOvhMatlRate <> 0 and @Parm10 <> 0
                                                 Then Round((CFOvhMatlRate + @Parm10), @DecPlPrcCst)
                                                 Else Case When CFOvhMatlRate <> 0 and @Parm7 <> 0
                                                          Then Round((CFOvhMatlRate * (1 + (@Parm7/100))), @DecPlPrcCst)
                                                          Else CFOvhMatlRate
                                                      End
                                             End,
                               PVOvhMatlRate = Case When CVOvhMatlRate <> 0 and @Parm11 <> 0
                                                 Then Round((CVOvhMatlRate + @Parm11), @DecPlPrcCst)
                                                 Else Case When CVOvhMatlRate <> 0 and @Parm8 <> 0
                                                          Then Round((CVOvhMatlRate * (1 + (@Parm8/100))), @DecPlPrcCst)
                                                          Else CVOvhMatlRate
                                                      End
                                             End,
                               LUpd_DateTime = GetDate(),
                               LUpd_Prog = @Parm2,
                               LUpd_User = @Parm3
                           From ProductClass
                    IF @@ERROR <> 0 GOTO ABORT

                END                           -- IF @Parm5 = 'S' (By Current Standard OverHead Rates)

            IF @Parm5 = 'Z' -- Zero Out OverHead Rates
                BEGIN
                    Update ProductClass
                           Set PFOvhMatlRate = Case When @Parm13 = '1'
                                                Then 0
                                                Else PFOvhMatlRate
                                            End,
                               PVOvhMatlRate = Case When @Parm14 = '1'
                                                Then 0
                                                Else PVOvhMatlRate
                                            End,
                               LUpd_DateTime = GetDate(),
                               LUpd_Prog = @Parm2,
                               LUpd_User = @Parm3
                           From ProductClass
                    IF @@ERROR <> 0 GOTO ABORT

                END                            -- IF @Parm5 <> 'Z' (Zero Out OverHead Rates)

        End                                    -- IF @Parm4 <> '1' (All Items)

    IF @Parm4 <> '1'                           -- Selected Items
        BEGIN
            IF @Parm5 = 'P'                    -- By Pending OverHead Rates
                BEGIN
                    Update ProductClass
                           Set PFOvhMatlRate = Case When PFOvhMatlRate <> 0 and @Parm10 <> 0
                                                 Then Round((PFOvhMatlRate + @Parm10), @DecPlPrcCst)
                                                 Else Case When PFOvhMatlRate <> 0 and @Parm7 <> 0
                                                          Then Round((PFOvhMatlRate * (1 + (@Parm7/100))), @DecPlPrcCst)
                                                          Else PFOvhMatlRate
                                                      End
                                             End,
                               PVOvhMatlRate = Case When PVOvhMatlRate <> 0 and @Parm11 <> 0
                                                 Then Round((PVOvhMatlRate + @Parm11), @DecPlPrcCst)
                                                 Else Case When PVOvhMatlRate <> 0 and @Parm8 <> 0
                                                          Then Round((PVOvhMatlRate * (1 + (@Parm8/100))), @DecPlPrcCst)
                                                          Else PVOvhMatlRate
                                                      End
                                             End,
                               LUpd_DateTime = GetDate(),
                               LUpd_Prog = @Parm2,
                               LUpd_User = @Parm3
                           From ProductClass, IN10520_Wrk
                          Where @Parm1 = IN10520_Wrk.ComputerName
                            And ProductClass.ClassId = IN10520_Wrk.ClassId
                    IF @@ERROR <> 0 GOTO ABORT

                END                           -- IF @Parm5 = 'P' (Pending OverHead Rates)

            IF @Parm5 = 'S' -- By Current OverHead Rates
                BEGIN
                    Update ProductClass
                           Set PFOvhMatlRate = Case When CFOvhMatlRate <> 0 and @Parm10 <> 0
                                                 Then Round((CFOvhMatlRate + @Parm10), @DecPlPrcCst)
                                                 Else Case When CFOvhMatlRate <> 0 and @Parm7 <> 0
                                                          Then Round((CFOvhMatlRate * (1 + (@Parm7/100))), @DecPlPrcCst)
                                                          Else CFOvhMatlRate
                                                      End
                                               End,
                               PVOvhMatlRate = Case When CVOvhMatlRate <> 0 and @Parm11 <> 0
                                                 Then Round((CVOvhMatlRate + @Parm11), @DecPlPrcCst)
                                                 Else Case When CVOvhMatlRate <> 0 and @Parm8 <> 0
                                                          Then Round((CVOvhMatlRate * (1 + (@Parm8/100))), @DecPlPrcCst)
                                                          Else CVOvhMatlRate
                                                      End
                                               End,
                               LUpd_DateTime = GetDate(),
                               LUpd_Prog = @Parm2,
                               LUpd_User = @Parm3
                           From ProductClass, IN10520_Wrk
                          Where @Parm1 = IN10520_Wrk.ComputerName
                            And ProductClass.ClassId = IN10520_Wrk.ClassId
                    IF @@ERROR <> 0 GOTO ABORT

                END                           -- IF @Parm5 = 'S' (Current OverHead Rates)

            IF @Parm5 = 'Z' -- Zero Out Pending OverHead Rates
                BEGIN
                    Update ProductClass
                           Set PFOvhMatlRate = Case When @Parm13 = '1'
                                                Then 0
                                                Else PFOvhMatlRate
                                            End,
                               PVOvhMatlRate = Case When @Parm14 = '1'
                                                Then 0
                                                Else PVOvhMatlRate
                                            End,
                               LUpd_DateTime = GetDate(),
                               LUpd_Prog = @Parm2,
                               LUpd_User = @Parm3
                           From ProductClass, IN10520_Wrk
                          Where @Parm1 = IN10520_Wrk.ComputerName
                            And ProductClass.ClassId = IN10520_Wrk.ClassId
                    IF @@ERROR <> 0 GOTO ABORT

                END                           -- IF @Parm5 = 'Z' (Zero Out Pending OverHead Rates)

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


