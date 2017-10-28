

CREATE     Procedure pCF523_SiteAccts 
		@parm1 varchar(16)
AS
   Select * 
	from PJACCT 
	Where acct_type='EX' AND acct_group_cd<>'PG'
	AND acct LIKE @parm1
	

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pCF523_SiteAccts] TO [MSDSL]
    AS [dbo];

