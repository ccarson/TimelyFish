 /****** Object:  Stored Procedure dbo.Component_CmpnentId    Script Date: 4/17/98 10:58:16 AM ******/
/****** Object:  Stored Procedure dbo.Component_CmpnentId    Script Date: 4/16/98 7:41:51 PM ******/
Create Proc Component_CmpnentId @parm1 varchar ( 30) as
            Select * from Component where CmpnentId = @parm1
                order by CmpnentId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Component_CmpnentId] TO [MSDSL]
    AS [dbo];

