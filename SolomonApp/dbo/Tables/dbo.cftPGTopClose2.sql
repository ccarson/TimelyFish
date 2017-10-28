CREATE TABLE [dbo].[cftPGTopClose2] (
    [ADG]           FLOAT (53)    NOT NULL,
    [BegStDate]     INT           NOT NULL,
    [Crtd_DateTime] SMALLDATETIME NULL,
    [Crtd_Prog]     CHAR (8)      NULL,
    [Crtd_User]     CHAR (10)     NULL,
    [GenderTypeID]  CHAR (1)      NOT NULL,
    [Lupd_DateTime] SMALLDATETIME NULL,
    [Lupd_Prog]     CHAR (8)      NULL,
    [Lupd_User]     CHAR (10)     NULL,
    [tstamp]        ROWVERSION    NULL
);


GO
CREATE CLUSTERED INDEX [cftPGtopClose20]
    ON [dbo].[cftPGTopClose2]([BegStDate] ASC, [GenderTypeID] ASC) WITH (FILLFACTOR = 90);

