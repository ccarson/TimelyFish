CREATE TABLE [dbo].[cft_SLF_ALL_COMPOSITION] (
    [Source_PigGroupID] CHAR (10)  NOT NULL,
    [Source_Qty]        INT        NOT NULL,
    [Source_TotalWgt]   FLOAT (53) NOT NULL,
    [Source_WgtGained]  FLOAT (53) NOT NULL,
    [Source_PigDays]    FLOAT (53) NOT NULL,
    [HC_Pct]            FLOAT (53) NOT NULL,
    [WT_Pct]            FLOAT (53) NOT NULL,
    [WG_Pct]            FLOAT (53) NOT NULL,
    [PD_Pct]            FLOAT (53) NOT NULL,
    [Dest_Qty]          INT        NOT NULL,
    [Dest_TotalWgt]     FLOAT (53) NOT NULL,
    [Dest_WgtGained]    FLOAT (53) NOT NULL,
    [Dest_PigDays]      FLOAT (53) NOT NULL,
    [Dest_PigGroupID]   CHAR (10)  NOT NULL
);

