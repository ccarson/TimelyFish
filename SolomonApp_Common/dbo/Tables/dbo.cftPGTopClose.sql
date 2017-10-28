CREATE TABLE [dbo].[cftPGTopClose] (
    [BegStDate]     INT           NOT NULL,
    [CloseDays]     INT           NOT NULL,
    [Crtd_DateTime] SMALLDATETIME NOT NULL,
    [Crtd_Prog]     CHAR (8)      NOT NULL,
    [Crtd_User]     CHAR (10)     NOT NULL,
    [EndStDate]     SMALLDATETIME NOT NULL,
    [EndWgt]        FLOAT (53)    NOT NULL,
    [GenderTypeID]  CHAR (1)      NOT NULL,
    [Lupd_DateTime] SMALLDATETIME NOT NULL,
    [Lupd_Prog]     CHAR (8)      NOT NULL,
    [Lupd_User]     CHAR (10)     NOT NULL,
    [StartWgt]      FLOAT (53)    NOT NULL,
    [TopDays]       INT           NOT NULL,
    [tstamp]        ROWVERSION    NULL
);


GO
CREATE CLUSTERED INDEX [cftPGTopClose0]
    ON [dbo].[cftPGTopClose]([BegStDate] ASC, [GenderTypeID] ASC) WITH (FILLFACTOR = 90);

