 /****** Object:  Stored Procedure dbo.INUnit_Global_Unit    Script Date: 4/17/98 10:58:17 AM ******/
/****** Object:  Stored Procedure dbo.INUnit_Global_Unit    Script Date: 4/16/98 7:41:51 PM ******/
Create Proc INUnit_Global_Unit @parm1 varchar ( 6) as
    Select * from INUnit
        where UnitType = '1'
                and ToUnit = @parm1
        order by UnitType,  ToUnit



GO
GRANT CONTROL
    ON OBJECT::[dbo].[INUnit_Global_Unit] TO [MSDSL]
    AS [dbo];

