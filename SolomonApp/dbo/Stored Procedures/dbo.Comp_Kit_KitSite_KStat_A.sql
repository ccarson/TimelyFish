 Create Proc Comp_Kit_KitSite_KStat_A @parm1 varchar ( 30), @parm2 varchar ( 10),
		@parm3 varchar ( 1), @parm4 varchar ( 30), @parm5 varchar (1) as
        Select * from Component where
        	Kitid = @parm1 and
		KitSiteid = @parm2 and
        	Kitstatus = @parm3 and
		cmpnentid like @parm4 and
        	status = @parm5
        Order by Kitid,KitSiteid,Kitstatus,LineNbr,Cmpnentid



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Comp_Kit_KitSite_KStat_A] TO [MSDSL]
    AS [dbo];

