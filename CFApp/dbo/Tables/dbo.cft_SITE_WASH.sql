CREATE TABLE [dbo].[cft_SITE_WASH] (
    [SiteWashID]         INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [ContactID]          INT          NOT NULL,
    [WashFromEffectDate] DATETIME     NULL,
    [WashToEffectDate]   DATETIME     NULL,
    [CreatedDateTime]    DATETIME     CONSTRAINT [DF_cft_SITE_WASH_CreatedDateTime] DEFAULT (getdate()) NOT NULL,
    [CreatedBy]          VARCHAR (50) NOT NULL,
    [UpdatedDateTime]    DATETIME     NULL,
    [UpdatedBy]          VARCHAR (50) NULL,
    CONSTRAINT [PK_SITE_WASH] PRIMARY KEY CLUSTERED ([SiteWashID] ASC) WITH (FILLFACTOR = 90)
);

