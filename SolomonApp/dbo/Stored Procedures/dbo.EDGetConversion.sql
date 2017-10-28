 Create Proc EDGetConversion @Unit1 varchar(6), @Unit2 varchar(6), @InvtId varchar(30), @ClassId varchar(6) As
If LTrim(RTrim(@Unit1)) <> LTrim(RTrim(@Unit2))
  Select FromUnit, ToUnit, CnvFact, MultDiv From InUnit Where FromUnit In (@Unit1, @Unit2) And ToUnit In (@Unit1, @Unit2)
  And InvtId In (@InvtId, '*') And ClassId In (@ClassId, '*') And FromUnit <> ToUnit
  Order By UnitType Desc
Else
  Select FromUnit, ToUnit, CnvFact, MultDiv From InUnit Where FromUnit In (@Unit1, @Unit2) And ToUnit In (@Unit1, @Unit2)
  And InvtId In (@InvtId, '*') And ClassId In (@ClassId, '*')
  Order By UnitType Desc



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDGetConversion] TO [MSDSL]
    AS [dbo];

