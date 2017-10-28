CREATE TABLE [dbo].[cft_CORN_PRODUCER_FARM_DIRECTIONS] (
    [CornProducerFarmDirectionID] INT            IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [CornProducerFarmID]          INT            NOT NULL,
    [FeedMillID]                  CHAR (10)      NOT NULL,
    [DirectionToFeedMill]         VARCHAR (3500) NULL,
    [DirectionFromFeedMill]       VARCHAR (3500) NULL,
    [CreatedDateTime]             DATETIME       CONSTRAINT [DF_cft_CORN_PRODUCER_FARM_DIRECTIONS_CreatedDateTime] DEFAULT (getdate()) NOT NULL,
    [CreatedBy]                   VARCHAR (50)   NOT NULL,
    [UpdatedDateTime]             DATETIME       NULL,
    [UpdatedBy]                   VARCHAR (50)   NULL,
    CONSTRAINT [PK_cft_CORN_PRODUCER_FARM_DIRECTIONS] PRIMARY KEY CLUSTERED ([CornProducerFarmDirectionID] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_cft_CORN_PRODUCER_FARM_DIRECTIONS_cft_CORN_PRODUCER_FARM] FOREIGN KEY ([CornProducerFarmID]) REFERENCES [dbo].[cft_CORN_PRODUCER_FARM] ([CornProducerFarmID]) ON DELETE CASCADE
);

