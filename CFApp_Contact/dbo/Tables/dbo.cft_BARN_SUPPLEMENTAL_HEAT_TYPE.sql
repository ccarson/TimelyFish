CREATE TABLE [dbo].[cft_BARN_SUPPLEMENTAL_HEAT_TYPE] (
    [SupplementalHeatTypeID]          INT          IDENTITY (500, 1) NOT FOR REPLICATION NOT NULL,
    [SupplementalHeatTypeDescription] VARCHAR (50) NULL,
    [CreatedDateTime]                 DATETIME     CONSTRAINT [DF_cft_BARN_SUPPLEMENTAL_HEAT_TYPE_CreatedDateTime] DEFAULT (getdate()) NOT NULL,
    [CreatedBy]                       VARCHAR (50) NOT NULL,
    [UpdatedDateTime]                 DATETIME     NULL,
    [UpdatedBy]                       VARCHAR (50) NULL,
    CONSTRAINT [PK_cft_BARN_SUPPLEMENTAL_HEAT_TYPE] PRIMARY KEY CLUSTERED ([SupplementalHeatTypeID] ASC) WITH (FILLFACTOR = 90)
);

