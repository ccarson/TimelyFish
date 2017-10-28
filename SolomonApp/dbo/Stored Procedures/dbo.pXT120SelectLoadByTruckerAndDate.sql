



CREATE PROCEDURE [dbo].[pXT120SelectLoadByTruckerAndDate] @StartDate smalldatetime, @EndDate smalldatetime, @PMTypeID varchar(2), @PMSystemID varchar(2), @TruckerContactID varchar(15), @PMID varchar(10) 
WITH EXECUTE AS '07718158D19D4f5f9D23B55DBF5DF1' 
AS

SELECT pm.*, c.*, c2.*, c3.*, Processed.POExists
FROM cftPM pm (NOLOCK)
LEFT JOIN cftContact c (NOLOCK) ON pm.TruckerContactID = c.ContactID
LEFT JOIN cftContact c2 (NOLOCK) ON pm.SourceContactID = c2.ContactID
LEFT JOIN cftContact c3 (NOLOCK) ON pm.DestContactID = c3.ContactID
LEFT JOIN (SELECT CASE WHEN po.User5 IS NOT NULL THEN 1 ELSE 0 END AS 'POExists', User5 FROM (SELECT MAX(POnbr) AS PONbr, User5 FROM PurOrdDet WHERE User5 <> '' GROUP BY User5) po) Processed ON pm.PMID = Processed.User5
WHERE PMID LIKE @PMID
AND	MovementDate BETWEEN @StartDate AND @EndDate
AND PMTypeID LIKE @PMTypeID
AND PMSystemID LIKE @PMSystemID
AND pm.TruckerContactID IN (SELECT DriverContactID FROM cfv_DriverCompany WHERE TruckingCompanyContactID = CONVERT(INTEGER, @TruckerContactID))
ORDER BY pm.MovementDate



GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXT120SelectLoadByTruckerAndDate] TO [MSDSL]
    AS [dbo];

