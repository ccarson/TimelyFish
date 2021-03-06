﻿CREATE TABLE [dbo].[CSPlan] (
    [Crtd_DateTime]   SMALLDATETIME CONSTRAINT [DF_CSPlan_Crtd_DateTime] DEFAULT (rtrim(CONVERT([varchar](30),CONVERT([smalldatetime],getdate(),0),0))) NOT NULL,
    [Crtd_Prog]       CHAR (8)      CONSTRAINT [DF_CSPlan_Crtd_Prog] DEFAULT (' ') NOT NULL,
    [Crtd_User]       CHAR (10)     CONSTRAINT [DF_CSPlan_Crtd_User] DEFAULT (' ') NOT NULL,
    [Descr]           CHAR (30)     CONSTRAINT [DF_CSPlan_Descr] DEFAULT (' ') NOT NULL,
    [LevelBasis]      CHAR (1)      CONSTRAINT [DF_CSPlan_LevelBasis] DEFAULT (' ') NOT NULL,
    [LevelBasisAccum] SMALLINT      CONSTRAINT [DF_CSPlan_LevelBasisAccum] DEFAULT ((0)) NOT NULL,
    [LevelPerType]    CHAR (1)      CONSTRAINT [DF_CSPlan_LevelPerType] DEFAULT (' ') NOT NULL,
    [LevelType]       CHAR (1)      CONSTRAINT [DF_CSPlan_LevelType] DEFAULT (' ') NOT NULL,
    [LineCntr]        SMALLINT      CONSTRAINT [DF_CSPlan_LineCntr] DEFAULT ((0)) NOT NULL,
    [LUpd_DateTime]   SMALLDATETIME CONSTRAINT [DF_CSPlan_LUpd_DateTime] DEFAULT ('01/01/1900') NOT NULL,
    [LUpd_Prog]       CHAR (8)      CONSTRAINT [DF_CSPlan_LUpd_Prog] DEFAULT (' ') NOT NULL,
    [LUpd_User]       CHAR (10)     CONSTRAINT [DF_CSPlan_LUpd_User] DEFAULT (' ') NOT NULL,
    [NoteID]          INT           CONSTRAINT [DF_CSPlan_NoteID] DEFAULT ((0)) NOT NULL,
    [PctEarnBook]     FLOAT (53)    CONSTRAINT [DF_CSPlan_PctEarnBook] DEFAULT ((0)) NOT NULL,
    [PctEarnInvc]     FLOAT (53)    CONSTRAINT [DF_CSPlan_PctEarnInvc] DEFAULT ((0)) NOT NULL,
    [PctEarnOther]    FLOAT (53)    CONSTRAINT [DF_CSPlan_PctEarnOther] DEFAULT ((0)) NOT NULL,
    [PctEarnPmt]      FLOAT (53)    CONSTRAINT [DF_CSPlan_PctEarnPmt] DEFAULT ((0)) NOT NULL,
    [PctEarnShip]     FLOAT (53)    CONSTRAINT [DF_CSPlan_PctEarnShip] DEFAULT ((0)) NOT NULL,
    [PlanID]          CHAR (10)     CONSTRAINT [DF_CSPlan_PlanID] DEFAULT (' ') NOT NULL,
    [Prorated]        SMALLINT      CONSTRAINT [DF_CSPlan_Prorated] DEFAULT ((0)) NOT NULL,
    [RowOption]       CHAR (1)      CONSTRAINT [DF_CSPlan_RowOption] DEFAULT (' ') NOT NULL,
    [S4Future01]      CHAR (30)     CONSTRAINT [DF_CSPlan_S4Future01] DEFAULT (' ') NOT NULL,
    [S4Future02]      CHAR (30)     CONSTRAINT [DF_CSPlan_S4Future02] DEFAULT (' ') NOT NULL,
    [S4Future03]      FLOAT (53)    CONSTRAINT [DF_CSPlan_S4Future03] DEFAULT ((0)) NOT NULL,
    [S4Future04]      FLOAT (53)    CONSTRAINT [DF_CSPlan_S4Future04] DEFAULT ((0)) NOT NULL,
    [S4Future05]      FLOAT (53)    CONSTRAINT [DF_CSPlan_S4Future05] DEFAULT ((0)) NOT NULL,
    [S4Future06]      FLOAT (53)    CONSTRAINT [DF_CSPlan_S4Future06] DEFAULT ((0)) NOT NULL,
    [S4Future07]      SMALLDATETIME CONSTRAINT [DF_CSPlan_S4Future07] DEFAULT ('01/01/1900') NOT NULL,
    [S4Future08]      SMALLDATETIME CONSTRAINT [DF_CSPlan_S4Future08] DEFAULT ('01/01/1900') NOT NULL,
    [S4Future09]      INT           CONSTRAINT [DF_CSPlan_S4Future09] DEFAULT ((0)) NOT NULL,
    [S4Future10]      INT           CONSTRAINT [DF_CSPlan_S4Future10] DEFAULT ((0)) NOT NULL,
    [S4Future11]      CHAR (10)     CONSTRAINT [DF_CSPlan_S4Future11] DEFAULT (' ') NOT NULL,
    [S4Future12]      CHAR (10)     CONSTRAINT [DF_CSPlan_S4Future12] DEFAULT (' ') NOT NULL,
    [User1]           CHAR (30)     CONSTRAINT [DF_CSPlan_User1] DEFAULT (' ') NOT NULL,
    [User10]          SMALLDATETIME CONSTRAINT [DF_CSPlan_User10] DEFAULT ('01/01/1900') NOT NULL,
    [User2]           CHAR (30)     CONSTRAINT [DF_CSPlan_User2] DEFAULT (' ') NOT NULL,
    [User3]           CHAR (30)     CONSTRAINT [DF_CSPlan_User3] DEFAULT (' ') NOT NULL,
    [User4]           CHAR (30)     CONSTRAINT [DF_CSPlan_User4] DEFAULT (' ') NOT NULL,
    [User5]           FLOAT (53)    CONSTRAINT [DF_CSPlan_User5] DEFAULT ((0)) NOT NULL,
    [User6]           FLOAT (53)    CONSTRAINT [DF_CSPlan_User6] DEFAULT ((0)) NOT NULL,
    [User7]           CHAR (10)     CONSTRAINT [DF_CSPlan_User7] DEFAULT (' ') NOT NULL,
    [User8]           CHAR (10)     CONSTRAINT [DF_CSPlan_User8] DEFAULT (' ') NOT NULL,
    [User9]           SMALLDATETIME CONSTRAINT [DF_CSPlan_User9] DEFAULT ('01/01/1900') NOT NULL,
    [tstamp]          ROWVERSION    NOT NULL,
    CONSTRAINT [CSPlan0] PRIMARY KEY CLUSTERED ([PlanID] ASC) WITH (FILLFACTOR = 90)
);

