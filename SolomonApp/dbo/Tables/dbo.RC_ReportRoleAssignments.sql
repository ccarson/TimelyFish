CREATE TABLE [dbo].[RC_ReportRoleAssignments] (
    [Role]      UNIQUEIDENTIFIER NOT NULL,
    [REPORT_ID] INT              NOT NULL,
    CONSTRAINT [PKRC_ReportRoleAssignments] PRIMARY KEY NONCLUSTERED ([REPORT_ID] ASC, [Role] ASC) WITH (FILLFACTOR = 90)
);

