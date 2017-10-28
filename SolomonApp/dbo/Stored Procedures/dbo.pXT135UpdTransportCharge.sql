
--*************************************************************
--	Purpose:Update Transport Charges that have already been batched
--		
--	Author: Charity Anderson
--	Date: 11/29/2005
--	Usage: Transport Charge
--	Parms: (period)
--*************************************************************


CREATE   PROC dbo.pXT135UpdTransportCharge
		(@parm1 as varchar(10))
AS

DECLARE @BegDate as smalldatetime, @EndDate as smalldatetime, @PrevPeriod as varchar(10)

Set @BegDate=(Select Min(WeekOfDate) from cftWeekDefinition where FiscalYear=left(rtrim(@parm1),4) 
		and FiscalPeriod=cast(right(rtrim(@parm1),2) as smallint))

Set @EndDate=(Select Max(WeekEndDate) from cftWeekDefinition where FiscalYear=left(rtrim(@parm1),4) 
		and FiscalPeriod=cast(right(rtrim(@parm1),2) as smallint))

--SET @PrevPeriod=(Select Top 1 Rtrim(FiscalYear) + rtrim(FiscalPeriod) from 
--				cftWeekDefinition where WeekEndDate<@BegDate order by WeekEndDate Desc)

SET @PrevPeriod=(Select Top 1 Rtrim(FiscalYear) + + CASE
  WHEN Len(rtrim(FiscalPeriod))=1 THEN '0' + rtrim(FiscalPeriod)
  ELSE rtrim(FiscalPeriod)
  END
from cftWeekDefinition where WeekEndDate<@BegDate order by WeekEndDate Desc)



IF @EndDate>GetDate() BEGIN set @EndDate=GetDate() END 

--Livestock Transfers
Update tr set tr.Genetics=1
from cftPMTranspRecord tr
JOIN Batch b on tr.BatchNbr=b.BatNbr and b.Module='XP'
JOIN cftPigTranSys ts on tr.SubTypeID=ts.TranTypeID and ts.PigSystemID='00'
JOIN cftPigProdPhase pd on ts.DestProdPhaseID=pd.PigProdPhaseID
JOIN cftPigProdPhase ps on ts.SrcProdPhaseID=ps.PigProdPhaseID
JOIN cftPigTrailer pt on tr.PigTrailerID=pt.PigTrailerID
where b.PerPost between @PrevPeriod and @parm1 
and tr.PigTrailerID<>'099'
and ps.ProdType<>'PUR'
and tr.Genetics=''

--Pig Sale Offloads
Update cftPigSale set BaseAcct=1	
from cftPigSale tr
JOIN Batch b on tr.BatNbr=b.BatNbr and Module='XS'
JOIN cftPM pm on tr.PMLoadID=pm.PMID
JOIN cftPigAcctTran tt on pm.TranSubTypeID=tt.TranTypeID and tt.acct='PIG NON-INV XFER'
JOIN cftPigTrailer pt on pm.PigTrailerID=pt.PigTrailerID
where b.PerPost between @PrevPeriod and @parm1 
and pm.PigTrailerID<>'099'
and right(rtrim(pm.TranSubTypeID),1)='O'
and tr.BaseAcct=''

--Site to Site From Transportation Schedule
Update cftPM set LineNbr=1
from cftPM tr
JOIN cftPigAcctTran tt on tr.TranSubTypeID=tt.TranTypeID and acct='PIG NON-INV XFER'
JOIN cftPigTrailer pt on tr.PigTrailerID=pt.PigTrailerID
where tr.MovementDate between @BegDate and @EndDate
and tr.PigTrailerID<>'099'
and right(rtrim(tr.TranSubTypeID),1)<>'O'
and tr.LineNbr=0




GO
GRANT EXECUTE
    ON OBJECT::[dbo].[pXT135UpdTransportCharge] TO [SOLOMON]
    AS [dbo];


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXT135UpdTransportCharge] TO [MSDSL]
    AS [dbo];

