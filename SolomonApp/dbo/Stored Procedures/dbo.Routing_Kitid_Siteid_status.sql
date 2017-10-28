 Create Proc Routing_Kitid_Siteid_status @parm1 varchar ( 30),@parm2 varchar (10),@parm3 varchar(1) as
            Select * from Routing where KitId = @parm1
                and siteid = @parm2 and status = @parm3
                order by KitId, siteid, status



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Routing_Kitid_Siteid_status] TO [MSDSL]
    AS [dbo];

