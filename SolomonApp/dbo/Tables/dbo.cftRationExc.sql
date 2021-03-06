﻿CREATE TABLE [dbo].[cftRationExc] (
    [CF01]           CHAR (30)     NOT NULL,
    [CF02]           CHAR (30)     NOT NULL,
    [CF03]           CHAR (10)     NOT NULL,
    [CF04]           CHAR (10)     NOT NULL,
    [CF05]           SMALLDATETIME NOT NULL,
    [CF06]           SMALLDATETIME NOT NULL,
    [CF07]           INT           NOT NULL,
    [CF08]           INT           NOT NULL,
    [CF09]           SMALLINT      NOT NULL,
    [CF10]           SMALLINT      NOT NULL,
    [CF11]           FLOAT (53)    NOT NULL,
    [CF12]           FLOAT (53)    NOT NULL,
    [Crtd_DateTime]  SMALLDATETIME NOT NULL,
    [Crtd_Prog]      CHAR (8)      NOT NULL,
    [Crtd_User]      CHAR (10)     NOT NULL,
    [InvtId]         CHAR (30)     NOT NULL,
    [Lupd_DateTime]  SMALLDATETIME NOT NULL,
    [Lupd_Prog]      CHAR (8)      NOT NULL,
    [Lupd_User]      CHAR (10)     NOT NULL,
    [NoSplit]        SMALLINT      NOT NULL,
    [OverrideQty]    SMALLINT      NOT NULL,
    [WithdrawalDays] SMALLINT      NOT NULL,
    [tstamp]         ROWVERSION    NULL,
    CONSTRAINT [cftRationExc0] PRIMARY KEY CLUSTERED ([InvtId] ASC) WITH (FILLFACTOR = 90)
);

