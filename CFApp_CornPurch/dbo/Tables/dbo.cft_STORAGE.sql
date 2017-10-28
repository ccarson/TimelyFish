CREATE TABLE [dbo].[cft_STORAGE] (
    [StorageID]       INT           IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [ContactID]       INT           NOT NULL,
    [StorageTypeID]   INT           NULL,
    [Active]          BIT           CONSTRAINT [DF_cft_CORN_PRODUCER_Active] DEFAULT (1) NULL,
    [Name]            VARCHAR (100) NULL,
    [Capacity]        INT           NULL,
    [AugerID]         INT           NULL,
    [CreatedDateTime] DATETIME      CONSTRAINT [DF_cft_STORAGE_CreatedDateTime] DEFAULT (getdate()) NOT NULL,
    [CreatedBy]       VARCHAR (50)  NOT NULL,
    [UpdatedDateTime] DATETIME      NULL,
    [UpdatedBy]       VARCHAR (50)  NULL,
    CONSTRAINT [PK_cft_STORAGE] PRIMARY KEY CLUSTERED ([StorageID] ASC) WITH (FILLFACTOR = 90)
);

