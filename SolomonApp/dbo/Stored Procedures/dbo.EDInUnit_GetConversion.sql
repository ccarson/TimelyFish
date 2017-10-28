 CREATE Proc EDInUnit_GetConversion @FromUnit varchar(6), @ToUnit varchar(6), @InvtId varchar(30), @ClassId varchar(6) As
Select CnvFact, MultDiv From InUnit Where FromUnit = @FromUnit And ToUnit = @ToUnit And
InvtId In (@InvtId,'*') And ClassId In (@ClassId,'*') Order By UnitType Desc



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDInUnit_GetConversion] TO [MSDSL]
    AS [dbo];

