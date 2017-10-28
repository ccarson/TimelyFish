 /****** Object:  Stored Procedure dbo.Component_KitId_CmpnentId    Script Date: 4/17/98 10:58:16 AM ******/
/****** Object:  Stored Procedure dbo.Component_KitId_CmpnentId    Script Date: 4/16/98 7:41:51 PM ******/
Create Proc Component_KitId_CmpnentId @parm1 varchar ( 30), @parm2 varchar ( 30) as
            Select * from Component where KitId = @parm1
                           and CmpnentId like @parm2
                        Order by KitId, CmpnentId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Component_KitId_CmpnentId] TO [MSDSL]
    AS [dbo];

