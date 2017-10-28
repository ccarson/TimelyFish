-- =====================================================================
-- Author:		Matt Dawson
-- Create date: 07/09/2008
-- Description:	Returns the medications string, given the sitecontactid
-- ,barnid, and piggroupid
-- related to site health information for grow/finish
-- =====================================================================


CREATE FUNCTION [dbo].[cffn_GET_MEDICATIONS_BY_SITE_BARN_PIGGROUP] (@sitecontactid int, @barnid int, @piggroupid int, @dateparm datetime)
RETURNS varchar(200)
AS


BEGIN
	declare @mystr varchar(200)
	set @mystr = ''

	select 
		@mystr = @mystr + cft_medication.name + ', '
	from cft_barn_health cft_barn_health (nolock)
	inner join cft_site_health cft_site_health (nolock)
		on cft_site_health.sitehealthid = cft_barn_health.sitehealthid
	inner join cft_medication cft_medication (nolock)
		on cft_medication.medicationid = cft_barn_health.medicationid
	where	cft_site_health.sitecontactid = @sitecontactid
	and	cft_barn_health.barnid = @barnid
	and	cft_barn_health.piggroupid = @piggroupid
	and	cft_site_health.sitecontactdate >= dateadd(d,-7,@dateparm)
	and	cft_barn_health.medicationid IS NOT NULL
	group by
		cft_medication.name
	order by
		cft_medication.name
	if len(rtrim(replace(@mystr,',',''))) >= 1
		select @mystr = left(@mystr,len(@mystr)-1)
	else
		select @mystr = NULL


    RETURN @mystr
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cffn_GET_MEDICATIONS_BY_SITE_BARN_PIGGROUP] TO [db_sp_exec]
    AS [dbo];

