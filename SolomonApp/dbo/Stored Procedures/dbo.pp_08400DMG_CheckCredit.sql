
--USETHISSYNTAX

CREATE PROCEDURE pp_08400DMG_CheckCredit @UserAddress VARCHAR(21) AS

/********************************************************************************
*             Copyright Solomon Software, Inc. 1994-1999 All Rights Reserved
*
*    Proc Name: pp_08400DMG_CheckCredit
*
*++* Narrative: Cycles through each customer for the batch and passes them to DMG_CheckCredit_InfoNotChanged.
*++*            
*
*   Called by: pp_08400
* 
*/
	

/***** Cycle all Customers through DMG Proc *****/ 		
DECLARE @aBatNbr CHAR(10), @aCpnyID CHAR(10), @aCustID CHAR(15)

DECLARE CustTranCursor Insensitive  CURSOR FOR
	SELECT DISTINCT b.BatNbr,d.CpnyID, d.CustID
	  FROM Batch b, ARDoc d, WrkRelease w (nolock)
	 WHERE  w.UserAddress = @UserAddress
		AND w.Module = "AR"
		AND b.BatNbr = w.BatNbr 
		AND b.BatNbr = d.BatNbr  
		AND b.Module = "AR"        

OPEN CustTranCursor
FETCH NEXT FROM CustTranCursor INTO @aBatNbr, @aCpnyID, @aCustID 

WHILE (@@FETCH_STATUS <> -1) 
	BEGIN
		IF @@FETCH_STATUS <> -2
			BEGIN
              			
				EXEC DMG_CheckCredit_InfoNotChanged @aCpnyID, @aCustID
				
			END

	FETCH NEXT FROM CustTranCursor INTO @aBatNbr, @aCpnyID, @aCustID 

	END
	 
CLOSE CustTranCursor

DEALLOCATE CustTranCursor


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pp_08400DMG_CheckCredit] TO [MSDSL]
    AS [dbo];

