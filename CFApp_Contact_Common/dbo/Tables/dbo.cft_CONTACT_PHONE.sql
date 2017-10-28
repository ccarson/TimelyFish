CREATE TABLE [dbo].[cft_CONTACT_PHONE] (
    [ContactID]       INT          NOT NULL,
    [PhoneID]         INT          NOT NULL,
    [PhoneTypeID]     INT          NOT NULL,
    [Comment]         VARCHAR (50) NULL,
    [PhoneCarrierID]  INT          CONSTRAINT [DF_cft_CONTACT_PHONE_PhoneCarrierID] DEFAULT (1) NOT NULL,
    [CreatedDateTime] DATETIME     CONSTRAINT [DF_cft_CONTACT_PHONE_CreatedDateTime] DEFAULT (getdate()) NOT NULL,
    [CreatedBy]       VARCHAR (50) NOT NULL,
    [UpdatedDateTime] DATETIME     NULL,
    [UpdatedBy]       VARCHAR (50) NULL,
    CONSTRAINT [PK_cft_CONTACT_PHONE] PRIMARY KEY CLUSTERED ([ContactID] ASC, [PhoneID] ASC, [PhoneTypeID] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_cft_CONTACT_PHONE_cft_CONTACT_CELL_PHONE_PROVIDER] FOREIGN KEY ([PhoneCarrierID]) REFERENCES [dbo].[cft_CONTACT_CELL_PHONE_PROVIDER] ([CarrierID]),
    CONSTRAINT [FK_cft_CONTACT_PHONE_cft_PHONE] FOREIGN KEY ([PhoneID]) REFERENCES [dbo].[cft_PHONE] ([PhoneID]) ON DELETE CASCADE
);

