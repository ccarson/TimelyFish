 CREATE Proc EDDiscCode_Direction @Direction varchar(1), @CustId varchar(15), @SpecChgCode varchar(5) As
Select * From EDDiscCode Where Direction = @Direction And CustId In (@CustId, '*') And
SpecChgCode Like @SpecChgCode Order By SpecChgCode


