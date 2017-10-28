 /****** Object:  Stored Procedure dbo.EDCustIntrChg_All    Script Date: 5/28/99 1:17:40 PM ******/
CREATE Proc EDCustIntrChg_AllDMG @Parm1 varchar(15), @Parm2 varchar(2), @Parm3 varchar(15), @Parm4 varchar(20) As
Select * From EDCustIntrChg Where CustId = @Parm1 And Qualifier Like @Parm2
And Id Like @Parm3 And CpnyId Like @Parm4
Order By CustId, Qualifier, Id, CpnyId


