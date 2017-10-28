CREATE TABLE [dbo].[cft_CONTACT_TYPE] (
    [ContactTypeID]          INT          IDENTITY (500, 1) NOT FOR REPLICATION NOT NULL,
    [ContactTypeDescription] VARCHAR (50) NULL,
    [CreatedDateTime]        DATETIME     CONSTRAINT [DF_cft_CONTACT_TYPE_CreatedDateTime] DEFAULT (getdate()) NOT NULL,
    [CreatedBy]              VARCHAR (50) NOT NULL,
    [UpdatedDateTime]        DATETIME     NULL,
    [UpdatedBy]              VARCHAR (50) NULL,
    CONSTRAINT [PK_cft_CONTACT_TYPE] PRIMARY KEY CLUSTERED ([ContactTypeID] ASC) WITH (FILLFACTOR = 90)
);

