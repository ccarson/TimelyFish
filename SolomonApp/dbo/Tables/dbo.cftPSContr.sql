CREATE TABLE [dbo].[cftPSContr] (
    [BaseAdjFreq]   CHAR (1)      NOT NULL,
    [BegDate]       SMALLDATETIME NOT NULL,
    [ContrNbr]      CHAR (10)     NOT NULL,
    [Crtd_DateTime] SMALLDATETIME NOT NULL,
    [Crtd_Prog]     CHAR (8)      NOT NULL,
    [Crtd_User]     CHAR (10)     NOT NULL,
    [CustId]        CHAR (15)     NOT NULL,
    [Descr]         CHAR (30)     NOT NULL,
    [EndDate]       SMALLDATETIME NOT NULL,
    [Lupd_DateTime] SMALLDATETIME NOT NULL,
    [Lupd_Prog]     CHAR (8)      NOT NULL,
    [Lupd_User]     CHAR (10)     NOT NULL,
    [NoteId]        INT           NOT NULL,
    [SaleBasis]     CHAR (2)      NOT NULL,
    [TrkgPaidFlg]   SMALLINT      NOT NULL,
    [tstamp]        ROWVERSION    NULL,
    CONSTRAINT [cftPSContr0] PRIMARY KEY CLUSTERED ([ContrNbr] ASC) WITH (FILLFACTOR = 90)
);

