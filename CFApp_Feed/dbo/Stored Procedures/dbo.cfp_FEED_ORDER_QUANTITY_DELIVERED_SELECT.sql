-- =============================================
-- Author:		Brian Cesafsky
-- Create date: 02/16/2009
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[cfp_FEED_ORDER_QUANTITY_DELIVERED_SELECT]
	@SiteContactID CHAR(10)
  , @BarnNumber CHAR(6)
  , @BinNumber CHAR(6)
  , @LastBinReadingDate SmallDateTime
AS
BEGIN
	Select datedel, sum (QtyDel) QuantityDelivered from [$(SolomonApp)].dbo.cftFeedOrder
	where DateDel >= (select max(DateDel) from [$(SolomonApp)].dbo.cftFeedOrder
		  where Status = 'C'
		  and ContactId = @SiteContactID 
		  and BarnNbr = @BarnNumber
		  and BinNbr = @BinNumber)
	and Status = 'C'
	and ContactId = @SiteContactID    
	and BarnNbr = @BarnNumber
	and BinNbr = @BinNumber
	and DateDel >= @LastBinReadingDate
	group by datedel

--	Select sum (QtyDel) QuantityDelivered from [$(SolomonApp)].dbo.cftFeedOrder
--	where DateDel >= (select max(DateDel) from [$(SolomonApp)].dbo.cftFeedOrder
--		  where Status = 'C'
--		  and ContactId = @SiteContactID 
--		  and BarnNbr = @BarnNumber
--		  and BinNbr = @BinNumber)
--	and Status = 'C'
--	and ContactId = @SiteContactID    
--	and BarnNbr = @BarnNumber
--	and BinNbr = @BinNumber
--	and DateDel < @LastBinReadingDate
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_FEED_ORDER_QUANTITY_DELIVERED_SELECT] TO [db_sp_exec]
    AS [dbo];

