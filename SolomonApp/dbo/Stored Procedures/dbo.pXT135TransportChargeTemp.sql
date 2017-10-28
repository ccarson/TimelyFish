--*************************************************************
--	Purpose:DBNav for TruckWash record
--		
--	Author: Charity Anderson
--	Date: 8/1/2005
--	Usage: Livestock Transfer Batch Release
--	Parms: (BatNbr)
--*************************************************************

CREATE PROC dbo.pXT135TransportChargeTemp
		(@parm1 as varchar(10))
AS
--CREATE TABLE #PMTransportCharge (BatNbr char(10), RefNbr char(10),MovementDate smalldatetime, CpnyID char(10),
--								 LocationAcct char(10),LocationSub char(24),ProjectID char(16), TaskID char(32),
--								 MileageRate float, StdLoadCharge float,OneWayMiles float,
--								 TransportAcct char(10), TransportSub char(24), Reversal char(2))
--
--INSERT INTO #PMTransportCharge 
DECLARE @BegDate as smalldatetime, @EndDate as smalldatetime
Set @BegDate=(Select Min(WeekOfDate) from cftWeekDefinition where FiscalYear=left(rtrim(@parm1),4) 
		and FiscalPeriod=cast(right(rtrim(@parm1),2) as smallint))

Set @EndDate=(Select Max(WeekEndDate) from cftWeekDefinition where FiscalYear=left(rtrim(@parm1),4) 
		and FiscalPeriod=cast(right(rtrim(@parm1),2) as smallint))

--Livestock Transfers
Select Distinct pm.PMLoadID, tr.PMID,tr.BatchNbr, tr.RefNbr,tr.MovementDate,
		SiteCpnyID=Case when pg.CpnyID is null then s.DefaultPigCpnyID else pg.CpnyID end,
		SiteAcct=Case when pd.ProdType='GRP' then
			(Select PhaseTranAcct from cftTransportSetup)
		else (Select SowTranAcct from cftTransportSetup) end, 
		SiteSub=isnull(pj.gl_subacct,''),tr.DestProject,tr.DestTask,
		MileageRate=isnull(tw.MileageRate,0),
		LoadCharge=isnull(tw.StdLoadCharge,0),
		Multiplier=isnull(l.LoadCount,1),
		OneWayMiles=Case when isnull(mm.OneWayMiles,0)=0 or sa.AddressID=da.AddressID then 1 
			else isnull(mm.OneWayMiles,1) end,
		TranAcct=(Select TranDeptAcct from cftTransportSetup),
		TranSub=isnull(tw.Sub,''),tr.DocType, tw.CpnyID as TrailerCpnyID
		
from cftPMTranspRecord tr
LEFT JOIN cftPM pm on tr.PMID=pm.PMID
LEFT JOIN vXP135LoadCount l on tr.PMID=l.PMID
JOIN Batch b on tr.BatchNbr=b.BatNbr and b.Module='XP'
JOIN cftPigTranSys ts on tr.SubTypeID=ts.TranTypeID
JOIN cftPigProdPhase pd on ts.DestProdPhaseID=pd.PigProdPhaseID
JOIN cftPigProdPhase ps on ts.SrcProdPhaseID=ps.PigProdPhaseID
JOIN cftPigTrailer pt on tr.PigTrailerID=pt.PigTrailerID
LEFT JOIN cftTruckWash tw on pt.TrailerWashContactID=tw.ContactID
LEFT JOIN PJPROJ pj on rtrim(tr.DestProject)=rtrim(pj.Project)
LEFT JOIN cftPigGroup pg on tr.DestPigGroupID=pg.PigGroupID
LEFT JOIN cftSite s on tr.DestContactID=s.ContactID
LEFT JOIN vCFContactMilesMatrix mm on tr.SourceContactID=mm.SourceSite and tr.DestContactID=mm.DestSite
LEFT JOIN cftContactAddress sa on tr.SourceContactID=sa.ContactID and sa.AddressTypeID='01'
LEFT JOIN cftContactAddress da on tr.DestContactID=da.ContactID and da.AddressTypeID='01'

where --tr.BatchNbr =@parm1
b.PerPost<'200605'
and 
pg.PGStatusID in ('F','A','T')
and tr.PigTrailerID<>'099'
and ps.ProdType<>'PUR'
and tr.Genetics=''


order by TranSub,tr.MovementDate


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[pXT135TransportChargeTemp] TO [SOLOMON]
    AS [dbo];

