 CREATE PROCEDURE pp_08400ApplyAllDocs @AdjgCpnyID VARCHAR(10),
	@AdjgBatNbr CHAR(10), @AdjgCustID CHAR(15), @AdjgTranType CHAR(2),
        @AdjgCuryTranAmt Float, @AdjgTranAmt float, @AdjgRefNbr CHAR(10),
	@AdjgCuryID CHAR(4), @AdjgCuryRate Float, @AdjgCuryMultDiv CHAR(1),
        @AdjgCuryRateType CHAR(6),
	@AdjgEffDate SmallDateTime, @AdjgDocDate SmallDateTime, @UserAddress VARCHAR(21),
	@AdjdTranDescDflt CHAR(1), @AdjdAcct CHAR(10), @AdjdSub CHAR(24),@Sol_User Char(10),
        @AdjgBal float OUTPUT, @CuryAdjgBal float OUTPUT,
        @AutoADResult INT OUTPUT

WITH EXECUTE AS '07718158D19D4f5f9D23B55DBF5DF1'
as

/***** Apply Payment Entries to All Open Documents *****/

DECLARE @AdjdBatNbr      CHAR(10),        @AdjdCustID        CHAR(15), @AdjdRefNbr   CHAR(10),
        @AdjdCuryDiscBal Float,           @AdjdCuryDocBal    Float,    @AdjdCuryApplyAmt Float,
        @AdjdDiscbal     Float,           @AdjdDocBal        Float,
        @AdjdDocType     CHAR(2),         @AdjdCuryID        CHAR(4),  @AdjdCuryRate Float,
        @AdjdCuryMultDiv CHAR(1),         @AdjdCuryRateType  CHAR(6),  @AdjdDecPl    SmallInt,
        @BaseDecPl       Smallint,        @AdjgDecPl         Smallint, @NewAdjdCuryRate float,
        @AdjdDiscDate    SmallDateTime,   @INAcct            Char(10), @INSub        Char(24),
        @AdjdPerPost     Char(6), 	  	@AdjdCuryDiscAmt   float, @EffDate SmallDateTime,
	@AdjdCpnyID      Char(10),        @NewAdjdCuryMultDiv    Char(1)
 DECLARE @AdjdApplyAmt Float
DECLARE @NewCuryRate FLOAT, @NewCuryMultDiv CHAR(1), @BaseCuryID CHAR(4)
DECLARE @PmtUnits FLOAT, @DocUnits FLOAT
DECLARE @Crtd_DateTime SmallDateTime, @Prog_ID Char (8),
        @FinChrgFirst Char(1), @sortkey int

SELECT @BaseCuryID =g.BaseCuryID, @Prog_ID = '08400', @Sol_User = 'Solomon',
       @BaseDecPl=c.DecPl,
       @AdjgCpnyID = CASE WHEN g.Central_Cash_Cntl = 1 AND g.CpnyID = @AdjgCpnyID
                          THEN '%'
                          ELSE @AdjgCpnyID END
  FROM GlSetup g (NOLOCK),Currncy c
 WHERE  c.Curyid = g.BaseCuryid

select @FinChrgFirst=FinChrgFirst from arsetup (nolock)
	/***** Apply to All Adjusted Docs in the Order of Due Date *****/
DECLARE AdjstdCursor  INSENSITIVE CURSOR FOR
		SELECT CASE @FinChrgFirst
                       WHEN 'Y' THEN
                                Case d.Doctype
                                WHEN 'FI' THEN 0
                                ELSE 1
                                END
                       ELSE
                          1
                       END Sortkey,
                      d.BatNbr, d.CustID, d.RefNbr, d.CuryDiscBal, d.CuryDocBal ,
                        d.DocType, d.CpnyID, d.CuryID, d.CuryRate, d.perpost,
			d.CuryMultDiv, d.CuryRateType, d.DiscDate, d.docbal, d.discbal, d.bankacct, d.banksub
		FROM ARDoc d
                LEFT OUTER JOIN ARTran t on
                     d.custid = t.custid and d.doctype = t.costtype and d.refnbr = t.siteid
                INNER JOIN Account a (nolock)
                        ON d.BankAcct = a.Acct
		WHERE d.CustID = @AdjgCustID AND d.DocType IN ('IN','DM','FI','NC')
                  AND d.OpenDoc = 1
                  AND d.CpnyID LIKE @AdjgCpnyID
                  AND d.CuryDocBal > 0
                  AND d.Rlsed = 1
                  AND t.custid IS NULL
                  AND (a.curyid = ' ' OR a.curyid = @AdjgCuryID)
		ORDER BY d.CustID, d.Rlsed,1,DueDate

	OPEN AdjstdCursor

	FETCH NEXT FROM AdjstdCursor
                   INTO @SortKey,@AdjdBatNbr, @AdjdCustID, @AdjdRefNbr, @AdjdCuryDiscBal,
                        @AdjdCuryDocBal, @AdjdDocType, @AdjdCpnyID, @AdjdCuryID,
                        @AdjdCuryRate, @AdjdPerPost, @AdjdCuryMultDiv, @AdjdCuryRateType, @AdjdDiscDate,
			@AdjdDocbal, @AdjdDiscbal, @INAcct, @INSub

	WHILE (@@FETCH_STATUS <> -1) AND @AdjgCuryTranAmt > 0
		BEGIN
		     IF @@FETCH_STATUS <> -2
                     BEGIN

                   SELECT  @AdjdDecPl=DecPl
                         FROM  Currncy
                        WHERE  Curyid = @AdjdCuryid
                       SELECT  @AdjgDecPl =DecPl
                         FROM  Currncy
                        WHERE  Curyid = @AdjgCuryid

				select @EffDate = max(c2.Effdate)
                                from CuryRate c2 (nolock)
                                where c2.FromCuryID = @AdjdCuryID
	                               	AND c2.ToCuryID = @BaseCuryID
                                      	AND c2.RateType = @AdjdCuryRateType
                                       	AND c2.EffDate <= @AdjgEffDate

			IF @AdjgCuryid <> @AdjdCuryid BEGIN
			Select @NewAdjdCuryRate = c.rate, @NewAdjdCuryMultDiv = c.MultDiv
			from curyrate c (nolock)
		        where c.FromCuryId = @AdjDCuryID and c.ToCuryId = @basecuryid
		        and c.RateType = @AdjdCuryRateType and c.EffDate = @EffDate


			if @NewAdjdcuryrate is null
			select @NewAdjdCuryRate = @AdjdCuryRate, @NewAdjdCuryMultDiv = @AdjdCuryMultDiv
			END ELSE select @NewAdjdCuryRate = @AdjgCuryRate, @NewAdjdCuryMultDiv = @AdjgCuryMultDiv

	/***** Determine Currency Difference *****/

			IF @AdjgCuryid <> @AdjdCuryid OR @NewAdjdCuryRate <> @AdjdCuryRate
			BEGIN
                          If @NewAdjdCuryMultDiv = 'D'
                              Select @AdjdDocBal =
                                     Round(@AdjdCurydocBal / @NewAdjdCuryRate, @BaseDecPl)
                          Else
                              Select @AdjdDocBal =
                                     Round(@AdjdCuryDocBal * @NewAdjdCuryRate, @BaseDecPl)
			IF @AdjgCuryid <> @AdjdCuryid BEGIN
                          If @AdjgCuryMultDiv = 'M'
                              Select @AdjdCuryDocBal =
                                     Round(@AdjdDocBal / @AdjgCuryRate, @AdjgDecPl)
                          Else
                              Select @AdjdCuryDocBal =
                                     Round(@AdjdDocBal * @AdjgCuryRate, @AdjgDecPl)
			END

                          IF DATEDIFF(Day, @AdjgDocDate, @AdjdDiscDate) >= 0
                          BEGIN
                            If @NewAdjdCuryMultDiv = 'D'
                              Select @AdjdDiscBal =
                                     Round(@AdjdCuryDiscBal / @NewAdjdCuryRate,@BaseDecPl)
                            Else
                              Select @AdjdDiscBal =
                                     Round(@AdjdCuryDiscBal * @NewAdjdCuryRate,@BaseDecPl)
			IF @AdjgCuryid <> @AdjdCuryid BEGIN
                            If @AdjgCuryMultDiv = 'M'
                              Select @AdjdCuryDiscBal =
                                     Round(@AdjdDiscBal / @AdjgCuryRate,@AdjgDecPl)
                            Else
                              Select @AdjdCuryDiscBal =
                                      Round(@AdjdDiscBal * @AdjgCuryRate,@AdjgDecPl)
			END
                          END
			END

		        Select @AdjdCuryDiscAmt = @AdjdCuryDiscBal

                        IF DATEDIFF(Day, @AdjgDocDate, @AdjdDiscDate) < 0
      	  	            SELECT @AdjdDiscBal = 0,@AdjdCuryDiscBal = 0

-- discount is always subtracted out at invoice cury rate first if the tran will fully pay off the
-- discounted amount

                        IF round(@AdjgCuryTranAmt + @AdjdCuryDiscBal,@AdjgDecPl) >= @AdjdCuryDocBal
                        BEGIN
                           SELECT @AdjdCuryApplyAmt = round(@AdjdCuryDocBal - @AdjdCurydiscBal,@AdjgDecPl),
                                  @AdjdApplyAmt = round(@AdjdDocBal - @AdjddiscBal, @BaseDecPL),
			          @AdjgCuryTranAmt = round(@AdjgCuryTranAmt - @AdjdCuryApplyAmt, @AdjgDecPl),
				  @AdjgTranAmt = round(@AdjgTranAmt - @AdjdApplyAmt, @BaseDecPl),
				  @AdjdCuryDocBal = 0,
				  @AdjdDocBal = 0,
				  @AdjdCuryDiscAmt = 0
			End

			/**** Not Enough to pay off invoice, move amounts over *****/
			Else
			   BEGIN
                              SELECT @AdjdCuryApplyAmt = @AdjgCuryTranAmt,
                                     @AdjdApplyAmt = @AdjgTranAmt,
                                     @AdjdDiscBal=0,
                                     @AdjdCuryDiscBal=0,
				     @AdjgCuryTranAmt = 0,
				     @AdjgTranAmt = 0,
				     @AdjdCuryDocBal = round(@AdjdCuryDocBal - @AdjdCuryApplyAmt, @AdjgDecPl),
				     @AdjdDocBal = round(@AdjdDocBal - @AdjdApplyAmt, @baseDecPl),
     				     @AdjdCuryDiscAmt = 1
                           END

			INSERT ARTran (Acct, AcctDist, BatNbr, CmmnPct, CnvFact, ContractID, CostType,
                                CpnyID, Crtd_DateTime, Crtd_Prog, Crtd_User, CuryExtCost,
                                CuryId, CuryMultDiv, CuryRate, CuryTaxAmt00, CuryTaxAmt01,
				CuryTaxAmt02, CuryTaxAmt03, CuryTranAmt, CuryTxblAmt00,
                                CuryTxblAmt01, CuryTxblAmt02, CuryTxblAmt03, CuryUnitPrice, CustId,
                                DrCr, Excpt, ExtCost, ExtRefNbr, FiscYr, FlatRateLineNbr, InstallNbr,
				InvtId, JobRate, JrnlType, LineId, LineNbr,
                                LineRef, LUpd_DateTime, LUpd_Prog, LUpd_User,
				MasterDocNbr, NoteId, OrdNbr, PC_Flag, PC_ID,
                                PC_Status, PerEnt, PerPost, ProjectID, Qty,
				RefNbr, Rlsed, S4Future01, S4Future02, S4Future03,
                                S4Future04, S4Future05, S4Future06,
				S4Future07, S4Future08, S4Future09, S4Future10, S4Future11,
                                S4Future12, ServiceCallID, ServiceCallLineNbr, ServiceDate,
                                ShipperCpnyID, ShipperID, ShipperLineRef, SiteId, SlsperId,
				SpecificcostID, Sub, TaskID, TaxAmt00, TaxAmt01, TaxAmt02,
                                TaxAmt03, TaxCalced, TaxCat, TaxId00,
				TaxId01, TaxId02, TaxId03, TaxIdDflt, TranAmt,
                                TranClass, TranDate, TranDesc, TranType,
				TxblAmt00, TxblAmt01, TxblAmt02, TxblAmt03, UnitDesc,
                                UnitPrice, User1, User2, User3, User4,
				User5, User6, User7, User8, WhseLoc)

			SELECT  @INAcct, 1, b.BatNbr, -@AdjdCuryApplyAmt,@AdjdDiscBal, ' ', @AdjdDocType,
				@AdjdCpnyID, GETDATE(), b.Crtd_Prog, b.Crtd_User, 0,
                                @AdjdCuryID, @AdjdCuryMultDiv,
				@NewAdjdCuryRate, 0, 0, 0, 0, @AdjdCuryApplyAmt, @AdjdCuryDocBal, @AdjdCuryDiscAmt, 0, 0,
                                @AdjdCuryDiscBal, @AdjdCustId, 'U', 0, 0, ' ',
				SUBSTRING(b.PerPost,1,4), 0, 0, ' ', 0, 'AR', 0,
				-32767,
				' ', Getdate(), b.LUpd_Prog, b.LUpd_User, ' ', 0, ' ', ' ', ' ', ' ', b.PerEnt,
                                b.PerPost, ' ', 0,
				@AdjgRefNbr, 1, ' ', ' ', 0, 0, 0, 0, ' ', ' ',
                                0, 0, ' ', ' ', ' ', 0, ' ', ' ', ' ', ' ', @AdjdRefNbr, ' ', ' ',
				@INSub,	' ', 0, 0, 0, 0, ' ', ' ', ' ', ' ', ' ', ' ', ' ',
                                @AdjdApplyAmt, ' ', @AdjgDocDate,
				substring((CASE @AdjdTranDescDflt
				WHEN 'C' THEN RTRIM(c.CustID) + ' ' +
					CASE
					WHEN CHARINDEX('~', c.Name) > 0
					THEN LTRIM(RTRIM(RIGHT(c.Name, DATALENGTH(RTRIM(c.Name)) -
                                             CHARINDEX('~', c.Name))))
                                             + ' ' + SUBSTRING(c.Name, 1, (CHARINDEX('~', c.Name) - 1))
					ELSE c.Name
					END
				WHEN 'I' THEN RTRIM(c.CustID)
				ELSE	CASE
					WHEN CHARINDEX('~', c.Name) > 0
					THEN LTRIM(RTRIM(RIGHT(c.Name, DATALENGTH(RTRIM(c.Name)) -
                                           CHARINDEX('~', c.Name))))
                                           + ' ' + SUBSTRING(c.Name, 1, (CHARINDEX('~', c.Name) - 1))
					ELSE c.Name
					END
				END),1,30), @AdjgTranType, 0, 0, 0, 0, @AdjdPerPost, @AdjdCuryRate, ' ', ' ', 0, 0, ' ', ' ', ' ', ' ', ' '
			FROM Batch b (nolock), Customer c (nolock), WrkRelease w (nolock)
			WHERE c.CustID = @AdjdCustID AND b.BatNbr = @AdjgBatNbr AND b.BatNbr = w.BatNbr
                          AND b.module = 'AR'  AND w.Module = 'AR' AND w.UserAddress = @UserAddress
			IF @@ERROR < > 0  BEGIN
						CLOSE AdjstdCursor
						DEALLOCATE AdjstdCursor
						GOTO ABORT
                                          END
			IF @AdjgCuryTranAmt = 0
				BREAK
				IF @AdjgCuryTranAmt = 0
				BREAK

		FETCH NEXT FROM AdjstdCursor INTO @SortKey,@AdjdBatNbr, @AdjdCustID, @AdjdRefNbr,
                                @AdjdCuryDiscBal, @AdjdCuryDocBal, @AdjdDocType, @AdjdCpnyID,
			@AdjdCuryID, @AdjdCuryRate, @AdjdPerPost, @AdjdCuryMultDiv, @AdjdCuryRateType, @AdjdDiscDate,
			@AdjdDocbal, @AdjdDiscbal, @INAcct, @INSub

            END
        END

	CLOSE AdjstdCursor
	DEALLOCATE AdjstdCursor

/** If there is a balance, pass back to the program to correctly create offsetting tran for it.  **/

select @AdjgBal = CASE @AdjgCuryMultDiv WHEN 'M'
	THEN ROUND(@AdjgCuryTranAmt * @AdjgCuryRate, @baseDecPl)
	ELSE ROUND(@AdjgCuryTranAmt / @AdjgCuryRate, @baseDecPl) END,
	@CuryAdjgBal = @AdjgCuryTranAmt

SELECT @AutoADResult = 1

GOTO FINISH

ABORT:
SELECT @AutoADResult = 0

FINISH:



GO
GRANT CONTROL
    ON OBJECT::[dbo].[pp_08400ApplyAllDocs] TO [MSDSL]
    AS [dbo];

