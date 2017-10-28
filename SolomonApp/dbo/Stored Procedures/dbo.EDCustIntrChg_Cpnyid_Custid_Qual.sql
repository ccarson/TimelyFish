 Create Proc EDCustIntrChg_Cpnyid_Custid_Qual @Parm1 varchar(10), @Parm2 varchar(15), @Parm3 varchar(2) As
Select * From EDCustIntrChg Where Cpnyid = @Parm1 And Custid = @Parm2
And Qualifier = @Parm3


