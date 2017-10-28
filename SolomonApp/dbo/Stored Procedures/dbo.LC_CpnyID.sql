 CREATE PROC LC_CpnyID
@Parm1 varchar(10),
@Parm2 varchar(10)
AS
SELECT CpnyID
  FROM LCVoucher
 WHERE APBatNbr = @Parm1 AND
       APRefNbr = @Parm2


