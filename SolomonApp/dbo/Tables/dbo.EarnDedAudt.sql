﻿CREATE TABLE [dbo].[EarnDedAudt] (
    [AddlCrAmt]     FLOAT (53)    NOT NULL,
    [AddlExmptAmt]  FLOAT (53)    NOT NULL,
    [ArrgEmpAllow]  SMALLINT      NOT NULL,
    [AudtDate]      CHAR (25)     NOT NULL,
    [AudtDateSort]  CHAR (25)     NOT NULL,
    [CalMaxYtdDed]  FLOAT (53)    NOT NULL,
    [CalYr]         CHAR (4)      NOT NULL,
    [Comment]       CHAR (100)    NOT NULL,
    [CpnyID]        CHAR (10)     NOT NULL,
    [Crtd_DateTime] SMALLDATETIME NOT NULL,
    [Crtd_Prog]     CHAR (8)      NOT NULL,
    [Crtd_User]     CHAR (10)     NOT NULL,
    [DedSequence]   SMALLINT      NOT NULL,
    [EarnDedId]     CHAR (10)     NOT NULL,
    [EarnDedType]   CHAR (1)      NOT NULL,
    [EDType]        CHAR (1)      NOT NULL,
    [EmpId]         CHAR (10)     NOT NULL,
    [Exmpt]         SMALLINT      NOT NULL,
    [FxdPctRate]    FLOAT (53)    NOT NULL,
    [LUpd_DateTime] SMALLDATETIME NOT NULL,
    [LUpd_Prog]     CHAR (8)      NOT NULL,
    [LUpd_User]     CHAR (10)     NOT NULL,
    [NbrOthrExmpt]  SMALLINT      NOT NULL,
    [NbrPersExmpt]  SMALLINT      NOT NULL,
    [S4Future01]    CHAR (30)     NOT NULL,
    [S4Future02]    CHAR (30)     NOT NULL,
    [S4Future03]    FLOAT (53)    NOT NULL,
    [S4Future04]    FLOAT (53)    NOT NULL,
    [S4Future05]    FLOAT (53)    NOT NULL,
    [S4Future06]    FLOAT (53)    NOT NULL,
    [S4Future07]    SMALLDATETIME NOT NULL,
    [S4Future08]    SMALLDATETIME NOT NULL,
    [S4Future09]    INT           NOT NULL,
    [S4Future10]    INT           NOT NULL,
    [S4Future11]    CHAR (10)     NOT NULL,
    [S4Future12]    CHAR (10)     NOT NULL,
    [User1]         CHAR (30)     NOT NULL,
    [User2]         CHAR (30)     NOT NULL,
    [User3]         FLOAT (53)    NOT NULL,
    [User4]         FLOAT (53)    NOT NULL,
    [User5]         CHAR (10)     NOT NULL,
    [User6]         CHAR (10)     NOT NULL,
    [User7]         SMALLDATETIME NOT NULL,
    [User8]         SMALLDATETIME NOT NULL,
    [WrkLocId]      CHAR (6)      NOT NULL,
    [tstamp]        ROWVERSION    NOT NULL,
    CONSTRAINT [EarnDedAudt0] PRIMARY KEY CLUSTERED ([EmpId] ASC, [CalYr] ASC, [EDType] ASC, [WrkLocId] ASC, [EarnDedId] ASC, [AudtDateSort] ASC)
);

