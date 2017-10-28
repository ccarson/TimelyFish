 /****** Object:  Stored Procedure dbo.ItemSite_MoveClass    Script Date: 4/17/98 10:58:18 AM ******/
Create Procedure ItemSite_MoveClass @parm1 VarChar(10) as
    update itemsite set itemsite.selected = 1, itemsite.countstatus = 'P'
    from itemsite, pimovecl
    where itemsite.siteid = @parm1
    and itemsite.countstatus = 'A'
    and itemsite.moveclass = pimovecl.moveclass
    and itemsite.lastvarpct > (100 - pimovecl.tolerance)



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ItemSite_MoveClass] TO [MSDSL]
    AS [dbo];

