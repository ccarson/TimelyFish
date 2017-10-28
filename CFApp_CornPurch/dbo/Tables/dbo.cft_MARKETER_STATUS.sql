CREATE TABLE [dbo].[cft_MARKETER_STATUS] (
    [MarketerStatusID] TINYINT      IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [Name]             VARCHAR (50) NOT NULL,
    [CreatedDateTime]  DATETIME     CONSTRAINT [DF_cft_MARKETER_STATUS_CreatedDateTime] DEFAULT (getdate()) NOT NULL,
    [CreatedBy]        VARCHAR (50) NOT NULL,
    [UpdatedDateTime]  DATETIME     NULL,
    [UpdatedBy]        VARCHAR (50) NULL,
    CONSTRAINT [PK_cft_MARKETER_STATUS] PRIMARY KEY CLUSTERED ([MarketerStatusID] ASC) WITH (FILLFACTOR = 90)
);

