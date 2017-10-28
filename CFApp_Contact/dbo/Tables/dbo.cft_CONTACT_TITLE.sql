CREATE TABLE [dbo].[cft_CONTACT_TITLE] (
    [ContactTitleID]          INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [ContactTitleDescription] VARCHAR (50) NULL,
    [CreatedDateTime]         DATETIME     CONSTRAINT [DF_cft_CONTACT_TITLE_CreatedDateTime] DEFAULT (getdate()) NOT NULL,
    [CreatedBy]               VARCHAR (50) NOT NULL,
    [UpdatedDateTime]         DATETIME     NULL,
    [UpdatedBy]               VARCHAR (50) NULL,
    CONSTRAINT [PK_cft_CONTACT_TITLE] PRIMARY KEY CLUSTERED ([ContactTitleID] ASC) WITH (FILLFACTOR = 90)
);

