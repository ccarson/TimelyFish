 /****** Object:  Stored Procedure dbo.ARAdjust_AdJd_Cust_Ref_Type2    Script Date: 4/7/98 12:30:32 PM ******/
Create proc ARAdjust_AdJd_Cust_Ref_Type2 @parm1 varchar ( 15), @parm2 varchar ( 10), @parm3 varchar ( 2) As
SELECT *
  FROM ARAdjust
 WHERE custid = @parm1 AND
       AdjdRefNbr = @parm2 AND
       AdjdDoctype = @parm3 AND
       NOT (AdjgDoctype = 'SB' AND AdjdDoctype = 'SC')


