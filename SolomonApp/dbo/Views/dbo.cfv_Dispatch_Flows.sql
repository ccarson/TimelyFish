


CREATE   VIEW [dbo].[cfv_Dispatch_Flows] (PigGroupID, PigFlowID, PigFlowDescription)
	AS
/* Used in the VFD Dispatch programs
*/
	-- This view is used to access the flows int the Pig Management db 
	-- that have the contact role of 'Veterinarian' (RoleTypeID = 001)
	SELECT pg.PigGroupID, pf.PigFlowID, pf.PigFlowDescription
		FROM [CFApp_PigManagement].[dbo].[cft_PIG_FLOW] pf
		JOIN [SolomonApp].[dbo].[cftPigGroup] pg (nolock) on pg.CF08 = pf.PigFlowID
