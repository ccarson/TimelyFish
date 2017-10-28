 /****** Object:  Stored Procedure dbo.itemsite_nabc    Script Date: 4/17/98 10:58:19 AM ******/
Create Procedure itemsite_nabc @parm1 Varchar(2), @parm2 VarChar(10) As
    select * from itemsite
    where abccode = @parm1
    and siteid = @parm2
    and itemsite.countstatus = 'A'
    order by siteid, invtid



GO
GRANT CONTROL
    ON OBJECT::[dbo].[itemsite_nabc] TO [MSDSL]
    AS [dbo];

