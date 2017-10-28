CREATE TABLE [dbo].[cft_COMMODITY] (
    [CommodityID]     TINYINT        IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [Name]            VARCHAR (50)   NOT NULL,
    [Description]     VARCHAR (1000) NOT NULL,
    [Active]          BIT            NOT NULL,
    [IsDefault]       BIT            NOT NULL,
    [CreatedDateTime] DATETIME       CONSTRAINT [DF_cft_COMMODITY_CreatedDateTime] DEFAULT (getdate()) NOT NULL,
    [CreatedBy]       VARCHAR (50)   NOT NULL,
    [UpdatedDateTime] DATETIME       NULL,
    [UpdatedBy]       VARCHAR (50)   NULL,
    CONSTRAINT [PK_cft_COMMODITY] PRIMARY KEY CLUSTERED ([CommodityID] ASC) WITH (FILLFACTOR = 90)
);

