CREATE TABLE [dbo].[cft_ADDRESS_TYPE] (
    [AddressTypeID]   INT          IDENTITY (500, 1) NOT FOR REPLICATION NOT NULL,
    [Description]     VARCHAR (30) NULL,
    [CreatedDateTime] DATETIME     CONSTRAINT [DF_cft_ADDRESS_TYPE_CreatedDateTime] DEFAULT (getdate()) NOT NULL,
    [CreatedBy]       VARCHAR (50) NOT NULL,
    [UpdatedDateTime] DATETIME     NULL,
    [UpdatedBy]       VARCHAR (50) NULL,
    CONSTRAINT [PK_cft_ADDRESS_TYPE] PRIMARY KEY CLUSTERED ([AddressTypeID] ASC) WITH (FILLFACTOR = 90)
);

