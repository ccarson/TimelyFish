CREATE TABLE [dbo].[cftMillReports] (
    [BioReportDate]    SMALLDATETIME NULL,
    [BioReportTime]    CHAR (10)     NULL,
    [BioReportUserID]  CHAR (10)     NULL,
    [HoldReportDate]   SMALLDATETIME NULL,
    [HoldReportTime]   CHAR (10)     NULL,
    [HoldReportUserID] CHAR (10)     NULL,
    [MillID]           CHAR (6)      NOT NULL,
    [MillName]         CHAR (30)     NULL,
    [RegReportDate]    SMALLDATETIME NULL,
    [RegReportTime]    CHAR (10)     NULL,
    [RegReportUserID]  CHAR (10)     NULL,
    [TollReportDate]   SMALLDATETIME NULL,
    [TollReportTime]   CHAR (10)     NULL,
    [TollReportUserID] CHAR (10)     NULL,
    [tstamp]           ROWVERSION    NULL,
    CONSTRAINT [cftMillReports0] PRIMARY KEY CLUSTERED ([MillID] ASC) WITH (FILLFACTOR = 90)
);

