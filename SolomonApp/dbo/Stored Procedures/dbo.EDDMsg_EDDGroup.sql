 CREATE PROCEDURE EDDMsg_EDDGroup
		@DocType varchar(2),	-- Doctype
		@DBName  varchar(30),	-- Database Name
		@parm1	 INTEGER	    -- EDDGROUP

WITH EXECUTE AS '07718158D19D4f5f9D23B55DBF5DF1'
AS

	DECLARE @szSelect	varchar(500)
	DECLARE @szFrom		varchar(500)
	DECLARE @szWhere	varchar(500)

	SELECT @szSelect = "SELECT * FROM "

	SELECT @szFrom = CASE WHEN @Doctype = 'U1'  
                           THEN @DBName + "..PurchOrd"
                          WHEN @Doctype = 'D1' 
                           THEN @DBName + "..PRCheckTran"
                          WHEN @Doctype = 'A1' 
                           THEN @DBName + "..ARDoc"
                          WHEN @Doctype = 'O1' 
                           THEN @DBName + "..SOShipHeader"
                          WHEN @Doctype = 'O2' 
                           THEN @DBName + "..SOHeader"
                          WHEN @Doctype = 'O3' 
                           THEN @DBName + "..SOHeader"
                          WHEN @Doctype = 'O4' 
                           THEN @DBName + "..SOShipHeader"
                          WHEN @Doctype = 'C1' 
                           THEN @DBName + "..pjinvhdr"
                          WHEN @Doctype = 'P1' 
                           THEN @DBName + "..PJInvHdr"
                          WHEN @Doctype = 'S1' 
                           THEN @DBName + "..SMServCall"
                          WHEN @Doctype = 'T1' 
                           THEN @DBName + "..SMInvoice"
                          END
	SELECT @szWhere = CASE WHEN @Doctype IN ('O3','O4') 
                            THEN " WHERE ASID01 = "
                           WHEN @Doctype = 'C1' 
                            THEN " WHERE Lupd_Prog = 'BICNP' AND ASID = "  
                           WHEN @Doctype = 'T1' 
                            THEN " WHERE DocType = 'C' AND ASID = "  
                            ELSE " WHERE ASID = "  --U1, D1, A1, O1, O2, P1, S1
                           END

--PRINT (@szSelect + @szFrom + @szWhere) PRINT @parm1
EXEC (@szSelect + @szFrom + @szWhere + @parm1 )

