 CREATE PROC LCDistV_Delete
@Parm1 varchar(10),
@Parm2 varchar(10),
@Parm3 varchar(5)
AS
DELETE FROM LCVoucher
      WHERE APBatNbr = @Parm1 AND
            APRefNbr LIKE @Parm2 AND
            APLineRef LIKE @Parm3


