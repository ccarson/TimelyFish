 CREATE PROC APTranLCCodeExists
@Parm1 varchar(10),
@Parm2 varchar(10)
AS
SELECT MAX(CpnyID)
  FROM APTran
 WHERE BatNbr = @Parm1 AND
       RefNbr like @Parm2



