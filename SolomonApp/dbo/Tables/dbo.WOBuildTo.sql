CREATE TABLE [dbo].[WOBuildTo] (
    [Adjustment]     CHAR (1)      CONSTRAINT [DF_WOBuildTo_Adjustment] DEFAULT (' ') NOT NULL,
    [BuildToLineRef] CHAR (5)      CONSTRAINT [DF_WOBuildTo_BuildToLineRef] DEFAULT (' ') NOT NULL,
    [BuildToProj]    CHAR (16)     CONSTRAINT [DF_WOBuildTo_BuildToProj] DEFAULT (' ') NOT NULL,
    [BuildToTask]    CHAR (32)     CONSTRAINT [DF_WOBuildTo_BuildToTask] DEFAULT (' ') NOT NULL,
    [BuildToType]    CHAR (3)      CONSTRAINT [DF_WOBuildTo_BuildToType] DEFAULT (' ') NOT NULL,
    [BuildToWO]      CHAR (16)     CONSTRAINT [DF_WOBuildTo_BuildToWO] DEFAULT (' ') NOT NULL,
    [CnvFact]        FLOAT (53)    CONSTRAINT [DF_WOBuildTo_CnvFact] DEFAULT ((0)) NOT NULL,
    [CpnyID]         CHAR (10)     CONSTRAINT [DF_WOBuildTo_CpnyID] DEFAULT (' ') NOT NULL,
    [Crtd_DateTime]  SMALLDATETIME CONSTRAINT [DF_WOBuildTo_Crtd_DateTime] DEFAULT (rtrim(CONVERT([varchar](30),CONVERT([smalldatetime],getdate(),0),0))) NOT NULL,
    [Crtd_Prog]      CHAR (8)      CONSTRAINT [DF_WOBuildTo_Crtd_Prog] DEFAULT (' ') NOT NULL,
    [Crtd_Time]      SMALLDATETIME CONSTRAINT [DF_WOBuildTo_Crtd_Time] DEFAULT (rtrim(CONVERT([varchar](30),CONVERT([smalldatetime],getdate(),0),0))) NOT NULL,
    [Crtd_User]      CHAR (10)     CONSTRAINT [DF_WOBuildTo_Crtd_User] DEFAULT (' ') NOT NULL,
    [CustID]         CHAR (15)     CONSTRAINT [DF_WOBuildTo_CustID] DEFAULT (' ') NOT NULL,
    [InvtID]         CHAR (30)     CONSTRAINT [DF_WOBuildTo_InvtID] DEFAULT (' ') NOT NULL,
    [LineNbr]        SMALLINT      CONSTRAINT [DF_WOBuildTo_LineNbr] DEFAULT ((0)) NOT NULL,
    [LineRef]        CHAR (5)      CONSTRAINT [DF_WOBuildTo_LineRef] DEFAULT (' ') NOT NULL,
    [LSLineCntr]     SMALLINT      CONSTRAINT [DF_WOBuildTo_LSLineCntr] DEFAULT ((0)) NOT NULL,
    [LUpd_DateTime]  SMALLDATETIME CONSTRAINT [DF_WOBuildTo_LUpd_DateTime] DEFAULT ('01/01/1900') NOT NULL,
    [LUpd_Prog]      CHAR (8)      CONSTRAINT [DF_WOBuildTo_LUpd_Prog] DEFAULT (' ') NOT NULL,
    [LUPd_Time]      SMALLDATETIME CONSTRAINT [DF_WOBuildTo_LUPd_Time] DEFAULT ('01/01/1900') NOT NULL,
    [LUpd_User]      CHAR (10)     CONSTRAINT [DF_WOBuildTo_LUpd_User] DEFAULT (' ') NOT NULL,
    [NoteID]         INT           CONSTRAINT [DF_WOBuildTo_NoteID] DEFAULT ((0)) NOT NULL,
    [OrdNbr]         CHAR (15)     CONSTRAINT [DF_WOBuildTo_OrdNbr] DEFAULT (' ') NOT NULL,
    [QtyComplete]    FLOAT (53)    CONSTRAINT [DF_WOBuildTo_QtyComplete] DEFAULT ((0)) NOT NULL,
    [QtyCompleteOps] FLOAT (53)    CONSTRAINT [DF_WOBuildTo_QtyCompleteOps] DEFAULT ((0)) NOT NULL,
    [QtyCurrent]     FLOAT (53)    CONSTRAINT [DF_WOBuildTo_QtyCurrent] DEFAULT ((0)) NOT NULL,
    [QtyOrig]        FLOAT (53)    CONSTRAINT [DF_WOBuildTo_QtyOrig] DEFAULT ((0)) NOT NULL,
    [QtyQCHold]      FLOAT (53)    CONSTRAINT [DF_WOBuildTo_QtyQCHold] DEFAULT ((0)) NOT NULL,
    [QtyReDirect]    FLOAT (53)    CONSTRAINT [DF_WOBuildTo_QtyReDirect] DEFAULT ((0)) NOT NULL,
    [QtyRemaining]   FLOAT (53)    CONSTRAINT [DF_WOBuildTo_QtyRemaining] DEFAULT ((0)) NOT NULL,
    [QtyRework]      FLOAT (53)    CONSTRAINT [DF_WOBuildTo_QtyRework] DEFAULT ((0)) NOT NULL,
    [QtyReworkComp]  FLOAT (53)    CONSTRAINT [DF_WOBuildTo_QtyReworkComp] DEFAULT ((0)) NOT NULL,
    [QtyScrap]       FLOAT (53)    CONSTRAINT [DF_WOBuildTo_QtyScrap] DEFAULT ((0)) NOT NULL,
    [S4Future01]     CHAR (30)     CONSTRAINT [DF_WOBuildTo_S4Future01] DEFAULT (' ') NOT NULL,
    [S4Future02]     CHAR (30)     CONSTRAINT [DF_WOBuildTo_S4Future02] DEFAULT (' ') NOT NULL,
    [S4Future03]     FLOAT (53)    CONSTRAINT [DF_WOBuildTo_S4Future03] DEFAULT ((0)) NOT NULL,
    [S4Future04]     FLOAT (53)    CONSTRAINT [DF_WOBuildTo_S4Future04] DEFAULT ((0)) NOT NULL,
    [S4Future05]     FLOAT (53)    CONSTRAINT [DF_WOBuildTo_S4Future05] DEFAULT ((0)) NOT NULL,
    [S4Future06]     FLOAT (53)    CONSTRAINT [DF_WOBuildTo_S4Future06] DEFAULT ((0)) NOT NULL,
    [S4Future07]     SMALLDATETIME CONSTRAINT [DF_WOBuildTo_S4Future07] DEFAULT ('01/01/1900') NOT NULL,
    [S4Future08]     SMALLDATETIME CONSTRAINT [DF_WOBuildTo_S4Future08] DEFAULT ('01/01/1900') NOT NULL,
    [S4Future09]     INT           CONSTRAINT [DF_WOBuildTo_S4Future09] DEFAULT ((0)) NOT NULL,
    [S4Future10]     INT           CONSTRAINT [DF_WOBuildTo_S4Future10] DEFAULT ((0)) NOT NULL,
    [S4Future11]     CHAR (10)     CONSTRAINT [DF_WOBuildTo_S4Future11] DEFAULT (' ') NOT NULL,
    [S4Future12]     CHAR (10)     CONSTRAINT [DF_WOBuildTo_S4Future12] DEFAULT (' ') NOT NULL,
    [SiteID]         CHAR (10)     CONSTRAINT [DF_WOBuildTo_SiteID] DEFAULT (' ') NOT NULL,
    [SpecificCostID] CHAR (25)     CONSTRAINT [DF_WOBuildTo_SpecificCostID] DEFAULT (' ') NOT NULL,
    [SrcLineNbr]     SMALLINT      CONSTRAINT [DF_WOBuildTo_SrcLineNbr] DEFAULT ((0)) NOT NULL,
    [SrcLineRef]     CHAR (5)      CONSTRAINT [DF_WOBuildTo_SrcLineRef] DEFAULT (' ') NOT NULL,
    [Status]         CHAR (1)      CONSTRAINT [DF_WOBuildTo_Status] DEFAULT (' ') NOT NULL,
    [TargetDescr]    CHAR (60)     CONSTRAINT [DF_WOBuildTo_TargetDescr] DEFAULT (' ') NOT NULL,
    [UnitDesc]       CHAR (6)      CONSTRAINT [DF_WOBuildTo_UnitDesc] DEFAULT (' ') NOT NULL,
    [User1]          CHAR (30)     CONSTRAINT [DF_WOBuildTo_User1] DEFAULT (' ') NOT NULL,
    [User10]         CHAR (30)     CONSTRAINT [DF_WOBuildTo_User10] DEFAULT (' ') NOT NULL,
    [User2]          CHAR (30)     CONSTRAINT [DF_WOBuildTo_User2] DEFAULT (' ') NOT NULL,
    [User3]          FLOAT (53)    CONSTRAINT [DF_WOBuildTo_User3] DEFAULT ((0)) NOT NULL,
    [User4]          FLOAT (53)    CONSTRAINT [DF_WOBuildTo_User4] DEFAULT ((0)) NOT NULL,
    [User5]          CHAR (10)     CONSTRAINT [DF_WOBuildTo_User5] DEFAULT (' ') NOT NULL,
    [User6]          CHAR (10)     CONSTRAINT [DF_WOBuildTo_User6] DEFAULT (' ') NOT NULL,
    [User7]          SMALLDATETIME CONSTRAINT [DF_WOBuildTo_User7] DEFAULT ('01/01/1900') NOT NULL,
    [User8]          SMALLDATETIME CONSTRAINT [DF_WOBuildTo_User8] DEFAULT ('01/01/1900') NOT NULL,
    [User9]          CHAR (30)     CONSTRAINT [DF_WOBuildTo_User9] DEFAULT (' ') NOT NULL,
    [WhseLoc]        CHAR (10)     CONSTRAINT [DF_WOBuildTo_WhseLoc] DEFAULT (' ') NOT NULL,
    [WONbr]          CHAR (16)     CONSTRAINT [DF_WOBuildTo_WONbr] DEFAULT (' ') NOT NULL,
    [tstamp]         ROWVERSION    NOT NULL,
    CONSTRAINT [WOBuildTo0] PRIMARY KEY CLUSTERED ([WONbr] ASC, [Status] ASC, [LineNbr] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [WOBuildTo1]
    ON [dbo].[WOBuildTo]([InvtID] ASC, [SiteID] ASC, [WONbr] ASC, [Status] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [WOBuildTo2]
    ON [dbo].[WOBuildTo]([CpnyID] ASC, [WONbr] ASC, [LineRef] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [WOBuildTo3]
    ON [dbo].[WOBuildTo]([BuildToWO] ASC, [BuildToLineRef] ASC, [Status] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [WOBuildTo4]
    ON [dbo].[WOBuildTo]([CpnyID] ASC, [OrdNbr] ASC, [BuildToLineRef] ASC, [Status] ASC, [WONbr] ASC) WITH (FILLFACTOR = 90);

