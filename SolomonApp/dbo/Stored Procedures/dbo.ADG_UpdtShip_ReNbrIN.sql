 create proc ADG_UpdtShip_ReNbrIN
	@BatNbr			varchar(10)
as

DECLARE	@LineCntr INT
DECLARE	@LineStep INT

SELECT	@LineCntr = COUNT(*) FROM INTran WHERE BatNbr = @BatNbr
IF COALESCE(@LineCntr,0) > 0
	SELECT	@LineStep = CEILING(LOG(@LineCntr)/LOG(2))
ELSE
	SELECT	@LineStep = 8
SELECT	@LineStep = CASE WHEN @LineStep < 8 THEN 256 WHEN @LineStep > 16 THEN 1 ELSE POWER(2, 16 - @LineStep) END

UPDATE	INTran SET LineNbr = -32768 + (CASE WHEN LineID < 1 THEN 1 WHEN LineID > @LineCntr THEN @LineCntr ELSE LineID END - 1) * @LineStep WHERE BatNbr = @BatNbr


