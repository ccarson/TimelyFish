CREATE TABLE [dbo].[WrkCAForecast] (
    [Bankacct]       CHAR (10)     NOT NULL,
    [Banksub]        CHAR (24)     NOT NULL,
    [cpnyid]         CHAR (10)     NOT NULL,
    [CuryID]         CHAR (4)      NOT NULL,
    [Descr]          CHAR (30)     NOT NULL,
    [Module]         CHAR (2)      NOT NULL,
    [Period1Amt]     FLOAT (53)    NOT NULL,
    [Period1Curyamt] FLOAT (53)    NOT NULL,
    [Period1Date]    SMALLDATETIME NOT NULL,
    [Period2Amt]     FLOAT (53)    NOT NULL,
    [Period2CuryAmt] FLOAT (53)    NOT NULL,
    [Period2Date]    SMALLDATETIME NOT NULL,
    [Period3Amt]     FLOAT (53)    NOT NULL,
    [Period3CuryAmt] FLOAT (53)    NOT NULL,
    [Period3Date]    SMALLDATETIME NOT NULL,
    [Period4Amt]     FLOAT (53)    NOT NULL,
    [Period4CuryAmt] FLOAT (53)    NOT NULL,
    [Period4Date]    SMALLDATETIME NOT NULL,
    [Period5Amt]     FLOAT (53)    NOT NULL,
    [Period5CuryAmt] FLOAT (53)    NOT NULL,
    [Period5date]    SMALLDATETIME NOT NULL,
    [Period6Amt]     FLOAT (53)    NOT NULL,
    [Period6CuryAmt] FLOAT (53)    NOT NULL,
    [Period6date]    SMALLDATETIME NOT NULL,
    [Period7Amt]     FLOAT (53)    NOT NULL,
    [Period7CuryAmt] FLOAT (53)    NOT NULL,
    [Period7date]    SMALLDATETIME NOT NULL,
    [Period8Amt]     FLOAT (53)    NOT NULL,
    [Period8CuryAmt] FLOAT (53)    NOT NULL,
    [Period8date]    SMALLDATETIME NOT NULL,
    [rcptDisbFlg]    CHAR (1)      NOT NULL,
    [RI_ID]          SMALLINT      NOT NULL,
    [tstamp]         ROWVERSION    NOT NULL
);


GO
CREATE CLUSTERED INDEX [WrkCAForecast0]
    ON [dbo].[WrkCAForecast]([RI_ID] ASC, [cpnyid] ASC, [Bankacct] ASC, [Banksub] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [WrkCAForecast2]
    ON [dbo].[WrkCAForecast]([cpnyid] ASC, [Bankacct] ASC, [Banksub] ASC) WITH (FILLFACTOR = 90);

