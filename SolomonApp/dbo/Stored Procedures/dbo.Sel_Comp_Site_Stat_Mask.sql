 Create Proc Sel_Comp_Site_Stat_Mask @parm1 varchar ( 30),@parm2 varchar (10), @parm3 varchar (1) as
	Select * from Component where Cmpnentid like @parm1 and siteid like
        @parm2 and status like @parm3
        order by Cmpnentid,Siteid,Status



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Sel_Comp_Site_Stat_Mask] TO [MSDSL]
    AS [dbo];

