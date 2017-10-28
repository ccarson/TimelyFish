


-- =============================================
-- Author:  Matt Dawson
-- Create date:   1/20/2011
-- Description:   gets the last vet visit contact prior to movement date
-- Parameters:    @SiteContactID, @MovementDate
-- change:  2014-07-07 sripley  (pigdata database to be obsoleted replaced old table with new table
-- pigdata.dbo.SiteHealthAssuranceTest replaced by [SolomonApp].[dbo].[cft_HAT_Vet_Schedule]
-- =============================================
CREATE Function [dbo].[getVetLastVisit_VetContactID]
      (@SiteContactID int, @MovementDate datetime)
RETURNS datetime

AS
BEGIN
DECLARE @VetContactID int

SET @VetContactID = 
(select distinct main.VetContactID
from [SolomonApp].[dbo].[cft_HAT_Vet_Schedule] main (NOLOCK)
join
      (select 
            sitecontactid, 
            max(actualtestdate) actualtestdate
      from [SolomonApp].[dbo].[cft_HAT_Vet_Schedule] (NOLOCK) 
      where actualtestdate <= @MovementDate
      and sitecontactid = @SiteContactID
      group by sitecontactid) maxhat
            on maxhat.sitecontactid = main.sitecontactid and maxhat.actualtestdate = main.actualtestdate)
--(
--select distinct
--main.TesterContactID
--from [SolomonApp].[dbo].[cft_HAT_Vet_Schedule] main (NOLOCK)

--join
--    (select max(SiteHealthAssuranceTestID) SiteHealthAssuranceTestID
--    from [SolomonApp].[dbo].[cft_HAT_Vet_Schedule] hat
--    join
--          (select 
--                sitecontactid, 
--                max(actualtestdate) actualtestdate
--          from [SolomonApp].[dbo].[cft_HAT_Vet_Schedule] (NOLOCK) 
--          where actualtestdate <= @MovementDate
--          and sitecontactid = @SiteContactID
--          group by sitecontactid) maxhat
--    on maxhat.sitecontactid = hat.sitecontactid
--    and maxhat.actualtestdate = hat.actualtestdate) getid
--    on getid.SiteHealthAssuranceTestID = main.SiteHealthAssuranceTestID     

--)

RETURN @VetContactID
END



GO
GRANT EXECUTE
    ON OBJECT::[dbo].[getVetLastVisit_VetContactID] TO PUBLIC
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[getVetLastVisit_VetContactID] TO [se\sqlreporthelene]
    AS [dbo];


GO
GRANT CONTROL
    ON OBJECT::[dbo].[getVetLastVisit_VetContactID] TO [MSDSL]
    AS [dbo];

