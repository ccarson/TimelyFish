 /****** Object:  Stored Procedure dbo.Comp_Kit_Site_Stat_Ln2    Script Date: 4/17/98 12:19:28 PM ******/
Create Proc Comp_Kit_Site_Stat_Ln2 @parm1 varchar ( 30),@parm2 varchar ( 10),
        @parm3 varchar ( 1),@parm4beg smallint,@parm4end smallint as
        Select * from Component where
        Kitid = @parm1 and KitSiteid = @parm2
        and kitstatus = @parm3 and linenbr between
        @parm4beg and @parm4end
        Order by Kitid,Kitsiteid,Kitstatus,LineNbr,Cmpnentid



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Comp_Kit_Site_Stat_Ln2] TO [MSDSL]
    AS [dbo];

