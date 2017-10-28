 CREATE PROC ARDoc_Batch_Duplicates @BatNbr as varchar(10) AS
SELECT Convert(SmallInt,CASE WHEN EXISTS(SELECT BatNbr, DocType, RefNbr, CustId
	FROM ARDoc
	WHERE BatNbr = @BatNbr AND CustId <> ''
	GROUP BY BatNbr, DocType, RefNbr, CustId
	HAVING Count(*) > 1) THEN 1 ELSE 0 END)



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ARDoc_Batch_Duplicates] TO [MSDSL]
    AS [dbo];

