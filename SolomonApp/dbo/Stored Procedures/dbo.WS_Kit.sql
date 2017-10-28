
Create Proc WS_Kit @parm1 varchar ( 30) as
            Select KitType from Kit where KitId like @parm1
                order by KitId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[WS_Kit] TO [MSDSL]
    AS [dbo];

