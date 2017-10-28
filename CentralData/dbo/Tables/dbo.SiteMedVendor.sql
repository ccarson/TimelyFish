CREATE TABLE [dbo].[SiteMedVendor] (
    [SiteContactID]   INT          NOT NULL,
    [VendorContactID] INT          NOT NULL,
    [AccountNbr]      VARCHAR (50) NULL,
    CONSTRAINT [PK_SiteMedVendor] PRIMARY KEY CLUSTERED ([SiteContactID] ASC, [VendorContactID] ASC) WITH (FILLFACTOR = 90)
);

