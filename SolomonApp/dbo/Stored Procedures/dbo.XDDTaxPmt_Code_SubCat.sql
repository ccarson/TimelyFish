CREATE PROCEDURE XDDTaxPmt_Code_SubCat
  @parm1 varchar(5),
  @parm2 varchar(5),
  @parm3 varchar(15)

AS

  Select    *
  FROM      XDDTaxPmt
  WHERE     Code LIKE @parm1 and
            SubCategory LIKE @parm2 and
            IDNbr LIKE @parm3
  Order by  Code, SubCategory, IDNbr
