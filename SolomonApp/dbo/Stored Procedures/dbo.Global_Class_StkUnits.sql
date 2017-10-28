 /****** Object:  Stored Procedure dbo.Global_Class_StkUnits    Script Date: 4/17/98 10:58:19 AM ******/
/****** Object:  Stored Procedure dbo.Global_Class_StkUnits    Script Date: 4/16/98 7:41:53 PM ******/
Create Proc Global_Class_StkUnits @parm1 varchar ( 6) as
select distinct tounit from inunit where UnitType = '1' or (unittype = '2' and classid = @parm1) order by toUnit



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Global_Class_StkUnits] TO [MSDSL]
    AS [dbo];

