 Create Proc Comp_Kit_Site_Stat_Ln3 @parm1 varchar (30),@parm2 varchar (10),
        @parm3 varchar (1), @parm4 varchar (10), @parm5beg smallint,@parm5end smallint as
        Select * from Component where
        Kitid = @parm1 and KitSiteid = @parm2
        and kitstatus = @parm3 and siteid = @parm4
	and linenbr between @parm5beg and @parm5end
        Order by Kitid,Kitsiteid, Kitstatus,Linenbr,Cmpnentid



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Comp_Kit_Site_Stat_Ln3] TO [MSDSL]
    AS [dbo];

