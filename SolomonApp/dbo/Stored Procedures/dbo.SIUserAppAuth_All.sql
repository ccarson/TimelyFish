 Create Proc SIUserAppAuth_All @Parm1 varchar(47) as
    Select * from SIUserAppAuth Where UserID like @Parm1
	Order by UserID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SIUserAppAuth_All] TO [MSDSL]
    AS [dbo];

