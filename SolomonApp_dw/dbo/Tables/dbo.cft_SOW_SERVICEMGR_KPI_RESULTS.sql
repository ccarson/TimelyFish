CREATE TABLE [dbo].[cft_SOW_SERVICEMGR_KPI_RESULTS] (
    [Site]         CHAR (30)  NULL,
    [SiteId]       INT        NULL,
    [ContactId]    INT        NULL,
    [SvcMgr]       CHAR (30)  NULL,
    [SvcMgrID]     INT        NULL,
    [FYPeriod]     CHAR (6)   NULL,
    [FarrowTarget] INT        NULL,
    [Farrows]      INT        NULL,
    [ServeFarrow]  INT        NULL,
    [BornAlive]    INT        NULL,
    [PreWeanBA]    INT        NULL,
    [StillBorn]    INT        NULL,
    [Mummy]        INT        NULL,
    [GoodPigs]     INT        NULL,
    [PreWeanGP]    INT        NULL,
    [AmtGoodPigs]  INT        NULL,
    [SowWeaned]    INT        NULL,
    [SowGiltDeath] INT        NULL,
    [SowDays]      INT        NULL,
    [Amt]          FLOAT (53) NULL
);

