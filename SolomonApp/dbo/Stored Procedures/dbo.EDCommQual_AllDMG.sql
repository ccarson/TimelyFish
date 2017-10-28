 /****** Object:  Stored Procedure dbo.EDCommQual_All    Script Date: 5/28/99 1:17:40 PM ******/
CREATE PROCEDURE EDCommQual_AllDMG
 @Parm1 varchar( 2 )
AS
 Select *
 From EDCommQual
 Where CommID LIKE @parm1
 Order By CommID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDCommQual_AllDMG] TO [MSDSL]
    AS [dbo];

