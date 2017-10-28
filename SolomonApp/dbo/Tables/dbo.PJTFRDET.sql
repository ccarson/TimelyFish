﻿CREATE TABLE [dbo].[PJTFRDET] (
    [Amount]           FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [Batch_ID]         CHAR (10)     DEFAULT ('') NOT NULL,
    [Crtd_DateTime]    SMALLDATETIME DEFAULT ('01/01/1900') NOT NULL,
    [Crtd_Prog]        CHAR (8)      DEFAULT ('') NOT NULL,
    [Crtd_User]        CHAR (10)     DEFAULT ('') NOT NULL,
    [CuryTranAmt]      FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [LineID]           SMALLINT      DEFAULT ((0)) NOT NULL,
    [LineNbr]          SMALLINT      DEFAULT ((0)) NOT NULL,
    [LineRef]          CHAR (6)      DEFAULT ('') NOT NULL,
    [LUpd_DateTime]    SMALLDATETIME DEFAULT ('01/01/1900') NOT NULL,
    [LUpd_Prog]        CHAR (8)      DEFAULT ('') NOT NULL,
    [LUpd_User]        CHAR (10)     DEFAULT ('') NOT NULL,
    [NoteID]           INT           DEFAULT ((0)) NOT NULL,
    [OrigBatch_ID]     CHAR (10)     DEFAULT ('') NOT NULL,
    [OrigDetail_Num]   INT           DEFAULT ((0)) NOT NULL,
    [OrigFiscalNo]     CHAR (6)      DEFAULT ('') NOT NULL,
    [OrigSystem_Cd]    CHAR (2)      DEFAULT ('') NOT NULL,
    [ProjCury_Amount]  FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [ProjCuryEffDate]  SMALLDATETIME DEFAULT ('01/01/1900') NOT NULL,
    [ProjCuryId]       CHAR (4)      DEFAULT ('') NOT NULL,
    [ProjCuryMultiDiv] CHAR (1)      DEFAULT ('') NOT NULL,
    [ProjCuryRate]     FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [ProjCuryRateType] CHAR (6)      DEFAULT ('') NOT NULL,
    [SeqNum]           SMALLINT      DEFAULT ((0)) NOT NULL,
    [TfrType]          CHAR (1)      DEFAULT ('') NOT NULL,
    [ToAcctCat]        CHAR (16)     DEFAULT ('') NOT NULL,
    [ToCpnyID]         CHAR (10)     DEFAULT ('') NOT NULL,
    [ToGLAcct]         CHAR (10)     DEFAULT ('') NOT NULL,
    [ToPjt_Entity]     CHAR (32)     DEFAULT ('') NOT NULL,
    [ToProject]        CHAR (16)     DEFAULT ('') NOT NULL,
    [ToSubAcct]        CHAR (24)     DEFAULT ('') NOT NULL,
    [Units]            FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [user1]            CHAR (30)     DEFAULT ('') NOT NULL,
    [user2]            CHAR (30)     DEFAULT ('') NOT NULL,
    [user3]            FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [user4]            FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [tstamp]           ROWVERSION    NOT NULL,
    CONSTRAINT [PJTFRDET0] PRIMARY KEY CLUSTERED ([Batch_ID] ASC, [LineID] ASC, [SeqNum] ASC)
);
