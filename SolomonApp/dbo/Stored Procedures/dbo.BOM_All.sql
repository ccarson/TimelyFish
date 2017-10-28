 Create Proc BOM_All @parm1 varchar ( 30) as
            Select * from Kit where KitId like @parm1
                order by KitId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[BOM_All] TO [MSDSL]
    AS [dbo];

