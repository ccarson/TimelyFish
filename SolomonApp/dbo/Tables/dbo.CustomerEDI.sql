﻿CREATE TABLE [dbo].[CustomerEDI] (
    [AgreeNbrFlg]          SMALLINT      CONSTRAINT [DF_CustomerEDI_AgreeNbrFlg] DEFAULT ((0)) NOT NULL,
    [ApptNbrFlg]           SMALLINT      CONSTRAINT [DF_CustomerEDI_ApptNbrFlg] DEFAULT ((0)) NOT NULL,
    [ArrivalDateFlg]       SMALLINT      CONSTRAINT [DF_CustomerEDI_ArrivalDateFlg] DEFAULT ((0)) NOT NULL,
    [BatchNbrFlg]          SMALLINT      CONSTRAINT [DF_CustomerEDI_BatchNbrFlg] DEFAULT ((0)) NOT NULL,
    [BidNbrFlg]            SMALLINT      CONSTRAINT [DF_CustomerEDI_BidNbrFlg] DEFAULT ((0)) NOT NULL,
    [BOLFlg]               SMALLINT      CONSTRAINT [DF_CustomerEDI_BOLFlg] DEFAULT ((0)) NOT NULL,
    [BOLNoteID]            INT           CONSTRAINT [DF_CustomerEDI_BOLNoteID] DEFAULT ((0)) NOT NULL,
    [BOLRptFormat]         CHAR (30)     CONSTRAINT [DF_CustomerEDI_BOLRptFormat] DEFAULT (' ') NOT NULL,
    [BuyerReqd]            SMALLINT      CONSTRAINT [DF_CustomerEDI_BuyerReqd] DEFAULT ((0)) NOT NULL,
    [CertID]               CHAR (2)      CONSTRAINT [DF_CustomerEDI_CertID] DEFAULT (' ') NOT NULL,
    [CheckShipToID]        SMALLINT      CONSTRAINT [DF_CustomerEDI_CheckShipToID] DEFAULT ((0)) NOT NULL,
    [COGSAcct]             CHAR (10)     CONSTRAINT [DF_CustomerEDI_COGSAcct] DEFAULT (' ') NOT NULL,
    [COGSSub]              CHAR (31)     CONSTRAINT [DF_CustomerEDI_COGSSub] DEFAULT (' ') NOT NULL,
    [ContractNbrFlg]       SMALLINT      CONSTRAINT [DF_CustomerEDI_ContractNbrFlg] DEFAULT ((0)) NOT NULL,
    [ContTrackLevel]       CHAR (10)     CONSTRAINT [DF_CustomerEDI_ContTrackLevel] DEFAULT (' ') NOT NULL,
    [CreditMgrID]          CHAR (10)     CONSTRAINT [DF_CustomerEDI_CreditMgrID] DEFAULT (' ') NOT NULL,
    [CreditRule]           CHAR (2)      CONSTRAINT [DF_CustomerEDI_CreditRule] DEFAULT (' ') NOT NULL,
    [CrossDockFlg]         SMALLINT      CONSTRAINT [DF_CustomerEDI_CrossDockFlg] DEFAULT ((0)) NOT NULL,
    [Crtd_DateTime]        SMALLDATETIME CONSTRAINT [DF_CustomerEDI_Crtd_DateTime] DEFAULT (rtrim(CONVERT([varchar](30),CONVERT([smalldatetime],getdate(),0),0))) NOT NULL,
    [Crtd_Prog]            CHAR (8)      CONSTRAINT [DF_CustomerEDI_Crtd_Prog] DEFAULT (' ') NOT NULL,
    [Crtd_User]            CHAR (10)     CONSTRAINT [DF_CustomerEDI_Crtd_User] DEFAULT (' ') NOT NULL,
    [CustCommClassID]      CHAR (10)     CONSTRAINT [DF_CustomerEDI_CustCommClassID] DEFAULT (' ') NOT NULL,
    [CustID]               CHAR (15)     CONSTRAINT [DF_CustomerEDI_CustID] DEFAULT (' ') NOT NULL,
    [CustItemReqd]         SMALLINT      CONSTRAINT [DF_CustomerEDI_CustItemReqd] DEFAULT ((0)) NOT NULL,
    [DeliveryDateFlg]      SMALLINT      CONSTRAINT [DF_CustomerEDI_DeliveryDateFlg] DEFAULT ((0)) NOT NULL,
    [DeptFlg]              SMALLINT      CONSTRAINT [DF_CustomerEDI_DeptFlg] DEFAULT ((0)) NOT NULL,
    [DfltBuyerID]          CHAR (10)     CONSTRAINT [DF_CustomerEDI_DfltBuyerID] DEFAULT (' ') NOT NULL,
    [DiscAcct]             CHAR (10)     CONSTRAINT [DF_CustomerEDI_DiscAcct] DEFAULT (' ') NOT NULL,
    [DiscSub]              CHAR (31)     CONSTRAINT [DF_CustomerEDI_DiscSub] DEFAULT (' ') NOT NULL,
    [DivFlg]               SMALLINT      CONSTRAINT [DF_CustomerEDI_DivFlg] DEFAULT ((0)) NOT NULL,
    [EDSOUser10Flg]        SMALLINT      CONSTRAINT [DF_CustomerEDI_EDSOUser10Flg] DEFAULT ((0)) NOT NULL,
    [EDSOUser1Flg]         SMALLINT      CONSTRAINT [DF_CustomerEDI_EDSOUser1Flg] DEFAULT ((0)) NOT NULL,
    [EDSOUser2Flg]         SMALLINT      CONSTRAINT [DF_CustomerEDI_EDSOUser2Flg] DEFAULT ((0)) NOT NULL,
    [EDSOUser3Flg]         SMALLINT      CONSTRAINT [DF_CustomerEDI_EDSOUser3Flg] DEFAULT ((0)) NOT NULL,
    [EDSOUser4Flg]         SMALLINT      CONSTRAINT [DF_CustomerEDI_EDSOUser4Flg] DEFAULT ((0)) NOT NULL,
    [EDSOUser5Flg]         SMALLINT      CONSTRAINT [DF_CustomerEDI_EDSOUser5Flg] DEFAULT ((0)) NOT NULL,
    [EDSOUser6Flg]         SMALLINT      CONSTRAINT [DF_CustomerEDI_EDSOUser6Flg] DEFAULT ((0)) NOT NULL,
    [EDSOUser7Flg]         SMALLINT      CONSTRAINT [DF_CustomerEDI_EDSOUser7Flg] DEFAULT ((0)) NOT NULL,
    [EDSOUser8Flg]         SMALLINT      CONSTRAINT [DF_CustomerEDI_EDSOUser8Flg] DEFAULT ((0)) NOT NULL,
    [EDSOUser9Flg]         SMALLINT      CONSTRAINT [DF_CustomerEDI_EDSOUser9Flg] DEFAULT ((0)) NOT NULL,
    [EquipNbrFlg]          SMALLINT      CONSTRAINT [DF_CustomerEDI_EquipNbrFlg] DEFAULT ((0)) NOT NULL,
    [FOBFlg]               SMALLINT      CONSTRAINT [DF_CustomerEDI_FOBFlg] DEFAULT ((0)) NOT NULL,
    [FOBID]                CHAR (15)     CONSTRAINT [DF_CustomerEDI_FOBID] DEFAULT (' ') NOT NULL,
    [FOBLocQualFlg]        SMALLINT      CONSTRAINT [DF_CustomerEDI_FOBLocQualFlg] DEFAULT ((0)) NOT NULL,
    [FOBTranTypeFlg]       SMALLINT      CONSTRAINT [DF_CustomerEDI_FOBTranTypeFlg] DEFAULT ((0)) NOT NULL,
    [FrtAcct]              CHAR (10)     CONSTRAINT [DF_CustomerEDI_FrtAcct] DEFAULT (' ') NOT NULL,
    [FrtAllowCd]           CHAR (30)     CONSTRAINT [DF_CustomerEDI_FrtAllowCd] DEFAULT (' ') NOT NULL,
    [FrtDiscCd]            CHAR (30)     CONSTRAINT [DF_CustomerEDI_FrtDiscCd] DEFAULT (' ') NOT NULL,
    [FrtSub]               CHAR (31)     CONSTRAINT [DF_CustomerEDI_FrtSub] DEFAULT (' ') NOT NULL,
    [GeoCode]              CHAR (10)     CONSTRAINT [DF_CustomerEDI_GeoCode] DEFAULT (' ') NOT NULL,
    [GLClassID]            CHAR (4)      CONSTRAINT [DF_CustomerEDI_GLClassID] DEFAULT (' ') NOT NULL,
    [GracePer]             SMALLINT      CONSTRAINT [DF_CustomerEDI_GracePer] DEFAULT ((0)) NOT NULL,
    [GSA]                  SMALLINT      CONSTRAINT [DF_CustomerEDI_GSA] DEFAULT ((0)) NOT NULL,
    [HeightFlg]            SMALLINT      CONSTRAINT [DF_CustomerEDI_HeightFlg] DEFAULT ((0)) NOT NULL,
    [ImpConvMeth]          CHAR (2)      CONSTRAINT [DF_CustomerEDI_ImpConvMeth] DEFAULT (' ') NOT NULL,
    [InternalNoteID]       INT           CONSTRAINT [DF_CustomerEDI_InternalNoteID] DEFAULT ((0)) NOT NULL,
    [IntVendorNbr]         CHAR (30)     CONSTRAINT [DF_CustomerEDI_IntVendorNbr] DEFAULT (' ') NOT NULL,
    [IntVendorNbrFlg]      SMALLINT      CONSTRAINT [DF_CustomerEDI_IntVendorNbrFlg] DEFAULT ((0)) NOT NULL,
    [InvcNoteID]           INT           CONSTRAINT [DF_CustomerEDI_InvcNoteID] DEFAULT ((0)) NOT NULL,
    [LabelReqd]            SMALLINT      CONSTRAINT [DF_CustomerEDI_LabelReqd] DEFAULT ((0)) NOT NULL,
    [LenFlg]               SMALLINT      CONSTRAINT [DF_CustomerEDI_LenFlg] DEFAULT ((0)) NOT NULL,
    [LineItemEDIDiscCode]  CHAR (5)      CONSTRAINT [DF_CustomerEDI_LineItemEDIDiscCode] DEFAULT (' ') NOT NULL,
    [LUpd_DateTime]        SMALLDATETIME CONSTRAINT [DF_CustomerEDI_LUpd_DateTime] DEFAULT ('01/01/1900') NOT NULL,
    [LUpd_Prog]            CHAR (8)      CONSTRAINT [DF_CustomerEDI_LUpd_Prog] DEFAULT (' ') NOT NULL,
    [LUpd_User]            CHAR (10)     CONSTRAINT [DF_CustomerEDI_LUpd_User] DEFAULT (' ') NOT NULL,
    [MajorAccount]         CHAR (15)     CONSTRAINT [DF_CustomerEDI_MajorAccount] DEFAULT (' ') NOT NULL,
    [ManNoteID]            INT           CONSTRAINT [DF_CustomerEDI_ManNoteID] DEFAULT ((0)) NOT NULL,
    [MinOrder]             FLOAT (53)    CONSTRAINT [DF_CustomerEDI_MinOrder] DEFAULT ((0)) NOT NULL,
    [MinWt]                FLOAT (53)    CONSTRAINT [DF_CustomerEDI_MinWt] DEFAULT ((0)) NOT NULL,
    [MiscAcct]             CHAR (10)     CONSTRAINT [DF_CustomerEDI_MiscAcct] DEFAULT (' ') NOT NULL,
    [MiscSub]              CHAR (31)     CONSTRAINT [DF_CustomerEDI_MiscSub] DEFAULT (' ') NOT NULL,
    [MultiDestMeth]        CHAR (3)      CONSTRAINT [DF_CustomerEDI_MultiDestMeth] DEFAULT (' ') NOT NULL,
    [NbrCartonsFlg]        SMALLINT      CONSTRAINT [DF_CustomerEDI_NbrCartonsFlg] DEFAULT ((0)) NOT NULL,
    [NoteID]               INT           CONSTRAINT [DF_CustomerEDI_NoteID] DEFAULT ((0)) NOT NULL,
    [OrigSourceID]         CHAR (10)     CONSTRAINT [DF_CustomerEDI_OrigSourceID] DEFAULT (' ') NOT NULL,
    [OutBndTemplate]       CHAR (20)     CONSTRAINT [DF_CustomerEDI_OutBndTemplate] DEFAULT (' ') NOT NULL,
    [PlanDateFlg]          SMALLINT      CONSTRAINT [DF_CustomerEDI_PlanDateFlg] DEFAULT ((0)) NOT NULL,
    [POReqd]               SMALLINT      CONSTRAINT [DF_CustomerEDI_POReqd] DEFAULT ((0)) NOT NULL,
    [PROFlg]               SMALLINT      CONSTRAINT [DF_CustomerEDI_PROFlg] DEFAULT ((0)) NOT NULL,
    [PromoNbrFlg]          SMALLINT      CONSTRAINT [DF_CustomerEDI_PromoNbrFlg] DEFAULT ((0)) NOT NULL,
    [PSNoteID]             INT           CONSTRAINT [DF_CustomerEDI_PSNoteID] DEFAULT ((0)) NOT NULL,
    [PTNoteID]             INT           CONSTRAINT [DF_CustomerEDI_PTNoteID] DEFAULT ((0)) NOT NULL,
    [QuoteNbrFlg]          SMALLINT      CONSTRAINT [DF_CustomerEDI_QuoteNbrFlg] DEFAULT ((0)) NOT NULL,
    [RegionID]             CHAR (10)     CONSTRAINT [DF_CustomerEDI_RegionID] DEFAULT (' ') NOT NULL,
    [RequestDateFlg]       SMALLINT      CONSTRAINT [DF_CustomerEDI_RequestDateFlg] DEFAULT ((0)) NOT NULL,
    [S4Future01]           CHAR (30)     CONSTRAINT [DF_CustomerEDI_S4Future01] DEFAULT (' ') NOT NULL,
    [S4Future02]           CHAR (30)     CONSTRAINT [DF_CustomerEDI_S4Future02] DEFAULT (' ') NOT NULL,
    [S4Future03]           FLOAT (53)    CONSTRAINT [DF_CustomerEDI_S4Future03] DEFAULT ((0)) NOT NULL,
    [S4Future04]           FLOAT (53)    CONSTRAINT [DF_CustomerEDI_S4Future04] DEFAULT ((0)) NOT NULL,
    [S4Future05]           FLOAT (53)    CONSTRAINT [DF_CustomerEDI_S4Future05] DEFAULT ((0)) NOT NULL,
    [S4Future06]           FLOAT (53)    CONSTRAINT [DF_CustomerEDI_S4Future06] DEFAULT ((0)) NOT NULL,
    [S4Future07]           SMALLDATETIME CONSTRAINT [DF_CustomerEDI_S4Future07] DEFAULT ('01/01/1900') NOT NULL,
    [S4Future08]           SMALLDATETIME CONSTRAINT [DF_CustomerEDI_S4Future08] DEFAULT ('01/01/1900') NOT NULL,
    [S4Future09]           INT           CONSTRAINT [DF_CustomerEDI_S4Future09] DEFAULT ((0)) NOT NULL,
    [S4Future10]           INT           CONSTRAINT [DF_CustomerEDI_S4Future10] DEFAULT ((0)) NOT NULL,
    [S4Future11]           CHAR (10)     CONSTRAINT [DF_CustomerEDI_S4Future11] DEFAULT (' ') NOT NULL,
    [S4Future12]           CHAR (10)     CONSTRAINT [DF_CustomerEDI_S4Future12] DEFAULT (' ') NOT NULL,
    [SalespersonFlg]       SMALLINT      CONSTRAINT [DF_CustomerEDI_SalespersonFlg] DEFAULT ((0)) NOT NULL,
    [SalesRegionFlg]       SMALLINT      CONSTRAINT [DF_CustomerEDI_SalesRegionFlg] DEFAULT ((0)) NOT NULL,
    [SCACFlg]              SMALLINT      CONSTRAINT [DF_CustomerEDI_SCACFlg] DEFAULT ((0)) NOT NULL,
    [ScheduledDateFlg]     SMALLINT      CONSTRAINT [DF_CustomerEDI_ScheduledDateFlg] DEFAULT ((0)) NOT NULL,
    [SDQMarkForFlg]        SMALLINT      CONSTRAINT [DF_CustomerEDI_SDQMarkForFlg] DEFAULT ((0)) NOT NULL,
    [SendZeroInvc]         SMALLINT      CONSTRAINT [DF_CustomerEDI_SendZeroInvc] DEFAULT ((0)) NOT NULL,
    [SepDestOrd]           SMALLINT      CONSTRAINT [DF_CustomerEDI_SepDestOrd] DEFAULT ((0)) NOT NULL,
    [ShipDateFlg]          SMALLINT      CONSTRAINT [DF_CustomerEDI_ShipDateFlg] DEFAULT ((0)) NOT NULL,
    [ShipmentLabel]        CHAR (30)     CONSTRAINT [DF_CustomerEDI_ShipmentLabel] DEFAULT (' ') NOT NULL,
    [ShipMthPayFlg]        SMALLINT      CONSTRAINT [DF_CustomerEDI_ShipMthPayFlg] DEFAULT ((0)) NOT NULL,
    [ShipNBDateFlg]        SMALLINT      CONSTRAINT [DF_CustomerEDI_ShipNBDateFlg] DEFAULT ((0)) NOT NULL,
    [ShipNLDateFlg]        SMALLINT      CONSTRAINT [DF_CustomerEDI_ShipNLDateFlg] DEFAULT ((0)) NOT NULL,
    [ShipToRefNbrFlg]      SMALLINT      CONSTRAINT [DF_CustomerEDI_ShipToRefNbrFlg] DEFAULT ((0)) NOT NULL,
    [ShipViaFlg]           SMALLINT      CONSTRAINT [DF_CustomerEDI_ShipViaFlg] DEFAULT ((0)) NOT NULL,
    [ShipWeekOfFlg]        SMALLINT      CONSTRAINT [DF_CustomerEDI_ShipWeekOfFlg] DEFAULT ((0)) NOT NULL,
    [SingleContainer]      SMALLINT      CONSTRAINT [DF_CustomerEDI_SingleContainer] DEFAULT ((0)) NOT NULL,
    [SiteID]               CHAR (10)     CONSTRAINT [DF_CustomerEDI_SiteID] DEFAULT (' ') NOT NULL,
    [SlsAcct]              CHAR (10)     CONSTRAINT [DF_CustomerEDI_SlsAcct] DEFAULT (' ') NOT NULL,
    [SlsSub]               CHAR (31)     CONSTRAINT [DF_CustomerEDI_SlsSub] DEFAULT (' ') NOT NULL,
    [SOTypeID]             CHAR (4)      CONSTRAINT [DF_CustomerEDI_SOTypeID] DEFAULT (' ') NOT NULL,
    [SOUser10Flg]          SMALLINT      CONSTRAINT [DF_CustomerEDI_SOUser10Flg] DEFAULT ((0)) NOT NULL,
    [SOUser1Flg]           SMALLINT      CONSTRAINT [DF_CustomerEDI_SOUser1Flg] DEFAULT ((0)) NOT NULL,
    [SOUser2Flg]           SMALLINT      CONSTRAINT [DF_CustomerEDI_SOUser2Flg] DEFAULT ((0)) NOT NULL,
    [SOUser3Flg]           SMALLINT      CONSTRAINT [DF_CustomerEDI_SOUser3Flg] DEFAULT ((0)) NOT NULL,
    [SOUser4Flg]           SMALLINT      CONSTRAINT [DF_CustomerEDI_SOUser4Flg] DEFAULT ((0)) NOT NULL,
    [SOUser5Flg]           SMALLINT      CONSTRAINT [DF_CustomerEDI_SOUser5Flg] DEFAULT ((0)) NOT NULL,
    [SOUser6Flg]           SMALLINT      CONSTRAINT [DF_CustomerEDI_SOUser6Flg] DEFAULT ((0)) NOT NULL,
    [SOUser7Flg]           SMALLINT      CONSTRAINT [DF_CustomerEDI_SOUser7Flg] DEFAULT ((0)) NOT NULL,
    [SOUser8Flg]           SMALLINT      CONSTRAINT [DF_CustomerEDI_SOUser8Flg] DEFAULT ((0)) NOT NULL,
    [SOUser9Flg]           SMALLINT      CONSTRAINT [DF_CustomerEDI_SOUser9Flg] DEFAULT ((0)) NOT NULL,
    [SplitPartialLineDisc] SMALLINT      CONSTRAINT [DF_CustomerEDI_SplitPartialLineDisc] DEFAULT ((0)) NOT NULL,
    [SubNbrFlg]            SMALLINT      CONSTRAINT [DF_CustomerEDI_SubNbrFlg] DEFAULT ((0)) NOT NULL,
    [SubstOK]              SMALLINT      CONSTRAINT [DF_CustomerEDI_SubstOK] DEFAULT ((0)) NOT NULL,
    [TerritoryID]          CHAR (10)     CONSTRAINT [DF_CustomerEDI_TerritoryID] DEFAULT (' ') NOT NULL,
    [TrackingNbrFlg]       SMALLINT      CONSTRAINT [DF_CustomerEDI_TrackingNbrFlg] DEFAULT ((0)) NOT NULL,
    [UseEDIPrice]          SMALLINT      CONSTRAINT [DF_CustomerEDI_UseEDIPrice] DEFAULT ((0)) NOT NULL,
    [User1]                CHAR (30)     CONSTRAINT [DF_CustomerEDI_User1] DEFAULT (' ') NOT NULL,
    [User10]               SMALLDATETIME CONSTRAINT [DF_CustomerEDI_User10] DEFAULT ('01/01/1900') NOT NULL,
    [User2]                CHAR (30)     CONSTRAINT [DF_CustomerEDI_User2] DEFAULT (' ') NOT NULL,
    [User3]                CHAR (30)     CONSTRAINT [DF_CustomerEDI_User3] DEFAULT (' ') NOT NULL,
    [User4]                CHAR (30)     CONSTRAINT [DF_CustomerEDI_User4] DEFAULT (' ') NOT NULL,
    [User5]                FLOAT (53)    CONSTRAINT [DF_CustomerEDI_User5] DEFAULT ((0)) NOT NULL,
    [User6]                FLOAT (53)    CONSTRAINT [DF_CustomerEDI_User6] DEFAULT ((0)) NOT NULL,
    [User7]                CHAR (10)     CONSTRAINT [DF_CustomerEDI_User7] DEFAULT (' ') NOT NULL,
    [User8]                CHAR (10)     CONSTRAINT [DF_CustomerEDI_User8] DEFAULT (' ') NOT NULL,
    [User9]                SMALLDATETIME CONSTRAINT [DF_CustomerEDI_User9] DEFAULT ('01/01/1900') NOT NULL,
    [UserNoteID1]          INT           CONSTRAINT [DF_CustomerEDI_UserNoteID1] DEFAULT ((0)) NOT NULL,
    [UserNoteID2]          INT           CONSTRAINT [DF_CustomerEDI_UserNoteID2] DEFAULT ((0)) NOT NULL,
    [UserNoteID3]          INT           CONSTRAINT [DF_CustomerEDI_UserNoteID3] DEFAULT ((0)) NOT NULL,
    [VolumeFlg]            SMALLINT      CONSTRAINT [DF_CustomerEDI_VolumeFlg] DEFAULT ((0)) NOT NULL,
    [WebSite]              CHAR (40)     CONSTRAINT [DF_CustomerEDI_WebSite] DEFAULT (' ') NOT NULL,
    [WeightFlg]            SMALLINT      CONSTRAINT [DF_CustomerEDI_WeightFlg] DEFAULT ((0)) NOT NULL,
    [WholeOrdEDIDiscCode]  CHAR (5)      CONSTRAINT [DF_CustomerEDI_WholeOrdEDIDiscCode] DEFAULT (' ') NOT NULL,
    [WidthFlg]             SMALLINT      CONSTRAINT [DF_CustomerEDI_WidthFlg] DEFAULT ((0)) NOT NULL,
    [tstamp]               ROWVERSION    NOT NULL,
    CONSTRAINT [CustomerEDI0] PRIMARY KEY CLUSTERED ([CustID] ASC) WITH (FILLFACTOR = 90)
);

