CREATE TABLE [dbo].[RC_ReportUsage] (
    [USERID]         UNIQUEIDENTIFIER NOT NULL,
    [ReportCenter]   CHAR (21)        NOT NULL,
    [ReferenceCount] INT              NOT NULL,
    [REPORT_ID]      INT              NOT NULL,
    CONSTRAINT [PKRC_ReportUsage] PRIMARY KEY NONCLUSTERED ([USERID] ASC, [ReportCenter] ASC, [REPORT_ID] ASC) WITH (FILLFACTOR = 90)
);

