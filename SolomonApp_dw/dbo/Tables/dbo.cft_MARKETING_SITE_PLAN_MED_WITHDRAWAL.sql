CREATE TABLE [dbo].[cft_MARKETING_SITE_PLAN_MED_WITHDRAWAL] (
    [Record]               INT        IDENTITY (1, 1) NOT NULL,
    [Medication]           CHAR (500) NULL,
    [TriWithdrawalDays]    INT        NOT NULL,
    [NonTriWithdrawalDays] INT        NOT NULL,
    CONSTRAINT [PK_cft_MARKETING_SITE_PLAN_MED_WITHDRAWAL] PRIMARY KEY CLUSTERED ([Record] ASC) WITH (FILLFACTOR = 90)
);

