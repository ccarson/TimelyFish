CREATE TABLE [dbo].[cft_ROW_CHANGE_REASON] (
    [ChangeReasonID]  TINYINT      IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [Name]            VARCHAR (50) NOT NULL,
    [CreatedDateTime] DATETIME     CONSTRAINT [DF_cft_ROW_CHANGE_REASON_CreatedDateTime] DEFAULT (getdate()) NOT NULL,
    [CreatedBy]       VARCHAR (50) NOT NULL,
    [UpdatedDateTime] DATETIME     NULL,
    [UpdatedBy]       VARCHAR (50) NULL,
    CONSTRAINT [PK_cft_ROW_CHANGE_REASON] PRIMARY KEY CLUSTERED ([ChangeReasonID] ASC) WITH (FILLFACTOR = 90)
);

