CREATE PROCEDURE pXU120_ChangeDocType (@BatNbr varchar(10))
	AS
	--------------------------------------------------------------------------------------------------------
	-- PURPOSE:		This procedure is used to change negative documents in the batch to Debit Adjustments (AD)
	-- CREATED BY:	Boyer & Associates, Inc. (TJones)
	-- CREATED ON:	3/13/2013
	--------------------------------------------------------------------------------------------------------
	--DECLARE @BatNbr varchar(10) = '000129'
	SET NOCOUNT ON;
	DECLARE @DocList TABLE (VendID varchar(15), RefNbr varchar(10), DocType varchar(2), CuryDocBal float, RowID smallint)
	DECLARE @CuryDecPl smallint
	SET @CuryDecPl = ISNULL((SELECT TOP 1 DecPl FROM Currncy WHERE CuryId = (SELECT TOP 1 BaseCuryId FROM GLSetup)), 2)  -- Default 2 if not found for US Dollars
	INSERT INTO @DocList (VendID, RefNbr, DocType, CuryDocBal, RowID )
	SELECT VendID, RefNbr, DocType, CuryDocBal, ROW_NUMBER() OVER(ORDER BY BatNbr) FROM APDoc (NOLOCK) WHERE BatNbr = @BatNbr AND CuryDocBal < 0
	DECLARE @LineCount smallint
	DECLARE @CurLine smallint
	SET @LineCount = ISNULL((SELECT COUNT(*) FROM @DocList), 0)
	IF @LineCount > 0 
		BEGIN
			UPDATE d
				SET d.DocType = 'AD', d.CuryDiscBal = ROUND(d.CuryDiscBal * -1, @CuryDecPl), d.CuryDocBal = ROUND(d.CuryDocBal * -1, @CuryDecPl), 
					d.CuryOrigDocAmt = ROUND(d.CuryOrigDocAmt * -1, @CuryDecPl), d.DiscBal = ROUND(d.DiscBal * -1, @CuryDecPl),
					d.DocBal = ROUND(d.DocBal * -1, @CuryDecPl), d.OrigDocAmt = ROUND(d.OrigDocAmt * -1, @CuryDecPl)
			FROM APDoc d
			INNER JOIN @DocList lst ON d.VendId = lst.VendID AND d.RefNbr = lst.RefNbr AND d.DocType = lst.DocType
			WHERE d.BatNbr = @BatNbr
			
			UPDATE t
				SET t.trantype = 'AD', t.DrCr = 'C', t.CuryTranAmt = ROUND(t.CuryTranAmt * -1, @CuryDecPl), t.TranAmt = ROUND(t.TranAmt * -1, @CuryDecPl)
			FROM APTran t
			INNER JOIN @DocList lst ON t.VendId = lst.VendID AND t.RefNbr = lst.RefNbr AND t.TranType = lst.DocType
			WHERE t.BatNbr = @BatNbr
			
			--Now reset the batch total 
			UPDATE b
				SET b.CuryDrTot = d.CuryDocTot, b.CuryCtrlTot = d.CuryDocTot,
				b.DrTot = d.DocTot, b.CtrlTot = d.DocTot
				FROM Batch b
				INNER JOIN (SELECT BatNbr, ROUND(SUM(CuryOrigDocAmt), @CuryDecPl) As CuryDocTot, ROUND(SUM(OrigDocAmt), @CuryDecPl) As DocTot FROM APDoc (NOLOCK) WHERE BatNbr = @BatNbr GROUP BY BatNbr) d ON b.BatNbr = d.BatNbr	
				WHERE b.Module = 'AP'
				AND b.BatNbr = @BatNbr
				
				--CuryDrTot = Math.Round(.CuryDrTot + baptran.CuryTranAmt, bCuryInfo.BaseDecPl)
    --                .CuryCtrlTot = .CuryDrTot
    --                .DrTot = Math.Round(.CuryDrTot * .CuryRate_Renamed, bCuryInfo.TranDecPl)
    --                .CtrlTot = .DrTot
		END		
	SET NOCOUNT OFF;

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXU120_ChangeDocType] TO [MSDSL]
    AS [dbo];

