CREATE TABLE [dbo].[cft_BARN_WATERER_TYPE] (
    [WatererTypeID]          INT          IDENTITY (500, 1) NOT FOR REPLICATION NOT NULL,
    [WatererTypeDescription] VARCHAR (50) NULL,
    [CreatedDateTime]        DATETIME     CONSTRAINT [DF_cft_BARN_WATERER_TYPE_CreatedDateTime] DEFAULT (getdate()) NOT NULL,
    [CreatedBy]              VARCHAR (50) NOT NULL,
    [UpdatedDateTime]        DATETIME     NULL,
    [UpdatedBy]              VARCHAR (50) NULL,
    CONSTRAINT [PK_cft_BARN_WATERER_TYPE] PRIMARY KEY CLUSTERED ([WatererTypeID] ASC) WITH (FILLFACTOR = 90)
);

