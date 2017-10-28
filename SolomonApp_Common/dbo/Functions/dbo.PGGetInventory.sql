CREATE FUNCTION [dbo].[PGGetInventory] (@PigGroupID AS VARCHAR(5))
RETURNS INT
AS


    BEGIN
    declare @PGInv INT
    select @PGInv = sum(t.Qty * t.InvEffect)
		from cftPGInvTran t (NOLOCK)
		Where t.Reversal<>'1' AND t.PigGroupID=@PigGroupID
		GROUP BY t.PigGroupID
    RETURN @PGInv
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[PGGetInventory] TO PUBLIC
    AS [dbo];


GO
GRANT CONTROL
    ON OBJECT::[dbo].[PGGetInventory] TO [MSDSL]
    AS [dbo];

