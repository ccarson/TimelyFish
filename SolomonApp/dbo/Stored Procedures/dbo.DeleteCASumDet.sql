 /****** Object:  Stored Procedure dbo.DeleteCASumDet    Script Date: 3/10/03 ******/
CREATE PROCEDURE DeleteCASumDet
        @DelPer         VARCHAR ( 6),
        @DelPerEndDate  SMALLDATETIME,
        @ProcessName    VARCHAR (5),    -- the same as bpes.ScreenNbr in caller screen
        @UserName       VARCHAR (10)    -- the same as bpes.UserID in caller screen

AS
        DECLARE @LedgerID       CHAR (10)
        DECLARE @BaseCuryID     CHAR (4)
        DECLARE @GLPostOpt      CHAR (1)
        DECLARE @AcceptTransDate        SMALLDATETIME
        SELECT
                @BaseCuryID = BaseCuryID,
                @LedgerID = LedgerID
        FROM GLSetup WITH (NOLOCK)
        IF @@ERROR <> 0 OR @@ROWCOUNT <> 1 GOTO Abort
        SELECT
                @GLPostOpt = GLPostOpt,
                @AcceptTransDate = AcceptTransDate
        FROM CASetup WITH (NOLOCK)
        IF @@ERROR <> 0 OR @@ROWCOUNT <> 1 GOTO Abort
        DECLARE @TodayDate SMALLDATETIME
        SET @TodayDate = CONVERT (SMALLDATETIME, CONVERT (VARCHAR(8),GETDATE(),112),112)
        BEGIN TRANSACTION
        IF @@ERROR <> 0 GOTO Abort
        -- CashSummD
        CREATE TABLE #CashSumDInfo      (
                CpnyID                  VARCHAR (10),
                BankAcct                VARCHAR (10),
                BankSub                 VARCHAR (24),
                CuryID                  VARCHAR (4),
                Receipts                FLOAT,
                Disbursements           FLOAT,
                CuryReceipts            FLOAT,
                CuryDisbursements       FLOAT   )
        IF @@ERROR <> 0 GOTO Abort
        INSERT INTO #CashSumDInfo
        SELECT CpnyID, BankAcct, BankSub, CuryID, SUM (Receipts), SUM (Disbursements), SUM (CuryReceipts), SUM (CuryDisbursements)
        FROM CashSumD
        WHERE PerNbr <= @DelPer
        GROUP BY CpnyID, BankAcct, BankSub, CuryID
        IF @@ERROR <> 0 GOTO Abort
        DELETE CashSumD WHERE PerNbr <= @DelPer
        IF @@ERROR <> 0 GOTO Abort
        INSERT INTO CashSumD    (
                BankAcct, BankSub, ConCuryDisbursements, ConCuryReceipts,
                Condisbursements, ConReceipts, CpnyID,
                Crtd_DateTime, Crtd_Prog, Crtd_User,
                CuryDisbursements, CuryID, CuryReceipts, Disbursements,
                LUpd_DateTime, LUpd_Prog, LUpd_User,
                NoteID, PerNbr, Receipts,
                S4Future01, S4Future02, S4Future03, S4Future04, S4Future05, S4Future06,
                S4Future07, S4Future08, S4Future09, S4Future10, S4Future11, S4Future12,
                TranDate,
                User1, User2, User3, User4, User5, User6, User7, User8)
        SELECT
                BankAcct, BankSub, 0, 0,
                0, 0, CpnyID,
                @TodayDate, @ProcessName, @UserName,
                CuryDisbursements, CuryID, CuryReceipts, Disbursements,
                @TodayDate, @ProcessName, @UserName,
                0, @DelPer, Receipts,
                '', '', 0, 0, 0, 0,
                '19000101', '19000101', 0, 0, '', '',
                @DelPerEndDate,
                '', '', 0, 0, '', '', '19000101', '19000101'
        FROM #CashSumDInfo
        IF @@ERROR <> 0 GOTO Abort
        DROP TABLE #CashSumDInfo

        -- CATran
        CREATE TABLE #BatchesToDelete (
                BatNbr  VARCHAR (10),
                Status CHAR (1) )
        IF @@ERROR <> 0 GOTO Abort
        CREATE UNIQUE CLUSTERED INDEX #BatchesToDelete_IDX0 ON #BatchesToDelete (BatNbr)
        IF @@ERROR <> 0 GOTO Abort
        INSERT INTO #BatchesToDelete
        SELECT BatNbr, Status FROM Batch
        WHERE
                        Module = 'CA'
                AND     Status in ('V', 'C', 'P')
                AND     PerPost <= @DelPer
        IF @@ERROR <> 0 GOTO Abort

        CREATE TABLE #CATranInfo (
                BankCpnyID      VARCHAR (10),
                BankAcct        VARCHAR (10),
                BankSub         VARCHAR (24),
                ClearAmt        FLOAT,
                ClearDate       SMALLDATETIME,
                CuryID          VARCHAR (4),
                CuryMultDiv     CHAR (1),
                CuryRate        FLOAT,
                CuryTranAmt     FLOAT,
                DrCr            CHAR (1),
                Qty		FLOAT,
                TranAmt         FLOAT           )

        INSERT INTO #CATranInfo
        SELECT
                BankCpnyID, BankAcct, BankSub, SUM (ClearAmt), CASE WHEN MAX (ClearDate) = '19000101' THEN @DelPerEndDate ELSE MAX (ClearDate) END,
                CuryID, '', 0, SUM (CuryTranAmt),
                CASE WHEN DrCr = 'D' THEN
                        CASE WHEN cat.EntryID = 'TR' THEN 'C' ELSE 'D' END
                ELSE
                        CASE WHEN cat.EntryID = 'TR' THEN 'D' ELSE 'C' END
                END,
                SUM (Qty),
                SUM (TranAmt)
        FROM CATran cat
                JOIN #BatchesToDelete btd ON cat.BatNbr = btd.BatNbr
        WHERE
                        btd.Status <> 'V'
                AND     cat.EntryID <> 'ZZ'
        GROUP BY BankCpnyID, BankAcct, BankSub, CuryID,
                        CASE WHEN DrCr = 'D' THEN
                                CASE WHEN cat.EntryID = 'TR' THEN 'C' ELSE 'D' END
                        ELSE
                                CASE WHEN cat.EntryID = 'TR' THEN 'D' ELSE 'C' END
                        END
        IF @@ERROR <> 0 GOTO Abort

        UPDATE #CATranInfo
        SET
                CuryMultDiv = (CASE WHEN ABS (TranAmt) >= ABS (CuryTranAmt) THEN 'M' ELSE 'D' END),
                CuryRate = (    CASE WHEN ABS (TranAmt) >= ABS (CuryTranAmt) THEN
                                        CASE WHEN CuryTranAmt = 0 THEN 1 ELSE TranAmt/CuryTranAmt END
                                ELSE CASE WHEN TranAmt = 0 THEN 1 ELSE CuryTranAmt/TranAmt END END )
        IF @@ERROR <> 0 GOTO Abort

        DELETE #CATranInfo
        FROM #CATranInfo cati JOIN Currncy  c (NOLOCK) ON cati.CuryID = c.CuryID
        WHERE ROUND (cati.CuryTranAmt, c.DecPl) = 0
        IF @@ERROR <> 0 GOTO Abort

        DELETE Batch
        FROM Batch b INNER JOIN
                #BatchesToDelete btd ON b.Module = 'CA' AND b.BatNbr = btd.BatNbr
        IF @@ERROR <> 0 GOTO Abort

        DELETE CATran
        FROM CATran cat INNER JOIN
                #BatchesToDelete btd ON cat.BatNbr = btd.BatNbr
        IF @@ERROR <> 0 GOTO Abort

        -- calculate nrs of batches to create
        CREATE TABLE #BatchNumeration (
                SerialNr        INT             NULL, -- 0...
                BatNbr          VARCHAR (10)    NULL,
                BankCpnyID      VARCHAR (10),
                BankAcct        VARCHAR (10),
                BankSub         VARCHAR (24),
                CuryID          VARCHAR (4) )
        IF @@ERROR <> 0 GOTO Abort
        CREATE UNIQUE CLUSTERED INDEX #BatchNumeration_IDX0 ON #BatchNumeration (BankCpnyID, BankAcct, BankSub, CuryID)
        IF @@ERROR <> 0 GOTO Abort
        INSERT INTO #BatchNumeration
        SELECT NULL, NULL, BankCpnyID, BankAcct, BankSub, CuryID
        FROM  #CATranInfo cati
        GROUP BY BankCpnyID, BankAcct, BankSub, CuryID
        IF @@ERROR <> 0 GOTO Abort
        UPDATE #BatchNumeration
        SET SerialNr = (
                SELECT COUNT (*)
                FROM #BatchNumeration i
                WHERE           i.BankCpnyID < o.BankCpnyID
                        OR (i.BankCpnyID = o.BankCpnyID AND i.BankAcct < o.BankAcct)
                        OR (i.BankCpnyID = o.BankCpnyID AND i.BankAcct = o.BankAcct AND i.BankSub < o.BankSub)
                        OR (i.BankCpnyID = o.BankCpnyID AND i.BankAcct = o.BankAcct AND i.BankSub = o.BankSub AND i.CuryID < o.CuryID) )
        FROM #BatchNumeration o
        IF @@ERROR <> 0 GOTO Abort
        DECLARE @LastBatNbr     VARCHAR (10)
        DECLARE @LastBatNbrInt  INT
        DECLARE @BatNbrLen      INT
        SELECT @LastBatNbr = LTRIM (RTRIM (CASetup.LastBatNbr)) FROM CASetup
        IF @@ERROR <> 0 OR @@ROWCOUNT <> 1 GOTO Abort
        SET @BatNbrLen = LEN (@LastBatNbr)
        IF @BatNbrLen = 0 SET @BatNbrLen = 6
        IF ISNUMERIC (@LastBatNbr) = 1
                SET @LastBatNbrInt = CAST (@LastBatNbr AS INT)
        ELSE
                SET @LastBatNbrInt = 0
        UPDATE #BatchNumeration
        SET BatNbr =
                CASE WHEN LEN (LTRIM (RTRIM(CAST ((@LastBatNbrInt + SerialNr + 1) AS VARCHAR (10))))) <= @BatNbrLen THEN
                        RIGHT ('0000000000' + CAST ((@LastBatNbrInt + SerialNr + 1) AS VARCHAR (10)), @BatNbrLen)
                ELSE
                        CAST ((@LastBatNbrInt + SerialNr + 1) AS VARCHAR (10))
                END
        IF @@ERROR <> 0 GOTO Abort

        DECLARE @MaxBatNbr CHAR (10)
        SELECT @MaxBatNbr = MAX (BatNbr) FROM #BatchNumeration
        IF @@ERROR <> 0 GOTO Abort
        UPDATE CASetup  SET LastBatNbr = @MaxBatNbr WHERE @MaxBatNbr IS NOT NULL
        IF @@ERROR <> 0 GOTO Abort

        -- OA trans
        INSERT INTO CATran (
                Acct, AcctDist, bankacct, BankCpnyID,
                banksub, batnbr, ClearAmt, ClearDate,
                CpnyID,
                Crtd_DateTime, Crtd_Prog, Crtd_User,
                CuryID, CuryMultDiv, CuryRate, curytranamt,
                DrCr, EntryId, EmployeeID, JrnlType, Labor_Class_Cd, LineID,
                Linenbr, LineRef,
                LUpd_DateTime, LUpd_Prog, LUpd_User,
                Module, NoteID, PayeeID, PC_Flag, PC_ID, PC_Status,
                PerClosed, Perent, PerPost, ProjectID, Qty,
                RcnclStatus, RecurId, RefNbr, Rlsed,
                S4Future01, S4Future02, S4Future03, S4Future04, S4Future05, S4Future06,
                S4Future07, S4Future08, S4Future09, S4Future10, S4Future11, S4Future12,
                Sub, TaskID, TranAmt, TranDate,
                TranDesc, trsftobankacct, trsftobanksub, TrsfToCpnyID,
                User1, User2, User3, User4, User5, User6, User7, User8 )
        SELECT
                et.DfltAcct, 1, cati.BankAcct, cati.BankCpnyID,
                cati.BankSub,  bn.BatNbr, cati.ClearAmt, cati.ClearDate,
                cati.BankCpnyID,
                @TodayDate, @ProcessName, @UserName,
                cati.CuryID, cati.CuryMultDiv, cati.CuryRate, cati.CuryTranAmt,
                cati.DrCr, et.EntryID, '', 'CA', '', 1,
                -32768, '',
                @TodayDate, @ProcessName, @UserName,
                'CA', 0, '', '', '', '',
                '', @DelPer, @DelPer, '', cati.Qty,
                'C', '', 'DummyOA', 1,
                '', '', 0, 0, 0, 0,
                '19000101', '19000101', 0, 0, '', '',
                et.DfltSub, '', cati.TranAmt, @DelPerEndDate,
                'Dummy OA tran', '', '', '',
                '', '', 0, 0, '', '', '19000101', '19000101'
        FROM #CATranInfo cati
                JOIN EntryTyp et ON et.EntryID = 'OA'
                JOIN #BatchNumeration bn ON
                                bn.BankCpnyID = cati.BankCpnyID
                        AND     bn.BankAcct = cati.BankAcct
                        AND     bn.BankSub = cati.BankSub
                        AND     bn.CuryID = cati.CuryID
        WHERE cati.DrCr = 'D'
        IF @@ERROR <> 0 GOTO Abort
        -- OD trans
        INSERT INTO CATran (
                Acct, AcctDist, bankacct, BankCpnyID,
                banksub, batnbr, ClearAmt, ClearDate,
                CpnyID,
                Crtd_DateTime, Crtd_Prog, Crtd_User,
                CuryID, CuryMultDiv, CuryRate, curytranamt,
   DrCr, EntryId, EmployeeID, JrnlType, Labor_Class_Cd, LineID,
                Linenbr, LineRef,
                LUpd_DateTime, LUpd_Prog, LUpd_User,
                Module, NoteID, PayeeID, PC_Flag, PC_ID, PC_Status,
                PerClosed, Perent, PerPost, ProjectID, Qty,
                RcnclStatus, RecurId, RefNbr, Rlsed,
                S4Future01, S4Future02, S4Future03, S4Future04, S4Future05, S4Future06,
                S4Future07, S4Future08, S4Future09, S4Future10, S4Future11, S4Future12,
                Sub, TaskID, TranAmt, TranDate,
                TranDesc, trsftobankacct, trsftobanksub, TrsfToCpnyID,
                User1, User2, User3, User4, User5, User6, User7, User8 )
        SELECT
                et.DfltAcct, 1, cati.BankAcct, cati.BankCpnyID,
                cati.BankSub,  bn.BatNbr, cati.ClearAmt, cati.ClearDate,
                cati.BankCpnyID,
                @TodayDate, @ProcessName, @UserName,
                cati.CuryID, cati.CuryMultDiv, cati.CuryRate, cati.CuryTranAmt,
                cati.DrCr, et.EntryID, '', 'CA', '', 2,
                -32767, '',
                @TodayDate, @ProcessName, @UserName,
                'CA', 0, '', '', '', '',
                '', @DelPer, @DelPer, '', cati.Qty,
                'C', '', 'DummyOD', 1,
                '', '', 0, 0, 0, 0,
                '19000101', '19000101', 0, 0, '', '',
                et.DfltSub, '', cati.TranAmt, @DelPerEndDate,
                'Dummy OD tran', '', '', '',
                '', '', 0, 0, '', '', '19000101', '19000101'
        FROM #CATranInfo cati
                JOIN EntryTyp et ON et.EntryID = 'OD'
                JOIN #BatchNumeration bn ON
                                bn.BankCpnyID = cati.BankCpnyID
                        AND     bn.BankAcct = cati.BankAcct
                        AND     bn.BankSub = cati.BankSub
                        AND     bn.CuryID = cati.CuryID
        WHERE cati.DrCr = 'C'
        IF @@ERROR <> 0 GOTO Abort
        -- ZZ trans
        INSERT INTO CATran (
                Acct, AcctDist, bankacct, BankCpnyID,
                banksub, batnbr, ClearAmt, ClearDate,
                CpnyID,
                Crtd_DateTime, Crtd_Prog, Crtd_User,
                CuryID,
                CuryMultDiv,
                CuryRate,
                curytranamt,
                DrCr, EntryId, EmployeeID, JrnlType, Labor_Class_Cd, LineID,
                Linenbr, LineRef,
                LUpd_DateTime, LUpd_Prog, LUpd_User,
                Module, NoteID, PayeeID, PC_Flag, PC_ID, PC_Status,
                PerClosed, Perent, PerPost, ProjectID, Qty,
                RcnclStatus, RecurId, RefNbr, Rlsed,
                S4Future01, S4Future02, S4Future03, S4Future04, S4Future05, S4Future06,
                S4Future07, S4Future08, S4Future09, S4Future10, S4Future11, S4Future12,
                Sub, TaskID, TranAmt, TranDate,
                TranDesc, trsftobankacct, trsftobanksub, TrsfToCpnyID,
                User1, User2, User3, User4, User5, User6, User7, User8 )
        SELECT
                cati.BankAcct, 1, cati.BankAcct, cati.BankCpnyID,
                cati.BankSub,  bn.BatNbr, 0, '19000101',
                cati.BankCpnyID,
                @TodayDate, @ProcessName, @UserName,
                cati.CuryID,
                CASE WHEN ABS (SUM (CASE WHEN cati.DrCr = 'D' THEN TranAmt ELSE -TranAmt END)) >= ABS (SUM (CASE WHEN cati.DrCr = 'D' THEN CuryTranAmt ELSE -CuryTranAmt END)) THEN 'M' ELSE 'D' END,
                CASE WHEN ABS (SUM (CASE WHEN cati.DrCr = 'D' THEN TranAmt ELSE -TranAmt END)) >= ABS (SUM (CASE WHEN cati.DrCr = 'D' THEN CuryTranAmt ELSE -CuryTranAmt END))
                THEN
                        CASE WHEN SUM (CASE WHEN cati.DrCr = 'D' THEN CuryTranAmt ELSE -CuryTranAmt END) = 0 THEN 1 ELSE ABS (SUM (CASE WHEN cati.DrCr = 'D' THEN TranAmt ELSE -TranAmt END)) / ABS (SUM (CASE WHEN cati.DrCr = 'D' THEN CuryTranAmt ELSE -CuryTranAmt END)) END
                ELSE
                        CASE WHEN SUM (CASE WHEN cati.DrCr = 'D' THEN TranAmt ELSE -TranAmt END) = 0 THEN 1 ELSE ABS (SUM (CASE WHEN cati.DrCr = 'D' THEN CuryTranAmt ELSE -CuryTranAmt END)) / ABS (SUM (CASE WHEN cati.DrCr = 'D' THEN TranAmt ELSE -TranAmt END)) END
                END,
                ABS (SUM (CASE WHEN cati.DrCr = 'D' THEN CuryTranAmt ELSE -CuryTranAmt END)),
                CASE WHEN SUM (CASE WHEN cati.DrCr = 'D' THEN TranAmt ELSE -TranAmt END) >= 0 THEN 'C' ELSE 'D' END,
                'ZZ', '', 'CA', '', 0,
                32767, '',
                @TodayDate, @ProcessName, @UserName,
                'CA', 0, '', '', '', '',
                '', @DelPer, @DelPer, '', ABS (SUM (CASE WHEN cati.DrCr = 'D' THEN Qty ELSE -Qty END)),
                '', '', 'Offset', 1,
                '', '', 0, 0, 0, 0,
                '19000101', '19000101', 0, 0, '', '',
                cati.BankSub, '',
                ABS (SUM (CASE WHEN cati.DrCr = 'D' THEN TranAmt ELSE -TranAmt END)),
                @DelPerEndDate,
                'Dummy offset', '', '', '',
                '', '', 0, 0, '', '', '19000101', '19000101'
        FROM #CATranInfo cati
                JOIN #BatchNumeration bn ON
                                bn.BankCpnyID = cati.BankCpnyID
                        AND     bn.BankAcct = cati.BankAcct
                        AND     bn.BankSub = cati.BankSub
                        AND     bn.CuryID = cati.CuryID
        GROUP BY cati.BankCpnyID, cati.BankAcct, cati.BankSub, cati.CuryID, bn.BatNbr
        IF @@ERROR <> 0 GOTO Abort

        -- Batch
        INSERT INTO Batch (
                Acct, AutoRev, AutoRevCopy, BalanceType,
                BankAcct, BankSub, BaseCuryID, BatNbr,
                BatType, clearamt, Cleared, CpnyID,
                Crtd_DateTime, Crtd_Prog, Crtd_User,
                CrTot,
                CtrlTot,
                CuryCrTot,
                CuryCtrlTot,
                CuryDepositAmt,
                CuryDrTot,
                CuryEffDate, CuryId,
                CuryMultDiv,
                CuryRate,
                CuryRateType, Cycle,
                DateClr, DateEnt, DepositAmt, Descr,
                DrTot,
                EditScrnNbr, GLPostOpt, JrnlType, LedgerID,
                LUpd_DateTime, LUpd_Prog, LUpd_User,
                Module, NbrCycle, NoteID, OrigBatNbr,
                OrigCpnyID, OrigScrnNbr, PerEnt, PerPost, Rlsed,
                S4Future01, S4Future02, S4Future03, S4Future04, S4Future05, S4Future06,
                S4Future07, S4Future08, S4Future09, S4Future10, S4Future11, S4Future12,
                Status, Sub,
                User1, User2, User3, User4, User5, User6, User7, User8, VOBatNbrForPP )
        SELECT
                '', 0, 0, 'A',
                '', '', @BaseCuryID, bn.BatNbr,
                'N', 0, 0, cati.BankCpnyID,
                @TodayDate, @ProcessName, @UserName,
                CASE WHEN SUM (CASE WHEN cati.DrCr = 'D' THEN cati.TranAmt ELSE 0 END) >= SUM (CASE WHEN cati.DrCr = 'C' THEN cati.TranAmt ELSE 0 END)
                THEN
                        SUM (CASE WHEN cati.DrCr = 'D' THEN cati.TranAmt ELSE 0 END)
                ELSE
                        SUM (CASE WHEN cati.DrCr = 'C' THEN cati.TranAmt ELSE 0 END)
                END,
                ABS (SUM (CASE WHEN cati.DrCr = 'D' THEN cati.TranAmt ELSE -cati.TranAmt END)),
                CASE WHEN SUM (CASE WHEN cati.DrCr = 'D' THEN cati.CuryTranAmt ELSE 0 END) > SUM (CASE WHEN cati.DrCr = 'C' THEN cati.CuryTranAmt ELSE 0 END)
                THEN
                        SUM (CASE WHEN cati.DrCr = 'D' THEN cati.CuryTranAmt ELSE 0 END)
                ELSE
                        SUM (CASE WHEN cati.DrCr = 'C' THEN cati.CuryTranAmt ELSE 0 END)
                END,
                ABS (SUM (CASE WHEN cati.DrCr = 'D' THEN cati.CuryTranAmt ELSE -cati.CuryTranAmt END)),
                0,
                CASE WHEN SUM (CASE WHEN cati.DrCr = 'D' THEN cati.CuryTranAmt ELSE 0 END) > SUM (CASE WHEN cati.DrCr = 'C' THEN cati.CuryTranAmt ELSE 0 END)
                THEN
                        SUM (CASE WHEN cati.DrCr = 'D' THEN cati.CuryTranAmt ELSE 0 END)
                ELSE
                        SUM (CASE WHEN cati.DrCr = 'C' THEN cati.CuryTranAmt ELSE 0 END)
                END,
                @DelPerEndDate, cati.CuryID,
                CASE WHEN (
                        CASE WHEN SUM (CASE WHEN cati.DrCr = 'D' THEN cati.TranAmt ELSE 0 END) > SUM (CASE WHEN cati.DrCr = 'C' THEN cati.TranAmt ELSE 0 END)
                        THEN
                                SUM (CASE WHEN cati.DrCr = 'D' THEN cati.TranAmt ELSE 0 END)
                        ELSE
                                SUM (CASE WHEN cati.DrCr = 'C' THEN cati.TranAmt ELSE 0 END)
                        END ) >=
                        ( CASE WHEN SUM (CASE WHEN cati.DrCr = 'D' THEN cati.CuryTranAmt ELSE 0 END) > SUM (CASE WHEN cati.DrCr = 'C' THEN cati.CuryTranAmt ELSE 0 END)
                        THEN
                                SUM (CASE WHEN cati.DrCr = 'D' THEN cati.CuryTranAmt ELSE 0 END)
                        ELSE
                                SUM (CASE WHEN cati.DrCr = 'C' THEN cati.CuryTranAmt ELSE 0 END)
                        END )
                THEN 'M' ELSE 'D' END,
                CASE WHEN (
                        CASE WHEN SUM (CASE WHEN cati.DrCr = 'D' THEN cati.TranAmt ELSE 0 END) > SUM (CASE WHEN cati.DrCr = 'C' THEN cati.TranAmt ELSE 0 END)
                        THEN
                                SUM (CASE WHEN cati.DrCr = 'D' THEN cati.TranAmt ELSE 0 END)
                        ELSE
                                SUM (CASE WHEN cati.DrCr = 'C' THEN cati.TranAmt ELSE 0 END)
                        END ) >
                        ( CASE WHEN SUM (CASE WHEN cati.DrCr = 'D' THEN cati.CuryTranAmt ELSE 0 END) > SUM (CASE WHEN cati.DrCr = 'C' THEN cati.CuryTranAmt ELSE 0 END)
                        THEN
                                SUM (CASE WHEN cati.DrCr = 'D' THEN cati.CuryTranAmt ELSE 0 END)
                        ELSE
                                SUM (CASE WHEN cati.DrCr = 'C' THEN cati.CuryTranAmt ELSE 0 END)
                        END )
                THEN
                        CASE WHEN
                                ( CASE WHEN SUM (CASE WHEN cati.DrCr = 'D' THEN cati.CuryTranAmt ELSE 0 END) > SUM (CASE WHEN cati.DrCr = 'C' THEN cati.CuryTranAmt ELSE 0 END)
                                THEN
                                        SUM (CASE WHEN cati.DrCr = 'D' THEN cati.CuryTranAmt ELSE 0 END)
                                ELSE
                                        SUM (CASE WHEN cati.DrCr = 'C' THEN cati.CuryTranAmt ELSE 0 END)
                                END ) = 0
                        THEN 1
                        ELSE
                                ( CASE WHEN SUM (CASE WHEN cati.DrCr = 'D' THEN cati.TranAmt ELSE 0 END) > SUM (CASE WHEN cati.DrCr = 'C' THEN cati.TranAmt ELSE 0 END)
                                THEN
                                        SUM (CASE WHEN cati.DrCr = 'D' THEN cati.TranAmt ELSE 0 END)
                                ELSE
                                        SUM (CASE WHEN cati.DrCr = 'C' THEN cati.TranAmt ELSE 0 END)
                                END ) /
                                ( CASE WHEN SUM (CASE WHEN cati.DrCr = 'D' THEN cati.CuryTranAmt ELSE 0 END) > SUM (CASE WHEN cati.DrCr = 'C' THEN cati.CuryTranAmt ELSE 0 END)
                                THEN
                                        SUM (CASE WHEN cati.DrCr = 'D' THEN cati.CuryTranAmt ELSE 0 END)
                                ELSE
                                        SUM (CASE WHEN cati.DrCr = 'C' THEN cati.CuryTranAmt ELSE 0 END)
                                END )
                        END
                ELSE
                        CASE WHEN
                                ( CASE WHEN SUM (CASE WHEN cati.DrCr = 'D' THEN cati.TranAmt ELSE 0 END) > SUM (CASE WHEN cati.DrCr = 'C' THEN cati.TranAmt ELSE 0 END)
                                THEN
                                        SUM (CASE WHEN cati.DrCr = 'D' THEN cati.TranAmt ELSE 0 END)
                                ELSE
                                        SUM (CASE WHEN cati.DrCr = 'C' THEN cati.TranAmt ELSE 0 END)
                                END ) = 0
                        THEN 1
                        ELSE
                                ( CASE WHEN SUM (CASE WHEN cati.DrCr = 'D' THEN cati.CuryTranAmt ELSE 0 END) > SUM (CASE WHEN cati.DrCr = 'C' THEN cati.CuryTranAmt ELSE 0 END)
                                THEN
                                        SUM (CASE WHEN cati.DrCr = 'D' THEN cati.CuryTranAmt ELSE 0 END)
                                ELSE
                                        SUM (CASE WHEN cati.DrCr = 'C' THEN cati.CuryTranAmt ELSE 0 END)
                                END ) /
                                ( CASE WHEN SUM (CASE WHEN cati.DrCr = 'D' THEN cati.TranAmt ELSE 0 END) > SUM (CASE WHEN cati.DrCr = 'C' THEN cati.TranAmt ELSE 0 END)
                                THEN
                                        SUM (CASE WHEN cati.DrCr = 'D' THEN cati.TranAmt ELSE 0 END)
                                ELSE
                                        SUM (CASE WHEN cati.DrCr = 'C' THEN cati.TranAmt ELSE 0 END)
                                END )
                        END
                END,
                '', 0,
                '19000101', @DelPerEndDate, 0, 'Cash Management Dummy Tran',
                CASE WHEN SUM (CASE WHEN cati.DrCr = 'D' THEN cati.TranAmt ELSE 0 END) > SUM (CASE WHEN cati.DrCr = 'C' THEN cati.TranAmt ELSE 0 END)
                THEN
                        SUM (CASE WHEN cati.DrCr = 'D' THEN cati.TranAmt ELSE 0 END)
                ELSE
                        SUM (CASE WHEN cati.DrCr = 'C' THEN cati.TranAmt ELSE 0 END)
                END,
                '20010', @GLPostOpt, 'CA', @LedgerID,
                @TodayDate, @ProcessName, @UserName,
                'CA', 0, 0, '',
                '', '', @DelPer, @DelPer, 1,
                '', '', 0, 0, 0, 0,
                '19000101', '19000101', 0, 0, '', '',
                'C', '',
                '', '', 0, 0, '', '', '19000101', '19000101', ''
        FROM #CATranInfo cati
                JOIN #BatchNumeration bn ON
                                bn.BankCpnyID = cati.BankCpnyID
                        AND     bn.BankAcct = cati.BankAcct
                        AND     bn.BankSub = cati.BankSub
                        AND     bn.CuryID = cati.CuryID
        GROUP BY cati.BankCpnyID, cati.BankAcct, cati.BankSub, cati.CuryID, bn.BatNbr
        IF @@ERROR <> 0 GOTO Abort
        IF @AcceptTransDate <= @DelPerEndDate BEGIN
                UPDATE CASetup SET AcceptTransDate = DATEADD (Day, 1, @DelPerEndDate)
                IF @@ERROR <> 0 GOTO Abort
        END
        COMMIT TRANSACTION
        IF @@ERROR <> 0 GOTO Abort
        GOTO Complete
        Abort:
        IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION
        Complete:



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DeleteCASumDet] TO [MSDSL]
    AS [dbo];

