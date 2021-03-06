﻿CREATE TABLE [dbo].[EDPackIndicator] (
    [ContainerQty]  INT           CONSTRAINT [DF_EDPackIndicator_ContainerQty] DEFAULT ((0)) NOT NULL,
    [Crtd_DateTime] SMALLDATETIME CONSTRAINT [DF_EDPackIndicator_Crtd_DateTime] DEFAULT (rtrim(CONVERT([varchar](30),CONVERT([smalldatetime],getdate(),0),0))) NOT NULL,
    [Crtd_Prog]     CHAR (8)      CONSTRAINT [DF_EDPackIndicator_Crtd_Prog] DEFAULT (' ') NOT NULL,
    [Crtd_User]     CHAR (10)     CONSTRAINT [DF_EDPackIndicator_Crtd_User] DEFAULT (' ') NOT NULL,
    [Description]   CHAR (30)     CONSTRAINT [DF_EDPackIndicator_Description] DEFAULT (' ') NOT NULL,
    [IndicatorType] SMALLINT      CONSTRAINT [DF_EDPackIndicator_IndicatorType] DEFAULT ((0)) NOT NULL,
    [InvtID]        CHAR (30)     CONSTRAINT [DF_EDPackIndicator_InvtID] DEFAULT (' ') NOT NULL,
    [Lupd_DateTime] SMALLDATETIME CONSTRAINT [DF_EDPackIndicator_Lupd_DateTime] DEFAULT ('01/01/1900') NOT NULL,
    [Lupd_Prog]     CHAR (8)      CONSTRAINT [DF_EDPackIndicator_Lupd_Prog] DEFAULT (' ') NOT NULL,
    [Lupd_User]     CHAR (10)     CONSTRAINT [DF_EDPackIndicator_Lupd_User] DEFAULT (' ') NOT NULL,
    [PackIndicator] CHAR (1)      CONSTRAINT [DF_EDPackIndicator_PackIndicator] DEFAULT (' ') NOT NULL,
    [S4Future01]    CHAR (30)     CONSTRAINT [DF_EDPackIndicator_S4Future01] DEFAULT (' ') NOT NULL,
    [S4Future02]    CHAR (30)     CONSTRAINT [DF_EDPackIndicator_S4Future02] DEFAULT (' ') NOT NULL,
    [S4Future03]    FLOAT (53)    CONSTRAINT [DF_EDPackIndicator_S4Future03] DEFAULT ((0)) NOT NULL,
    [S4Future04]    FLOAT (53)    CONSTRAINT [DF_EDPackIndicator_S4Future04] DEFAULT ((0)) NOT NULL,
    [S4Future05]    FLOAT (53)    CONSTRAINT [DF_EDPackIndicator_S4Future05] DEFAULT ((0)) NOT NULL,
    [S4Future06]    FLOAT (53)    CONSTRAINT [DF_EDPackIndicator_S4Future06] DEFAULT ((0)) NOT NULL,
    [S4Future07]    SMALLDATETIME CONSTRAINT [DF_EDPackIndicator_S4Future07] DEFAULT ('01/01/1900') NOT NULL,
    [S4Future08]    SMALLDATETIME CONSTRAINT [DF_EDPackIndicator_S4Future08] DEFAULT ('01/01/1900') NOT NULL,
    [S4Future09]    INT           CONSTRAINT [DF_EDPackIndicator_S4Future09] DEFAULT ((0)) NOT NULL,
    [S4Future10]    INT           CONSTRAINT [DF_EDPackIndicator_S4Future10] DEFAULT ((0)) NOT NULL,
    [S4Future11]    CHAR (10)     CONSTRAINT [DF_EDPackIndicator_S4Future11] DEFAULT (' ') NOT NULL,
    [S4Future12]    CHAR (10)     CONSTRAINT [DF_EDPackIndicator_S4Future12] DEFAULT (' ') NOT NULL,
    [User1]         CHAR (30)     CONSTRAINT [DF_EDPackIndicator_User1] DEFAULT (' ') NOT NULL,
    [User10]        SMALLDATETIME CONSTRAINT [DF_EDPackIndicator_User10] DEFAULT ('01/01/1900') NOT NULL,
    [User2]         CHAR (30)     CONSTRAINT [DF_EDPackIndicator_User2] DEFAULT (' ') NOT NULL,
    [User3]         CHAR (30)     CONSTRAINT [DF_EDPackIndicator_User3] DEFAULT (' ') NOT NULL,
    [User4]         CHAR (30)     CONSTRAINT [DF_EDPackIndicator_User4] DEFAULT (' ') NOT NULL,
    [User5]         FLOAT (53)    CONSTRAINT [DF_EDPackIndicator_User5] DEFAULT ((0)) NOT NULL,
    [User6]         FLOAT (53)    CONSTRAINT [DF_EDPackIndicator_User6] DEFAULT ((0)) NOT NULL,
    [User7]         SMALLDATETIME CONSTRAINT [DF_EDPackIndicator_User7] DEFAULT ('01/01/1900') NOT NULL,
    [User8]         CHAR (10)     CONSTRAINT [DF_EDPackIndicator_User8] DEFAULT (' ') NOT NULL,
    [User9]         SMALLDATETIME CONSTRAINT [DF_EDPackIndicator_User9] DEFAULT ('01/01/1900') NOT NULL,
    [tstamp]        ROWVERSION    NOT NULL,
    CONSTRAINT [EDPackIndicator0] PRIMARY KEY CLUSTERED ([IndicatorType] ASC, [InvtID] ASC, [PackIndicator] ASC) WITH (FILLFACTOR = 90)
);

