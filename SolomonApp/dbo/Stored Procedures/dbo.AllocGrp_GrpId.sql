 /****** Object:  Stored Procedure dbo.AllocGrp_GrpId    Script Date: 4/7/98 12:38:58 PM ******/
Create Proc AllocGrp_GrpId @parm1 varchar ( 10),@parm2 varchar ( 6) as
       Select * from AllocGrp
           where CpnyId like @parm1
             and GrpId like @parm2
           order by CpnyId, GrpId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[AllocGrp_GrpId] TO [MSDSL]
    AS [dbo];

