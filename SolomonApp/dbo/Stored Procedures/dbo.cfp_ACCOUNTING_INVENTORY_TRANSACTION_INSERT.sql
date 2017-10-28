-- =======================================================================
-- Author:		Brian Cesafsky
-- Create date: 08/18/2008
-- Description:	Inserts an inventory into the inventory transaction table
-- =======================================================================
CREATE PROCEDURE dbo.cfp_ACCOUNTING_INVENTORY_TRANSACTION_INSERT
(	
		@Acct							char(10)
		,@BatNbr						char(10)
		,@BMIMultDiv					char(1)
		,@BMIRate						float
		,@CnvFact						float
		,@CpnyID						char(10)
		,@Crtd_Prog						char(8)
		,@Crtd_User						char(10)
		,@DrCr							char(11)
		,@ExtCost						float
		,@FiscYr						char(4)
		,@InvtAcct						char(10)
		,@InvtID						char(30)
		,@InvtMult						smallint
		,@InvtSub						char(24)
		,@JrnlType						char(3)
		,@LayerType						char(1)
		,@LineID						int
		,@LineNbr						int
		,@LineRef						char(5)
		,@PerEnt						char(6)
		,@PerPost						char(6)
		,@Qty							float
		,@RcptDate						smalldatetime
		,@RcptNbr						char(15)
		,@ReasonCd						char(6)
		,@RefNbr						char(15)
		,@Rlsed							smallint
		,@S4Future10					int
		,@SiteID						char(10)
		,@Sub							char(24)
		,@TranAmt						float
		,@TranDate						smalldatetime
		,@TranDesc						char(30)
		,@TranType						char(2)
		,@UnitDesc						char(6)
		,@UnitMultDiv					char(1)
		,@UnitPrice						float
		,@WhseLoc						char(10)
)
AS
BEGIN
INSERT INTO SolomonApp.dbo.INTran
(
		Acct
		,BatNbr
		,BMIMultDiv
		,BMIRate
		,CnvFact
		,CpnyID
		,Crtd_Prog
		,Crtd_User
		,DrCr	
		,ExtCost
		,FiscYr
		,InvtAcct
		,InvtID
		,InvtMult
		,InvtSub
		,JrnlType
		,LayerType
		,LineID
		,LineNbr
		,LineRef
		,PerEnt
		,PerPost
		,Qty
		,RcptDate
		,RcptNbr
		,ReasonCd
		,RefNbr
		,Rlsed
		,S4Future10
		,SiteID
		,Sub
		,TranAmt
		,TranDate
		,TranDesc
		,TranType
		,UnitDesc
		,UnitMultDiv
		,UnitPrice
		,WhseLoc
)
VALUES
(
		@Acct
		,@BatNbr
		,@BMIMultDiv
		,@BMIRate
		,@CnvFact
		,@CpnyID
		,@Crtd_Prog
		,@Crtd_User
		,@DrCr
		,@ExtCost
		,@FiscYr
		,@InvtAcct
		,@InvtID
		,@InvtMult
		,@InvtSub
		,@JrnlType
		,@LayerType
		,@LineID
		,@LineNbr
		,@LineRef
		,@PerEnt
		,@PerPost
		,@Qty
		,@RcptDate
		,@RcptNbr
		,@ReasonCd
		,@RefNbr
		,@Rlsed
		,@S4Future10
		,@SiteID
		,@Sub
		,@TranAmt
		,@TranDate
		,@TranDesc
		,@TranType
		,@UnitDesc
		,@UnitMultDiv
		,@UnitPrice
		,@WhseLoc
)
END

