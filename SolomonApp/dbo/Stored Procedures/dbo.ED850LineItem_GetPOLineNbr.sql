 CREATE PROC ED850LineItem_GetPOLineNbr @CpnyID varchar(10), @OrdNbr varchar(15), @OrdLineRef varchar(5)
As
DECLARE @EDIPOID varchar(10)
DECLARE @LineID int

	SELECT @EDIPOID = EDIPOID
	FROM SOHeader (NOLOCK)
	WHERE 	CpnyID = @CpnyID AND OrdNbr = @OrdNbr

	SELECT @LineID = CAST(S4Future06 as int)
	FROM SOLine (NOLOCK)
	WHERE 	CpnyID = @CpnyID AND OrdNbr = @OrdNbr AND LineRef = @OrdLineRef

	SELECT MIN(POLineNbr)
	FROM ED850LineItem (NOLOCK)
	Where CpnyId = @CpnyId And EDIPOID = @EDIPOID And LineID = @LineID


