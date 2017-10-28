CREATE TABLE [dbo].[cft_Address_attrib] (
    [AddressID] INT               NOT NULL,
    [GeoRef]    [sys].[geography] NULL,
    CONSTRAINT [PK_cft_Address_attrib] PRIMARY KEY CLUSTERED ([AddressID] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_Address] FOREIGN KEY ([AddressID]) REFERENCES [dbo].[Address] ([AddressID]) ON DELETE CASCADE
);
