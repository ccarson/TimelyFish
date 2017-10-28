 Create Proc Kit_Kitid @parm1 varchar ( 30) as
            Select * from Kit where KitId like @parm1
                order by KitId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Kit_Kitid] TO [MSDSL]
    AS [dbo];

