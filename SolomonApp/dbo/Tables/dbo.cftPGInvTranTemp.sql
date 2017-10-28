﻿CREATE TABLE [dbo].[cftPGInvTranTemp] (
    [RecID]            INT           IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [acct]             CHAR (16)     NOT NULL,
    [BatNbr]           CHAR (10)     NOT NULL,
    [Crtd_DateTime]    SMALLDATETIME NOT NULL,
    [Crtd_Prog]        CHAR (8)      NOT NULL,
    [Crtd_User]        CHAR (10)     NOT NULL,
    [IndWgt]           FLOAT (53)    NOT NULL,
    [InvEffect]        SMALLINT      NOT NULL,
    [LineNbr]          SMALLINT      NOT NULL,
    [LUpd_DateTime]    SMALLDATETIME NOT NULL,
    [LUpd_Prog]        CHAR (8)      NOT NULL,
    [LUpd_User]        CHAR (10)     NOT NULL,
    [NoteID]           INT           NOT NULL,
    [PC_Source]        SMALLINT      NULL,
    [PigGroupID]       CHAR (10)     NOT NULL,
    [Qty]              INT           NOT NULL,
    [Rlsed]            SMALLINT      NOT NULL,
    [SourceBatNbr]     CHAR (10)     NOT NULL,
    [SourceLineNbr]    SMALLINT      NOT NULL,
    [SourcePigGroupID] CHAR (10)     NOT NULL,
    [SourceProg]       CHAR (8)      NOT NULL,
    [SourceRefNbr]     CHAR (10)     NOT NULL,
    [TotalWgt]         FLOAT (53)    NOT NULL,
    [TranDate]         SMALLDATETIME NOT NULL,
    [TranSubTypeID]    CHAR (2)      NOT NULL,
    [TranTypeID]       CHAR (2)      NOT NULL,
    CONSTRAINT [cftPGInvTranTemp0] PRIMARY KEY CLUSTERED ([RecID] ASC) WITH (FILLFACTOR = 90)
);
