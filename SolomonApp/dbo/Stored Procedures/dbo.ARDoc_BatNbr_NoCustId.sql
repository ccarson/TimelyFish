 create proc ARDoc_BatNbr_NoCustId @BatNbr as varchar(10) AS
SELECT *
FROM ARDoc
WHERE BatNbr = @BatNbr AND DocType <> 'RC' AND CustId = ''



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ARDoc_BatNbr_NoCustId] TO [MSDSL]
    AS [dbo];

