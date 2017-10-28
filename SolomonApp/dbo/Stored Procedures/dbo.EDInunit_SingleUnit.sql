 Create Proc EDInunit_SingleUnit @Parm1 varchar(30), @Parm2 varchar(6), @Parm3 varchar(6), @Parm4 varchar(6) As
-- @Parm1 = InvtId, @Parm2 = ClassId, @Parm3 = FromUnit, @Parm4 = ToUnit
Select * From InUnit Where InvtId In (@Parm1, '*') And ClassId In (@Parm2, '*') And
FromUnit = @Parm3 And ToUnit = @Parm4 Order By UnitType Desc



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDInunit_SingleUnit] TO [MSDSL]
    AS [dbo];

