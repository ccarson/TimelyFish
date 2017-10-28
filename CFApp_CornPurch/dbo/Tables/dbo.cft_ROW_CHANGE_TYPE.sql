CREATE TABLE [dbo].[cft_ROW_CHANGE_TYPE] (
    [RowChangeTypeID] TINYINT      IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [Name]            VARCHAR (20) NOT NULL,
    [CreatedDateTime] DATETIME     CONSTRAINT [DF_cft_ROW_CHANGE_TYPE_CreatedDateTime] DEFAULT (getdate()) NOT NULL,
    [CreatedBy]       VARCHAR (50) NOT NULL,
    [UpdatedDateTime] DATETIME     NULL,
    [UpdatedBy]       VARCHAR (50) NULL,
    CONSTRAINT [PK_cft_ROW_CHANGE_TYPE] PRIMARY KEY CLUSTERED ([RowChangeTypeID] ASC) WITH (FILLFACTOR = 90)
);

