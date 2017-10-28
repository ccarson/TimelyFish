CREATE   Procedure pXF212FeedCabNextID
AS
Select Max(CAST(DrTrCabID AS INTEGER)) 
From cftFeedTrDrCab 

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF212FeedCabNextID] TO [MSDSL]
    AS [dbo];

