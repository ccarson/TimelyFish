 /****** Object:  Stored Procedure dbo.LocTable_siteid_status_date    Script Date: 4/17/98 10:58:18 AM ******/
Create Procedure LocTable_siteid_status_date @parm1 varchar(10), @parm2 varchar(1), @parm3 smalldatetime As
    select whseloc, selected, cycleid from LocTable
    where siteid = @parm1
    and countstatus = @parm2
    and lastcountdate <= @parm3

    order by siteid, whseloc


