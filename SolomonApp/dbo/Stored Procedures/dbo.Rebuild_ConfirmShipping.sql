 CREATE PROCEDURE Rebuild_ConfirmShipping AS
   UPDATE Location Set ShipConfirmQty = 0 
    WHERE ShipConfirmQty <> 0
    
   UPDATE LotSerMst Set ShipConfirmQty = 0 
    WHERE ShipConfirmQty <> 0


GO
GRANT CONTROL
    ON OBJECT::[dbo].[Rebuild_ConfirmShipping] TO [MSDSL]
    AS [dbo];

