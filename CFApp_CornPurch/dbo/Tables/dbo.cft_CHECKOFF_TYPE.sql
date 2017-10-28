CREATE TABLE [dbo].[cft_CHECKOFF_TYPE] (
    [CheckoffTypeID]  INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [Name]            VARCHAR (50) NOT NULL,
    [CreatedDateTime] DATETIME     CONSTRAINT [DF_cft_CHECKOFF_TYPE_CreatedDateTime] DEFAULT (getdate()) NOT NULL,
    [CreatedBy]       VARCHAR (50) NOT NULL,
    [UpdatedDateTime] DATETIME     NULL,
    [UpdatedBy]       VARCHAR (50) NULL,
    CONSTRAINT [PK_cft_CHECKOFF_TYPE] PRIMARY KEY CLUSTERED ([CheckoffTypeID] ASC) WITH (FILLFACTOR = 90)
);

