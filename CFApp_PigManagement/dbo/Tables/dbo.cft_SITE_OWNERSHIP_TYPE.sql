CREATE TABLE [dbo].[cft_SITE_OWNERSHIP_TYPE] (
    [SiteOwnershipTypeID]          INT              IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [SiteOwnershipTypeDescription] VARCHAR (50)     NULL,
    [CreatedDateTime]              DATETIME         CONSTRAINT [DF_cft_SITE_OWNERSHIP_TYPE_CreatedDateTime] DEFAULT (getdate()) NOT NULL,
    [CreatedBy]                    VARCHAR (50)     NOT NULL,
    [UpdatedDateTime]              DATETIME         NULL,
    [UpdatedBy]                    VARCHAR (50)     NULL,
    [msrepl_tran_version]          UNIQUEIDENTIFIER DEFAULT (newid()) NOT NULL,
    CONSTRAINT [PK_cft_SITE_OWNERSHIP_TYPE] PRIMARY KEY CLUSTERED ([SiteOwnershipTypeID] ASC) WITH (FILLFACTOR = 90)
);

