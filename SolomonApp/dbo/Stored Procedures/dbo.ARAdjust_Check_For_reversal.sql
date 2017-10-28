 CREATE PROCEDURE ARAdjust_Check_For_reversal  @parm1 varchar ( 10), @parm2 varchar ( 10), @parm3 varchar ( 10) ,@parm4 varchar (15)  as
SELECT *
  FROM ARAdjust
 WHERE CustId = @parm4
   AND Adjdrefnbr = @parm2
   AND AdjgRefNbr = @parm3
   AND AdjBatnbr = @parm1
   AND AdjgDocType IN ('RP','NS')



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ARAdjust_Check_For_reversal] TO [MSDSL]
    AS [dbo];

