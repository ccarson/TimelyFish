 CREATE PROCEDURE AP_PPBatch
	@BatNbr varchar(10)
AS

SELECT * FROM Batch
WHERE BatNbr LIKE @BatNbr
AND editscrnnbr = '03070'
AND status <> 'V'
ORDER BY BatNbr


