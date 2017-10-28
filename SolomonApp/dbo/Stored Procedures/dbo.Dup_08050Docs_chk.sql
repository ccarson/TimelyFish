 CREATE PROC Dup_08050Docs_chk @Batnbr VARCHAR (10), @Custid VARCHAR (15),
                              @Doctype VARCHAR (2), @Refnbr VARCHAR (10) AS

SELECT *
  FROM ARDoc
 WHERE batnbr <> @Batnbr AND
       Custid = @Custid AND
       Doctype = @Doctype AND
       refnbr = @Refnbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Dup_08050Docs_chk] TO [MSDSL]
    AS [dbo];

