 Create Proc Routing_All @parm1 varchar ( 30),@parm2 varchar (1), @parm3 varchar (10)  as
            Select * from Routing where KitId like @parm1 and Status like @parm2 and SiteID like @parm3
                order by KitId, SiteID, Status



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Routing_All] TO [MSDSL]
    AS [dbo];

