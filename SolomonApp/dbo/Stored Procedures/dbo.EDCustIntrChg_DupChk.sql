 Create Proc EDCustIntrChg_DupChk @Parm1 varchar(2), @Parm2 varchar(15), @Parm3 varchar(20) As
Select CustId From EDCustIntrChg Where Qualifier = @Parm1 And Id = @Parm2
And EDIBillToRef = @Parm3


