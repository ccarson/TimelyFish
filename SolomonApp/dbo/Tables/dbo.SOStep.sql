﻿CREATE TABLE [dbo].[SOStep] (
    [Auto]          SMALLINT      CONSTRAINT [DF_SOStep_Auto] DEFAULT ((0)) NOT NULL,
    [AutoPgmClass]  CHAR (4)      CONSTRAINT [DF_SOStep_AutoPgmClass] DEFAULT (' ') NOT NULL,
    [AutoPgmID]     CHAR (8)      CONSTRAINT [DF_SOStep_AutoPgmID] DEFAULT (' ') NOT NULL,
    [AutoProc]      CHAR (30)     CONSTRAINT [DF_SOStep_AutoProc] DEFAULT (' ') NOT NULL,
    [CpnyID]        CHAR (10)     CONSTRAINT [DF_SOStep_CpnyID] DEFAULT (' ') NOT NULL,
    [CreditChk]     SMALLINT      CONSTRAINT [DF_SOStep_CreditChk] DEFAULT ((0)) NOT NULL,
    [CreditChkProg] SMALLINT      CONSTRAINT [DF_SOStep_CreditChkProg] DEFAULT ((0)) NOT NULL,
    [Crtd_DateTime] SMALLDATETIME CONSTRAINT [DF_SOStep_Crtd_DateTime] DEFAULT (rtrim(CONVERT([varchar](30),CONVERT([smalldatetime],getdate(),0),0))) NOT NULL,
    [Crtd_Prog]     CHAR (8)      CONSTRAINT [DF_SOStep_Crtd_Prog] DEFAULT (' ') NOT NULL,
    [Crtd_User]     CHAR (10)     CONSTRAINT [DF_SOStep_Crtd_User] DEFAULT (' ') NOT NULL,
    [Descr]         CHAR (30)     CONSTRAINT [DF_SOStep_Descr] DEFAULT (' ') NOT NULL,
    [EventType]     CHAR (4)      CONSTRAINT [DF_SOStep_EventType] DEFAULT (' ') NOT NULL,
    [FunctionClass] CHAR (4)      CONSTRAINT [DF_SOStep_FunctionClass] DEFAULT (' ') NOT NULL,
    [FunctionID]    CHAR (8)      CONSTRAINT [DF_SOStep_FunctionID] DEFAULT (' ') NOT NULL,
    [LanguageID]    CHAR (4)      CONSTRAINT [DF_SOStep_LanguageID] DEFAULT (' ') NOT NULL,
    [LUpd_DateTime] SMALLDATETIME CONSTRAINT [DF_SOStep_LUpd_DateTime] DEFAULT ('01/01/1900') NOT NULL,
    [LUpd_Prog]     CHAR (8)      CONSTRAINT [DF_SOStep_LUpd_Prog] DEFAULT (' ') NOT NULL,
    [LUpd_User]     CHAR (10)     CONSTRAINT [DF_SOStep_LUpd_User] DEFAULT (' ') NOT NULL,
    [NoteID]        INT           CONSTRAINT [DF_SOStep_NoteID] DEFAULT ((0)) NOT NULL,
    [NotesOn]       SMALLINT      CONSTRAINT [DF_SOStep_NotesOn] DEFAULT ((0)) NOT NULL,
    [Prompt]        CHAR (40)     CONSTRAINT [DF_SOStep_Prompt] DEFAULT (' ') NOT NULL,
    [RptProg]       SMALLINT      CONSTRAINT [DF_SOStep_RptProg] DEFAULT ((0)) NOT NULL,
    [S4Future01]    CHAR (30)     CONSTRAINT [DF_SOStep_S4Future01] DEFAULT (' ') NOT NULL,
    [S4Future02]    CHAR (30)     CONSTRAINT [DF_SOStep_S4Future02] DEFAULT (' ') NOT NULL,
    [S4Future03]    FLOAT (53)    CONSTRAINT [DF_SOStep_S4Future03] DEFAULT ((0)) NOT NULL,
    [S4Future04]    FLOAT (53)    CONSTRAINT [DF_SOStep_S4Future04] DEFAULT ((0)) NOT NULL,
    [S4Future05]    FLOAT (53)    CONSTRAINT [DF_SOStep_S4Future05] DEFAULT ((0)) NOT NULL,
    [S4Future06]    FLOAT (53)    CONSTRAINT [DF_SOStep_S4Future06] DEFAULT ((0)) NOT NULL,
    [S4Future07]    SMALLDATETIME CONSTRAINT [DF_SOStep_S4Future07] DEFAULT ('01/01/1900') NOT NULL,
    [S4Future08]    SMALLDATETIME CONSTRAINT [DF_SOStep_S4Future08] DEFAULT ('01/01/1900') NOT NULL,
    [S4Future09]    INT           CONSTRAINT [DF_SOStep_S4Future09] DEFAULT ((0)) NOT NULL,
    [S4Future10]    INT           CONSTRAINT [DF_SOStep_S4Future10] DEFAULT ((0)) NOT NULL,
    [S4Future11]    CHAR (10)     CONSTRAINT [DF_SOStep_S4Future11] DEFAULT (' ') NOT NULL,
    [S4Future12]    CHAR (10)     CONSTRAINT [DF_SOStep_S4Future12] DEFAULT (' ') NOT NULL,
    [Seq]           CHAR (4)      CONSTRAINT [DF_SOStep_Seq] DEFAULT (' ') NOT NULL,
    [SkipTo]        CHAR (4)      CONSTRAINT [DF_SOStep_SkipTo] DEFAULT (' ') NOT NULL,
    [SOTypeID]      CHAR (4)      CONSTRAINT [DF_SOStep_SOTypeID] DEFAULT (' ') NOT NULL,
    [Status]        CHAR (1)      CONSTRAINT [DF_SOStep_Status] DEFAULT (' ') NOT NULL,
    [User1]         CHAR (30)     CONSTRAINT [DF_SOStep_User1] DEFAULT (' ') NOT NULL,
    [User10]        SMALLDATETIME CONSTRAINT [DF_SOStep_User10] DEFAULT ('01/01/1900') NOT NULL,
    [User2]         CHAR (30)     CONSTRAINT [DF_SOStep_User2] DEFAULT (' ') NOT NULL,
    [User3]         CHAR (30)     CONSTRAINT [DF_SOStep_User3] DEFAULT (' ') NOT NULL,
    [User4]         CHAR (30)     CONSTRAINT [DF_SOStep_User4] DEFAULT (' ') NOT NULL,
    [User5]         FLOAT (53)    CONSTRAINT [DF_SOStep_User5] DEFAULT ((0)) NOT NULL,
    [User6]         FLOAT (53)    CONSTRAINT [DF_SOStep_User6] DEFAULT ((0)) NOT NULL,
    [User7]         CHAR (10)     CONSTRAINT [DF_SOStep_User7] DEFAULT (' ') NOT NULL,
    [User8]         CHAR (10)     CONSTRAINT [DF_SOStep_User8] DEFAULT (' ') NOT NULL,
    [User9]         SMALLDATETIME CONSTRAINT [DF_SOStep_User9] DEFAULT ('01/01/1900') NOT NULL,
    [tstamp]        ROWVERSION    NOT NULL,
    CONSTRAINT [SOStep0] PRIMARY KEY CLUSTERED ([CpnyID] ASC, [SOTypeID] ASC, [Seq] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [SOStep1]
    ON [dbo].[SOStep]([CpnyID] ASC, [SOTypeID] ASC, [FunctionID] ASC, [FunctionClass] ASC) WITH (FILLFACTOR = 90);
