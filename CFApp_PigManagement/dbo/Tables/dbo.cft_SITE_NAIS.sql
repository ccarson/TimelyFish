CREATE TABLE [dbo].[cft_SITE_NAIS] (
    [NaisID]                INT              IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [SiteID]                INT              NOT NULL,
    [NaisDisplayID]         VARCHAR (7)      NOT NULL,
    [OriginalIssueDateTime] DATETIME         NOT NULL,
    [Active]                BIT              CONSTRAINT [DF_cft_SITE_NAIS_Active] DEFAULT (0) NULL,
    [CreatedDateTime]       DATETIME         CONSTRAINT [DF_cft_SITE_NAIS_CreatedDateTime] DEFAULT (getdate()) NOT NULL,
    [CreatedBy]             VARCHAR (50)     NOT NULL,
    [UpdatedDateTime]       DATETIME         NULL,
    [UpdatedBy]             VARCHAR (50)     NULL,
    [msrepl_tran_version]   UNIQUEIDENTIFIER DEFAULT (newid()) NOT NULL,
    CONSTRAINT [PK_cft_SITE_NAIS] PRIMARY KEY CLUSTERED ([NaisID] ASC) WITH (FILLFACTOR = 90)
);


GO
GRANT SELECT
    ON OBJECT::[dbo].[cft_SITE_NAIS] TO [E8F575915A2E4897A517779C0DD7CE]
    AS [dbo];

