CREATE TABLE [dbo].[cft_STORAGE_UNIT] (
    [StorageUnitID]   INT           IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [FeedMillID]      CHAR (10)     NOT NULL,
    [Name]            VARCHAR (50)  NOT NULL,
    [StorageTypeID]   INT           NOT NULL,
    [StorageCapacity] INT           NOT NULL,
    [Description]     VARCHAR (100) NULL,
    [Active]          BIT           NOT NULL,
    [CreatedDateTime] DATETIME      CONSTRAINT [DF_cft_STORAGE_UNIT_CreatedDateTime] DEFAULT (getdate()) NOT NULL,
    [CreatedBy]       VARCHAR (50)  NOT NULL,
    [UpdatedDateTime] DATETIME      NULL,
    [UpdatedBy]       VARCHAR (50)  NULL,
    CONSTRAINT [PK_cft_STORAGE_UNIT] PRIMARY KEY CLUSTERED ([StorageUnitID] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_cft_STORAGE_UNIT_cft_FEED_MILL] FOREIGN KEY ([FeedMillID]) REFERENCES [dbo].[cft_FEED_MILL] ([FeedMillID])
);

