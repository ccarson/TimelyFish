CREATE TABLE [dbo].[cft_SLF_FLOWGROUP_CALCS] (
    [FlowGroup]            CHAR (10)      NOT NULL,
    [FlowGroupDescription] CHAR (50)      NOT NULL,
    [WeanPigsIn_Qty]       FLOAT (53)     NOT NULL,
    [WeanPigsIn_Wt]        FLOAT (53)     NOT NULL,
    [AvgWeanPig_Wt]        FLOAT (53)     NOT NULL,
    [HeadStarted]          FLOAT (53)     NOT NULL,
    [AvgMarket_Wt]         FLOAT (53)     NOT NULL,
    [TotalMarketLbs]       FLOAT (53)     NOT NULL,
    [TotalMarketQty]       FLOAT (53)     NOT NULL,
    [WeightGained]         FLOAT (53)     NOT NULL,
    [TotalPigDays]         FLOAT (53)     NOT NULL,
    [MortalityRate]        FLOAT (53)     NOT NULL,
    [ADG]                  FLOAT (53)     NOT NULL,
    [FeedEfficiency]       FLOAT (53)     NOT NULL,
    [DOA_Pct]              FLOAT (53)     NOT NULL,
    [DIY_Pct]              FLOAT (53)     NOT NULL,
    [Condemn_Pct]          FLOAT (53)     NOT NULL,
    [WTF_DownDays]         FLOAT (53)     NOT NULL,
    [Utilization]          DECIMAL (6, 2) NULL,
    [DaysToMarket]         FLOAT (53)     NOT NULL,
    PRIMARY KEY CLUSTERED ([FlowGroup] ASC) WITH (FILLFACTOR = 90)
);

