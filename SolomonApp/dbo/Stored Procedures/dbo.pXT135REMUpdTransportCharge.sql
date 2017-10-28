--*************************************************************
--	Purpose:Remove Update Transport Charges that have already been batched
--		
--	Author: Charity Anderson
--	Date: 12/2/2005
--	Usage: Transport Charge
--	Parms: (period)
--*************************************************************

CREATE PROC dbo.pXT135REMUpdTransportCharge
		(@parm1 as varchar(10))
AS

DECLARE @BegDate as smalldatetime, @EndDate as smalldatetime
Set @BegDate=(Select Min(WeekOfDate) from cftWeekDefinition where FiscalYear=left(rtrim(@parm1),4) 
		and FiscalPeriod=cast(right(rtrim(@parm1),2) as smallint))

Set @EndDate=(Select Max(WeekEndDate) from cftWeekDefinition where FiscalYear=left(rtrim(@parm1),4) 
		and FiscalPeriod=cast(right(rtrim(@parm1),2) as smallint))


IF @EndDate>GetDate() BEGIN set @EndDate=GetDate() END 

--Livestock Transfers
Update tr set tr.Genetics=''
from cftPMTranspRecord tr
JOIN Batch b on tr.BatchNbr=b.BatNbr and b.Module='XP'
JOIN cftPigTranSys ts on tr.SubTypeID=ts.TranTypeID and ts.PigSystemID='00'
JOIN cftPigProdPhase pd on ts.DestProdPhaseID=pd.PigProdPhaseID
JOIN cftPigProdPhase ps on ts.SrcProdPhaseID=ps.PigProdPhaseID
JOIN cftPigTrailer pt on tr.PigTrailerID=pt.PigTrailerID
where 
b.PerPost=@parm1
and tr.PigTrailerID<>'099'
and ps.ProdType<>'PUR'
and tr.Genetics=1

--Pig Sale Offloads
Update cftPigSale set BaseAcct=''	
from cftPigSale tr
JOIN Batch b on tr.BatNbr=b.BatNbr and Module='XS'
JOIN cftPM pm on tr.PMLoadID=pm.PMID
JOIN cftPigAcctTran tt on pm.TranSubTypeID=tt.TranTypeID and tt.acct='PIG NON-INV XFER'
JOIN cftPigTrailer pt on pm.PigTrailerID=pt.PigTrailerID

where b.PerPost=@parm1
	
and pm.PigTrailerID<>'099'
and right(rtrim(pm.TranSubTypeID),1)='O'
and tr.BaseAcct=1

--Site to Site From Transportation Schedule
Update cftPM set LineNbr=0
		
from cftPM tr
JOIN cftPigAcctTran tt on tr.TranSubTypeID=tt.TranTypeID and acct='PIG NON-INV XFER'
JOIN cftPigTrailer pt on tr.PigTrailerID=pt.PigTrailerID

where tr.MovementDate between @BegDate and @EndDate
	
and tr.PigTrailerID<>'099'
and right(rtrim(tr.TranSubTypeID),1)<>'O'
and tr.LineNbr=1


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[pXT135REMUpdTransportCharge] TO [SOLOMON]
    AS [dbo];


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXT135REMUpdTransportCharge] TO [MSDSL]
    AS [dbo];

