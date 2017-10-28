 /****** Object:  Stored Procedure dbo.ItemSite_Abc    Script Date: 4/17/98 10:58:17 AM ******/
Create Procedure ItemSite_Abc @parm1 Varchar(10) as
    update itemsite set itemsite.selected = 1, countstatus = 'P'
    from itemsite, piabc
    where itemsite.siteid = @parm1
    and itemsite.countstatus = 'A'
    and itemsite.abccode = piabc.abccode
    and itemsite.lastvarpct > (100 - piabc.tolerance)



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ItemSite_Abc] TO [MSDSL]
    AS [dbo];

