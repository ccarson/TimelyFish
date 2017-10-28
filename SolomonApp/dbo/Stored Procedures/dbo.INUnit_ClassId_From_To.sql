 /****** Object:  Stored Procedure dbo.INUnit_ClassId_From_To    Script Date: 4/17/98 10:58:17 AM ******/
/****** Object:  Stored Procedure dbo.INUnit_ClassId_From_To    Script Date: 4/16/98 7:41:51 PM ******/
Create Proc INUnit_ClassId_From_To @parm1 varchar ( 6), @parm2 varchar ( 6), @parm3 varchar ( 6) as
    Select * from INUnit
        where UnitType = '2'
        and ClassId = @parm1
                and FromUnit = @parm2
                and ToUnit = @parm3
        order by UnitType, ClassId, InvtId, FromUnit, ToUnit


