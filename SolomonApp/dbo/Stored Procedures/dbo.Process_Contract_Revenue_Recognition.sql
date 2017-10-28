 CREATE PROCEDURE Process_Contract_Revenue_Recognition @StartDate SMALLDATETIME, @EndDate SMALLDATETIME, @AllBranch VARCHAR(1), @BranchID VARCHAR(10),
        @CpnyID VARCHAR(10), @UserID VARCHAR(10), @ScrnNbr VARCHAR(5), @UserAddress VARCHAR(21)
WITH EXECUTE AS '07718158D19D4f5f9D23B55DBF5DF1'
as
-- =======================================================================================================
-- Process_Contract_Revenue_Recognition.crp
-- Create GL Batches and GLTrans associated with RevDate in SmContractRev record.
--
-- Parameters:
-- @StartDate, @EndDate - Date range to process
-- @AllBranch           - Include All Branches (Y/N)
-- @BranchID            - Entered Branch ID, used when @AllBranch is N
-- @CpnyID              - bPes.CpnyID
-- @UserID              - bPes.UserID
-- @ScrnNbr             - bPes.ScrnNbr
-- @UserAddress         - bPes.ComputerName
-- =======================================================================================================

SET NOCOUNT ON

DECLARE @LastBatNbr      VARCHAR(10)
      , @LedgerID        VARCHAR(10)
      , @ARPerEnt        VARCHAR(6)
      , @GLRtTpDflt      VARCHAR(6)
      , @Period          VARCHAR(6)
      , @BatNbr_Len      SMALLINT
      , @BatNbr_Str      VARCHAR(10)
      , @SQlError        INTEGER
      , @GL_PerNbr       VARCHAR(6)
      , @ValidateAcctSub VARCHAR(1)
      , @BaseCuryID      VARCHAR(4)
      , @LineOffset      INTEGER
      , @WrkPeriod       VARCHAR(6)
      , @WrkRevDate      SMALLDATETIME

--Figure out what fields are needed below, then update the fields below
CREATE TABLE #smWrkContractRev
 ( RevPeriod    CHAR(6)
 , ContractID   CHAR(10)
 , RevAmount    FLOAT
 , RevDate      SMALLDATETIME
 , SalesAcct    CHAR(10)
 , SalesSub     CHAR(24)
 , ReserveAcct  CHAR(10)
 , ReserveSub   CHAR(24)
 , ContractAcct CHAR(10)
 , ContractSub  CHAR(24)
 , ContractType CHAR(10)
 , CustID       CHAR(15)
 , SiteID       CHAR(12)
 , CpnyID       CHAR(10)
 , RecordId     INT IDENTITY(-32767, 2)
 )

SELECT @ValidateAcctSub = ValidateAcctSub
 FROM GLSetup (NOLOCK)

-- Get Period Number from ARSetup record
SELECT @ARPerEnt = PerNbr
 FROM ARSetup (NOLOCK)

-- Get Rate Default from CMSetup record
SELECT @GLRtTpDflt = GLRtTpDflt
 FROM CMSetup (NOLOCK)

-- Process
BEGIN TRAN
    -- Lock smContractRev
    UPDATE smContractRev
     SET ContractID = smContractRev.ContractID
     FROM smContractRev
     INNER JOIN smContract
      ON smContract.ContractID = smContractRev.ContractID
       AND smContract.Status = 'A' -- Active
       AND ((@AllBranch <> 'Y'
             AND smContract.BranchId = @BranchID)
            OR (@AllBranch = 'Y'
                AND EXISTS (SELECT *
                             FROM smBranch
                             WHERE smBranch.CpnyID = @CpnyID
                              AND smBranch.BranchId = smContract.BranchId)))
     WHERE smContractRev.RevDate BETWEEN @StartDate AND @EndDate
       AND smContractRev.RevFlag = 0
       AND smContractRev.Status = 'O'
       AND smContractRev.RevAmount <> 0 -- No need to look if there's no revenue

    -- Lock smContract
    UPDATE smContract
     SET ContractID = smContract.ContractID
     FROM smContractRev
     INNER JOIN smContract
      ON smContract.ContractID = smContractRev.ContractID
       AND smContract.Status = 'A' -- Active
       AND ((@AllBranch <> 'Y'
             AND smContract.BranchId = @BranchID)
            OR (@AllBranch = 'Y'
                AND EXISTS (SELECT *
                             FROM smBranch
                             WHERE smBranch.CpnyID = @CpnyID
                              AND smBranch.BranchId = smContract.BranchId)))
     WHERE smContractRev.RevDate BETWEEN @StartDate AND @EndDate
       AND smContractRev.RevFlag = 0
       AND smContractRev.Status = 'O'
       AND smContractRev.RevAmount <> 0 -- No need to look if there's no revenue

    -- Build work table
        INSERT INTO #smWrkContractRev
         ( RevPeriod
         , ContractID
         , RevAmount
         , RevDate
         , SalesAcct
         , SalesSub
         , ReserveAcct
         , ReserveSub
         , ContractAcct
         , ContractSub
         , ContractType
         , CustID
         , SiteID
         , CpnyID
         )
         SELECT ''
              , smContractRev.ContractID
              , smContractRev.RevAmount
              , smContractRev.RevDate
              , smContractRev.SalesAcct
              , smContractRev.SalesSub
              , ''
              , ''
              , ''
              , ''
              , smContract.ContractType
              , smContract.CustID
              , smContract.SiteID
              , smContract.CpnyID
          FROM smContractRev
           INNER JOIN smContract
            ON smContract.ContractID = smContractRev.ContractID
             AND smContract.Status = 'A' -- Active
             AND ((@AllBranch <> 'Y'
                   AND smContract.BranchId = @BranchID)
                  OR (@AllBranch = 'Y'
                      AND EXISTS (SELECT *
                                   FROM smBranch
                                   WHERE smBranch.CpnyID = @CpnyID
                                    AND smBranch.BranchId = smContract.BranchId)))
          WHERE smContractRev.RevDate BETWEEN @StartDate AND @EndDate
           AND smContractRev.RevFlag = 0
           AND smContractRev.Status = 'O'
           AND smContractRev.RevAmount <> 0 -- No need to look if there's no revenue
          ORDER BY smContractRev.RevDate
                 , smContractRev.ContractId

    -- Update the period field based on the revdate
    -- Use a cursor rather than create a user-defined function to use in the INSERT statement above.
    DECLARE wrkCursor CURSOR LOCAL FOR SELECT DISTINCT RevDate FROM #smWrkContractRev
    OPEN wrkCursor
    FETCH NEXT FROM wrkCursor INTO @WrkRevDate
    WHILE (@@FETCH_STATUS = 0)	-- For each revdate in the table
    BEGIN
        SET @WrkPeriod = ''
        -- This is the stored proc the original vb code called
        EXEC ADG_GLPeriod_GetPerFromDateOut @WrkRevDate, 0, @WrkPeriod OUTPUT
        UPDATE wrk
         SET RevPeriod = @WrkPeriod
         FROM #smWrkContractRev wrk
         WHERE RevDate = @WrkRevDate

        FETCH NEXT FROM wrkCursor INTO @WrkRevDate
    END
    CLOSE wrkCursor
    DEALLOCATE wrkCursor

    -- First clear any records from another run of this proc.
    DELETE smWrkContractRevRec
     WHERE UserAddress = @UserAddress
      AND MsgType IN ('B','G','T')

    -- Log those with no Agreement Type and delete from the work table.
    -- Message type for these is 'T' for Contract Type
    INSERT INTO smWrkContractRevRec
     ( BatNbr
     , ContractId
     , ContractType
     , MsgType
     , UserAddress
     )
     SELECT ''
          , wrk.ContractID
          , wrk.ContractType
          , 'T'
          , @UserAddress
      FROM #smWrkContractRev wrk
       LEFT OUTER JOIN smAgreement
        ON smAgreement.AgreementTypeID = wrk.ContractType
      WHERE smAgreement.AgreementTypeID IS NULL

    DELETE wrk
     FROM #smWrkContractRev wrk
      LEFT OUTER JOIN smAgreement
       ON smAgreement.AgreementTypeID = wrk.ContractType
     WHERE smAgreement.AgreementTypeID IS NULL

    -- Update the Accounts and SubAccounts in the WorkTable.
    UPDATE wrk
     SET ContractAcct = wrk.SalesAcct
       , ReserveAcct  = smAgreement.ReserveAcct
       , ContractSub  = CASE WHEN smAgreement.SubFromSite = '1' THEN
                                 CASE WHEN ISNULL(smSOAddress.Sub,' ') <> ' ' THEN
                                          smSOAddress.Sub
                                      ELSE wrk.SalesSub
                                 END
                             ELSE wrk.SalesSub
   END
       , ReserveSub   = CASE WHEN smAgreement.SubFromSite = '1' THEN
                                 CASE WHEN ISNULL(smSOAddress.Sub,' ') <> ' ' THEN
                                          smSOAddress.Sub
                                      ELSE smAgreement.ReserveSub
                                 END
                             ELSE smAgreement.ReserveSub
                        END
     FROM #smWrkContractRev wrk
      INNER JOIN smAgreement
       ON smAgreement.AgreementTypeID = wrk.ContractType
      LEFT OUTER JOIN smSOAddress
       ON smSOAddress.Custid = wrk.Custid
        AND smSOAddress.ShipTOID = wrk.SiteID

    IF @ValidateAcctSub = 1
    BEGIN
      -- Log the invalid (Credit) deferred Account and SubAccount combination and remove from the work table
        -- Message type for these is 'G' for GL Acct/Sub
        INSERT INTO smWrkContractRevRec
         ( BatNbr
         , ContractId
         , ContractType
         , MsgType
         , UserAddress
         )
         SELECT ''
              , wrk.ContractID
              , wrk.ContractType
              , 'G'
              , @UserAddress
          FROM #smWrkContractRev wrk
           LEFT OUTER JOIN VS_AcctSub ValidAcctSub
            ON ValidAcctSub.Acct = wrk.ContractAcct
             AND ValidAcctSub.Sub = wrk.ContractSub
             AND ValidAcctSub.CpnyID = wrk.CpnyID
             AND ValidAcctSub.Active = 1
          WHERE ValidAcctSub.Acct IS NULL
         DELETE wrk
         FROM #smWrkContractRev wrk
          LEFT OUTER JOIN VS_AcctSub ValidAcctSub
           ON ValidAcctSub.Acct = wrk.ContractAcct -- smContractRev.SalesAcct
            AND ValidAcctSub.Sub = wrk.ContractSub
            AND ValidAcctSub.CpnyID = wrk.CpnyID
            AND ValidAcctSub.Active = 1
         WHERE ValidAcctSub.Acct IS NULL

        -- Log the invalid (Debit) contract receivable Account and SubAccount combination and remove from the work table
        -- Message type for these is 'G' for GL Acct/Sub
        INSERT INTO smWrkContractRevRec
         ( BatNbr
         , ContractId
         , ContractType
         , MsgType
         , UserAddress
         )
         SELECT ''
              , wrk.ContractID
              , wrk.ContractType
              , 'G'
              , @UserAddress
          FROM #smWrkContractRev wrk
           LEFT OUTER JOIN VS_AcctSub ValidAcctSub
            ON ValidAcctSub.Acct = wrk.ReserveAcct -- smAgreeement.ReservAcct
             AND ValidAcctSub.Sub = wrk.ReserveSub
             AND ValidAcctSub.CpnyID = wrk.CpnyID
             AND ValidAcctSub.Active = 1
          WHERE ValidAcctSub.Acct IS NULL

        DELETE wrk
         FROM #smWrkContractRev wrk
          LEFT OUTER JOIN VS_AcctSub ValidAcctSub
           ON ValidAcctSub.Acct = wrk.ReserveAcct
            AND ValidAcctSub.Sub = wrk.ReserveSub
            AND ValidAcctSub.CpnyID = wrk.CpnyID
            AND ValidAcctSub.Active = 1
         WHERE ValidAcctSub.Acct IS NULL
    END -- @ValidateAcctSub = 1

    --Lock GLSetup
    UPDATE GLSetup
     SET [Init] = [Init]

    -- Get Last Batch Number and Ledger ID from GLSetup record
    SELECT @BaseCuryID = BaseCuryID
         , @LastBatNbr = LastBatNbr
         , @LedgerID   = LedgerID
         , @BatNbr_Len = LEN(LTRIM(LastBatNbr)) -- Determines Batch Number Mask Length
         , @GL_PerNbr  = PerNbr
     FROM GLSetup (NOLOCK)

    --Create cursor to retrieve the Period
    DECLARE Process_Cursor CURSOR LOCAL
     FOR SELECT RevPeriod, MIN(RecordId) + 32767
          FROM #smWrkContractRev
          GROUP BY RevPeriod
    OPEN Process_Cursor

    FETCH NEXT FROM Process_Cursor INTO @Period, @LineOffset
    WHILE (@@FETCH_STATUS = 0)
    BEGIN -- Create the batches for each period
        INCR_BATNBR:
        SET @LastBatNbr = @LastBatNbr + 1
        -- Convert the Last Batch Number into a string with the length equal to defined mask and zero padded on the left.
        SET @BatNbr_Str = RIGHT(REPLICATE('0', @BatNbr_Len) + CAST(@LastBatNbr AS VARCHAR(10)), @BatNbr_Len)

        INSERT INTO Batch
         ( AutoRev, AutoRevCopy, BatNbr, BatType, Descr
         , EditScrnNbr, GlPostOpt, JrnlType, Module, PerEnt
         , PerPost, Rlsed, Status, Crtd_DateTime, Crtd_Prog
         , Crtd_User, Lupd_DateTime, Lupd_Prog, Lupd_User, NbrCycle
         , CrTot, CtrlTot, CuryCrTot
         , CuryCtrlTot, CuryDrtot, DrTot
         , CuryDepositAmt, Cycle, Acct, BalanceType
         , BankAcct, BankSub, BaseCuryID, ClearAmt, Cleared
         , CpnyID, CuryEffDate, CuryID, CuryMultDiv, CuryRate
         , CuryRateType, DateClr, DateEnt, DepositAmt
         , LedgerID, NoteID, OrigBatNbr, origCpnyID, OrigScrnNbr, Sub
         , S4Future01, S4Future02, S4Future03, S4Future04, S4Future05
         , S4Future06, S4Future07, S4Future08, S4Future09, S4Future10
         , S4Future11, S4Future12, User1, User2, User3
         , User4, User5, User6, User7, User8, VOBatNbrForPP
         )
         SELECT 0, 0, @BatNbr_Str , 'N', 'Revenue Recognition'
              , '01010', 'D', 'RE', 'GL', @ARPerEnt
              , @Period, 1, 'U', GETDATE(), @ScrnNbr
              , @UserID, GETDATE(), @ScrnNbr, @UserID, 0
              , SUM(ABS(wrk.RevAmount)), SUM(ABS(wrk.RevAmount)), SUM(ABS(wrk.RevAmount))
              , SUM(ABS(wrk.RevAmount)), SUM(ABS(wrk.RevAmount)), SUM(ABS(wrk.RevAmount))
              , 0, 0, '', 'A'
              , '', '', @BaseCuryID, 0,  0
              , @CpnyId, GETDATE(), @BaseCuryID, 'M', 1.00
              , ISNULL(@GLRtTpDflt, SPACE(1)), '', GETDATE(), 0
              , @LedgerID, 0, '', '', '', ''
              , '', '', 0, 0, 0
              , 0, '', '', 0, 0
              , '', '', '', '', 0
              , 0, '', '', '', '', ''
          FROM #smWrkContractRev wrk
          WHERE wrk.RevPeriod = @Period

        SET @SQLError = @@ERROR
        -- SQL Error Number 2627:  Cannot insert duplicate key in object.
        IF  @SQLError = 2627 GOTO INCR_BATNBR
        -- If another error occured.
        IF @SQLError <> 0 GOTO ABORT

        -- Record the batches created by this process
        -- Message Type for thise is B for Batch
        INSERT INTO smWrkContractRevRec
         ( BatNbr
         , ContractId
         , ContractType
         , MsgType
         , UserAddress
         )
         VALUES (@BatNbr_Str, '', '', 'B', @UserAddress)

        -- Update GLSetup with the Last Batch Number
        UPDATE GLSetup
         SET LastBatNbr = @BatNbr_Str
        IF @SQLError <> 0 GOTO ABORT

        -- Create Credit side
        INSERT INTO GLTran
         ( Acct, AppliedDate, BalanceType, BaseCuryID, BatNbr
         , CpnyID, CrAmt
         , Crtd_DateTime, Crtd_Prog, Crtd_User
         , CuryCrAmt
         , CuryDrAmt
         , CuryEffDate, CuryID, CuryMultDiv, CuryRate, CuryRateType
         , DrAmt, EmployeeID, ExtRefNbr
         , FiscYr, IC_Distribution, [ID], JrnlType, Labor_Class_Cd
         , LedgerID, LineID, LineNbr, LineRef, LUpd_DateTime
         , LUpd_Prog, LUpd_User, Module, NoteID, OrigAcct
         , OrigBatNbr, OrigCpnyID, OrigSub, PC_Flag, PC_ID
         , PC_Status, PerEnt, PerPost, Posted, ProjectID
         , Qty, RefNbr, RevEntryOption, Rlsed, S4Future01
         , S4Future02, S4Future03, S4Future04, S4Future05, S4Future06
         , S4Future07, S4Future08, S4Future09, S4Future10, S4Future11
         , S4Future12, ServiceDate, Sub, TaskID, TranDate
         , TranDesc, TranType, Units, User1, User2
         , User3, User4, User5, User6, User7, User8
         )
         SELECT wrk.ContractAcct, '', 'A', @BaseCuryID, @BatNbr_Str
              , wrk.CpnyID, CrAmt = CASE WHEN wrk.RevAmount > 0 THEN wrk.RevAmount ELSE 0.00 END
              , GETDATE(), @ScrnNbr, @UserID
              , CuryCramt = CASE WHEN wrk.RevAmount > 0 THEN wrk.RevAmount ELSE 0.00 END
              , CuryDrAmt = CASE WHEN wrk.RevAmount >= 0 THEN 0.00 ELSE ABS(wrk.RevAmount) END
              , GETDATE(), @BaseCuryID, 'M', 1, ISNULL(@GLRtTpDflt, SPACE(1))
              , DrAmt = CASE WHEN wrk.RevAmount >= 0 THEN 0.00 ELSE ABS(wrk.RevAmount) END, '', wrk.ContractID
              , LEFT(@Period, 4), 0, '', 'RE', ''
              , @LedgerID, 0, wrk.RecordID - @LineOffset, '', GETDATE()
              , @ScrnNbr, @UserID, 'GL', 0, ''
              , '', @CpnyID, '', 'N', ''
              , 0, @GL_PerNbr, @Period, 'U', ''
              , 1, wrk.ContractID, '', 1, ''
              , '', 0, 0, 0, 0
              , GETDATE(), '', 0, 0, 'C'
       , '', '', wrk.ContractSub, '', GETDATE()
              , 'RECOGNIZE REVENUE', 'GL', 0, '', ''
              , 0, 0, '', '', '', ''
          FROM #smWrkContractRev wrk
          WHERE wrk.RevPeriod = @Period

        SET @SQLError = @@ERROR
        IF @SQLError <> 0 GOTO ABORT

        -- Create side two
        INSERT INTO GLTran
         ( Acct, AppliedDate, BalanceType, BaseCuryID, BatNbr
         , CpnyID, CrAmt
         , Crtd_DateTime, Crtd_Prog, Crtd_User
         , CuryCrAmt
         , CuryDrAmt
         , CuryEffDate, CuryID, CuryMultDiv, CuryRate, CuryRateType
         , DrAmt, EmployeeID, ExtRefNbr
         , FiscYr, IC_Distribution, [ID], JrnlType, Labor_Class_Cd
         , LedgerID, LineID, LineNbr, LineRef, LUpd_DateTime
         , LUpd_Prog, LUpd_User, Module, NoteID, OrigAcct
         , OrigBatNbr, OrigCpnyID, OrigSub, PC_Flag, PC_ID
         , PC_Status, PerEnt, PerPost, Posted, ProjectID
         , Qty, RefNbr, RevEntryOption, Rlsed, S4Future01
         , S4Future02, S4Future03, S4Future04, S4Future05, S4Future06
         , S4Future07, S4Future08, S4Future09, S4Future10, S4Future11
         , S4Future12, ServiceDate, Sub, TaskID, TranDate
         , TranDesc, TranType, Units, User1, User2
         , User3, User4, User5, User6, User7, User8
         )
         SELECT wrk.ReserveAcct, '', 'A', @BaseCuryID, @BatNbr_Str
              , wrk.CpnyID, CrAmt = CASE WHEN wrk.RevAmount >= 0 THEN 0.00 ELSE ABS(wrk.RevAmount) END
              , GETDATE(), @ScrnNbr, @UserID
              , CuryCramt = CASE WHEN wrk.RevAmount >= 0 THEN 0.00 ELSE ABS(wrk.RevAmount) END
              , CuryDrAmt = CASE WHEN wrk.RevAmount > 0 THEN wrk.RevAmount ELSE 0.00 END
              , GETDATE(), @BaseCuryID, 'M', 1, ISNULL(@GLRtTpDflt, SPACE(1))
              , DrAmt = CASE WHEN wrk.RevAmount > 0 THEN wrk.RevAmount ELSE 0.00 END, '', wrk.ContractID
              , Left(@Period, 4), 0, '', 'RE', ''
              , @LedgerID, 0, (wrk.RecordID - @LineOffset) + 1, '', GETDATE()
              , @ScrnNbr, @UserID, 'GL', 0, ''
              , '', @CpnyID, '', 'N', ''
              , 0, @GL_PerNbr, @Period, 'U', ''
              , 1, wrk.ContractID, '', 1, ''
              , '', 0, 0, 0, 0
              , GETDATE(), '', 0, 0, 'C'
              , '', '', wrk.ReserveSub, '', GETDATE()
              , 'RECOGNIZE REVENUE', 'GL', 0, '', ''
              , 0, 0, '', '', '', ''
          FROM #smWrkContractRev wrk
          WHERE wrk.RevPeriod = @Period

        SET @SQLError = @@ERROR
        IF @SQLError <> 0 GOTO ABORT

        -- update smContractRev
        UPDATE SmContractRev
         SET RevFlag       = 1               -- True
           , GLBatNbr      = @BatNbr_Str
           , PerPost       = wrk.RevPeriod
           , Status        = 'P'             -- Processed
           , LUpd_DateTime = GETDATE()
           , Lupd_prog     = @ScrnNbr
           , Lupd_User     = @UserID
         FROM #smWrkContractRev wrk
         WHERE wrk.ContractID = SmContractRev.ContractID
          AND wrk.RevDate = SmContractRev.RevDate
          AND wrk.RevPeriod = @Period

        SET @SQLError = @@ERROR
        IF @SQLError <> 0 GOTO ABORT

        FETCH NEXT FROM Process_Cursor INTO @Period, @LineOffset

    END -- Done Creating batches for each period
    CLOSE Process_Cursor
    DEALLOCATE Process_Cursor

    -- Update SmContract records
    UPDATE smContract
     SET LastAmortDate = wrk.RevDate
       , LUpd_DateTime = GETDATE()
       , Lupd_prog     = @ScrnNbr
       , Lupd_User     = @UserID
     FROM #smWrkContractRev wrk
     WHERE wrk.ContractID = smContract.ContractID

    SET @SQLError = @@ERROR
    IF @SQLError <> 0 GOTO ABORT

    -- Update existing smConHistory records (update first, then insert those with no history)
    UPDATE smConHistory
     SET AmtRevenue    = smConHistory.AmtRevenue + wrk2.RevAmount
       , Lupd_DateTime = GETDATE()
       , Lupd_Prog     = @ScrnNbr
       , Lupd_User     = @UserID
     FROM (select RevAmount=sum(wrk.RevAmount), wrk.ContractID, YRRevDate=YEAR(wrk.RevDate), MTHRevDate=MONTH(wrk.RevDate)
             FROM #smWrkContractRev wrk
            GROUP BY wrk.ContractID, MONTH(wrk.RevDate), YEAR(wrk.RevDate)) wrk2
      INNER JOIN smConHistory
       ON smConHistory.ContractID = wrk2.ContractID
        AND smConHistory.HistYear = wrk2.YRRevDate
        AND smConHistory.HistMonth = wrk2.MTHRevDate


    SET @SQLError = @@ERROR
    IF @SQLError <> 0 GOTO ABORT

    -- Insert smConHistory records for those that did not have any
    INSERT INTO smConHistory
     ( AmtInvoiced, AmtRevenue, ContractID, Crtd_DateTime, Crtd_Prog, Crtd_User
     , HistMonth, HistYear, LaborBillHrs, LaborCost, LaborHours, LaborSales
     , Lupd_DateTime, Lupd_Prog, Lupd_User, OtherCost, OtherSales, SalesTotal, TaxTotal
     , User1, User2, User3, User4, User5, User6, User7, User8
     )
     SELECT 0, sum(wrk.RevAmount), wrk.ContractID, GETDATE(), @ScrnNbr, @UserID
          , MONTH(wrk.RevDate), YEAR(wrk.RevDate), 0, 0, 0, 0
          , GETDATE(), @ScrnNbr, @UserID, 0, 0, 0, 0
          , '', '', 0, 0, '', '', '', ''
      FROM #smWrkContractRev wrk
       LEFT OUTER JOIN smConHistory
        ON smConHistory.ContractID = wrk.ContractID
         AND smConHistory.HistYear = YEAR(wrk.RevDate)
         AND smConHistory.HistMonth = MONTH(wrk.RevDate)
      WHERE smConHistory.ContractID IS NULL
      GROUP BY wrk.ContractID, MONTH(wrk.RevDate), YEAR(wrk.RevDate)

    SET @SQLError = @@ERROR
    IF @SQLError <> 0 GOTO ABORT

COMMIT TRAN
GOTO FINISH
 ABORT:
    ROLLBACK TRANSACTION

FINISH:



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Process_Contract_Revenue_Recognition] TO [MSDSL]
    AS [dbo];

