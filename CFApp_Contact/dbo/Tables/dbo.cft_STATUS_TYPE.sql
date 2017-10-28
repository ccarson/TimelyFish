CREATE TABLE [dbo].[cft_STATUS_TYPE] (
    [StatusID]        INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [Description]     VARCHAR (50) NULL,
    [CreatedDateTime] DATETIME     CONSTRAINT [DF_cft_STATUS_TYPE_CreatedDateTime] DEFAULT (getdate()) NOT NULL,
    [CreatedBy]       VARCHAR (50) NOT NULL,
    [UpdatedDateTime] DATETIME     NULL,
    [UpdatedBy]       VARCHAR (50) NULL,
    CONSTRAINT [PK_cft_STATUS_TYPE] PRIMARY KEY CLUSTERED ([StatusID] ASC) WITH (FILLFACTOR = 90)
);

