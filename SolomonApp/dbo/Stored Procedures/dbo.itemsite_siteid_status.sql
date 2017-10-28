 /****** Object:  Stored Procedure dbo.itemsite_siteid_status    Script Date: 4/17/98 10:58:19 AM ******/
Create Procedure itemsite_siteid_status @parm1 varchar(10), @parm2 varchar(1)  As
    select invtid, selected, cycleid from itemsite
    where siteid = @parm1
    and countstatus = @parm2
    order by  invtid



GO
GRANT CONTROL
    ON OBJECT::[dbo].[itemsite_siteid_status] TO [MSDSL]
    AS [dbo];

