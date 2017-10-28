-- used in Health Assurance Testing App to retrieve the SourceFarm
-- load information for a Trailer Inspection
CREATE PROC [dbo].[pGetTrailerCert]
	@PigTrailerID as int,
	@RefDateTime as smalldatetime
AS
Select pm.ID, pm.MovementDate, pm.LoadingTime, rtrim(c.ContactName) as SourceFarm, 
	rtrim(pt.PigTypeDesc) as PigTransferType,rtrim(tt.Description) as TrailerNbr,pm.SourceContactID
FROM
(Select Top 1 ID,MovementDate, LoadingTime,ArrivalTime, pm.SourceContactID,PigTypeID,PigTrailerID
	from SolomonApp.dbo.cftPM pm 
where Cast(pm.MovementDate + ' ' + 
		IsNull(
		Convert(Varchar(2),DatePart(hour,pm.LoadingTime)) + ':' +
		Convert(varchar(2),datepart(minute,pm.LoadingTime)) + ':' +
		Convert(varchar(2),datepart(second,pm.LoadingTime)),'00:00:00'
		) as smalldatetime)>=@RefDateTime and pm.MovementDate<@RefDateTime+5
	and pm.TrailerWashFlag=-1 and pm.PigTrailerID=@PigTrailerID 
Order by MovementDate ASC, LoadingTime ASC) temp
JOIN SolomonApp.dbo.cftPM pm on 
	temp.MovementDate=pm.MovementDate and 
	(temp.ArrivalTime=pm.ArrivalTime) and
	temp.PigTrailerID=pm.PigTrailerID
JOIN SolomonApp.dbo.cftContact c on pm.SourceContactID=c.ContactID
LEFT JOIN SolomonApp.dbo.cftPigType pt on pm.PigTypeID=pt.PigTypeID
JOIN SolomonApp.dbo.cftPigTrailer tt on pm.PigTrailerID=tt.PigTrailerID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[pGetTrailerCert] TO [MSDSL]
    AS [dbo];

