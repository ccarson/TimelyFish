﻿CREATE TABLE [dbo].[ED850HeaderExt] (
    [AcctNbr]         CHAR (35)     CONSTRAINT [DF_ED850HeaderExt_AcctNbr] DEFAULT (' ') NOT NULL,
    [AgreeNbr]        CHAR (35)     CONSTRAINT [DF_ED850HeaderExt_AgreeNbr] DEFAULT (' ') NOT NULL,
    [ArrivalDate]     SMALLDATETIME CONSTRAINT [DF_ED850HeaderExt_ArrivalDate] DEFAULT ('01/01/1900') NOT NULL,
    [BatchNbr]        CHAR (35)     CONSTRAINT [DF_ED850HeaderExt_BatchNbr] DEFAULT (' ') NOT NULL,
    [BidNbr]          CHAR (35)     CONSTRAINT [DF_ED850HeaderExt_BidNbr] DEFAULT (' ') NOT NULL,
    [CancelDate]      SMALLDATETIME CONSTRAINT [DF_ED850HeaderExt_CancelDate] DEFAULT ('01/01/1900') NOT NULL,
    [ChangeNbr]       CHAR (35)     CONSTRAINT [DF_ED850HeaderExt_ChangeNbr] DEFAULT (' ') NOT NULL,
    [ContractNbr]     CHAR (35)     CONSTRAINT [DF_ED850HeaderExt_ContractNbr] DEFAULT (' ') NOT NULL,
    [ConvertedDate]   SMALLDATETIME CONSTRAINT [DF_ED850HeaderExt_ConvertedDate] DEFAULT ('01/01/1900') NOT NULL,
    [CpnyID]          CHAR (10)     CONSTRAINT [DF_ED850HeaderExt_CpnyID] DEFAULT (' ') NOT NULL,
    [CreationDate]    SMALLDATETIME CONSTRAINT [DF_ED850HeaderExt_CreationDate] DEFAULT ('01/01/1900') NOT NULL,
    [Crtd_DateTime]   SMALLDATETIME CONSTRAINT [DF_ED850HeaderExt_Crtd_DateTime] DEFAULT (rtrim(CONVERT([varchar](30),CONVERT([smalldatetime],getdate(),0),0))) NOT NULL,
    [Crtd_Prog]       CHAR (8)      CONSTRAINT [DF_ED850HeaderExt_Crtd_Prog] DEFAULT (' ') NOT NULL,
    [Crtd_User]       CHAR (10)     CONSTRAINT [DF_ED850HeaderExt_Crtd_User] DEFAULT (' ') NOT NULL,
    [CurCode]         CHAR (3)      CONSTRAINT [DF_ED850HeaderExt_CurCode] DEFAULT (' ') NOT NULL,
    [CustSalesOrder]  CHAR (30)     CONSTRAINT [DF_ED850HeaderExt_CustSalesOrder] DEFAULT (' ') NOT NULL,
    [DeliveryDate]    SMALLDATETIME CONSTRAINT [DF_ED850HeaderExt_DeliveryDate] DEFAULT ('01/01/1900') NOT NULL,
    [DeptNbr]         CHAR (35)     CONSTRAINT [DF_ED850HeaderExt_DeptNbr] DEFAULT (' ') NOT NULL,
    [DistributorNbr]  CHAR (35)     CONSTRAINT [DF_ED850HeaderExt_DistributorNbr] DEFAULT (' ') NOT NULL,
    [EDIPOID]         CHAR (10)     CONSTRAINT [DF_ED850HeaderExt_EDIPOID] DEFAULT (' ') NOT NULL,
    [EffDate]         SMALLDATETIME CONSTRAINT [DF_ED850HeaderExt_EffDate] DEFAULT ('01/01/1900') NOT NULL,
    [EndCustPackNbr]  CHAR (30)     CONSTRAINT [DF_ED850HeaderExt_EndCustPackNbr] DEFAULT (' ') NOT NULL,
    [EndCustPODate]   SMALLDATETIME CONSTRAINT [DF_ED850HeaderExt_EndCustPODate] DEFAULT ('01/01/1900') NOT NULL,
    [EndCustPONbr]    CHAR (30)     CONSTRAINT [DF_ED850HeaderExt_EndCustPONbr] DEFAULT (' ') NOT NULL,
    [EndCustSONbr]    CHAR (30)     CONSTRAINT [DF_ED850HeaderExt_EndCustSONbr] DEFAULT (' ') NOT NULL,
    [ExchgDate1]      SMALLDATETIME CONSTRAINT [DF_ED850HeaderExt_ExchgDate1] DEFAULT ('01/01/1900') NOT NULL,
    [ExchgDate2]      SMALLDATETIME CONSTRAINT [DF_ED850HeaderExt_ExchgDate2] DEFAULT ('01/01/1900') NOT NULL,
    [ExchgDateQual1]  CHAR (3)      CONSTRAINT [DF_ED850HeaderExt_ExchgDateQual1] DEFAULT (' ') NOT NULL,
    [ExchgDateQual2]  CHAR (3)      CONSTRAINT [DF_ED850HeaderExt_ExchgDateQual2] DEFAULT (' ') NOT NULL,
    [ExchgRate]       FLOAT (53)    CONSTRAINT [DF_ED850HeaderExt_ExchgRate] DEFAULT ((0)) NOT NULL,
    [ExchgTime1]      CHAR (8)      CONSTRAINT [DF_ED850HeaderExt_ExchgTime1] DEFAULT (' ') NOT NULL,
    [ExchgTime2]      CHAR (8)      CONSTRAINT [DF_ED850HeaderExt_ExchgTime2] DEFAULT (' ') NOT NULL,
    [ExpirDate]       SMALLDATETIME CONSTRAINT [DF_ED850HeaderExt_ExpirDate] DEFAULT ('01/01/1900') NOT NULL,
    [GsDate]          SMALLDATETIME CONSTRAINT [DF_ED850HeaderExt_GsDate] DEFAULT ('01/01/1900') NOT NULL,
    [GsNbr]           INT           CONSTRAINT [DF_ED850HeaderExt_GsNbr] DEFAULT ((0)) NOT NULL,
    [GsRcvID]         CHAR (15)     CONSTRAINT [DF_ED850HeaderExt_GsRcvID] DEFAULT (' ') NOT NULL,
    [GsSenderID]      CHAR (15)     CONSTRAINT [DF_ED850HeaderExt_GsSenderID] DEFAULT (' ') NOT NULL,
    [GsTime]          CHAR (8)      CONSTRAINT [DF_ED850HeaderExt_GsTime] DEFAULT (' ') NOT NULL,
    [HashTotal]       FLOAT (53)    CONSTRAINT [DF_ED850HeaderExt_HashTotal] DEFAULT ((0)) NOT NULL,
    [IntchgStandard]  CHAR (1)      CONSTRAINT [DF_ED850HeaderExt_IntchgStandard] DEFAULT (' ') NOT NULL,
    [IntchgTestFlg]   CHAR (1)      CONSTRAINT [DF_ED850HeaderExt_IntchgTestFlg] DEFAULT (' ') NOT NULL,
    [IntchgVersion]   CHAR (5)      CONSTRAINT [DF_ED850HeaderExt_IntchgVersion] DEFAULT (' ') NOT NULL,
    [IntVenNbr]       CHAR (35)     CONSTRAINT [DF_ED850HeaderExt_IntVenNbr] DEFAULT (' ') NOT NULL,
    [IsaNbr]          INT           CONSTRAINT [DF_ED850HeaderExt_IsaNbr] DEFAULT ((0)) NOT NULL,
    [IsaRcvID]        CHAR (15)     CONSTRAINT [DF_ED850HeaderExt_IsaRcvID] DEFAULT (' ') NOT NULL,
    [IsaRcvQual]      CHAR (2)      CONSTRAINT [DF_ED850HeaderExt_IsaRcvQual] DEFAULT (' ') NOT NULL,
    [ISndID]          CHAR (15)     CONSTRAINT [DF_ED850HeaderExt_ISndID] DEFAULT (' ') NOT NULL,
    [ISndQual]        CHAR (2)      CONSTRAINT [DF_ED850HeaderExt_ISndQual] DEFAULT (' ') NOT NULL,
    [Lupd_DateTime]   SMALLDATETIME CONSTRAINT [DF_ED850HeaderExt_Lupd_DateTime] DEFAULT ('01/01/1900') NOT NULL,
    [Lupd_Prog]       CHAR (8)      CONSTRAINT [DF_ED850HeaderExt_Lupd_Prog] DEFAULT (' ') NOT NULL,
    [Lupd_User]       CHAR (10)     CONSTRAINT [DF_ED850HeaderExt_Lupd_User] DEFAULT (' ') NOT NULL,
    [MasterOrderFlag] SMALLINT      CONSTRAINT [DF_ED850HeaderExt_MasterOrderFlag] DEFAULT ((0)) NOT NULL,
    [MultiStore]      SMALLINT      CONSTRAINT [DF_ED850HeaderExt_MultiStore] DEFAULT ((0)) NOT NULL,
    [OrderVolume]     INT           CONSTRAINT [DF_ED850HeaderExt_OrderVolume] DEFAULT ((0)) NOT NULL,
    [OrderVolumeUOM]  CHAR (6)      CONSTRAINT [DF_ED850HeaderExt_OrderVolumeUOM] DEFAULT (' ') NOT NULL,
    [OrderWeight]     INT           CONSTRAINT [DF_ED850HeaderExt_OrderWeight] DEFAULT ((0)) NOT NULL,
    [OrderWeightUOM]  CHAR (6)      CONSTRAINT [DF_ED850HeaderExt_OrderWeightUOM] DEFAULT (' ') NOT NULL,
    [PODate]          SMALLDATETIME CONSTRAINT [DF_ED850HeaderExt_PODate] DEFAULT ('01/01/1900') NOT NULL,
    [POSuff]          CHAR (35)     CONSTRAINT [DF_ED850HeaderExt_POSuff] DEFAULT (' ') NOT NULL,
    [PrintDate]       SMALLDATETIME CONSTRAINT [DF_ED850HeaderExt_PrintDate] DEFAULT ('01/01/1900') NOT NULL,
    [PromoEndDate]    SMALLDATETIME CONSTRAINT [DF_ED850HeaderExt_PromoEndDate] DEFAULT ('01/01/1900') NOT NULL,
    [PromoNbr]        CHAR (35)     CONSTRAINT [DF_ED850HeaderExt_PromoNbr] DEFAULT (' ') NOT NULL,
    [PromoStartDate]  SMALLDATETIME CONSTRAINT [DF_ED850HeaderExt_PromoStartDate] DEFAULT ('01/01/1900') NOT NULL,
    [PurReqNbr]       CHAR (35)     CONSTRAINT [DF_ED850HeaderExt_PurReqNbr] DEFAULT (' ') NOT NULL,
    [QuoteNbr]        CHAR (35)     CONSTRAINT [DF_ED850HeaderExt_QuoteNbr] DEFAULT (' ') NOT NULL,
    [RequestDate]     SMALLDATETIME CONSTRAINT [DF_ED850HeaderExt_RequestDate] DEFAULT ('01/01/1900') NOT NULL,
    [S4Future01]      CHAR (30)     CONSTRAINT [DF_ED850HeaderExt_S4Future01] DEFAULT (' ') NOT NULL,
    [S4Future02]      CHAR (30)     CONSTRAINT [DF_ED850HeaderExt_S4Future02] DEFAULT (' ') NOT NULL,
    [S4Future03]      FLOAT (53)    CONSTRAINT [DF_ED850HeaderExt_S4Future03] DEFAULT ((0)) NOT NULL,
    [S4Future04]      FLOAT (53)    CONSTRAINT [DF_ED850HeaderExt_S4Future04] DEFAULT ((0)) NOT NULL,
    [S4Future05]      FLOAT (53)    CONSTRAINT [DF_ED850HeaderExt_S4Future05] DEFAULT ((0)) NOT NULL,
    [S4Future06]      FLOAT (53)    CONSTRAINT [DF_ED850HeaderExt_S4Future06] DEFAULT ((0)) NOT NULL,
    [S4Future07]      SMALLDATETIME CONSTRAINT [DF_ED850HeaderExt_S4Future07] DEFAULT ('01/01/1900') NOT NULL,
    [S4Future08]      SMALLDATETIME CONSTRAINT [DF_ED850HeaderExt_S4Future08] DEFAULT ('01/01/1900') NOT NULL,
    [S4Future09]      INT           CONSTRAINT [DF_ED850HeaderExt_S4Future09] DEFAULT ((0)) NOT NULL,
    [S4Future10]      INT           CONSTRAINT [DF_ED850HeaderExt_S4Future10] DEFAULT ((0)) NOT NULL,
    [S4Future11]      CHAR (10)     CONSTRAINT [DF_ED850HeaderExt_S4Future11] DEFAULT (' ') NOT NULL,
    [S4Future12]      CHAR (10)     CONSTRAINT [DF_ED850HeaderExt_S4Future12] DEFAULT (' ') NOT NULL,
    [SalesDivision]   CHAR (30)     CONSTRAINT [DF_ED850HeaderExt_SalesDivision] DEFAULT (' ') NOT NULL,
    [Salesman]        CHAR (30)     CONSTRAINT [DF_ED850HeaderExt_Salesman] DEFAULT (' ') NOT NULL,
    [SalesRegion]     CHAR (30)     CONSTRAINT [DF_ED850HeaderExt_SalesRegion] DEFAULT (' ') NOT NULL,
    [SalesTerritory]  CHAR (30)     CONSTRAINT [DF_ED850HeaderExt_SalesTerritory] DEFAULT (' ') NOT NULL,
    [ScheduleDate]    SMALLDATETIME CONSTRAINT [DF_ED850HeaderExt_ScheduleDate] DEFAULT ('01/01/1900') NOT NULL,
    [ShipDate]        SMALLDATETIME CONSTRAINT [DF_ED850HeaderExt_ShipDate] DEFAULT ('01/01/1900') NOT NULL,
    [ShipNBDate]      SMALLDATETIME CONSTRAINT [DF_ED850HeaderExt_ShipNBDate] DEFAULT ('01/01/1900') NOT NULL,
    [ShipNLDate]      SMALLDATETIME CONSTRAINT [DF_ED850HeaderExt_ShipNLDate] DEFAULT ('01/01/1900') NOT NULL,
    [ShipWeekOf]      SMALLDATETIME CONSTRAINT [DF_ED850HeaderExt_ShipWeekOf] DEFAULT ('01/01/1900') NOT NULL,
    [Standard]        CHAR (2)      CONSTRAINT [DF_ED850HeaderExt_Standard] DEFAULT (' ') NOT NULL,
    [StNbr]           INT           CONSTRAINT [DF_ED850HeaderExt_StNbr] DEFAULT ((0)) NOT NULL,
    [TaxExemptCode]   CHAR (1)      CONSTRAINT [DF_ED850HeaderExt_TaxExemptCode] DEFAULT (' ') NOT NULL,
    [TaxID]           CHAR (20)     CONSTRAINT [DF_ED850HeaderExt_TaxID] DEFAULT (' ') NOT NULL,
    [TaxLocation]     CHAR (30)     CONSTRAINT [DF_ED850HeaderExt_TaxLocation] DEFAULT (' ') NOT NULL,
    [TaxLocQual]      CHAR (2)      CONSTRAINT [DF_ED850HeaderExt_TaxLocQual] DEFAULT (' ') NOT NULL,
    [TransmitDate]    SMALLDATETIME CONSTRAINT [DF_ED850HeaderExt_TransmitDate] DEFAULT ('01/01/1900') NOT NULL,
    [TransmitTime]    CHAR (8)      CONSTRAINT [DF_ED850HeaderExt_TransmitTime] DEFAULT (' ') NOT NULL,
    [User1]           CHAR (30)     CONSTRAINT [DF_ED850HeaderExt_User1] DEFAULT (' ') NOT NULL,
    [User10]          SMALLDATETIME CONSTRAINT [DF_ED850HeaderExt_User10] DEFAULT ('01/01/1900') NOT NULL,
    [User2]           CHAR (30)     CONSTRAINT [DF_ED850HeaderExt_User2] DEFAULT (' ') NOT NULL,
    [User3]           CHAR (30)     CONSTRAINT [DF_ED850HeaderExt_User3] DEFAULT (' ') NOT NULL,
    [User4]           CHAR (30)     CONSTRAINT [DF_ED850HeaderExt_User4] DEFAULT (' ') NOT NULL,
    [User5]           FLOAT (53)    CONSTRAINT [DF_ED850HeaderExt_User5] DEFAULT ((0)) NOT NULL,
    [User6]           FLOAT (53)    CONSTRAINT [DF_ED850HeaderExt_User6] DEFAULT ((0)) NOT NULL,
    [User7]           CHAR (10)     CONSTRAINT [DF_ED850HeaderExt_User7] DEFAULT (' ') NOT NULL,
    [User8]           CHAR (10)     CONSTRAINT [DF_ED850HeaderExt_User8] DEFAULT (' ') NOT NULL,
    [User9]           SMALLDATETIME CONSTRAINT [DF_ED850HeaderExt_User9] DEFAULT ('01/01/1900') NOT NULL,
    [Version]         CHAR (12)     CONSTRAINT [DF_ED850HeaderExt_Version] DEFAULT (' ') NOT NULL,
    [WONbr]           CHAR (30)     CONSTRAINT [DF_ED850HeaderExt_WONbr] DEFAULT (' ') NOT NULL,
    [tstamp]          ROWVERSION    NOT NULL,
    CONSTRAINT [ED850HeaderExt0] PRIMARY KEY CLUSTERED ([CpnyID] ASC, [EDIPOID] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [ED850HeaderExt1]
    ON [dbo].[ED850HeaderExt]([EDIPOID] ASC) WITH (FILLFACTOR = 90);

