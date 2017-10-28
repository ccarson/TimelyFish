 /****** Object:  Stored Procedure dbo.Itemsite_MoveClass_Freq    Script Date: 4/17/98 10:58:18 AM ******/
Create Proc Itemsite_MoveClass_Freq @parm1 varchar(10) as
   Select * from ItemSite where MoveClass <> ''
	and siteid = @Parm1 and countstatus = 'A'
	order by moveclass, invtid



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Itemsite_MoveClass_Freq] TO [MSDSL]
    AS [dbo];

