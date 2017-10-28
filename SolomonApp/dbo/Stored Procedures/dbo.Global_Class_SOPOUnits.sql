 /****** Object:  Stored Procedure dbo.Global_Class_SOPOUnits    Script Date: 4/17/98 10:58:17 AM ******/
/****** Object:  Stored Procedure dbo.Global_Class_SOPOUnits    Script Date: 4/16/98 7:41:51 PM ******/
Create Proc Global_Class_SOPOUnits @parm1 varchar ( 6), @parm2 varchar ( 6), @parm3 varchar ( 30), @parm4 varchar ( 6) as
    Select distinct fromunit, ToUnit from inunit
        where fromUnit like @parm4
                and toUnit = @parm2
        and (InvtId = '*' or InvtId = @parm3)
                and (ClassId = '*' or ClassId = @parm1)
        order by FromUnit, Tounit



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Global_Class_SOPOUnits] TO [MSDSL]
    AS [dbo];

