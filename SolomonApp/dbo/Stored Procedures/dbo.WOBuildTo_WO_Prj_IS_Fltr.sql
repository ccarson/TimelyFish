 CREATE PROCEDURE WOBuildTo_WO_Prj_IS_Fltr
   	@InvtID        	varchar( 30 ),
   	@SiteID        	varchar( 10 ),
   	@WhseLoc	varchar( 10 ),
   	@Status        	varchar( 1 ),
   	@CustID        	varchar( 15 ),
   	@PlanEndBeg    	smalldatetime,
   	@PlanEndEnd    	smalldatetime,
   	@ProcStage     	varchar( 1 ),
   	@WOStatus      	varchar( 1 )

AS

	-- A - Firm or Released
	if @ProcStage = 'A'
		BEGIN
   		SELECT      	*
		FROM        	WOBuildTo LEFT JOIN WOHeader
               			ON WOBuildTo.WONbr = WOHeader.WONbr
		               	LEFT JOIN PJProj
               			ON WOBuildTo.WONbr = PJProj.Project
		WHERE       	WOBuildTo.InvtID = @InvtID and
               			WOBuildTo.SiteID LIKE @SiteID and
               			WOBuildTo.WhseLoc LIKE @WhseLoc and
		               	WOBuildTo.Status LIKE @Status and
               			WOBuildTo.CustID LIKE @CustID and
		               	WOHeader.PlanEnd Between @PlanEndBeg and @PlanEndEnd and
               			WOHeader.ProcStage IN ('F','R') and
				WOHeader.Status LIKE @WOStatus
		ORDER BY    	WOHeader.PlanEnd DESC, WOBuildTo.WONbr DESC
		END

	-- B - Plan or Firm or Released
	ELSE 	if @ProcStage = 'B'
		BEGIN
   		SELECT      	*
		FROM        	WOBuildTo LEFT JOIN WOHeader
               			ON WOBuildTo.WONbr = WOHeader.WONbr
		               	LEFT JOIN PJProj
               			ON WOBuildTo.WONbr = PJProj.Project
		WHERE       	WOBuildTo.InvtID = @InvtID and
               			WOBuildTo.SiteID LIKE @SiteID and
               			WOBuildTo.WhseLoc LIKE @WhseLoc and
		               	WOBuildTo.Status LIKE @Status and
               			WOBuildTo.CustID LIKE @CustID and
		               	WOHeader.PlanEnd Between @PlanEndBeg and @PlanEndEnd and
               			WOHeader.ProcStage IN ('P', 'F','R') and
				WOHeader.Status LIKE @WOStatus
		ORDER BY    	WOHeader.PlanEnd DESC, WOBuildTo.WONbr DESC
		END
	ELSE
		BEGIN
   		SELECT      	*
		FROM        	WOBuildTo LEFT JOIN WOHeader
               			ON WOBuildTo.WONbr = WOHeader.WONbr
		               	LEFT JOIN PJProj
               			ON WOBuildTo.WONbr = PJProj.Project
		WHERE       	WOBuildTo.InvtID = @InvtID and
               			WOBuildTo.SiteID LIKE @SiteID and
               			WOBuildTo.WhseLoc LIKE @WhseLoc and
		               	WOBuildTo.Status LIKE @Status and
               			WOBuildTo.CustID LIKE @CustID and
		               	WOHeader.PlanEnd Between @PlanEndBeg and @PlanEndEnd and
               			WOHeader.ProcStage LIKE @ProcStage and
				WOHeader.Status LIKE @WOStatus
		ORDER BY    	WOHeader.PlanEnd DESC, WOBuildTo.WONbr DESC
		END

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[WOBuildTo_WO_Prj_IS_Fltr] TO [MSDSL]
    AS [dbo];

