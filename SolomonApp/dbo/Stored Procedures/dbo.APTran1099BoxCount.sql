
CREATE PROC APTran1099BoxCount @refnbr VARCHAR(10)
AS
  SELECT Count(*)
  FROM   APTran
  WHERE  RefNbr = @refnbr
         AND BoxNbr <> ''

