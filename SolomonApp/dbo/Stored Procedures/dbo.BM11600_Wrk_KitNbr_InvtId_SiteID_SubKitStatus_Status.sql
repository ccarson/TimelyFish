 Create Proc BM11600_Wrk_KitNbr_InvtId_SiteID_SubKitStatus_Status
	@parm1  integer,
	@parm2 varchar (30),
	@parm3 varchar (10),
	@parm4 varchar (10),
	@parm5 varchar (1)  as

            Select * from BM11600_Wrk where
		KitNbr = @parm1 AND
		InvtId = @parm2 AND
		CmpnentSiteID = @parm3 AND
		SubKitStatus = @parm4 AND
		Status = @parm5

           Order by KitNbr, InvtId, SiteID, Status, SubKitStatus


