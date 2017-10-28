
CREATE PROCEDURE dbo.pDeleteFromMarkets
AS DELETE FROM dbo.MarketMovement
WHERE     (SourceSiteID = 'DEL')


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pDeleteFromMarkets] TO [MSDSL]
    AS [dbo];

