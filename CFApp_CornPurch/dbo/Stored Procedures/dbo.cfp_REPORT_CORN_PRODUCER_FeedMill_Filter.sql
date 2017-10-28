



-- =============================================
-- Author:	Andrey Derco
-- Create date: 10/13/2008
-- Description:	Returns all Corn Producers
-- =============================================
create PROCEDURE [dbo].[cfp_REPORT_CORN_PRODUCER_FeedMill_Filter]
(
   @FeedMillname char(50)
)
AS
BEGIN
	SET NOCOUNT ON;

IF @FeedMillname = '--All--' BEGIN


  SELECT '%' AS CornProducerID,
         '--All--' AS CornProducerName
       
  UNION ALL 

  SELECT CP.CornProducerID,
         V.RemitName AS CornProducerName
  FROM cft_FEED_MILL fm (nolock)
  inner join dbo.cft_CORN_PRODUCER CP (Nolock) on CP.DefaultFeedMillID = fm.FeedMillID
  INNER JOIN [$(SolomonApp)].dbo.Vendor V (nolock) ON V.VendId = CP.CornProducerID

  ORDER BY 2

END ELSE BEGIN

  SELECT '%' AS CornProducerID,
         '--All--' AS CornProducerName
       
  UNION ALL 

  SELECT CP.CornProducerID,
         V.RemitName AS CornProducerName
  FROM cft_FEED_MILL fm (nolock)
  inner join dbo.cft_CORN_PRODUCER CP (Nolock) on CP.DefaultFeedMillID = fm.FeedMillID
  INNER JOIN [$(SolomonApp)].dbo.Vendor V (nolock) ON V.VendId = CP.CornProducerID
  where fm.name like Rtrim(@FeedMillname)
  ORDER BY 2

END

END




