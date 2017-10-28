CREATE PROCEDURE XDDTaxPmt_Code @parm1 varchar(5) AS
  Select * from XDDTaxPmt where
  Selected = 'Y' and
  Code LIKE @parm1
  Order by Code, SubCategory
