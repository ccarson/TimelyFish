 Create Proc SCMRtgTran_RefNbr_Kitid_SiteID @parm1 varchar ( 15), @parm2 varchar (30), @parm3 varchar ( 10)  as
       Select * From RtgTran, Operation Where
		RefNbr = @parm1 AND
		KitId = @parm2 AND
		RtgSiteId = @parm3 AND
		Operation.OperationId = RtgTran.OperationId
	Order By Rtgtran.Refnbr,Rtgtran.Kitid, Rtgtran.LineNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SCMRtgTran_RefNbr_Kitid_SiteID] TO [MSDSL]
    AS [dbo];

