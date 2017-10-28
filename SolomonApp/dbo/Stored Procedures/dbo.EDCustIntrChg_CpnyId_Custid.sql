 CREATE Proc EDCustIntrChg_CpnyId_Custid @Parm1 varchar(10), @Parm2 varchar(15) As
Select * From EDCustIntrChg Where Cpnyid like @Parm1 And Custid like @Parm2
Order By Id Desc


