CREATE TABLE [dbo].[cft_PHONE] (
    [PhoneID]         INT          IDENTITY (50000, 1) NOT FOR REPLICATION NOT NULL,
    [PhoneNbr]        VARCHAR (10) NOT NULL,
    [Extension]       VARCHAR (50) NULL,
    [SpeedDial]       INT          NULL,
    [CreatedDateTime] DATETIME     CONSTRAINT [DF_cft_PHONE_CreatedDateTime] DEFAULT (getdate()) NOT NULL,
    [CreatedBy]       VARCHAR (50) NOT NULL,
    [UpdatedDateTime] DATETIME     NULL,
    [UpdatedBy]       VARCHAR (50) NULL,
    CONSTRAINT [PK_cft_PHONE] PRIMARY KEY CLUSTERED ([PhoneID] ASC) WITH (FILLFACTOR = 90)
);

