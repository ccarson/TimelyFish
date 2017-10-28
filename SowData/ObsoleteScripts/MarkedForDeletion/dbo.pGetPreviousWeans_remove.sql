CREATE PROC [dbo].[pGetPreviousWeans_remove]
	@FarmID varchar(8)
	As

	Select DISTINCT w1.* from 
            PCUploadMasterWean w1
            JOIN PCUploadMasterWean w2 ON w1.FarmID = w2.FarmID and w1.SowID = w2.SowID
            Where w1.FarmID = @FarmID
            AND w1.TransferStatus = 0
            AND w2.TransferStatus = -1
            AND w1.EventDay < w2.EventDay
            AND w1.DateInserted > w2.DateInserted

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[pGetPreviousWeans_remove] TO [se\analysts]
    AS [dbo];


GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[pGetPreviousWeans_remove] TO [se\analysts]
    AS [dbo];

