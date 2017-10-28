CREATE TABLE [dbo].[FarmSetup] (
    [FarmID]                    VARCHAR (8)   NOT NULL,
    [SourceExtractFile]         VARCHAR (90)  NULL,
    [PCDirectory]               VARCHAR (60)  NULL,
    [Status]                    VARCHAR (1)   NULL,
    [ProcessStatus]             VARCHAR (1)   NULL,
    [PadSowIDLength]            SMALLINT      NULL,
    [PadAlternateIDLength]      SMALLINT      NULL,
    [PadSemenIDLength]          SMALLINT      NULL,
    [LastExtractDate]           SMALLDATETIME NULL,
    [LastExtractElapsedMinutes] FLOAT (53)    NULL,
    [LastImportDate]            SMALLDATETIME NULL,
    [LastImportElapsedMinutes]  FLOAT (53)    NULL,
    [LastImportRecordCount]     INT           NULL,
    [LastFormSerialID]          INT           NULL,
    [AlternateIDSuffix]         VARCHAR (1)   NULL,
    [ContactID]                 INT           NULL,
    [LastUploadDate]            SMALLDATETIME NULL,
    [PCFarmCode]                VARCHAR (2)   NULL,
    [AssignedRepUserName]       VARCHAR (30)  NULL,
    [EffectiveWeekOfDate]       SMALLDATETIME NULL,
    [OnSiteISOFlag]             SMALLINT      CONSTRAINT [DF_FarmSetup_OnSiteISOFlag] DEFAULT (0) NULL,
    CONSTRAINT [PK_SowSiteSetup] PRIMARY KEY CLUSTERED ([FarmID] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [IX_FarmSetup_Status]
    ON [dbo].[FarmSetup]([Status] ASC) WITH (FILLFACTOR = 80);


GO
CREATE NONCLUSTERED INDEX [IX_FarmSetup_ContactID]
    ON [dbo].[FarmSetup]([ContactID] ASC) WITH (FILLFACTOR = 80);

