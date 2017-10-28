CREATE TABLE [dbo].[ManureApplicationVendorEmployeeName] (
    [ContactID]                   INT          NOT NULL,
    [ManureAppVendorEmployeeName] VARCHAR (50) NOT NULL,
    CONSTRAINT [PK_ManureAppVendorEmployeeName] PRIMARY KEY CLUSTERED ([ContactID] ASC, [ManureAppVendorEmployeeName] ASC) WITH (FILLFACTOR = 90)
);

