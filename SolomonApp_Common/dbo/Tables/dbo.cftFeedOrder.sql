CREATE TABLE [dbo].[cftFeedOrder] (
    [AvgWgt]            FLOAT (53)    NOT NULL,
    [BarnNbr]           CHAR (6)      NOT NULL,
    [BatNbrAP]          CHAR (10)     NOT NULL,
    [BatNbrGL]          CHAR (10)     NOT NULL,
    [BatNbrIN]          CHAR (10)     NOT NULL,
    [BinNbr]            CHAR (6)      NOT NULL,
    [CF01]              CHAR (30)     NOT NULL,
    [CF02]              CHAR (30)     NOT NULL,
    [CF03]              CHAR (10)     NOT NULL,
    [CF04]              CHAR (10)     NOT NULL,
    [CF05]              SMALLDATETIME NOT NULL,
    [CF06]              SMALLDATETIME NOT NULL,
    [CF07]              INT           NOT NULL,
    [CF08]              INT           NOT NULL,
    [CF09]              SMALLINT      NOT NULL,
    [CF10]              SMALLINT      NOT NULL,
    [CF11]              FLOAT (53)    NOT NULL,
    [CF12]              FLOAT (53)    NOT NULL,
    [CnvFactDel]        FLOAT (53)    NOT NULL,
    [CnvFactOrd]        FLOAT (53)    NOT NULL,
    [Comment]           CHAR (30)     NOT NULL,
    [CommentId]         CHAR (5)      NOT NULL,
    [ContactId]         CHAR (6)      NOT NULL,
    [ContAddrId]        CHAR (6)      NOT NULL,
    [CpnyId]            CHAR (10)     NOT NULL,
    [Crtd_DateTime]     SMALLDATETIME NOT NULL,
    [Crtd_Prog]         CHAR (8)      NOT NULL,
    [Crtd_User]         CHAR (10)     NOT NULL,
    [DateDel]           SMALLDATETIME NOT NULL,
    [DateOrd]           SMALLDATETIME NOT NULL,
    [DateReq]           SMALLDATETIME NOT NULL,
    [DateSched]         SMALLDATETIME NOT NULL,
    [DaysIn]            SMALLINT      NOT NULL,
    [FarmTentative]     SMALLINT      NOT NULL,
    [FeedPlanId]        CHAR (4)      NOT NULL,
    [InvtIdDel]         CHAR (30)     NOT NULL,
    [InvtIdDflt]        CHAR (30)     NOT NULL,
    [InvtIdOrd]         CHAR (30)     NOT NULL,
    [LoadNbr]           CHAR (6)      NOT NULL,
    [Lupd_DateTime]     SMALLDATETIME NOT NULL,
    [Lupd_Prog]         CHAR (8)      NOT NULL,
    [Lupd_User]         CHAR (10)     NOT NULL,
    [MillAddrId]        CHAR (6)      NOT NULL,
    [MillId]            CHAR (6)      NOT NULL,
    [NoteId]            INT           NOT NULL,
    [OrdNbr]            CHAR (10)     NOT NULL,
    [OrdType]           CHAR (2)      NOT NULL,
    [PGQty]             INT           NOT NULL,
    [PigGroupId]        CHAR (10)     NOT NULL,
    [Priority]          CHAR (10)     NOT NULL,
    [Project]           CHAR (16)     NOT NULL,
    [PrtByUser]         CHAR (10)     NOT NULL,
    [PrtFlg]            SMALLINT      NOT NULL,
    [PrtRptFormat]      CHAR (10)     NOT NULL,
    [QtyDel]            FLOAT (53)    NOT NULL,
    [QtyOrd]            FLOAT (53)    NOT NULL,
    [RelOrdNbr]         CHAR (10)     NOT NULL,
    [Reversal]          SMALLINT      NOT NULL,
    [RoomNbr]           CHAR (10)     NOT NULL,
    [SrcOrdNbr]         CHAR (10)     NOT NULL,
    [StageDflt]         SMALLINT      NOT NULL,
    [StageOrd]          SMALLINT      NOT NULL,
    [Status]            CHAR (1)      NOT NULL,
    [TaskId]            CHAR (32)     NOT NULL,
    [UOMDel]            CHAR (6)      NOT NULL,
    [UOMOrd]            CHAR (6)      NOT NULL,
    [User1]             CHAR (30)     NOT NULL,
    [User2]             CHAR (30)     NOT NULL,
    [User3]             FLOAT (53)    NOT NULL,
    [User4]             FLOAT (53)    NOT NULL,
    [User5]             CHAR (10)     NOT NULL,
    [User6]             CHAR (10)     NOT NULL,
    [User7]             SMALLDATETIME NOT NULL,
    [User8]             INT           NOT NULL,
    [UsingGroupActFlag] SMALLINT      NOT NULL,
    [WithdrawalDays]    SMALLINT      NOT NULL,
    [WithdrawalFlg]     SMALLINT      NOT NULL,
    [tstamp]            ROWVERSION    NULL,
    CONSTRAINT [PK_cftFeedOrder] PRIMARY KEY NONCLUSTERED ([OrdNbr] ASC) WITH (FILLFACTOR = 100)
);


GO
CREATE UNIQUE CLUSTERED INDEX [cftFeedOrder0]
    ON [dbo].[cftFeedOrder]([OrdNbr] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [cftFeedOrder_piggroup]
    ON [dbo].[cftFeedOrder]([PigGroupId] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [cftFeedorderQty]
    ON [dbo].[cftFeedOrder]([PigGroupId] ASC, [QtyOrd] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [cftFeedOrder_OrdType]
    ON [dbo].[cftFeedOrder]([OrdType] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [cftFeedOrder_ContactID]
    ON [dbo].[cftFeedOrder]([ContactId] ASC)
    INCLUDE([MillId], [OrdNbr], [Status], [CF09], [DateReq]) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [idx_cftFeedOrder_XF185]
    ON [dbo].[cftFeedOrder]([DateSched] ASC, [ContactId] ASC, [CpnyId] ASC, [MillId] ASC);


GO
CREATE NONCLUSTERED INDEX [cftFeedOrderLoads]
    ON [dbo].[cftFeedOrder]([CF09] ASC)
    INCLUDE([DateReq], [MillId], [ContactId], [Status], [OrdType], [CommentId]) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [idx_cftFeedOrder_XF211]
    ON [dbo].[cftFeedOrder]([CF09] ASC, [DateReq] ASC, [MillId] ASC, [ContactId] ASC);


GO
CREATE NONCLUSTERED INDEX [idx_cftFeedOrder_Paging]
    ON [dbo].[cftFeedOrder]([OrdNbr] ASC)
    INCLUDE([BinNbr], [CF03], [ContactId], [DateOrd], [InvtIdOrd], [OrdType], [Status]);


GO
CREATE NONCLUSTERED INDEX [cftFeedOrderDateDel]
    ON [dbo].[cftFeedOrder]([BinNbr] ASC, [ContactId] ASC, [DateDel] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [cftFeedOrder_DateSched]
    ON [dbo].[cftFeedOrder]([DateSched] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [cftFeedOrder_MillID]
    ON [dbo].[cftFeedOrder]([MillId] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [cftFeedOrder_PrtFlag]
    ON [dbo].[cftFeedOrder]([PrtFlg] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [idx_cftFeedOrder_XF305]
    ON [dbo].[cftFeedOrder]([ContactId] ASC, [OrdNbr] ASC)
    INCLUDE([Status]) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [cftFeedOrder_Status]
    ON [dbo].[cftFeedOrder]([Status] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [cftfeedorder_invtidord_rev_incl]
    ON [dbo].[cftFeedOrder]([InvtIdOrd] ASC, [Reversal] ASC)
    INCLUDE([BinNbr], [ContactId], [ContAddrId], [DateOrd], [PigGroupId], [StageOrd], [BarnNbr], [tstamp]) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [idx_cftfeedorder_xf145]
    ON [dbo].[cftFeedOrder]([InvtIdOrd] ASC, [DateOrd] ASC)
    INCLUDE([BarnNbr], [BinNbr], [ContactId], [PigGroupId], [StageOrd]) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [idx_cftfeedorder_datereq_incl]
    ON [dbo].[cftFeedOrder]([DateReq] ASC)
    INCLUDE([Comment], [ContactId], [MillId], [OrdNbr], [OrdType], [PigGroupId], [BinNbr], [CF10], [QtyOrd], [Status], [Priority]) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [idx_cftfeedorder_PFOS_feedplan]
    ON [dbo].[cftFeedOrder]([FeedPlanId] ASC, [PrtFlg] ASC, [Status] ASC, [OrdType] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [idx_cftFeedOrder_XF122]
    ON [dbo].[cftFeedOrder]([RelOrdNbr] ASC);

