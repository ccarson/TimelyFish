



CREATE  FUNCTION [dbo].[GetFOIssueCount] 
     (@SiteContactID as varchar(6), @StartDate as smalldatetime,@RespPty as varchar(1))
RETURNS varchar(20)
AS
	BEGIN 
	DECLARE @intReturn int
	SET @intReturn=(Select Count(fo.OrdNbr)  
FROM cftFeedOrder fo WITH (NOLOCK)
JOIN cftOrderType ot WITH (NOLOCK) on fo.OrdType=ot.OrdType
LEFT JOIN cftFeedOrder ovr WITH (NOLOCK) on fo.User1=ovr.OrdNbr
where ((fo.ContactID=@SiteContactID and ot.User8=0) or (ovr.ContactID=@SiteContactID and ot.User8=1)) 
	and RespPty=@RespPty
	and fo.DateOrd between DateAdd(d,-29,@StartDate) and DateAdd(d,-1,@StartDate))


	 RETURN @intReturn
	END



