CREATE TABLE [dbo].[cft_SITE_VISIT] (
    [SiteVisitID]              INT        IDENTITY (1, 1) NOT NULL,
    [PigGroupID]               CHAR (10)  NULL,
    [SiteContactID]            CHAR (6)   NULL,
    [BarnNbr]                  CHAR (6)   NULL,
    [CurrentFeedBinInventory]  FLOAT (53) NULL,
    [MedicationWithdrawalDate] DATETIME   NULL,
    [PigHealth]                INT        NULL,
    [GrowthRate]               INT        NULL,
    [MarketingPlan]            INT        NULL,
    [DateOfVisit]              DATETIME   NULL,
    [Datestamp]                DATETIME   NULL,
    [UserID]                   DATETIME   NULL,
    PRIMARY KEY CLUSTERED ([SiteVisitID] ASC)
);

