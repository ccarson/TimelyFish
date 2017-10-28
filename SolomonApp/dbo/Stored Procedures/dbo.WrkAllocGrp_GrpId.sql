 /****** Object:  Stored Procedure dbo.WrkAllocGrp_GrpId    Script Date: 4/7/98 12:38:59 PM ******/
Create Proc  WrkAllocGrp_GrpId @parm1 varchar ( 6) as
       Select * from WrkAllocGrp
           where GrpId  =  @parm1




GO
GRANT CONTROL
    ON OBJECT::[dbo].[WrkAllocGrp_GrpId] TO [MSDSL]
    AS [dbo];

