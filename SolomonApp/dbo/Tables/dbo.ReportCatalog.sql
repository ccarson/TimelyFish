CREATE TABLE [dbo].[ReportCatalog] (
    [PRODNAME]                 CHAR (31)  NOT NULL,
    [Business_Desk_Report_Nam] CHAR (51)  NOT NULL,
    [Report_Option]            CHAR (51)  NOT NULL,
    [Business_Desk_Report_Typ] CHAR (5)   NOT NULL,
    [Report_URL]               CHAR (255) NOT NULL,
    [Last_Date_Published]      DATETIME   NOT NULL,
    [Last_Time_Published]      DATETIME   NOT NULL,
    [Report_Series]            SMALLINT   NOT NULL,
    [Reviewed]                 TINYINT    NOT NULL,
    [DEX_ROW_ID]               INT        IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    CONSTRAINT [PKReportCatalog] PRIMARY KEY CLUSTERED ([PRODNAME] ASC, [Business_Desk_Report_Nam] ASC, [Report_Option] ASC, [Last_Date_Published] ASC, [Last_Time_Published] ASC) WITH (FILLFACTOR = 90)
);

