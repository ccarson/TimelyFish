﻿CREATE TABLE [dbo].[smAgreement] (
    [AgreementDesc]    CHAR (30)     NOT NULL,
    [AgreementTypeID]  CHAR (10)     NOT NULL,
    [Amount]           FLOAT (53)    NOT NULL,
    [BranchID]         CHAR (10)     NOT NULL,
    [CalculateBy]      CHAR (1)      NOT NULL,
    [Capamount]        FLOAT (53)    NOT NULL,
    [CapContract]      CHAR (1)      NOT NULL,
    [CapTolerance]     FLOAT (53)    NOT NULL,
    [CapType]          CHAR (1)      NOT NULL,
    [ContractAcct]     CHAR (10)     NOT NULL,
    [ContractSub]      CHAR (24)     NOT NULL,
    [CpnyID]           CHAR (10)     NOT NULL,
    [Crtd_DateTime]    SMALLDATETIME NOT NULL,
    [Crtd_Prog]        CHAR (8)      NOT NULL,
    [Crtd_User]        CHAR (10)     NOT NULL,
    [CT_ID01]          CHAR (30)     NOT NULL,
    [CT_ID02]          CHAR (30)     NOT NULL,
    [CT_ID03]          CHAR (20)     NOT NULL,
    [CT_ID04]          CHAR (20)     NOT NULL,
    [CT_ID05]          CHAR (10)     NOT NULL,
    [CT_ID06]          CHAR (10)     NOT NULL,
    [CT_ID07]          CHAR (4)      NOT NULL,
    [CT_ID08]          FLOAT (53)    NOT NULL,
    [CT_ID09]          SMALLDATETIME NOT NULL,
    [CT_ID10]          SMALLINT      NOT NULL,
    [CT_ID11]          CHAR (30)     NOT NULL,
    [CT_ID12]          CHAR (30)     NOT NULL,
    [CT_ID13]          CHAR (20)     NOT NULL,
    [CT_ID14]          CHAR (20)     NOT NULL,
    [CT_ID15]          CHAR (10)     NOT NULL,
    [CT_ID16]          CHAR (10)     NOT NULL,
    [CT_ID17]          CHAR (4)      NOT NULL,
    [CT_ID18]          FLOAT (53)    NOT NULL,
    [CT_ID19]          SMALLDATETIME NOT NULL,
    [CT_ID20]          SMALLINT      NOT NULL,
    [DefaultAgrLength] SMALLINT      NOT NULL,
    [DefaultCallType]  CHAR (10)     NOT NULL,
    [FlatRateID]       CHAR (10)     NOT NULL,
    [IncreasePercent]  FLOAT (53)    NOT NULL,
    [LabMarkupID]      CHAR (10)     NOT NULL,
    [LaborPct]         FLOAT (53)    NOT NULL,
    [Lupd_DateTime]    SMALLDATETIME NOT NULL,
    [Lupd_Prog]        CHAR (8)      NOT NULL,
    [Lupd_User]        CHAR (10)     NOT NULL,
    [MarkupID]         CHAR (10)     NOT NULL,
    [MaterialPct]      FLOAT (53)    NOT NULL,
    [MatMarkupID]      CHAR (10)     NOT NULL,
    [NoteId]           INT           NOT NULL,
    [PMFlag]           CHAR (1)      NOT NULL,
    [PMLaborPct]       FLOAT (53)    NOT NULL,
    [PMMaterialPct]    FLOAT (53)    NOT NULL,
    [Priority]         CHAR (1)      NOT NULL,
    [RenewalCode]      CHAR (10)     NOT NULL,
    [RenewalType]      CHAR (2)      NOT NULL,
    [ReserveAcct]      CHAR (10)     NOT NULL,
    [ReserveSub]       CHAR (24)     NOT NULL,
    [SalesAcct]        CHAR (10)     NOT NULL,
    [SalesSub]         CHAR (24)     NOT NULL,
    [ServiceType]      CHAR (1)      NOT NULL,
    [SubFromSite]      SMALLINT      NOT NULL,
    [Taxable]          SMALLINT      NOT NULL,
    [TMDiscount]       FLOAT (53)    NOT NULL,
    [User1]            CHAR (30)     NOT NULL,
    [User2]            CHAR (30)     NOT NULL,
    [User3]            FLOAT (53)    NOT NULL,
    [User4]            FLOAT (53)    NOT NULL,
    [User5]            CHAR (10)     NOT NULL,
    [User6]            CHAR (10)     NOT NULL,
    [User7]            SMALLDATETIME NOT NULL,
    [User8]            SMALLDATETIME NOT NULL,
    [tstamp]           ROWVERSION    NOT NULL,
    CONSTRAINT [smAgreement0] PRIMARY KEY CLUSTERED ([AgreementTypeID] ASC) WITH (FILLFACTOR = 90)
);
