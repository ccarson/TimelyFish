 CREATE PROCEDURE TrnsfrDoc_Intransit
	@CpnyID varchar(10),
	@TrnsfrDocNbr varchar(10)
AS
	SELECT *
	FROM TrnsfrDoc
	WHERE CpnyID = @CpnyID AND
	      Status = 'I' AND
            TransferType = '2' AND
	      TrnsfrDocNbr LIKE @TrnsfrDocNbr
	ORDER BY TrnsfrDocNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[TrnsfrDoc_Intransit] TO [MSDSL]
    AS [dbo];

