CREATE TABLE [dbo].[cft_SowMart_MatingGroup_Rollup] (
    [GroupID]           VARCHAR (8)  NOT NULL,
    [Total_born_qty]    INT          NULL,
    [born_alive_qty]    INT          NULL,
    [born_alive_pct]    FLOAT (53)   NULL,
    [mummy_qty]         INT          NULL,
    [mummy_pct]         FLOAT (53)   NULL,
    [Stillborn_qty]     INT          NULL,
    [stillborn_pct]     FLOAT (53)   NULL,
    [wean_qty]          INT          NULL,
    [wean_pct]          FLOAT (53)   NULL,
    [PigletDeath_qty]   INT          NULL,
    [pigletdeath_pct]   FLOAT (53)   NULL,
    [avg_wean_age]      FLOAT (53)   NULL,
    [avg_lact_days_qty] INT          NULL,
    [avg_gest_days_qty] INT          NULL,
    [semenid]           VARCHAR (12) NULL,
    [observer]          VARCHAR (30) NULL,
    [sowgenetics]       VARCHAR (20) NULL,
    [matingeventid]     INT          NULL,
    [load_Dt]           DATETIME     DEFAULT (getdate()) NOT NULL
);

