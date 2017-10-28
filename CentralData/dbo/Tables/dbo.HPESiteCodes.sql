CREATE TABLE [dbo].[HPESiteCodes] (
    [ContactID]      INT            NOT NULL,
    [OldSiteID]      NVARCHAR (50)  NULL,
    [SiteID]         NVARCHAR (255) NULL,
    [FacilityTypeID] INT            NULL,
    [Name]           NVARCHAR (255) NULL,
    [skip]           BIT            NULL,
    [Ownership]      INT            NULL,
    CONSTRAINT [PK_HPESiteCodes] PRIMARY KEY CLUSTERED ([ContactID] ASC) WITH (FILLFACTOR = 90)
);

