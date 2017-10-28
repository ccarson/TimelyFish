-- =======================================================================
-- Author:		Brian Cesafsky
-- Create date: 09/10/2008
-- Description:	Inserts an accounts payable into the AP DOC table
-- =======================================================================
/*
===============================================================================
Change Log:
Date        Who           Change
----------- ----------- -------------------------------------------------------
2013-02-14  Doran Dahle Added Code to set the ACH value to user2
						

===============================================================================
*/

CREATE PROCEDURE [dbo].[cfp_ACCOUNTING_ACCOUNTS_PAYABLE_DOC_INSERT]
(	
		@Acct char(10)
		,@AddlCost smallint
		,@ApplyAmt float
		,@ApplyDate smalldatetime
		,@ApplyRefNbr char(10)
		,@BatNbr char(10)
		,@BatSeq int
		,@CashAcct char(10)
		,@CashSub char(24)
		,@ClearAmt float
		,@ClearDate smalldatetime
		,@CpnyID char(10)
		,@Crtd_Prog char(8)
		,@Crtd_User char(10)
		,@CurrentNbr smallint
		,@CuryDiscBal float
		,@CuryDiscTkn float
		,@CuryDocBal float
		,@CuryEffDate smalldatetime
		,@CuryId char(4)
		,@CuryMultDiv char(1)
		,@CuryOrigDocAmt float
		,@CuryPmtAmt float
		,@CuryRate float
		,@CuryRateType char(6)
		,@CuryTaxTot00 float
		,@CuryTaxTot01 float
		,@CuryTaxTot02 float
		,@CuryTaxTot03 float
		,@CuryTxblTot00 float
		,@CuryTxblTot01 float
		,@CuryTxblTot02 float
		,@CuryTxblTot03 float
		,@Cycle smallint
		,@DfltDetail smallint
		,@DirectDeposit char(1)
		,@DiscBal float
		,@DiscDate smalldatetime
		,@DiscTkn float
		,@Doc1099 smallint
		,@DocBal float
		,@DocClass char(1)
		,@DocDate smalldatetime
		,@DocDesc char(30)
		,@DocType char(2)
		,@DueDate smalldatetime
		,@Econfirm char(18)
		,@Estatus char(1)
		,@InstallNbr smallint
		,@InvcDate smalldatetime
		,@InvcNbr char(15)
		,@LCCode char(10)
		,@LineCntr int
		,@LUpd_Prog char(8)
		,@LUpd_User char(10)
		,@MasterDocNbr char(10)
		,@NbrCycle smallint
		,@NoteID int
		,@OpenDoc smallint
		,@OrigDocAmt float
		,@PayDate smalldatetime
		,@PayHoldDesc char(30)
		,@PC_Status char(1)
		,@PerClosed char(6)
		,@PerEnt char(6)
		,@PerPost char(6)
		,@PmtAmt float
		,@PmtID char(10)
		,@PmtMethod char(1)
		,@PONbr char(10)
		,@PrePay_RefNbr char(10)
		,@ProjectID char(16)
		,@RefNbr char(10)
		,@Retention smallint
		,@RGOLAmt float
		,@Rlsed smallint
		,@S4Future01 char(30)
		,@S4Future02 char(30)
		,@S4Future03 float
		,@S4Future04 float
		,@S4Future05 float
		,@S4Future06 float
		,@S4Future07 smalldatetime
		,@S4Future08 smalldatetime
		,@S4Future09 int
		,@S4Future10 int
		,@S4Future11 char(10)
		,@S4Future12 char(10)
		,@Selected smallint
		,@Status char(1)
		,@Sub char(24)
		,@TaxCntr00 smallint
		,@TaxCntr01 smallint
		,@TaxCntr02 smallint
		,@TaxCntr03 smallint
		,@TaxId00 char(10)
		,@TaxId01 char(10)
		,@TaxId02 char(10)
		,@TaxId03 char(10)
		,@TaxTot00 float
		,@TaxTot01 float
		,@TaxTot02 float
		,@TaxTot03 float
		,@Terms char(2)
		,@TxblTot00 float
		,@TxblTot01 float
		,@TxblTot02 float
		,@TxblTot03 float
		,@User1 char(30)
		,@User2 char(30)
		,@User3 float
		,@User4 float
		,@User5 char(10)
		,@User6 char(10)
		,@User7 smalldatetime
		,@User8 smalldatetime
		,@VendId char(15)
)
AS
BEGIN

if exists (Select top 1 * from [SolomonApp].[dbo].[XDDDepositor] where VendId = @VendId And Status = 'Y' and entryclass = 'PPD')
	SET @User2 = 'AC'
	
	INSERT INTO [SolomonApp].[dbo].[APDoc]
	(
		[Acct]
       ,[AddlCost]
       ,[ApplyAmt]
       ,[ApplyDate]
       ,[ApplyRefNbr]
       ,[BatNbr]
       ,[BatSeq]
       ,[CashAcct]
       ,[CashSub]
       ,[ClearAmt]
       ,[ClearDate]
       ,[CpnyID]
       ,[Crtd_DateTime]
       ,[Crtd_Prog]
       ,[Crtd_User]
       ,[CurrentNbr]
       ,[CuryDiscBal]
       ,[CuryDiscTkn]
       ,[CuryDocBal]
       ,[CuryEffDate]
       ,[CuryId]
       ,[CuryMultDiv]
       ,[CuryOrigDocAmt]
       ,[CuryPmtAmt]
       ,[CuryRate]
       ,[CuryRateType]
       ,[CuryTaxTot00]
       ,[CuryTaxTot01]
       ,[CuryTaxTot02]
       ,[CuryTaxTot03]
       ,[CuryTxblTot00]
       ,[CuryTxblTot01]
       ,[CuryTxblTot02]
       ,[CuryTxblTot03]
       ,[Cycle]
       ,[DfltDetail]
       ,[DirectDeposit]
       ,[DiscBal]
       ,[DiscDate]
       ,[DiscTkn]
       ,[Doc1099]
       ,[DocBal]
       ,[DocClass]
       ,[DocDate]
       ,[DocDesc]
       ,[DocType]
       ,[DueDate]
       ,[Econfirm]
       ,[Estatus]
       ,[InstallNbr]
       ,[InvcDate]
       ,[InvcNbr]
       ,[LCCode]
       ,[LineCntr]
       ,[LUpd_DateTime]
       ,[LUpd_Prog]
       ,[LUpd_User]
       ,[MasterDocNbr]
       ,[NbrCycle]
       ,[NoteID]
       ,[OpenDoc]
       ,[OrigDocAmt]
       ,[PayDate]
       ,[PayHoldDesc]
       ,[PC_Status]
       ,[PerClosed]
       ,[PerEnt]
       ,[PerPost]
       ,[PmtAmt]
       ,[PmtID]
       ,[PmtMethod]
       ,[PONbr]
       ,[PrePay_RefNbr]
       ,[ProjectID]
       ,[RefNbr]
       ,[Retention]
       ,[RGOLAmt]
       ,[Rlsed]
       ,[S4Future01]
       ,[S4Future02]
       ,[S4Future03]
       ,[S4Future04]
       ,[S4Future05]
       ,[S4Future06]
       ,[S4Future07]
       ,[S4Future08]
       ,[S4Future09]
       ,[S4Future10]
       ,[S4Future11]
       ,[S4Future12]
       ,[Selected]
       ,[Status]
       ,[Sub]
       ,[TaxCntr00]
       ,[TaxCntr01]
       ,[TaxCntr02]
       ,[TaxCntr03]
       ,[TaxId00]
       ,[TaxId01]
       ,[TaxId02]
       ,[TaxId03]
       ,[TaxTot00]
       ,[TaxTot01]
       ,[TaxTot02]
       ,[TaxTot03]
       ,[Terms]
       ,[TxblTot00]
       ,[TxblTot01]
       ,[TxblTot02]
       ,[TxblTot03]
       ,[User1]
       ,[User2]
       ,[User3]
       ,[User4]
       ,[User5]
       ,[User6]
       ,[User7]
       ,[User8]
       ,[VendId]
	)
    VALUES
    (
		@Acct
       ,@AddlCost
       ,@ApplyAmt
       ,@ApplyDate
       ,@ApplyRefNbr
       ,@BatNbr
       ,@BatSeq
       ,@CashAcct
       ,@CashSub
       ,@ClearAmt
       ,@ClearDate
       ,@CpnyID
       ,getdate()
       ,@Crtd_Prog
       ,@Crtd_User
       ,@CurrentNbr
       ,@CuryDiscBal
       ,@CuryDiscTkn
       ,@CuryDocBal
       ,@CuryEffDate
       ,@CuryId
       ,@CuryMultDiv
       ,@CuryOrigDocAmt
       ,@CuryPmtAmt
       ,@CuryRate
       ,@CuryRateType
       ,@CuryTaxTot00
       ,@CuryTaxTot01
       ,@CuryTaxTot02
       ,@CuryTaxTot03
       ,@CuryTxblTot00
       ,@CuryTxblTot01
       ,@CuryTxblTot02
       ,@CuryTxblTot03
       ,@Cycle
       ,@DfltDetail
       ,@DirectDeposit
       ,@DiscBal
       ,@DiscDate
       ,@DiscTkn
       ,@Doc1099
       ,@DocBal
       ,@DocClass
       ,@DocDate
       ,@DocDesc
       ,@DocType
       ,@DueDate
       ,@Econfirm
       ,@Estatus
       ,@InstallNbr
       ,@InvcDate
       ,@InvcNbr
       ,@LCCode
       ,@LineCntr
       ,getdate()
       ,@LUpd_Prog
       ,@LUpd_User
       ,@MasterDocNbr
       ,@NbrCycle
       ,@NoteID
       ,@OpenDoc
       ,@OrigDocAmt
       ,@PayDate
       ,@PayHoldDesc
       ,@PC_Status
       ,@PerClosed
       ,@PerEnt
       ,@PerPost
       ,@PmtAmt
       ,@PmtID
       ,@PmtMethod
       ,@PONbr
       ,@PrePay_RefNbr
       ,@ProjectID
       ,@RefNbr
       ,@Retention
       ,@RGOLAmt
       ,@Rlsed
       ,@S4Future01
       ,@S4Future02
       ,@S4Future03
       ,@S4Future04
       ,@S4Future05
       ,@S4Future06
       ,@S4Future07
       ,@S4Future08
       ,@S4Future09
       ,@S4Future10
       ,@S4Future11
       ,@S4Future12
       ,@Selected
       ,@Status
       ,@Sub
       ,@TaxCntr00
       ,@TaxCntr01
       ,@TaxCntr02
       ,@TaxCntr03
       ,@TaxId00
       ,@TaxId01
       ,@TaxId02
       ,@TaxId03
       ,@TaxTot00
       ,@TaxTot01
       ,@TaxTot02
       ,@TaxTot03
       ,@Terms
       ,@TxblTot00
       ,@TxblTot01
       ,@TxblTot02
       ,@TxblTot03
       ,@User1
       ,@User2
       ,@User3
       ,@User4
       ,@User5
       ,@User6
       ,@User7
       ,@User8
       ,@VendId
)
END

