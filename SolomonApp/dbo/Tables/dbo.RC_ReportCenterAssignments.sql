CREATE TABLE [dbo].[RC_ReportCenterAssignments] (
    [ReportCenter] CHAR (21) NOT NULL,
    [REPORT_ID]    INT       NOT NULL,
    CONSTRAINT [PKRC_ReportCenterAssignments] PRIMARY KEY NONCLUSTERED ([REPORT_ID] ASC, [ReportCenter] ASC) WITH (FILLFACTOR = 90)
);

