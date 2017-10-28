CREATE TABLE [dbo].[cft_CORN_PRODUCER_FARM] (
    [CornProducerFarmID]    INT            IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [ContactID]             INT            NOT NULL,
    [CornProducerID]        VARCHAR (15)   NOT NULL,
    [RoadRestrictionWeight] INT            NULL,
    [Active]                BIT            CONSTRAINT [DF_cft_CORN_PRODUCER_FARM_Active] DEFAULT (1) NULL,
    [Comments]              VARCHAR (2000) NULL,
    [CreatedDateTime]       DATETIME       CONSTRAINT [DF_cft_CORN_PRODUCER_FARM_CreatedDateTime] DEFAULT (getdate()) NOT NULL,
    [CreatedBy]             VARCHAR (50)   NOT NULL,
    [UpdatedDateTime]       DATETIME       NULL,
    [UpdatedBy]             VARCHAR (50)   NULL,
    CONSTRAINT [PK_CORN_PRODUCER_FARM] PRIMARY KEY CLUSTERED ([CornProducerFarmID] ASC) WITH (FILLFACTOR = 90)
);

