 Create Proc Process_Accrual_Contracts @PerNbr VarChar(6), @PastPeriod VarChar(1), @InclCancelled Int, @AllBranch VarChar(1), @BranchID VarChar(10),
        @CpnyID VarChar(10), @UserID VarChar(10), @ScrnNbr VarChar(5), @UserAddress VarChar(21)
WITH EXECUTE AS '07718158D19D4f5f9D23B55DBF5DF1'
as

Set nocount ON

DECLARE @LastBatNbr VarChar(10),
        @LedgerID   VarChar(10),
        @ARPerEnt   VarChar(6),
        @GLRtTpDflt VarChar(6),
        @Period     VarChar(6),
        @BatNbr_Len SmallInt,
        @DecPlQty   SmallInt,
        @BatNbr_Str VarChar(10),
        @SQlError   Integer,
        @Amt        float,
        @ContractID VarChar(10),
        @GL_PerNbr  VarChar(6),
        @ValidateAcctSub VarChar(1),
        @BaseCuryID VarChar(4),
        @LineOffset Integer,
        @RecordID   Integer

CREATE TABLE #WrkSmContract
(
        AccrualPeriod char( 6 ),
        BranchId char( 10 ),
        CpnyID char( 10 ),
        CustID char(15),
        RevenueAcct char( 10 ),
        RevenueSub char( 24 ),
        SiteId char( 10 ),
        Status char( 1 ),
        TotalAmort float,
        TotalAmt float,
        ReserveAcct char(10),
        ContractAcct char(10),
        ReserveSub char(24),
        ContractSub char(24),
        ContractType Char(10),
        ContractID Char(10),
        Amt float,
        RecordId    Int Identity(-32767,2)
)

Select  @ValidateAcctSub = ValidateAcctSub
        From GLSetup(NOLOCK)

/* Get Period Number from ARSetup record */
Select @ARPerEnt = PerNbr
       from ARSetup (NOLOCK)

/* Get Rate Default from CMSetup record */
Select @GLRtTpDflt = GLRtTpDflt
       from CMSetup (NOLOCK)

/*Print 'Delete WrkSmContract for the specific user' */
/*DELETE FROM WrkSmContract where UserAddress = 'DEBUG' */
Begin Tran
IF @AllBranch = 'Y'
  BEGIN
    IF @PastPeriod = 'N'
      BEGIN
        /* Lock smcontract records and insert into the temp table #WrkSmContract */

        Update SmContract set ContractID = ContractID
         WHERE Status = 'A' AND TotalAmt <> TotalAmort AND AccrualPeriod = @PerNbr
           AND EXISTS (SELECT *
                         FROM smBranch
                        WHERE CpnyID = @CpnyID AND BranchID = SmContract.BranchID)

        INSERT #WrkSmContract (AccrualPeriod, BranchId,
                              CpnyID,CustID,RevenueAcct,RevenueSub,SiteID,
                              Status,TotalAmort, TotalAmt,
                              ReserveAcct, ContractAcct, ReserveSub, ContractSub,ContractType, ContractID, Amt)
        SELECT  AccrualPeriod = a.AccrualPeriod, BranchId = a.BranchID,
                              CpnyID = a.CpnyID,CustId = a.CustID, RevenueAcct = a.RevenueAcct,RevenueSub = a.RevenueSub,
                              SiteID = a.SiteId, Status = a.Status ,TotalAmort = a.TotalAmort, TotalAmt = a.TotalAmt,
                              ReserveAcct = '', ContractAcct = '', ReserveSub = '',
                              ContractSub = '', ContractType = a.ContractType,
                              ConctractID = a.ContractID, Amt = (a.TotalAmt - a.TotalAmort)
          FROM smContract a
         WHERE Status = 'A' AND TotalAmt <> TotalAmort AND AccrualPeriod = @PerNbr
           AND EXISTS (SELECT *
                         FROM smBranch
                        WHERE CpnyID = @CpnyID AND BranchID = a.BranchID)
         ORDER BY Status, AccrualFlag, AccrualPeriod, ContractId
      END
    ELSE
      BEGIN
        /* Lock smcontract records and insert into the temp table #WrkSmContract */
        Update SmContract set ContractID = ContractID
         WHERE Status = 'A' AND TotalAmt <> TotalAmort AND AccrualPeriod <= @PerNbr
           AND EXISTS (SELECT *
                         FROM smBranch
                WHERE CpnyID = @CpnyID AND BranchID = SmContract.BranchID)

        INSERT #WrkSmContract (AccrualPeriod, BranchId,
                              CpnyID,CustID,RevenueAcct,RevenueSub,SiteID,
                              Status,TotalAmort, TotalAmt,
                              ReserveAcct, ContractAcct, ReserveSub, ContractSub,ContractType,ContractID, Amt)
        SELECT AccrualPeriod = a.AccrualPeriod, BranchId = a.BranchID,
                              CpnyID = a.CpnyID,CustId = a.CustID,RevenueAcct = a.RevenueAcct,RevenueSub = a.RevenueSub,
                              SiteID = a.SiteId, Status = a.Status ,TotalAmort = a.TotalAmort, TotalAmt = a.TotalAmt,
                              ReserveAcct = '', ContractAcct = '', ReserveSub = '',
                              ContractSub = '', ContractType = a.ContractType,
                              ConctractID = a.ContractID,Amt = (a.TotalAmt - a.TotalAmort)
          FROM smContract a
         WHERE Status = 'A' AND TotalAmt <> TotalAmort AND AccrualPeriod <= @PerNbr
           AND EXISTS (SELECT *
                         FROM smBranch
                        WHERE CpnyID = @CpnyID AND BranchID = a.BranchID)
         ORDER BY Status, AccrualFlag, AccrualPeriod, ContractId
      END
  END
ELSE   -- @RevDoctype = ' ', application reversal
  BEGIN
    IF @PastPeriod = 'N'
      BEGIN
        /* Lock smcontract records and insert into the temp table #WrkSmContract */
        Update SmContract set ContractID = ContractID
         WHERE Status = 'A' AND TotalAmt <> TotalAmort AND AccrualPeriod = @PerNbr
           AND BranchId = @BranchID

        INSERT #WrkSmContract (AccrualPeriod, BranchId,
                              CpnyID,CustID, RevenueAcct,RevenueSub,SiteID,
                              Status,TotalAmort, TotalAmt,
                              ReserveAcct, ContractAcct, ReserveSub, ContractSub,ContractType, ContractID,Amt)
        SELECT AccrualPeriod = a.AccrualPeriod, BranchId = a.BranchID,
                              CpnyID = a.CpnyID,CustId = a.CustID,RevenueAcct = a.RevenueAcct,RevenueSub = a.RevenueSub,
                              SiteID = a.SiteId, Status = a.Status ,TotalAmort = a.TotalAmort, TotalAmt = a.TotalAmt,
                              ReserveAcct = '', ContractAcct = '', ReserveSub = '',
                              ContractSub = '', ContractType = a.ContractType,
                              ConctractID = a.ContractID, Amt = (a.TotalAmt - a.TotalAmort)
          FROM smContract a
         WHERE Status = 'A' AND TotalAmt <> TotalAmort AND AccrualPeriod = @PerNbr
           AND BranchId = @BranchID
         ORDER BY Status, AccrualFlag, AccrualPeriod, ContractId
      END
    ELSE
      BEGIN
        /* Lock smcontract records and insert into the temp table #WrkSmContract */
        Update SmContract set ContractID = ContractID
         WHERE Status = 'A' AND TotalAmt <> TotalAmort AND AccrualPeriod <= @PerNbr
           AND BranchId = @BranchID

        INSERT #WrkSmContract (AccrualPeriod, BranchId,
                              CpnyID,CustID, RevenueAcct,RevenueSub,SiteID,
                              Status,TotalAmort, TotalAmt,
                              ReserveAcct, ContractAcct, ReserveSub, ContractSub, ContractType,ContractID, Amt)
        SELECT AccrualPeriod = a.AccrualPeriod, BranchId = a.BranchID,
                              CpnyID = a.CpnyID,CustId = a.CustID,RevenueAcct = a.RevenueAcct,RevenueSub = a.RevenueSub,
                              SiteID = a.SiteId, Status = a.Status ,TotalAmort = a.TotalAmort, TotalAmt = a.TotalAmt,
                              ReserveAcct = '', ContractAcct = '', ReserveSub = '',
                              ContractSub = '', ContractType = a.ContractType,
                              ConctractID = a.ContractID, Amt = (a.TotalAmt - a.TotalAmort)
          FROM smContract a
         WHERE Status = 'A' AND TotalAmt <> TotalAmort AND AccrualPeriod <= @PerNbr
           AND BranchId = @BranchID
         ORDER BY Status, AccrualFlag, AccrualPeriod, ContractId
      END
  END

-- WrkPostBad table will be re-used to store the contracts failing validation of contract type
-- Batnbr will contain the ContractID
-- Situation will contain the Contract Type
-- Module will contain the reason code (T for Contract Type) (A for Acct) and G for GL Batch will be used later in this proc

-- First clear any records from another run of this proc.
Delete WrkPostBad where UserAddress = @UserAddress and Module in ('B','G','T')

INSERT into WrkPostBad (BatNbr, Situation, Module, UserAddress)
SELECT ContractID, ContractType, 'T', @UserAddress
  FROM  #WrkSmContract w LEFT OUTER JOIN smAgreement s
                         ON w.ContractType = s.AgreementTypeID
 WHERE s.AgreementTypeID is null

--Delete this from the Work Table and Log the error later.
DELETE w
  FROM #WrkSmContract w LEFT OUTER JOIN smAgreement s
                         ON w.ContractType = s.AgreementTypeID
WHERE s.AgreementTypeID is null

--Update the Accounts and SubAccounts in the WorkTable.
UPDATE w SET  ReserveAcct = s.ReserveAcct,ContractAcct = s.ContractAcct,
              ReserveSub = CASE WHEN s.SubFromSite = '1'
                               THEN CASE WHEN ISNULL(a.Sub,' ') <> ' '
                                         THEN a.Sub
                                         ELSE s.ReserveSub END
                               ELSE s.ReserveSub END,
             ContractSub = CASE WHEN s.SubFromSite = '1'
                                THEN CASE WHEN ISNULL(a.Sub,' ') <> ' '
                                          THEN a.Sub
                                          ELSE s.ContractSub END
                                ELSE s.ContractSub END
  FROM #WrkSmContract w JOIN smAgreement s
                         ON w.ContractType = s.AgreementTypeID
                       LEFT JOIN smSOAddress a
                         ON w.Custid = a.Custid AND w.SiteID = a.ShipTOID

If @ValidateAcctSub = 1
  BEGIN
	-- WrkPostBad table will be re-used to store the contracts failing validation of Acct/Sub
	-- Batnbr will contain the ContractID
	-- Situation will contain the Contract Type
	-- Module will contain the reason code ( G for GL Acct/Sub)
		 INSERT into WrkPostBad (BatNbr, Situation, Module, UserAddress)
	 SELECT ContractID, ContractType, 'G', @UserAddress
         FROM #WrkSmContract w LEFT JOIN VS_AcctSub a
                                ON w.ReserveAcct = a.Acct
                               AND w.ReserveSub = a.Sub
                               AND w.CpnyID = a.CpnyID
                               AND a.Active = 1
        WHERE a.Acct is null
	       --Validate the ReserveAcct Account and SubAccount Combination
       Delete w
         FROM #WrkSmContract w LEFT JOIN VS_AcctSub a
                                ON w.Reserveacct = a.Acct
                               AND w.ReserveSub = a.Sub
                               AND w.CpnyID = a.CpnyID
                               AND a.Active = 1
        WHERE a.Acct is null
	       --Validate the Contract Account and SubAccount Combination
       INSERT into WrkPostBad (BatNbr, Situation, Module, UserAddress)
       SELECT ContractID, ContractType, 'G', @UserAddress
       FROM #WrkSmContract w LEFT JOIN VS_AcctSub a
                                ON w.ContractAcct = a.Acct
                               AND w.ContractSub = a.Sub
                               AND w.CpnyID = a.CpnyID
                               AND a.Active = 1
        WHERE a.Acct is null
        DELETE w
         FROM #WrkSmContract w LEFT JOIN VS_AcctSub a
                                ON w.ContractAcct = a.Acct
                               AND w.ContractSub = a.Sub
                               AND w.CpnyID = a.CpnyID
                               AND a.Active = 1
        WHERE a.Acct is null
  END
/* Lock GLSetup */
Update GLSetup set Init = Init
 /* Get Last Batch Number and Ledger ID from GLSetup record */
Select	@BaseCuryID = BaseCuryID,
        @LastBatNbr = LastBatNbr,
	@LedgerID = LedgerID,
        @BatNbr_Len = Len(LTrim(LastBatNbr)),			/*	Determines Batch Number Mask Length	*/				/*	Quantity Decimal Position	*/
        @GL_PerNbr = PerNbr
        From	GLSetup(NOLOCK)

/* Create cursor to retrieve the Period */
Declare C1 Cursor local for
   Select  accrualPeriod, min(recordid) + 32767
     From #WrkSmContract
       Group by accrualPeriod
Open C1
Fetch Next From C1 into @Period, @LineOffset
While (@@fetch_Status = 0)
Begin  /* Create the batches for each period */
      Incr_Batnbr:
      Set @LastBatNbr = @LastBatNbr + 1
      /* Convert the Last Batch Number into a string with the length equal to defined mask and zero padded on the left.	*/
      set @BatNbr_Str = Right(Replicate('0', @BatNbr_Len) + Cast(@LastBatNbr As VarChar(10)), @BatNbr_Len)

		     Insert into Batch
				(
					AutoRev, AutoRevCopy, BatNbr, BatType, Descr,
					EditScrnNbr, GlPostOpt, JrnlType, Module, PerEnt,
					PerPost, Rlsed, Status, Crtd_DateTime, Crtd_Prog,
					Crtd_User, Lupd_DateTime, Lupd_Prog, Lupd_User, NbrCycle,
					CrTot, CtrlTot, CuryCrTot, CuryCtrlTot, CuryDrtot,
					DrTot, CuryDepositAmt, Cycle, Acct, BalanceType,
					BankAcct, BankSub, BaseCuryID, ClearAmt, Cleared,
					CpnyID, CuryEffDate, CuryID, CuryMultDiv, CuryRate,
					CuryRateType, DateClr, DateEnt, DepositAmt, LedgerID,
					NoteID, OrigBatNbr, origCpnyID, OrigScrnNbr, Sub,
					S4Future01, S4Future02, S4Future03, S4Future04, S4Future05,
					S4Future06, S4Future07, S4Future08, S4Future09, S4Future10,
					S4Future11, S4Future12, User1, User2, User3,
					User4, User5, User6, User7, User8, VOBatNbrForPP
				)
			Select
					 0, 0, @BatNbr_str , 'N','Revenue Recognition',
					 '01010', 'D', 'AC', 'GL', @ARPerEnt,
					 @Period, 1, 'U',GetDate(),@ScrnNbr,
					 @UserID, GetDate(), @ScrnNbr, @UserID, 0,
					 Sum(abs(w.amt)),Sum(abs(w.amt)),Sum(abs(w.amt)),Sum(abs(w.amt)),Sum(abs(w.amt)),
					 Sum(abs(w.amt)),0,0,'','A',
					 '', '', @BaseCuryID, 0,  0,
					 @CpnyId, GetDate(), @BaseCuryID, 'M', 1.00,
					 ISNULL(@GLRtTpDflt,space(1)),'', GetDate(), 0, @LedgerID,
					 0,'', '', '', '',
					 '', '',0,0,0,
					 0, '', '', 0,0,
					 '', '', '', '', 0,
					 0,'','','', '', ''
                                From #WrkSmContract w where w.AccrualPeriod = @Period

        Set	@SQLError = @@Error

  /*	SQL Error Number 2627:  Cannot insert duplicate key in object. */
        If  @SQLError = 2627 GoTo Incr_BatNbr
  /*    If another error occured	*/
        If @SQLError <> 0 GoTo Abort
-- WrkPostBad table will be re-used to store the batches created by this process
	-- Batnbr will contain the Batch numer
	-- Module will contain the reason code (B for Acct)
		INSERT into WrkPostBad (BatNbr, Situation, Module, UserAddress)
	Values (@BatNbr_Str, '', 'B', @UserAddress)

	       --Validate the RevenueAcct Account and SubAccount Combination

	If  @SQLError = 0
	BEGIN /* Not Duplicate Batch */
             /*Update GLSetup with the Last Batch Number */
             Update	GLSetup
	         Set	LastBatNbr = @BatNbr_Str

             If @SQLError <> 0 GOTO Abort

                   /* Create Credit side  */
	                 Insert Into GLTran
			(Acct, AppliedDate, BalanceType, BaseCuryID, BatNbr,
			CpnyID, CrAmt, Crtd_DateTime, Crtd_Prog, Crtd_User,
			CuryCrAmt, CuryDrAmt, CuryEffDate, CuryID, CuryMultDiv,
			CuryRate, CuryRateType, DrAmt, EmployeeID, ExtRefNbr,
			FiscYr, IC_Distribution, ID, JrnlType, Labor_Class_Cd,
			LedgerID, LineID, LineNbr, LineRef, LUpd_DateTime,
			LUpd_Prog, LUpd_User, Module, NoteID, OrigAcct,
			OrigBatNbr, OrigCpnyID, OrigSub, PC_Flag, PC_ID,
			PC_Status, PerEnt, PerPost, Posted, ProjectID,
			Qty, RefNbr, RevEntryOption, Rlsed, S4Future01,
			S4Future02, S4Future03, S4Future04, S4Future05, S4Future06,
			S4Future07, S4Future08, S4Future09, S4Future10, S4Future11,
			S4Future12, ServiceDate, Sub, TaskID, TranDate,
			TranDesc, TranType, Units, User1, User2,
			User3, User4, User5, User6, User7,
			User8)
		Select	w.ReserveAcct, '', 'A', @BaseCuryID, @BatNbr_str,
			@CpnyID, CrAmt = Case When w.Amt >= 0  Then w.Amt Else 0.00 End, GetDate(), @ScrnNbr, @UserID,
			CuryCramt = Case When w.Amt >= 0  Then w.Amt Else 0.00 End, CuryDrAmt = Case When w.Amt >= 0 Then 0.00 Else abs(w.Amt) End, GetDate(),
			@BaseCuryID,'M', 1, ISNULL(@GLRtTpDflt,space(1)), DrAmt = Case When w.Amt >= 0 Then 0.00 Else abs(w.Amt) End, '', w.ContractID,
			Left(@Period,4), 0, '', 'AC', '',
			@LedgerID, 0, w.RecordID - @LineOffset,'',GetDate(),
			@ScrnNbr, @UserID,'GL',0,'',
			'', @CpnyID, '', 'N', '',
			0, @GL_PerNbr, @Period, 'U', '',
			1, w.ContractID, '', 1, '',
			'', 0, 0, 0, 0,
			GetDate(), '', 0, 0, 'C',
			'', '', w.ReserveSub, '', GetDate(),
			'ACCRUE CONTRACT', 'GL', 0, '', '',
			0, 0, '', '', '',
			''
                 From #WrkSmContract w where w.AccrualPeriod = @Period


                  Set	@SQLError = @@Error
		  If	@SQLError <> 0 Goto Abort

                  /* Create side two */

                  Insert  Into GLTran
			(Acct, AppliedDate, BalanceType, BaseCuryID, BatNbr,
			CpnyID, CrAmt, Crtd_DateTime, Crtd_Prog, Crtd_User,
			CuryCrAmt, CuryDrAmt, CuryEffDate, CuryID, CuryMultDiv,
			CuryRate, CuryRateType, DrAmt, EmployeeID, ExtRefNbr,
			FiscYr, IC_Distribution, ID, JrnlType, Labor_Class_Cd,
			LedgerID, LineID, LineNbr, LineRef, LUpd_DateTime,
			LUpd_Prog, LUpd_User, Module, NoteID, OrigAcct,
			OrigBatNbr, OrigCpnyID, OrigSub, PC_Flag, PC_ID,
			PC_Status, PerEnt, PerPost, Posted, ProjectID,
			Qty, RefNbr, RevEntryOption, Rlsed, S4Future01,
			S4Future02, S4Future03, S4Future04, S4Future05, S4Future06,
			S4Future07, S4Future08, S4Future09, S4Future10, S4Future11,
			S4Future12, ServiceDate, Sub, TaskID, TranDate,
			TranDesc, TranType, Units, User1, User2,
			User3, User4, User5, User6, User7,
			User8)
		Select	w.ContractAcct, '', 'A', @BaseCuryID, @BatNbr_str,
			@CpnyID, CrAmt = Case When w.Amt > 0 Then 0.00 Else abs(w.amt) End, GetDate(), @ScrnNbr, @UserID,
			CuryCramt = Case When w.Amt > 0  Then 0.00 Else abs(w.amt) End, CuryDrAmt = Case When w.Amt > 0 Then w.amt Else 0.00 End, GetDate(),
			@BaseCuryID,'M', 1, ISNULL(@GLRtTpDflt,space(1)), DrAmt = Case When w.Amt > 0 Then w.amt Else 0.00 End, '', w.ContractID,
			Left(@Period,4), 0, '', 'AC', '',
			@LedgerID, 0, (w.RecordID-@LineOffset) + 1,'',GetDate(),
			@ScrnNbr, @UserID,'GL',0,'',
			'', @CpnyID, '', 'N', '',
			0, @GL_PerNbr, @Period, 'U', '',
			1,w.ContractID, '', 1, '',
			'', 0, 0, 0, 0,
			GetDate(), '', 0, 0, 'C',
			'', '', w.ContractSub, '', GetDate(),
			'ACCRUE CONTRACT', 'GL', 0, '', '',
			0, 0, '', '', '',
			''
                 From #WrkSmContract w where w.AccrualPeriod = @Period


                Set	@SQLError = @@Error
		If	@SQLError <> 0 Goto Abort

         END   /* Allowed to Create GLTrans because the BatNbr got Saved OK */
         Fetch Next From C1 into @Period,@LineOffset

END	/* Done Creating batches for each period */

/* Update SmContract records */
Update SmContract
  Set TotalAmort = w.TotalAmt,
      LUpd_DateTime = GetDate(),
      Lupd_prog = @ScrnNbr,
    Lupd_User = @UserID
  from #WrkSmContract w  where w.ContractID = SmContract.ContractID


Close C1
Deallocate C1
Commit Tran
Goto FINISH
 ABORT:
        RollBack Transaction

FINISH:


