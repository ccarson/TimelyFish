 /****** Object:  Stored Procedure dbo.itemsite_nmc    Script Date: 4/17/98 10:58:19 AM ******/
Create Procedure itemsite_nmc @parm1 Varchar(10), @parm2 varchar(10) As
    select * from itemsite
    where moveclass = @parm1
    and siteid = @parm2
    and itemsite.countstatus = 'A'
    order by siteid, invtid



GO
GRANT CONTROL
    ON OBJECT::[dbo].[itemsite_nmc] TO [MSDSL]
    AS [dbo];

