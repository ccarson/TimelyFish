CREATE TABLE [dbo].[cft_COMMISSION_RATE_TYPE] (
    [CommissionRateTypeID] INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [Name]                 VARCHAR (50) NOT NULL,
    [CreatedDateTime]      DATETIME     CONSTRAINT [DF_cft_COMMISSION_RATE_TYPE_CreatedDateTime] DEFAULT (getdate()) NOT NULL,
    [CreatedBy]            VARCHAR (50) NOT NULL,
    [UpdatedDateTime]      DATETIME     NULL,
    [UpdatedBy]            VARCHAR (50) NULL,
    CONSTRAINT [PK_cft_COMMISSION_RATE_TYPE] PRIMARY KEY CLUSTERED ([CommissionRateTypeID] ASC) WITH (FILLFACTOR = 90)
);

