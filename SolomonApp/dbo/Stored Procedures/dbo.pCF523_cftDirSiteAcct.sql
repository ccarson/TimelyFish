
/****** Object:  Stored Procedure dbo.pCF523_cftDirSiteAcct    Script Date: 5/18/2005 9:11:26 AM ******/


CREATE    Procedure pCF523_cftDirSiteAcct @parm1 varchar (16)
AS
    Select * from cftDirSiteAcct Where Type='S' AND AcctCatSite LIKE @parm1 
	


