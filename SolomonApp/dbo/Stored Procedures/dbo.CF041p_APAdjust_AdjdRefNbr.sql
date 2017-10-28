CREATE PROCEDURE CF041p_APAdjust_AdjdRefNbr 
	@VendID varchar (15),
	@AdjdRefNbr varchar(10),
	@AdjdDocType varchar(2)
	AS 
    	SELECT * 
	FROM APAdjust
	WHERE VendID = @VendID
	AND AdjdRefNbr = @AdjdRefNbr
	AND AdjdDocType = @AdjdDocType
	Order by VendID, AdjBatNbr, AdjgRefNbr

GO
GRANT CONTROL
    ON OBJECT::[dbo].[CF041p_APAdjust_AdjdRefNbr] TO [MSDSL]
    AS [dbo];

