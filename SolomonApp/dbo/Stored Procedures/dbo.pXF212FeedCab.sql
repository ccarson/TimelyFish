
CREATE    Procedure pXF212FeedCab
	 @parmCabID As varchar(10)
AS
Select *
From cftFeedCab
Where CabID LIKE @parmCabID


