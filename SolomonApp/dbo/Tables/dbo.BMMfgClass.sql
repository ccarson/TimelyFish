﻿CREATE TABLE [dbo].[BMMfgClass] (
    [CFMtlOvhRate]  FLOAT (53)    CONSTRAINT [DF_BMMfgClass_CFMtlOvhRate] DEFAULT ((0)) NOT NULL,
    [CMtlOvhRate]   FLOAT (53)    CONSTRAINT [DF_BMMfgClass_CMtlOvhRate] DEFAULT ((0)) NOT NULL,
    [CVMtlOvhRate]  FLOAT (53)    CONSTRAINT [DF_BMMfgClass_CVMtlOvhRate] DEFAULT ((0)) NOT NULL,
    [Crtd_DateTime] SMALLDATETIME CONSTRAINT [DF_BMMfgClass_Crtd_DateTime] DEFAULT (rtrim(CONVERT([varchar](30),CONVERT([smalldatetime],getdate(),0),0))) NOT NULL,
    [Crtd_Prog]     CHAR (8)      CONSTRAINT [DF_BMMfgClass_Crtd_Prog] DEFAULT (' ') NOT NULL,
    [Crtd_User]     CHAR (10)     CONSTRAINT [DF_BMMfgClass_Crtd_User] DEFAULT (' ') NOT NULL,
    [Descr]         CHAR (30)     CONSTRAINT [DF_BMMfgClass_Descr] DEFAULT (' ') NOT NULL,
    [DirectMtlAC]   CHAR (16)     CONSTRAINT [DF_BMMfgClass_DirectMtlAC] DEFAULT (' ') NOT NULL,
    [LUpd_DateTime] SMALLDATETIME CONSTRAINT [DF_BMMfgClass_LUpd_DateTime] DEFAULT ('01/01/1900') NOT NULL,
    [LUpd_Prog]     CHAR (8)      CONSTRAINT [DF_BMMfgClass_LUpd_Prog] DEFAULT (' ') NOT NULL,
    [LUpd_User]     CHAR (10)     CONSTRAINT [DF_BMMfgClass_LUpd_User] DEFAULT (' ') NOT NULL,
    [MfgClassID]    CHAR (10)     CONSTRAINT [DF_BMMfgClass_MfgClassID] DEFAULT (' ') NOT NULL,
    [NoteID]        INT           CONSTRAINT [DF_BMMfgClass_NoteID] DEFAULT ((0)) NOT NULL,
    [OvhMtlFixedAC] CHAR (16)     CONSTRAINT [DF_BMMfgClass_OvhMtlFixedAC] DEFAULT (' ') NOT NULL,
    [OvhMtlVarAC]   CHAR (16)     CONSTRAINT [DF_BMMfgClass_OvhMtlVarAC] DEFAULT (' ') NOT NULL,
    [PFMtlOvhRate]  FLOAT (53)    CONSTRAINT [DF_BMMfgClass_PFMtlOvhRate] DEFAULT ((0)) NOT NULL,
    [PMtlOvhRate]   FLOAT (53)    CONSTRAINT [DF_BMMfgClass_PMtlOvhRate] DEFAULT ((0)) NOT NULL,
    [PVMtlOvhRate]  FLOAT (53)    CONSTRAINT [DF_BMMfgClass_PVMtlOvhRate] DEFAULT ((0)) NOT NULL,
    [S4Future01]    CHAR (30)     CONSTRAINT [DF_BMMfgClass_S4Future01] DEFAULT (' ') NOT NULL,
    [S4Future02]    CHAR (30)     CONSTRAINT [DF_BMMfgClass_S4Future02] DEFAULT (' ') NOT NULL,
    [S4Future03]    FLOAT (53)    CONSTRAINT [DF_BMMfgClass_S4Future03] DEFAULT ((0)) NOT NULL,
    [S4Future04]    FLOAT (53)    CONSTRAINT [DF_BMMfgClass_S4Future04] DEFAULT ((0)) NOT NULL,
    [S4Future05]    FLOAT (53)    CONSTRAINT [DF_BMMfgClass_S4Future05] DEFAULT ((0)) NOT NULL,
    [S4Future06]    FLOAT (53)    CONSTRAINT [DF_BMMfgClass_S4Future06] DEFAULT ((0)) NOT NULL,
    [S4Future07]    SMALLDATETIME CONSTRAINT [DF_BMMfgClass_S4Future07] DEFAULT ('01/01/1900') NOT NULL,
    [S4Future08]    SMALLDATETIME CONSTRAINT [DF_BMMfgClass_S4Future08] DEFAULT ('01/01/1900') NOT NULL,
    [S4Future09]    INT           CONSTRAINT [DF_BMMfgClass_S4Future09] DEFAULT ((0)) NOT NULL,
    [S4Future10]    INT           CONSTRAINT [DF_BMMfgClass_S4Future10] DEFAULT ((0)) NOT NULL,
    [S4Future11]    CHAR (10)     CONSTRAINT [DF_BMMfgClass_S4Future11] DEFAULT (' ') NOT NULL,
    [S4Future12]    CHAR (10)     CONSTRAINT [DF_BMMfgClass_S4Future12] DEFAULT (' ') NOT NULL,
    [User1]         CHAR (30)     CONSTRAINT [DF_BMMfgClass_User1] DEFAULT (' ') NOT NULL,
    [User10]        CHAR (30)     CONSTRAINT [DF_BMMfgClass_User10] DEFAULT (' ') NOT NULL,
    [User2]         CHAR (30)     CONSTRAINT [DF_BMMfgClass_User2] DEFAULT (' ') NOT NULL,
    [User3]         FLOAT (53)    CONSTRAINT [DF_BMMfgClass_User3] DEFAULT ((0)) NOT NULL,
    [User4]         FLOAT (53)    CONSTRAINT [DF_BMMfgClass_User4] DEFAULT ((0)) NOT NULL,
    [User5]         CHAR (10)     CONSTRAINT [DF_BMMfgClass_User5] DEFAULT (' ') NOT NULL,
    [User6]         CHAR (10)     CONSTRAINT [DF_BMMfgClass_User6] DEFAULT (' ') NOT NULL,
    [User7]         SMALLDATETIME CONSTRAINT [DF_BMMfgClass_User7] DEFAULT ('01/01/1900') NOT NULL,
    [User8]         SMALLDATETIME CONSTRAINT [DF_BMMfgClass_User8] DEFAULT ('01/01/1900') NOT NULL,
    [User9]         CHAR (30)     CONSTRAINT [DF_BMMfgClass_User9] DEFAULT (' ') NOT NULL,
    [tstamp]        ROWVERSION    NOT NULL,
    CONSTRAINT [BMMfgClass0] PRIMARY KEY CLUSTERED ([MfgClassID] ASC) WITH (FILLFACTOR = 90)
);

