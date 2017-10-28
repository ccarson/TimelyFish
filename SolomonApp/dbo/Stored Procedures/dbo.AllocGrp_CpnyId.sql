 /****** Object:  Stored Procedure dbo.AllocGrp_CpnyId    Script Date: 4/7/98 12:38:58 PM ******/
Create Proc AllocGrp_CpnyId @parm1 varchar ( 10) as
       Select * from AllocGrp
           where CpnyId like @parm1
           order by CpnyId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[AllocGrp_CpnyId] TO [MSDSL]
    AS [dbo];

