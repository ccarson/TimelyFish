CREATE TABLE [dbo].[cft_STORAGE_TYPE] (
    [StorageTypeID]   INT           IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [Description]     VARCHAR (100) NULL,
    [CreatedDateTime] DATETIME      CONSTRAINT [DF_cft_STORAGE_TYPE_CreatedDateTime] DEFAULT (getdate()) NOT NULL,
    [CreatedBy]       VARCHAR (50)  NOT NULL,
    [UpdatedDateTime] DATETIME      NULL,
    [UpdatedBy]       VARCHAR (50)  NULL,
    CONSTRAINT [PK_cft_STORAGE_TYPE] PRIMARY KEY CLUSTERED ([StorageTypeID] ASC) WITH (FILLFACTOR = 90)
);

