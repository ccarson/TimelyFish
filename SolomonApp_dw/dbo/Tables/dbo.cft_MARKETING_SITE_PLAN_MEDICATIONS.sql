CREATE TABLE [dbo].[cft_MARKETING_SITE_PLAN_MEDICATIONS] (
    [Record]        INT           IDENTITY (1, 1) NOT NULL,
    [SiteContactID] CHAR (24)     NULL,
    [BarnNbr]       CHAR (24)     NULL,
    [PigGroupID]    CHAR (10)     NULL,
    [Medication]    CHAR (500)    NULL,
    [StartDate]     SMALLDATETIME NOT NULL,
    [EndDate]       SMALLDATETIME NOT NULL,
    CONSTRAINT [PK_cft_MARKETING_SITE_PLAN_MEDICATIONS] PRIMARY KEY CLUSTERED ([Record] ASC) WITH (FILLFACTOR = 90)
);

