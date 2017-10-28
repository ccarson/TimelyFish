 /****** Object:  Stored Procedure dbo.SNote_Fetch_Text    Script Date: 4/17/98 12:50:25 PM ******/
CREATE PROC SNote_Fetch_Text @parm1 int as
    Select nID, sNoteText from SNote
        where nID = @parm1
        order by nID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SNote_Fetch_Text] TO [MSDSL]
    AS [dbo];

