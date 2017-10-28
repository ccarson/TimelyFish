CREATE TABLE [dbo].[cft_CONTACT_ADDRESS] (
    [ContactID]       INT          NOT NULL,
    [AddressID]       INT          NOT NULL,
    [AddressTypeID]   INT          NOT NULL,
    [CreatedDateTime] DATETIME     CONSTRAINT [DF_cft_CONTACT_ADDRESS_CreatedDateTime] DEFAULT (getdate()) NOT NULL,
    [CreatedBy]       VARCHAR (50) NOT NULL,
    [UpdatedDateTime] DATETIME     NULL,
    [UpdatedBy]       VARCHAR (50) NULL,
    CONSTRAINT [PK_cft_CONTACT_ADDRESS] PRIMARY KEY CLUSTERED ([ContactID] ASC, [AddressID] ASC, [AddressTypeID] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_cft_CONTACT_ADDRESS_cft_ADDRESS] FOREIGN KEY ([AddressID]) REFERENCES [dbo].[cft_ADDRESS] ([AddressID]) ON DELETE CASCADE
);

