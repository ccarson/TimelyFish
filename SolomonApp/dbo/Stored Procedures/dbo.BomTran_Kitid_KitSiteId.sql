 Create Proc BomTran_Kitid_KitSiteId @parm1 varchar ( 30), @parm2 varchar (10)   as
       Select * from BomTran where KitId = @parm1
	     and KitSiteId = @parm2
		 order by KitId, KitSiteId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[BomTran_Kitid_KitSiteId] TO [MSDSL]
    AS [dbo];

