CREATE TABLE [dbo].[cftWtPrediction] (
    [Crtd_DateTime] SMALLDATETIME NOT NULL,
    [Crtd_Prog]     CHAR (8)      NOT NULL,
    [Crtd_User]     CHAR (10)     NOT NULL,
    [DaysIn]        INT           NOT NULL,
    [Lupd_DateTime] SMALLDATETIME NOT NULL,
    [Lupd_Prog]     CHAR (8)      NOT NULL,
    [Lupd_User]     CHAR (10)     NOT NULL,
    [Rate]          FLOAT (53)    NOT NULL,
    [StartWgt]      FLOAT (53)    NOT NULL,
    [tstamp]        ROWVERSION    NULL
);

