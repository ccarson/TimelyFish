 /****** Object:  Stored Procedure dbo.ARAdjust_CustId_AdjgType_Ref2    Script Date: 11/5/00 12:30:32 PM ******/
CREATE PROC ARAdjust_CustId_AdjgType_Ref2 @parm1 varchar ( 15), @parm2 varchar ( 2), @parm3 varchar ( 10) as
SELECT *
  FROM ARAdjust
 WHERE CustId = @parm1
   AND AdjgDocType = @parm2
   AND AdjgRefNbr = @parm3
   AND AdjgDoctype IN ('PA','PP','CM','SB')
   AND AdjdDoctype NOT IN ('SC','NS','RP')


