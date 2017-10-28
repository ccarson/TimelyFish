CREATE PROCEDURE CF041p_APAdjust_AdjgRefNbr 
	@VendID varchar (15),
	@AdjgRefNbr varchar(10),
	@AdjgDocType varchar(2)
	AS 
    	SELECT a.*, d.* 
	FROM APAdjust a
	JOIN APDoc d ON a.AdjdRefNbr = d.RefNbr and a.AdjdDocType = d.DocType AND a.VendID = d.VendID
	WHERE a.VendID = @VendID
	AND AdjgRefNbr = @AdjgRefNbr
	AND AdjgDocType = @AdjgDocType
	Order by a.VendID, AdjBatNbr, AdjdRefNbr

GO
GRANT CONTROL
    ON OBJECT::[dbo].[CF041p_APAdjust_AdjgRefNbr] TO [MSDSL]
    AS [dbo];

