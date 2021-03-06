﻿CREATE TABLE [dbo].[CASetup] (
    [AcceptTransDate]  SMALLDATETIME NOT NULL,
    [ARHoldingAcct]    CHAR (10)     NOT NULL,
    [ARHoldingSub]     CHAR (24)     NOT NULL,
    [AutoBatRpt]       SMALLINT      NOT NULL,
    [BnkChgType]       CHAR (2)      NOT NULL,
    [ClearAcct]        CHAR (10)     NOT NULL,
    [ClearSub]         CHAR (24)     NOT NULL,
    [Crtd_DateTime]    SMALLDATETIME NOT NULL,
    [Crtd_Prog]        CHAR (8)      NOT NULL,
    [Crtd_User]        CHAR (10)     NOT NULL,
    [CurrPerNbr]       CHAR (6)      NOT NULL,
    [DfltRateType]     CHAR (6)      NOT NULL,
    [DfltRcnclAmt]     SMALLINT      NOT NULL,
    [GlPostOpt]        CHAR (1)      NOT NULL,
    [Init]             SMALLINT      NOT NULL,
    [lastbatnbr]       CHAR (10)     NOT NULL,
    [LUpd_DateTime]    SMALLDATETIME NOT NULL,
    [LUpd_Prog]        CHAR (8)      NOT NULL,
    [LUpd_User]        CHAR (10)     NOT NULL,
    [MCuryBatRpt]      SMALLINT      NOT NULL,
    [NbrAvgDay]        SMALLINT      NOT NULL,
    [NoteID]           INT           NOT NULL,
    [paststartdate]    SMALLDATETIME NOT NULL,
    [PerNbr]           CHAR (6)      NOT NULL,
    [PerretBal]        SMALLINT      NOT NULL,
    [PerRetTran]       SMALLINT      NOT NULL,
    [PostGLDetail]     SMALLINT      NOT NULL,
    [PrtEmpName]       SMALLINT      NOT NULL,
    [S4Future01]       CHAR (30)     NOT NULL,
    [S4Future02]       CHAR (30)     NOT NULL,
    [S4Future03]       FLOAT (53)    NOT NULL,
    [S4Future04]       FLOAT (53)    NOT NULL,
    [S4Future05]       FLOAT (53)    NOT NULL,
    [S4Future06]       FLOAT (53)    NOT NULL,
    [S4Future07]       SMALLDATETIME NOT NULL,
    [S4Future08]       SMALLDATETIME NOT NULL,
    [S4Future09]       INT           NOT NULL,
    [S4Future10]       INT           NOT NULL,
    [S4Future11]       CHAR (10)     NOT NULL,
    [S4Future12]       CHAR (10)     NOT NULL,
    [SetUpId]          CHAR (2)      NOT NULL,
    [ShowGLInfo]       SMALLINT      NOT NULL,
    [ShowLastBankRecs] SMALLINT      NOT NULL,
    [User1]            CHAR (30)     NOT NULL,
    [User2]            CHAR (30)     NOT NULL,
    [User3]            FLOAT (53)    NOT NULL,
    [User4]            FLOAT (53)    NOT NULL,
    [User5]            CHAR (10)     NOT NULL,
    [User6]            CHAR (10)     NOT NULL,
    [User7]            SMALLDATETIME NOT NULL,
    [User8]            SMALLDATETIME NOT NULL,
    [tstamp]           ROWVERSION    NOT NULL,
    CONSTRAINT [CASetup0] PRIMARY KEY NONCLUSTERED ([SetUpId] ASC) WITH (FILLFACTOR = 90)
);

