CREATE TABLE [dbo].[cft_RPT_SLF_sys_sea_DW] (
    [PICYear_Week]   VARCHAR (6)     NOT NULL,
    [Phase]          VARCHAR (30)    NOT NULL,
    [SysADG]         NUMERIC (14, 3) NULL,
    [SysAvg_PurchWt] NUMERIC (14, 3) NULL,
    [SysAvg_OutWt]   NUMERIC (14, 3) NULL,
    [SysFE]          NUMERIC (14, 3) NULL,
    [SysAdjFE]       NUMERIC (14, 3) NULL,
    [SysAdjADG]      NUMERIC (14, 3) NULL,
    [sysmortality]   NUMERIC (14, 3) NULL,
    [sysDOTDIY]      NUMERIC (14, 3) NULL,
    [SeaAdjADG]      NUMERIC (14, 3) NULL,
    [SeaAdjFE]       NUMERIC (14, 3) NULL,
    CONSTRAINT [PK_cft_RPT_SLF_sys_sea_DW] PRIMARY KEY CLUSTERED ([PICYear_Week] ASC, [Phase] ASC) WITH (FILLFACTOR = 80)
);

