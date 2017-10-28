Create Procedure CF599p_cftDirSiteAcct_ACS @parm1 varchar (16) as 
    Select * from cftDirSiteAcct Where AcctCatSite Like @parm1
	Order by AcctCatSite
