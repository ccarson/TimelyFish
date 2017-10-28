 --11250,11500,11510,11520,11530
	Create Proc Routing_Kitid @parm1 varchar ( 30) as
            Select * from Routing where KitId like @parm1
                order by KitId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Routing_Kitid] TO [MSDSL]
    AS [dbo];

