CREATE TABLE [dbo].[cft_SLF_TWOPHASE_COMPOSITION] (
    [CombPigGroupID] CHAR (50)  NOT NULL,
    [G1_PigGroupID]  CHAR (10)  NOT NULL,
    [G1G2_Qty]       INT        NOT NULL,
    [G1G2_TotalWgt]  FLOAT (53) NOT NULL,
    [G1G2_WgtGained] FLOAT (53) NOT NULL,
    [G1G2_PigDays]   FLOAT (53) NOT NULL,
    [G1G2_HC_Pct]    FLOAT (53) NOT NULL,
    [G1G2_WT_Pct]    FLOAT (53) NOT NULL,
    [G1G2_WG_Pct]    FLOAT (53) NOT NULL,
    [G1G2_PD_Pct]    FLOAT (53) NOT NULL,
    [G2_Qty]         INT        NOT NULL,
    [G2_TotalWgt]    FLOAT (53) NOT NULL,
    [G2_WgtGained]   FLOAT (53) NOT NULL,
    [G2_PigDays]     FLOAT (53) NOT NULL,
    [G2_PigGroupID]  CHAR (10)  NOT NULL
);

