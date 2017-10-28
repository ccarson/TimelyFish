 Create Proc RtgTran_Kitid_RtgSiteId @parm1 varchar ( 30), @parm2 varchar (10)  as
       Select * from RtgTran where KitId = @parm1
	     and RtgSiteId = @parm2
		 order by KitId, RtgSiteId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[RtgTran_Kitid_RtgSiteId] TO [MSDSL]
    AS [dbo];

