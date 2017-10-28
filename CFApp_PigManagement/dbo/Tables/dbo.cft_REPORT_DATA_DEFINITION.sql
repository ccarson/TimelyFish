CREATE TABLE [dbo].[cft_REPORT_DATA_DEFINITION] (
    [ReportID]            INT              NOT NULL,
    [DataDefinitionID]    INT              NOT NULL,
    [msrepl_tran_version] UNIQUEIDENTIFIER DEFAULT (newid()) NOT NULL,
    [Rel_Attribute]       VARCHAR (500)    NULL,
    CONSTRAINT [PK_cft_REPORT_DATA_DEFINITION] PRIMARY KEY CLUSTERED ([ReportID] ASC, [DataDefinitionID] ASC) WITH (FILLFACTOR = 90)
);
