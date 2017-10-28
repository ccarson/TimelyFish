 

CREATE VIEW vp_08400_AllAdjD AS
/********************************************************************************
*             Copyright Solomon Software, Inc. 1994-1999 All Rights Reserved
*
*    View Name: vp_08400_AllAdjD
*
*
* Narrative: Figures out the current adjustments to adjusted docs in this batch
*     
*
*
*   Called by: pp_08400
* 
*/


SELECT PerClosed = MAX(CASE WHEN PerAppl > AdjgPerPost THEN PerAppl ELSE AdjgPerPost END),
       PerOpen =   MIN(PerAppl),
       AdjgDocDate= MAX(case AdjgDocType When 'CM' then '' Else AdjgDocDate END),
       CustID,
       AdjdDocType,
       AdjdRefNbr
  FROM ARAdjust 
 GROUP BY 
       CustID,
       AdjdDocType,
       AdjdRefNbr


 
