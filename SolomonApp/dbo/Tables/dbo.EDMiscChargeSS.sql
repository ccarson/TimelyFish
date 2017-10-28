CREATE TABLE [dbo].[EDMiscChargeSS] (
    [Code]        CHAR (10)  CONSTRAINT [DF_EDMiscChargeSS_Code] DEFAULT (' ') NOT NULL,
    [Description] CHAR (30)  CONSTRAINT [DF_EDMiscChargeSS_Description] DEFAULT (' ') NOT NULL,
    [MiscChrgID]  CHAR (10)  CONSTRAINT [DF_EDMiscChargeSS_MiscChrgID] DEFAULT (' ') NOT NULL,
    [tstamp]      ROWVERSION NOT NULL,
    CONSTRAINT [EDMiscChargeSS0] PRIMARY KEY CLUSTERED ([MiscChrgID] ASC, [Code] ASC) WITH (FILLFACTOR = 90)
);

