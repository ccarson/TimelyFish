CREATE TABLE [dbo].[cft_SITE_PIG_SYSTEM] (
    [SitePigSystemID]          INT              IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [SitePigSystemDescription] VARCHAR (50)     NULL,
    [CreatedDateTime]          DATETIME         CONSTRAINT [DF_cft_SITE_PIG_SYSTEM_CreatedDateTime] DEFAULT (getdate()) NOT NULL,
    [CreatedBy]                VARCHAR (50)     NOT NULL,
    [UpdatedDateTime]          DATETIME         NULL,
    [UpdatedBy]                VARCHAR (50)     NULL,
    [msrepl_tran_version]      UNIQUEIDENTIFIER DEFAULT (newid()) NOT NULL,
    CONSTRAINT [PK_cft_SITE_PIG_SYSTEM] PRIMARY KEY CLUSTERED ([SitePigSystemID] ASC) WITH (FILLFACTOR = 90)
);

