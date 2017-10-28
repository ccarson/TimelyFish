CREATE PROCEDURE XDDTaxPmt_ShortDescr
  @parm1   varchar(15)

AS
  Select   *
  FROM     XDDTaxPmt
  WHERE    ShortDescr LIKE @parm1
  Order by ShortDescr
