 /****** Object:  Stored Procedure dbo.CABTSet_All    Script Date: 4/7/98 12:49:20 PM ******/
create Proc CABTSet_All @parm1 varchar (10), @parm2 varchar (10), @parm3 varchar (10), @parm4 varchar (24) as
Select * from CABTSet
where setupid like @parm1
and cpnyid like @parm2
and bankacct like @parm3
and banksub like @parm4
Order by setupid, cpnyid, bankacct, banksub



GO
GRANT CONTROL
    ON OBJECT::[dbo].[CABTSet_All] TO [MSDSL]
    AS [dbo];

