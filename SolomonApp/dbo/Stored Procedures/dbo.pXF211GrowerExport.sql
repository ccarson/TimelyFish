
CREATE Procedure dbo.pXF211GrowerExport
@RoadRestrictions int
AS

----------------------------------------------------------------------------------------
--	Purpose: Select Site Data for WEM Database 
--	Author: Sue Matter
--	Date: 8/11/2006
--	Program Usage: 
--	Parms: 
----------------------------------------------------------------------------------------

if (@RoadRestrictions = 0)
begin
	SELECT 	'"' + 
		c.ContactID + '",' + '"'+  
		dbo.RemoveCSVChars(RTrim(c.ContactName)) + '",' + '"'+  '' + '",' + '"'+ '' + '",' + '"'+  
		dbo.RemoveCSVChars(RTrim(ISNULL(ad.Address1,''))) + '",' + '"'+  
		dbo.RemoveCSVChars(RTrim(ISNULL(ad.Address2,''))) + '",' + '"'+  
		RTrim(ISNULL(ad.City,'')) + '",' + '"'+ 
		RTrim(ISNULL(ad.State,'')) + '",' + '"'+ ''+'",' + '"'+ ''+ '",' + '"'+ ''+'",' + '"'+ ''+'",' + '"'+ 
		RTrim(CAST(0 AS CHAR)) + '",' + '"'+ 
		RTrim(CAST(0 AS CHAR))  + '",' + '"'+ 
		RTrim(CAST(0 AS CHAR))  + '",' + '"'+ 
		RTrim(CAST(0 AS CHAR))  + '",' +'"'+ ''+ '",' + '"'+ ''+ '",' + '"'+ ''+ '",' + '"'+ '' + '",' + '"'+ 
		dbo.RemoveCSVChars(RTrim(ISNULL(dr.Dir1,''))) + ' ' + 
		dbo.RemoveCSVChars(RTrim(ISNULL(dr.Dir2,''))) + ' ' + 
		dbo.RemoveCSVChars(RTrim(ISNULL(dr.Dir3,''))) +' '+ 
		dbo.RemoveCSVChars(RTrim(ISNULL(dr.Dir4,'')))  + '"' 
	FROM cftContact c (NOLOCK)
	INNER JOIN cftContactAddress s (NOLOCK) 
		ON c.ContactID=s.ContactID 
		AND s.AddressTypeID='01'
	INNER JOIN cftAddress ad (NOLOCK) 
		ON s.AddressID=ad.AddressID 
	INNER JOIN cftSiteDir dr (NOLOCK) 
		ON c.ContactID=dr.ContactID 
		AND dr.RoadRestrictions=0
	Where c.StatusTypeID='1' and dr.ShowInWEM = '1'
end
else
begin
	SELECT 	'"' + 
		c.ContactID + '",' + '"'+  
		dbo.RemoveCSVChars(RTrim(c.ContactName)) + '",' + '"'+  '' + '",' + '"'+ '' + '",' + '"'+  
		dbo.RemoveCSVChars(RTrim(ISNULL(ad.Address1,''))) + '",' + '"'+  
		dbo.RemoveCSVChars(RTrim(ISNULL(ad.Address2,''))) + '",' + '"'+  
		RTrim(ISNULL(ad.City,'')) + '",' + '"'+ 
		RTrim(ISNULL(ad.State,'')) + '",' + '"'+ ''+'",' + '"'+ ''+ '",' + '"'+ ''+'",' + '"'+ ''+'",' + '"'+ 
		RTrim(CAST(0 AS CHAR)) + '",' + '"'+ 
		RTrim(CAST(0 AS CHAR))  + '",' + '"'+ 
		RTrim(CAST(0 AS CHAR))  + '",' + '"'+ 
		RTrim(CAST(0 AS CHAR))  + '",' +'"'+ ''+ '",' + '"'+ ''+ '",' + '"'+ ''+ '",' + '"'+ '' + '",' + '"'+ 
		CASE WHEN dr2.RoadRestrictions IS NULL
		THEN
			dbo.RemoveCSVChars(RTrim(ISNULL(dr.Dir1,''))) + ' ' + 
			dbo.RemoveCSVChars(RTrim(ISNULL(dr.Dir2,''))) + ' ' + 
			dbo.RemoveCSVChars(RTrim(ISNULL(dr.Dir3,''))) +' '+ 
			dbo.RemoveCSVChars(RTrim(ISNULL(dr.Dir4,'')))  + '"' 
		ELSE
			dbo.RemoveCSVChars(RTrim(ISNULL(dr2.Dir1,''))) + ' ' + 
			dbo.RemoveCSVChars(RTrim(ISNULL(dr2.Dir2,''))) + ' ' + 
			dbo.RemoveCSVChars(RTrim(ISNULL(dr2.Dir3,''))) +' '+ 
			dbo.RemoveCSVChars(RTrim(ISNULL(dr2.Dir4,'')))  + '"' 
		END
	FROM cftContact c (NOLOCK)
	INNER JOIN cftContactAddress s (NOLOCK) 
		ON c.ContactID=s.ContactID AND s.AddressTypeID='01'
	INNER JOIN cftAddress ad (NOLOCK) 
		ON s.AddressID=ad.AddressID 
	LEFT OUTER JOIN cftSiteDir dr (NOLOCK) 
		ON c.ContactID=dr.ContactID 
		AND dr.RoadRestrictions=0
	LEFT OUTER JOIN cftSiteDir dr2 (NOLOCK) 
		ON c.ContactID=dr2.ContactID 
		AND dr2.RoadRestrictions=1
	Where c.StatusTypeID='1' and dr.ShowInWEM = '1'
end



GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF211GrowerExport] TO [MSDSL]
    AS [dbo];

