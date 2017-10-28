 /****** Object:  Stored Procedure dbo.LocTable_Abc    Script Date: 4/17/98 10:58:18 AM ******/
Create Procedure LocTable_Abc @parm1 VarChar(10) as
    update LocTable set LocTable.selected = 1, countstatus = 'P'
    From LocTable, PIAbc
    where LocTable.siteid = @parm1
    and LocTable.countstatus = 'A'
    and LocTable.abccode = piabc.abccode
    and LocTable.lastvarpct > (100 - piabc.tolerance)


