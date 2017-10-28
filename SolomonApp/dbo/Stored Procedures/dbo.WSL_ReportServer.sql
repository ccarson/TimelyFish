
CREATE PROCEDURE WSL_ReportServer
AS
SELECT ReportServerURL, BaseFolder FROM vs_rs_reportserver

GO
GRANT CONTROL
    ON OBJECT::[dbo].[WSL_ReportServer] TO [MSDSL]
    AS [dbo];

