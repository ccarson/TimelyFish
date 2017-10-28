
-- ===================================================================
-- Author:  Andrew Derco
-- Create date: 06/19/2008
-- Description: Determines if a corn producer can be marked as inactive
-- ===================================================================
CREATE FUNCTION [dbo].[cffn_CAN_CORN_PRODUCER_BE_INACTIVE_20130820] (
  @CornProducerID varchar(15)
) RETURNS bit
AS
BEGIN 

  DECLARE @Result bit

  SELECT @Result = CASE WHEN EXISTS(

                                    SELECT 1
                                    FROM dbo.cft_CORN_PRODUCER CP (nolock)
                                    -- open quote with tickets assigned
                                    LEFT OUTER JOIN dbo.cft_QUOTE Q (nolock) ON Q.CornProducerID = CP.CornProducerID
                                    LEFT OUTER JOIN (  
                                                       SELECT QuoteID, COUNT(1) AS Loads 
                                                       FROM dbo.cft_PARTIAL_TICKET (nolock)
                                                       GROUP BY QuoteID
                                                    ) L ON L.QuoteID = Q.QuoteID 
                                    --tickets not paid. 
                                    LEFT OUTER JOIN dbo.cft_PARTIAL_TICKET PT (nolock) ON PT.CornProducerID = CP.CornProducerID
                                    --open contracts
                                    LEFT OUTER JOIN dbo.cft_CONTRACT C (nolock) ON C.CornProducerID = CP.CornProducerID
                                    WHERE CP.CornProducerID = @CornProducerID
                                          AND (
                                                (Q.QuoteID IS NOT NULL AND ISNULL(L.Loads, 0) > 0 AND Q.NumberOfLoads > ISNULL(L.Loads, 0))
                                                OR (PT.PartialTicketID IS NOT NULL AND ISNULL(PT.SentToAccountsPayable, 0) = 0)
                                                OR (C.ContractID IS NOT NULL AND C.ContractStatusID = 1)
                                              )
                                     
                                   )
                                  --Full tickets without partial tickets are unpaid tickets, too
                         OR EXISTS (
                                                      
                                      SELECT 1
                                      FROM dbo.cft_CORN_TICKET FT (nolock)
                                      LEFT OUTER JOIN dbo.cft_FULL_TICKET_ASSIGNMENT FTA (nolock) ON FTA.CornProducerID = @CornProducerID AND FTA.TicketID = FT.TicketID
                                      LEFT OUTER JOIN dbo.cft_PARTIAL_TICKET PT (nolock) ON PT.FullTicketID = FT.TicketID
                                      WHERE (FTA.FullTicketAssignmentID IS NOT NULL OR FT.CornProducerID = @CornProducerID) AND PT.PartialTicketID IS NULL
                                   )
                  THEN 0 ELSE 1 END
  RETURN @Result

END


