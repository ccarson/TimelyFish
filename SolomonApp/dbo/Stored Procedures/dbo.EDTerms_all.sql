 CREATE PROCEDURE EDTerms_all
 @parm1 varchar( 2 ),
 @parm2 varchar( 15 )
AS
 SELECT *
 FROM EDTerms
 WHERE TermsId LIKE @parm1
    AND CustId LIKE @parm2
 ORDER BY TermsId,
    CustId


