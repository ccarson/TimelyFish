
CREATE PROCEDURE smConReversal_all  
        @parm1 varchar( 10 ),  
        @parm2min smallint, @parm2max smallint  
AS  
        SELECT *  
        FROM smConReversal  
        WHERE BatNbr LIKE @parm1  
           AND LineNbr BETWEEN @parm2min AND @parm2max  
        ORDER BY BatNbr,  
           LineNbr  

GO
GRANT CONTROL
    ON OBJECT::[dbo].[smConReversal_all] TO [MSDSL]
    AS [dbo];

