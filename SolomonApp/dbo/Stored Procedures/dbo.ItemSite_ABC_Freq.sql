 /****** Object:  Stored Procedure dbo.ItemSite_ABC_Freq    Script Date: 4/17/98 10:58:17 AM ******/
Create Proc ItemSite_ABC_Freq @parm1 varchar(10) as
    select * from ItemSite
	where abccode <> '' and siteid = @parm1
	and countstatus = 'A' order by abccode, invtid



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ItemSite_ABC_Freq] TO [MSDSL]
    AS [dbo];

