 Create Proc Comp_Kit_KitSite_KStat51 @parm1 varchar ( 30), @parm2 varchar ( 10), @parm3 varchar ( 1), @parm4 varchar ( 30), @parm5 varchar (10),@parm6 varchar (1),@parm7 smallint as
        Select * from Component where
        Kitid = @parm1 and KitSiteid = @parm2 and
        Kitstatus = @parm3 and cmpnentid = @parm4 and siteid = @parm5 and
        status = @parm6 and sequence = @parm7
        Order by Kitid,KitSiteid,Kitstatus,Cmpnentid,Status



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Comp_Kit_KitSite_KStat51] TO [MSDSL]
    AS [dbo];

