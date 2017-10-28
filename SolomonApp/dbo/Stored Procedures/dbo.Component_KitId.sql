 Create Proc Component_KitId @parm1 varchar ( 30) as
            Select * from Component where KitId = @parm1
           Order by KitId, CmpnentId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Component_KitId] TO [MSDSL]
    AS [dbo];

