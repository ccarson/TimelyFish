﻿


--*************************************************************
--	Purpose:Calculates Tranport Charges for Internal Movements
--		
--	Author: Charity Anderson
--	Date: 8/1/2005
--	Usage: Livestock Transfer Batch Release
--	Parms: (BatNbr)
-- 20131211 sripley added nolock hints because this proc was being blocked excessively
--*************************************************************

CREATE  PROC [dbo].[pXT135TransportCharge]
		(@parm1 as varchar(10))
AS
--CREATE TABLE #PMTransportCharge (BatNbr char(10), RefNbr char(10),MovementDate smalldatetime, CpnyID char(10),
--								 LocationAcct char(10),LocationSub char(24),ProjectID char(16), TaskID char(32),
--								 MileageRate float, StdLoadCharge float,OneWayMiles float,
--								 TransportAcct char(10), TransportSub char(24), Reversal char(2))
--
--INSERT INTO #PMTransportCharge 

DECLARE @BegDate as smalldatetime, @EndDate as smalldatetime, @PrevPeriod as varchar(10)

Set @BegDate=(Select Min(WeekOfDate) from cftWeekDefinition (nolock) where FiscalYear=left(rtrim(@parm1),4) 
		and FiscalPeriod=cast(right(rtrim(@parm1),2) as smallint))

Set @EndDate=(Select Max(WeekEndDate) from cftWeekDefinition  (nolock) where FiscalYear=left(rtrim(@parm1),4) 
		and FiscalPeriod=cast(right(rtrim(@parm1),2) as smallint))

--SET @PrevPeriod=(Select Top 1 Rtrim(FiscalYear) + rtrim(FiscalPeriod) from 
--				cftWeekDefinition where WeekEndDate<@BegDate order by WeekEndDate Desc)
SET @PrevPeriod=(Select Top 1 Rtrim(FiscalYear) + + CASE
  WHEN Len(rtrim(FiscalPeriod))=1 THEN '0' + rtrim(FiscalPeriod)
  ELSE rtrim(FiscalPeriod)
  END
from cftWeekDefinition  (nolock) where WeekEndDate<@BegDate order by WeekEndDate Desc)

IF @EndDate>GetDate() BEGIN set @EndDate=GetDate() END 

--Livestock Transfers
Select pm.PMLoadID, tr.PMID,tr.BatchNbr, tr.RefNbr,tr.MovementDate,
		SiteCpnyID=Case when pg.CpnyID is null then s.DefaultPigCpnyID else pg.CpnyID end,
		SiteAcct=Case when pd.ProdType='GRP' then
			(Select PhaseTranAcct from cftTransportSetup (nolock) )
		else (Select SowTranAcct from cftTransportSetup (nolock) ) end, 
		SiteSub=isnull(pj.gl_subacct,''),tr.DestProject,tr.DestTask,
		MileageRate=isnull(tw.MileageRate,0),
		LoadCharge=isnull(tw.StdLoadCharge,0),
		Multiplier=isnull(l.LoadCount,1),
		OneWayMiles=Case when isnull(mm.OneWayMiles,0)=0 or sa.AddressID=da.AddressID then 1 
			else isnull(mm.OneWayMiles,1) end,
		TranAcct=(Select TranDeptAcct from cftTransportSetup (nolock) ),
		TranSub=isnull(tw.Sub,''),tr.DocType, tw.CpnyID as TrailerCpnyID
		
from cftPMTranspRecord tr (nolock) 
LEFT JOIN cftPM pm  (nolock) on tr.PMID=pm.PMID
LEFT JOIN vXP135LoadCount l (nolock)  on tr.PMID=l.PMID
JOIN Batch b (nolock)  on tr.BatchNbr=b.BatNbr and b.Module='XP'
JOIN cftPigTranSys ts (nolock)  on tr.SubTypeID=ts.TranTypeID and ts.PigSystemID='00'
JOIN cftPigProdPhase pd  (nolock) on ts.DestProdPhaseID=pd.PigProdPhaseID
JOIN cftPigProdPhase ps  (nolock) on ts.SrcProdPhaseID=ps.PigProdPhaseID
JOIN cftPigTrailer pt  (nolock) on tr.PigTrailerID=pt.PigTrailerID
LEFT JOIN cftTruckWash tw  (nolock) on pt.TrailerWashContactID=tw.ContactID
LEFT JOIN PJPROJ pj  (nolock) on rtrim(tr.DestProject)=rtrim(pj.Project)
LEFT JOIN cftPigGroup pg  (nolock) on tr.DestPigGroupID=pg.PigGroupID
LEFT JOIN cftSite s  (nolock) on tr.DestContactID=s.ContactID
LEFT JOIN vCFContactMilesMatrix mm on tr.SourceContactID=mm.SourceSite and tr.DestContactID=mm.DestSite
LEFT JOIN cftContactAddress sa  (nolock) on tr.SourceContactID=sa.ContactID and sa.AddressTypeID='01'
LEFT JOIN cftContactAddress da  (nolock) on tr.DestContactID=da.ContactID and da.AddressTypeID='01'

where --tr.BatchNbr =@parm1
b.PerPost between @PrevPeriod and @parm1 
and tr.PigTrailerID<>'099'
and ps.ProdType<>'PUR'
and tr.Genetics=''

UNION 
--Pig Sale Offloads
Select pm.PMLoadID, tr.PMLoadID,tr.BatNbr as BatchNbr, tr.RefNbr as RefNbr,pm.MovementDate,
		s.DefaultPigCpnyID as CpnyID,
		(Select SowTranAcct from cftTransportSetup (nolock) ), 
		isnull(pj.gl_subacct,''),tr.Project,tr.TaskID,isnull(tw.MileageRate,0),
		isnull(tw.StdLoadCharge,0),Multiplier=(Select Count(*) from cftPM  (nolock) where PMLoadID=tr.PMLoadID),
		OneWayMiles=Case when mm.OneWayMiles=0 or sa.AddressID=da.AddressID then 1 
			else isnull(mm.OneWayMiles,0) end,
		(Select TranDeptAcct from cftTransportSetup (nolock) ),
		isnull(tw.Sub,''),tr.DocType as DocType, tw.CpnyID as TrailerCpnyID
		
from cftPigSale tr (nolock) 
JOIN Batch b  (nolock) on tr.BatNbr=b.BatNbr and Module='XS'
JOIN cftPM pm  (nolock) on tr.PMLoadID=pm.PMID
JOIN cftPigAcctTran tt  (nolock) on pm.TranSubTypeID=tt.TranTypeID and tt.acct='PIG NON-INV XFER'
JOIN cftPigTrailer pt  (nolock) on pm.PigTrailerID=pt.PigTrailerID
LEFT JOIN cftTruckWash tw  (nolock) on pt.TrailerWashContactID=tw.ContactID
LEFT JOIN PJPROJ pj  (nolock) on rtrim(tr.Project)=rtrim(pj.Project)
LEFT JOIN cftSite s  (nolock) on tr.SiteContactID=s.ContactID
LEFT JOIN vCFContactMilesMatrix mm on tr.SiteContactID=mm.SourceSite and pm.DestContactID=mm.DestSite
LEFT JOIN cftContactAddress sa  (nolock) on tr.SiteContactID=sa.ContactID and sa.AddressTypeID='01'
LEFT JOIN cftContactAddress da  (nolock) on pm.DestContactID=da.ContactID and da.AddressTypeID='01'

where b.PerPost between @PrevPeriod and @parm1 
	
and pm.PigTrailerID<>'099'
and right(rtrim(pm.TranSubTypeID),1)='O'
and tr.BaseAcct=''

UNION
--Site to Site From Transportation Schedule
Select tr.PMLoadID, tr.PMID,'TRANSPORT' as BatchNbr, 'TRANSPORT' as RefNbr,tr.MovementDate,
		s.DefaultPigCpnyID as CpnyID,
		(Select SowTranAcct from cftTransportSetup (nolock) ), 
		isnull(pj.gl_subacct,''),tr.DestProject,tr.DestTask,isnull(tw.MileageRate,0),
		isnull(tw.StdLoadCharge,0),Multiplier=(Select Count(*) from cftPM  (nolock) where PMLoadID=tr.PMLoadID),
		OneWayMiles=Case when mm.OneWayMiles=0 or sa.AddressID=da.AddressID then 1 
			else isnull(mm.OneWayMiles,0) end,
		(Select TranDeptAcct from cftTransportSetup (nolock) ),
		isnull(tw.Sub,''),'TR' as DocType, tw.CpnyID as TrailerCpnyID
		
from cftPM tr (nolock) 
JOIN cftPigAcctTran tt  (nolock) on tr.TranSubTypeID=tt.TranTypeID and acct='PIG NON-INV XFER'
JOIN cftPigTrailer pt  (nolock) on tr.PigTrailerID=pt.PigTrailerID
LEFT JOIN cftPMTranspRecord r  (nolock) on tr.PMID=r.PMID
LEFT JOIN cftTruckWash tw  (nolock) on pt.TrailerWashContactID=tw.ContactID
LEFT JOIN PJPROJ pj  (nolock) on rtrim(tr.DestProject)=rtrim(pj.Project)
LEFT JOIN cftSite s  (nolock) on tr.DestContactID=s.ContactID
LEFT JOIN vCFContactMilesMatrix mm on tr.SourceContactID=mm.SourceSite and tr.DestContactID=mm.DestSite
LEFT JOIN cftContactAddress sa  (nolock) on tr.SourceContactID=sa.ContactID and sa.AddressTypeID='01'
LEFT JOIN cftContactAddress da  (nolock) on tr.DestContactID=da.ContactID and da.AddressTypeID='01'

where tr.MovementDate between @BegDate and @EndDate
and r.PMID is null	
and tr.PigTrailerID not in ('099')
and tr.TruckerContactID not in ('000942')
and right(rtrim(tr.TranSubTypeID),1)<>'O'
and tr.LineNbr=0
order by TranSub,tr.MovementDate




GO
GRANT EXECUTE
    ON OBJECT::[dbo].[pXT135TransportCharge] TO [SOLOMON]
    AS [dbo];


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXT135TransportCharge] TO [MSDSL]
    AS [dbo];

