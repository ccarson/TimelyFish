
/****** Object:  Stored Procedure dbo.pCF523_SiteAccts    Script Date: 5/18/2005 10:45:26 AM ******/


CREATE      Procedure pCF523_GroupAccts 
		@parm1 varchar(16)
AS
   Select * 
	from PJACCT 
	Where acct_type='EX' AND acct_group_cd='PG'
	AND acct LIKE @parm1
	


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pCF523_GroupAccts] TO [MSDSL]
    AS [dbo];

