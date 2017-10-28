CREATE TABLE [dbo].[cft_potential_index_list] (
    [serverNAME] NVARCHAR (128)  NOT NULL,
    [crtd_date]  SMALLDATETIME   NOT NULL,
    [DB_NAME]    NVARCHAR (128)  NOT NULL,
    [ucompiles]  INT             NULL,
    [useeks]     INT             NULL,
    [uscans]     INT             NULL,
    [luseeks]    DATETIME        NULL,
    [luscans]    DATETIME        NULL,
    [avgTcost]   DECIMAL (18)    NULL,
    [avguimpact] DECIMAL (18)    NULL,
    [ecols]      NVARCHAR (4000) NULL,
    [icols]      NVARCHAR (4000) NULL,
    [incols]     NVARCHAR (4000) NULL,
    [TEXT]       NVARCHAR (4000) NULL
);

