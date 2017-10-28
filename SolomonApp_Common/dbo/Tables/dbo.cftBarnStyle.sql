CREATE TABLE [dbo].[cftBarnStyle] (
    [BarnStyleID]          CHAR (2)      NULL,
    [Crtd_DateTime]        SMALLDATETIME NULL,
    [Crtd_Prog]            CHAR (8)      NULL,
    [Crtd_User]            CHAR (10)     NULL,
    [DefaultBarnLossValue] FLOAT (53)    NULL,
    [Description]          CHAR (30)     NULL,
    [Lupd_DateTime]        SMALLDATETIME NULL,
    [Lupd_Prog]            CHAR (8)      NULL,
    [Lupd_User]            CHAR (10)     NULL,
    [tstamp]               ROWVERSION    NULL
);

