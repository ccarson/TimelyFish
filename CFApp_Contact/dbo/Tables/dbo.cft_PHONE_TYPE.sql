CREATE TABLE [dbo].[cft_PHONE_TYPE] (
    [PhoneTypeID]     INT          IDENTITY (500, 1) NOT FOR REPLICATION NOT NULL,
    [Description]     VARCHAR (30) NULL,
    [CreatedDateTime] DATETIME     CONSTRAINT [DF_cft_PHONE_TYPE_CreatedDateTime] DEFAULT (getdate()) NOT NULL,
    [CreatedBy]       VARCHAR (50) NOT NULL,
    [UpdatedDateTime] DATETIME     NULL,
    [UpdatedBy]       VARCHAR (50) NULL,
    CONSTRAINT [PK_cft_PHONE_TYPE] PRIMARY KEY CLUSTERED ([PhoneTypeID] ASC) WITH (FILLFACTOR = 90)
);

