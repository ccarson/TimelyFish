CREATE TABLE [dbo].[cft_SITE_MARKETING_STRATEGY] (
    [SiteMarketingStrategyID] INT        IDENTITY (1, 1) NOT NULL,
    [SiteContactID]           CHAR (6)   NULL,
    [BarnNbr]                 CHAR (6)   NULL,
    [FirstTopPercent]         FLOAT (53) NULL,
    [SecondTopPercent]        FLOAT (53) NULL,
    [ThirdTopPercent]         FLOAT (53) NULL,
    [HeavyCloseoutPercent]    FLOAT (53) NULL,
    [LightCloseoutPercent]    FLOAT (53) NULL,
    [Datestamp]               DATETIME   NULL,
    [UserID]                  DATETIME   NULL,
    PRIMARY KEY CLUSTERED ([SiteMarketingStrategyID] ASC)
);

