 /****** Object:  Stored Procedure dbo.POUserSubAcct_DBNAV    Script Date: 12/17/97 10:48:55 AM ******/
CREATE PROCEDURE POUserSubAcct_DBNAV @parm1 Varchar(47), @Parm2 Varchar(24) AS
SELECT * FROM POUserSubacct where
UserID = @parm1 and
Sub Like @Parm2
ORDER BY UserID, Sub



GO
GRANT CONTROL
    ON OBJECT::[dbo].[POUserSubAcct_DBNAV] TO [MSDSL]
    AS [dbo];

