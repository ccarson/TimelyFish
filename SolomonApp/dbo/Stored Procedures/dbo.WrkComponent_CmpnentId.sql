 /****** Object:  Stored Procedure dbo.WrkComponent_CmpnentId    Script Date: 4/17/98 10:58:19 AM ******/
/****** Object:  Stored Procedure dbo.WrkComponent_CmpnentId    Script Date: 4/16/98 7:41:53 PM ******/
Create Proc  WrkComponent_CmpnentId @parm1 varchar ( 30) as
       Select * from WrkComponent
           where CmpnentId  =  @parm1
           order by CmpnentId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[WrkComponent_CmpnentId] TO [MSDSL]
    AS [dbo];

