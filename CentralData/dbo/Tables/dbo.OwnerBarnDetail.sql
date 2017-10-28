CREATE TABLE [dbo].[OwnerBarnDetail] (
    [OwnerBarnDetailID] INT        IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [BarnID]            INT        NOT NULL,
    [OwnerContactID]    INT        NOT NULL,
    [SiteContactID]     INT        NOT NULL,
    [PercentOwnership]  FLOAT (53) NULL,
    CONSTRAINT [PK_OwnerBarnDetail] PRIMARY KEY CLUSTERED ([OwnerBarnDetailID] ASC) WITH (FILLFACTOR = 90)
);

