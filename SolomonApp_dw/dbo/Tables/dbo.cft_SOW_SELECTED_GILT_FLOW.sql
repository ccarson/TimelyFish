CREATE TABLE [dbo].[cft_SOW_SELECTED_GILT_FLOW] (
    [Record]       INT       IDENTITY (1, 1) NOT NULL,
    [SiteID]       CHAR (24) NULL,
    [ContactName]  CHAR (24) NULL,
    [Source]       CHAR (24) NULL,
    [Phase]        CHAR (24) NULL,
    [FlowName]     CHAR (24) NULL,
    [MovementType] CHAR (24) NULL,
    [FiscalYear]   SMALLINT  NOT NULL,
    [FiscalPeriod] SMALLINT  NOT NULL,
    CONSTRAINT [PK_cft_SOW_SELECTED_GILT] PRIMARY KEY CLUSTERED ([Record] ASC) WITH (FILLFACTOR = 90)
);

