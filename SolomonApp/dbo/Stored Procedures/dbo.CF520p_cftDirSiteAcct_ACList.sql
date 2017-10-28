Create Procedure CF520p_cftDirSiteAcct_ACList as 
    Select * from cftDirSiteAcct Order by AcctCatSite

GO
GRANT CONTROL
    ON OBJECT::[dbo].[CF520p_cftDirSiteAcct_ACList] TO [MSDSL]
    AS [dbo];

