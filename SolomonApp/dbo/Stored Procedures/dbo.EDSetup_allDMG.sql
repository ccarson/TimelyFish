 /****** Object:  Stored Procedure dbo.EDSetup_all    Script Date: 5/28/99 1:17:44 PM ******/
CREATE PROCEDURE EDSetup_allDMG
AS
 SELECT *
 FROM EDSetup
 ORDER BY SetUpID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDSetup_allDMG] TO [MSDSL]
    AS [dbo];

