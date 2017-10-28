CREATE TABLE [dbo].[XBankBlnk] (
    [Account]  CHAR (10)  NOT NULL,
    [CheckNbr] CHAR (10)  NOT NULL,
    [CnyID]    CHAR (10)  NOT NULL,
    [RI_ID]    SMALLINT   NOT NULL,
    [SubAcct]  CHAR (24)  NOT NULL,
    [tstamp]   ROWVERSION NOT NULL,
    CONSTRAINT [XBankBlnk0] PRIMARY KEY CLUSTERED ([CheckNbr] ASC, [RI_ID] ASC) WITH (FILLFACTOR = 90)
);

