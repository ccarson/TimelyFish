/****** Object:  Stored Procedure dbo.pCF511GroupRoom    Script Date: 10/27/2004 8:46:33 AM ******/

CREATE  Procedure pCF511GroupRoom
	@parm1 varchar(6),
	@parm2 varchar(10)

AS
	Select gr.*, f.*
	From cftPigGroupRoom gr 
	Left JOIN cftFeedPlanHdr f ON gr.FeedPlanID=f.FeedPlanID
	WHERE gr.PigGroupID=@parm1 AND gr.RoomNbr LIKE @parm2
	Order by gr.PigGroupID, gr.RoomNbr 



 