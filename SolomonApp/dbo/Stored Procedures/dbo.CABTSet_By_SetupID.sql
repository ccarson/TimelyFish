 /****** Object:  Stored Procedure dbo.CABTSet_By_SetupID    Script Date: 4/7/98 12:49:20 PM ******/
create Proc CABTSet_By_SetupID @parm1 varchar ( 10) as
Select * from CABTSet
where SetupId like @parm1
Order by setupid, cpnyid, bankacct, banksub



GO
GRANT CONTROL
    ON OBJECT::[dbo].[CABTSet_By_SetupID] TO [MSDSL]
    AS [dbo];

