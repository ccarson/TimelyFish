Create Procedure CF300p_cftSSMA_SvcMgr @parm1 varchar (6), @parm2 smalldatetime as 
    Select c.* From cftContact c Join cftSiteSvcMgrAsn s on c.ContactId = s.SvcMgrContactID 
	Where s.SiteContactId = @parm1 and s.EffectiveDate <= @parm2
	Order by s.EffectiveDate Desc

GO
GRANT CONTROL
    ON OBJECT::[dbo].[CF300p_cftSSMA_SvcMgr] TO [MSDSL]
    AS [dbo];

