CREATE TABLE [dbo].[cft_SITE_HEALTH] (
    [SiteHealthID]        INT              IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [SiteContactID]       INT              NOT NULL,
    [SiteContactDate]     DATETIME         NOT NULL,
    [HealthConcern]       BIT              CONSTRAINT [DF_cft_SITE_HEALTH_HealthConcern] DEFAULT (0) NULL,
    [CreatedDateTime]     DATETIME         CONSTRAINT [DF_cft_SITE_HEALTH_CreatedDateTime] DEFAULT (getdate()) NOT NULL,
    [CreatedBy]           VARCHAR (50)     NOT NULL,
    [UpdatedDateTime]     DATETIME         NULL,
    [UpdatedBy]           VARCHAR (50)     NULL,
    [msrepl_tran_version] UNIQUEIDENTIFIER DEFAULT (newid()) NOT NULL,
    CONSTRAINT [PK_cft_SITE_HEALTH] PRIMARY KEY CLUSTERED ([SiteHealthID] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [IX_cft_SITE_HEALTH] UNIQUE NONCLUSTERED ([SiteContactID] ASC, [SiteContactDate] ASC) WITH (FILLFACTOR = 90)
);

