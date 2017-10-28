CREATE PROCEDURE XDDTaxPmt_ShortDescr_Sel
  @parm1   varchar(15)

AS
  Select   *
  FROM     XDDTaxPmt
  WHERE    ShortDescr LIKE @parm1
           and Selected = 'Y'
  Order by ShortDescr
