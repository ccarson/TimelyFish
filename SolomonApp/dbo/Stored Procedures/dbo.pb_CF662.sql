
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
Create Procedure pb_CF662 @RI_ID smallint as 

	--use variable to hold the report run date (for determining the active manager)
	Declare @RI_Where VARCHAR(255), @Search VARCHAR(255), @Pos SMALLINT,
		@RptDate smalldatetime
	Select @RI_Where = LTRIM(RTRIM(RI_Where)), @RptDate = ReportDate from RptRunTime Where RI_ID = @RI_ID

	--clear the work table (just in case)
    Delete from wrkPFEUInel Where RI_ID = @RI_ID
	--insert the pfeu ineligible information into the work table (most comes from this join
    Insert Into wrkPFEUInel (BarnNbr, Comment, ContactName, FacType, Gender, LegacyGroupId, PigGroupId, RI_ID, 
	SiteContactId, SvcMgrContactID)
    Select p.BarnNbr, p.Comment, c.ContactName, Coalesce(f.Description, ''), Coalesce(g.Description, ''), 
	p.LegacyGroupId, p.PigGroupId, @RI_ID, p.SiteContactId, ''
	from cftPigGroup p Join cftPGStatus o on p.PGStatusID = o.PGStatusID
	Join cftSite s on p.SiteContactId = s.ContactId
	Join cftContact c on p.SiteContactId = c.ContactId
	Left Join cftPigGenderType g on p.PigGenderTypeId = g.PigGenderTypeId
	Left Join cftFacilityType f on s.FacilityTypeId = f.FacilityTypeId
	Where p.EUPFEUInel = -1 and s.PFEUClassification = 'Approved' and o.status_pa = 'A'
	and s.FacilityTypeId <> '001' and s.FacilityTypeId <> '002'	--don't include sows and nurseries
	--now fill in the lines for sites not approved
    Insert Into wrkPFEUInel (BarnNbr, Comment, ContactName, FacType, Gender, LegacyGroupId, PigGroupId, RI_ID, 
	SiteContactId, SvcMgrContactID)
    Select 'All', 'All barns are ' + s.PFEUClassification, c.ContactName, Coalesce(f.Description, ''), '', 
	'All', 'All', @RI_ID, s.ContactId, '' 
	from cftSite s Join cftContact c on s.ContactId = c.ContactId
	Left Join cftFacilityType f on s.FacilityTypeId = f.FacilityTypeId
	Where s.PFEUClassification <> 'Approved' 
	and s.FacilityTypeId <> '001' and s.FacilityTypeId <> '002'	--don't include sows and nurseries

	--create a temporary work table to hold a list of active service managers
    Create Table #SMCList (SiteContactId Char (6), SvcMgrContactID Char (6))
	--fill the table with that list (the ones with the highest effective date before the report date)
    Insert Into #SMCList (SiteContactId, SvcMgrContactID)
	Select SiteContactId, SvcMgrContactID from cftSiteSvcMgrAsn Where EffectiveDate = 
	(Select Max(m.EffectiveDate) from cftSiteSvcMgrAsn m Where m.SiteContactId = cftSiteSvcMgrAsn.SiteContactId 
	and m.EffectiveDate <= @RptDate)

	--get the svc manager from the temporary table
    Update wrkPFEUInel Set SvcMgrContactID = Coalesce((Select Max(SvcMgrContactID) 
	from #SMCList where wrkPFEUInel.SiteContactId = #SMCList.SiteContactId), '') Where RI_ID = @RI_ID

	--add ri_id as a filter in the report where clause
	SELECT @Search = '(RI_ID = ' + RTRIM(CONVERT(VARCHAR(6),@RI_ID)) + ')'
	
	SELECT @Pos = PATINDEX('%' + @Search + '%', @RI_Where)
	
	UPDATE RptRunTime SET RI_Where = CASE
		WHEN @RI_Where IS NULL OR DATALENGTH(@RI_Where) <= 0
			THEN @Search
		WHEN @Pos <= 0
			THEN @Search + ' AND (' + @RI_WHERE + ')'
	END
	WHERE RI_ID = @RI_ID


 
GO
GRANT CONTROL
    ON OBJECT::[dbo].[pb_CF662] TO [MSDSL]
    AS [dbo];

