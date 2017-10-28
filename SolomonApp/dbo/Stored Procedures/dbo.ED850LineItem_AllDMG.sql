 /****** Object:  Stored Procedure dbo.ED850LineItem_All    Script Date: 5/28/99 1:17:38 PM ******/
CREATE Proc ED850LineItem_AllDMG @Parm1 varchar(10), @Parm2 varchar(10), @Parm3 smallint, @Parm4 smallint As
Select * From ED850LineItem Where CpnyId = @Parm1 And EDIPOID = @Parm2 And LineNbr Between @Parm3 And @Parm4 Order By CpnyId, EDIPOID, LineNbr


