CREATE PROCEDURE pXU120_APImportStaging_Grid (@RecIDMin INT, @RecIDMax INT)
	AS
	--------------------------------------------------------------------------------------------------------
	-- PURPOSE:		This procedure is used to provide the data in the grid of the AP voucher
	--				import application.
	-- CREATED BY:	Boyer & Associates, Inc. (TJones)
	-- CREATED ON:	1/31/2013
	--------------------------------------------------------------------------------------------------------
	SELECT * 
	FROM cftAPImportStaging
	WHERE RecordID BETWEEN @RecIDMin AND @RecIDMax
	ORDER BY RecordID
