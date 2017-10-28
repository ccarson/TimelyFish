
-- used in Health Assurance Testing App to retrieve health assurance test status
-- trailer inspection status and results for printing authorization certificates.
CREATE PROC [dbo].[pGetTrailerCertDetail]
	@EndDate as smalldatetime
AS
Select distinct 
	ti.TrailerCertID , pm.MovementDate,
	 pm.LoadingTime, c.ContactName as SourceFarm, d.ContactName as Destination,
	rtrim(tt.Description) as TrailerNbr, tt.PigTrailerID,ti.PrintFlg,
	SourceTestStatus, DestTestStatus, ti.PassFail,
	ti.CertDateTime, e.FirstLastName,
	Walkthrough,TattooFlag,
	PrintFlag=Case 
			when (SourceTestStatus in(0,'') and DestTestStatus in (0,'') and (ti.PassFail in (0,2)) and Walkthrough in (0,1)) 
				and (cast(pm.MovementDate + ' ' + pm.LoadingTime as smalldatetime) between ti.CertDateTime and DateAdd(d,7,ti.CertDateTime)) and isnull(ti.PrintFlg,0)=0 then 1
			--when (SourceTestStatus is null and DestinationTestStatus=0) and (ti.PassFail=0) and (isnull(WalkThrough,0)=0) then 1
			--when (SourceTestStatus =0 and DestinationTestStatus is null) and (ti.PassFail=0) and (isnull(WalkThrough,0)=0) then 1
			when (pm.PigTypeID='04' or pm.PigTypeID='05') and (ti.PassFail in (0,2)) and isnull(ti.PrintFlg,0)=0
				and (cast(pm.MovementDate + ' ' + pm.LoadingTime as smalldatetime)  between ti.CertDateTime and DateAdd(d,7,ti.CertDateTime)) then 1
			when isnull(ti.PrintFlg,0)=-1 and ((SourceTestStatus in(0,'') and DestTestStatus in (0,'') and (ti.PassFail in (0,2)) and Walkthrough in (0,1))
					or (pm.PigTypeID='04' or pm.PigTypeID='05') and (ti.PassFail in (0,2))) then 2 
			else 0
			End,
	pt.PigTypeDesc
FROM SolomonApp.dbo.cftPM pm 

LEFT JOIN TrailerCert ti on pm.ID=ti.PigMovementID 
	and ti.CertDateTime=(Select Top 1 CertDateTime from TrailerCert
		where PigMovementID=pm.ID 
		and certdatetime<Cast(pm.MovementDate + ' ' + SUBSTRING(CONVERT(CHAR(19),pm.LoadingTime,100),13,19) as smalldatetime) order by certdatetime desc)

JOIN SolomonApp.dbo.cftContact c on pm.SourceContactID=c.ContactID
JOIN SolomonApp.dbo.cftContact d on pm.DestContactID=d.ContactID
JOIN SolomonApp.dbo.cftPigTrailer tt on pm.PigTrailerID=tt.PigTrailerID and TrailerWashContactID='003324'
LEFT JOIN SolomonApp.dbo.cftPigType pt on pm.PigTypeID=pt.PigTypeID
LEFT JOIN CentralData.dbo.vEmployeewithContactName e on ti.InspectorUserName=e.UserID

where (isnull(pm.Highlight,0)<>255 and isnull(pm.Highlight,0)<>-65536)
--and Cast(pm.MovementDate + ' ' + pm.LoadingTime as smalldatetime) between GetDate() and @EndDate
and Cast(pm.MovementDate + ' ' + SUBSTRING(CONVERT(CHAR(19),pm.LoadingTime,100),13,19) as smalldatetime) between GetDate() and Cast(@EndDate + '23:59:00' as smalldatetime)
and TrailerWashFlag=-1 and PMSystemID in ('01','05')
order by MovementDate, TrailerNbr, LoadingTime


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pGetTrailerCertDetail] TO [MSDSL]
    AS [dbo];

