 /********************************************************************************
*             Copyright Solomon Software, Inc. 1994-1999 All Rights Reserved
** Proc Name: FMG_AR_Select_CuryBatchTot
** Narrative: SELECT CURYCRTOT FROM BATCH TABLE
** Inputs   : Batch Number
** Outputs  :
** Called by: 0801000 Application Update1_NewLevel()
*
*/

CREATE PROCEDURE FMG_AR_Select_CuryBatchTot @Parm1 VARCHAR(10) AS
SELECT CuryCrTot
  FROM batch
 WHERE Module='AR' AND batnbr= @Parm1


