CREATE TABLE [dbo].[cft_SBF_ContactID_REF] (
    [CFContactID]     INT          NOT NULL,
    [CFSiteContactID] CHAR (6)     NULL,
    [SBFSiteID]       CHAR (3)     NULL,
    [SBFSiteName]     VARCHAR (50) NULL,
    CONSTRAINT [PK_cft_SBF_ContactID_REF] PRIMARY KEY CLUSTERED ([CFContactID] ASC) WITH (FILLFACTOR = 90)
);

