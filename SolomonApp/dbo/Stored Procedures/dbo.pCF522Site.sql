CREATE    Proc pCF522Site
	@parm1 varchar(3)
	as
select ct.ContactName, ct.ContactID
	FROM cftContact ct 
	--Temp change to close inactive site
	--Where ct.ContactTypeID='04' AND ct.StatusTypeID='1'
	Where ct.ContactTypeID='04' 
	AND ct.ContactID IN (Select SiteContactID From cftPigGroup 
	Where CostFlag='1' AND PGStatusID='I' AND PigProdPhaseID=@parm1
	Group by SiteContactID)
        Group by ct.ContactName, ct.ContactID
	Order by ct.ContactName





 
GO
GRANT CONTROL
    ON OBJECT::[dbo].[pCF522Site] TO [MSDSL]
    AS [dbo];

