CREATE TABLE [dbo].[Vendor] (
    [ContactID]      INT          NOT NULL,
    [VendorNumber]   VARCHAR (10) NOT NULL,
    [MAS90CompanyID] INT          NOT NULL,
    CONSTRAINT [PK_Vendor] PRIMARY KEY CLUSTERED ([ContactID] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [Cont/Vend/Company]
    ON [dbo].[Vendor]([ContactID] ASC, [VendorNumber] ASC, [MAS90CompanyID] ASC) WITH (FILLFACTOR = 90);

