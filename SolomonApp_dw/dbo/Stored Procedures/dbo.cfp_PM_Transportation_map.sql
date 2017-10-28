

CREATE  PROCEDURE [dbo].[cfp_PM_Transportation_map]
	@StartDate datetime, @EndDate datetime

AS
BEGIN
/*
===============================================================================
Purpose: Gathers data that will be translated and used by google maps.  Contains
movement dates and sites. 

Inputs:
Outputs:    
Returns:    0 for success, 1 for failure
Enviroment:    Test, Production 


Change Log:
Date        Who           Change
----------- ----------- -------------------------------------------------------
2014-05-22	sripley		for Amy, initial proc

===============================================================================
*/

-------------------------------------------------------------------------------
-- Standard proc settings
-------------------------------------------------------------------------------
SET NOCOUNT ON;
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

Select
      convert(DATE, cftPM.MovementDate) as 'MovementDate',
      SourceContact.ShortName as Site,  --source farm
      --DestContact.ContactName as Packer,
      substring(DATENAME(weekday,cftPM.movementdate),1,3) as 'Name',   
      a.Latitude,
      a.Longitude,
     
      case
            when substring(DATENAME(weekday,cftPM.movementdate),1,3) = 'Sun' then 'DarkGoldenrod' 
            when substring(DATENAME(weekday,cftPM.movementdate),1,3) = 'Mon' then 'MediumSeaGreen'   
            when substring(DATENAME(weekday,cftPM.movementdate),1,3) = 'Tue' then 'CornflowerBlue'
            when substring(DATENAME(weekday,cftPM.movementdate),1,3) = 'Wed' then 'PaleGoldenrod'
            when substring(DATENAME(weekday,cftPM.movementdate),1,3) = 'Thu' then 'IndianRed'
            when substring(DATENAME(weekday,cftPM.movementdate),1,3) = 'Fri' then 'Coral'
            when substring(DATENAME(weekday,cftPM.movementdate),1,3) = 'Sat' then 'MediumTurquoise'
      end as Color,
      case
            when substring(DATENAME(weekday,cftPM.movementdate),1,3) = 'Sun' then 'pushpin' 
            when substring(DATENAME(weekday,cftPM.movementdate),1,3) = 'Mon' then 'pushpin'   
            when substring(DATENAME(weekday,cftPM.movementdate),1,3) = 'Tue' then 'pushpin'
            when substring(DATENAME(weekday,cftPM.movementdate),1,3) = 'Wed' then 'pushpin'
            when substring(DATENAME(weekday,cftPM.movementdate),1,3) = 'Thu' then 'pushpin'
            when substring(DATENAME(weekday,cftPM.movementdate),1,3) = 'Fri' then 'pushpin'
            when substring(DATENAME(weekday,cftPM.movementdate),1,3) = 'Sat' then 'pushpin'
      end as Symbol,
      
      case
        when substring(DATENAME(weekday,cftPM.movementdate),1,3) = 'Sun' then  substring(DATENAME(weekday,cftPM.movementdate),1,3) + ': DarkGoldenrod'
        when substring(DATENAME(weekday,cftPM.movementdate),1,3) = 'Mon' then  substring(DATENAME(weekday,cftPM.movementdate),1,3) + ': MediumSeaGreen'
        when substring(DATENAME(weekday,cftPM.movementdate),1,3) = 'Tue' then  substring(DATENAME(weekday,cftPM.movementdate),1,3) + ': CornflowerBlue'
        when substring(DATENAME(weekday,cftPM.movementdate),1,3) = 'Wed' then  substring(DATENAME(weekday,cftPM.movementdate),1,3) + ': PaleGoldenrod'
        when substring(DATENAME(weekday,cftPM.movementdate),1,3) = 'Thu' then  substring(DATENAME(weekday,cftPM.movementdate),1,3) + ': IndianRed'
        when substring(DATENAME(weekday,cftPM.movementdate),1,3) = 'Fri' then  substring(DATENAME(weekday,cftPM.movementdate),1,3) + ': Coral'
        when substring(DATENAME(weekday,cftPM.movementdate),1,3) = 'Sat' then  substring(DATENAME(weekday,cftPM.movementdate),1,3) + ': MediumTurquoise'
      end as Folder,    
    min(substring(CONVERT(char(20),cftPM.LoadingTime, 0),13,7) )as '1stLoad'

      FROM [$(SolomonApp)].dbo.cftPM cftPM (NOLOCK)
            LEFT JOIN [$(SolomonApp)].dbo.cftContact SourceContact (NOLOCK) on cftPM.SourceContactID = SourceContact.ContactID
            LEFT JOIN [$(SolomonApp)].dbo.cftSite Site on Site.ContactID = SourceContact.ContactID
            LEFT JOIN [$(SolomonApp)].dbo.cftContactAddress ca on ca.ContactID = SourceContactID and ca.addresstypeid = '01'
            LEFT JOIN [$(SolomonApp)].dbo.cftAddress a on a.AddressID = ca.AddressID
            LEFT JOIN [$(SolomonApp)].dbo.cftContact DestContact (NOLOCK) on cftPM.DestContactID = DestContact.ContactID
            LEFT JOIN [$(SolomonApp)].dbo.cftWeekDefinition cftWeekDefinition (NOLOCK) on cftPM.MovementDate between cftWeekDefinition.WeekOfDate and cftWeekDefinition.WeekEndDate
            LEFT JOIN (select s.contactid, c.contactname          
            FROM [$(SolomonApp)].dbo.cftSite s (nolock)
            INNER JOIN [$(CentralData)].dbo.Contact c (nolock) on c.contactid = s.contactid
                  WHERE s.pigsystemid = '00') mulip on mulip.contactid = cftPM.destcontactid 
                  
                  WHERE cftPM.MovementDate between @startdate and @enddate
                  AND cftPM.PMSystemID like '%' 
                  AND cftPM.PMTypeID = '02'
                  AND cftPM.SuppressFlg = 0
                  AND cftPM.Highlight <> 255
                  AND cftPM.Highlight <> -65536

      GROUP BY  
      convert(DATE, cftPM.MovementDate),
      SourceContact.ShortName ,  --source farm
      --DestContact.ContactName,
      substring(DATENAME(weekday,cftPM.movementdate),1,3),   
      a.Latitude,
      a.Longitude,
      
      case
            when substring(DATENAME(weekday,cftPM.movementdate),1,3) = 'Sun' then 'DarkGoldenrod' 
            when substring(DATENAME(weekday,cftPM.movementdate),1,3) = 'Mon' then 'MediumSeaGreen'   
            when substring(DATENAME(weekday,cftPM.movementdate),1,3) = 'Tue' then 'CornflowerBlue'
            when substring(DATENAME(weekday,cftPM.movementdate),1,3) = 'Wed' then 'PaleGoldenrod'
            when substring(DATENAME(weekday,cftPM.movementdate),1,3) = 'Thu' then 'IndianRed'
            when substring(DATENAME(weekday,cftPM.movementdate),1,3) = 'Fri' then 'Coral'
            when substring(DATENAME(weekday,cftPM.movementdate),1,3) = 'Sat' then 'MediumTurquoise'
      end ,
      case
            when substring(DATENAME(weekday,cftPM.movementdate),1,3) = 'Sun' then 'pushpin' 
            when substring(DATENAME(weekday,cftPM.movementdate),1,3) = 'Mon' then 'pushpin'   
            when substring(DATENAME(weekday,cftPM.movementdate),1,3) = 'Tue' then 'pushpin'
            when substring(DATENAME(weekday,cftPM.movementdate),1,3) = 'Wed' then 'pushpin'
            when substring(DATENAME(weekday,cftPM.movementdate),1,3) = 'Thu' then 'pushpin'
            when substring(DATENAME(weekday,cftPM.movementdate),1,3) = 'Fri' then 'pushpin'
            when substring(DATENAME(weekday,cftPM.movementdate),1,3) = 'Sat' then 'pushpin'
      end ,
      
      case
        when substring(DATENAME(weekday,cftPM.movementdate),1,3) = 'Sun' then  substring(DATENAME(weekday,cftPM.movementdate),1,3) + ': DarkGoldenrod'
        when substring(DATENAME(weekday,cftPM.movementdate),1,3) = 'Mon' then  substring(DATENAME(weekday,cftPM.movementdate),1,3) + ': MediumSeaGreen'
        when substring(DATENAME(weekday,cftPM.movementdate),1,3) = 'Tue' then  substring(DATENAME(weekday,cftPM.movementdate),1,3) + ': CornflowerBlue'
        when substring(DATENAME(weekday,cftPM.movementdate),1,3) = 'Wed' then  substring(DATENAME(weekday,cftPM.movementdate),1,3) + ': PaleGoldenrod'
        when substring(DATENAME(weekday,cftPM.movementdate),1,3) = 'Thu' then  substring(DATENAME(weekday,cftPM.movementdate),1,3) + ': IndianRed'
        when substring(DATENAME(weekday,cftPM.movementdate),1,3) = 'Fri' then  substring(DATENAME(weekday,cftPM.movementdate),1,3) + ': Coral'
        when substring(DATENAME(weekday,cftPM.movementdate),1,3) = 'Sat' then  substring(DATENAME(weekday,cftPM.movementdate),1,3) + ': MediumTurquoise'
      end 
            ORDER BY
                  1,
                  4;
                  
                  
END


	  








GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_PM_Transportation_map] TO [db_sp_exec]
    AS [dbo];

