 CREATE PROCEDURE PI_Validate_SpecCostID_QtyBalance
	@PIID VARCHAR(10)
AS

-- Find inventory tags for Specific Cost ID items where the variance between the physical quantity
-- and the book quantity does not match the cumulative adjustment quantity for the the cost layers
-- of that item.
--
SELECT	PD.Number, PD.InvtID
FROM	vp_DecPl PL, PIDetail PD LEFT JOIN PIDetCost PC ON
	PC.PIID = PD.PIID AND
	PD.Number = PC.Number
	JOIN Inventory I ON
	PD.InvtID = I.InvtID
WHERE	PD.PIID = @PIID AND
	I.ValMthd = 'S'
GROUP BY PD.Number, PD.InvtID, PD.PhysQty, PD.BookQty, PL.DecPlQty
HAVING	ROUND(PD.PhysQty - PD.BookQty, PL.DecPlQty) <> ISNULL(ROUND(SUM(PC.AdjQty), PL.DecPlQty), 0)



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PI_Validate_SpecCostID_QtyBalance] TO [MSDSL]
    AS [dbo];

