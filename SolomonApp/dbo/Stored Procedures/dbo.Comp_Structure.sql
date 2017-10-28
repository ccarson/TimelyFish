 Create Procedure Comp_Structure
	@parm1 varchar (30),
	@parm2 varchar (10),
	@parm3 varchar (1) as
	Select * from Component where
        	Kitid = @parm1
		and KitSiteid = @parm2
		and KitStatus = @parm3
        	Order by Kitid,Kitsiteid,Sequence



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Comp_Structure] TO [MSDSL]
    AS [dbo];

