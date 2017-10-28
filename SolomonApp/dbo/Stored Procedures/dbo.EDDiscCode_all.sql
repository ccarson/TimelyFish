 CREATE PROCEDURE EDDiscCode_all
 @parm1 varchar( 15 ), @Parm2 varchar(15), @Parm3 smallint, @Parm4 varchar(1)
AS
 SELECT *
 FROM EDDiscCode
 WHERE SpecChgCode LIKE @parm1 And CustId Like @Parm2 And DiscountType Like @Parm3 And Direction Like @Parm4
 ORDER BY SpecChgCode, CustId, DiscountType, Direction



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDDiscCode_all] TO [MSDSL]
    AS [dbo];

