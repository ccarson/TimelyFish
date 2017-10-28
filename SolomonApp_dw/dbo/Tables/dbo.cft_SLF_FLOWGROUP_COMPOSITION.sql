CREATE TABLE [dbo].[cft_SLF_FLOWGROUP_COMPOSITION] (
    [FlowGroup]    CHAR (10)  NOT NULL,
    [CombPigGroup] CHAR (50)  NOT NULL,
    [SourceGroup]  CHAR (10)  NOT NULL,
    [HC_Pct]       FLOAT (53) NOT NULL,
    [WT_Pct]       FLOAT (53) NOT NULL,
    [WG_Pct]       FLOAT (53) NOT NULL,
    [PD_Pct]       FLOAT (53) NOT NULL
);

