Create Procedure CF522p_cftDirSiteAcct_ACList as 
    Select * from cftDirSiteAcct Where Type='S' Order by AcctCatSite
