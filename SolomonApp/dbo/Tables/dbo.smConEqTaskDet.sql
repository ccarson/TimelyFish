﻿CREATE TABLE [dbo].[smConEqTaskDet] (
    [ContractID]    CHAR (10)     NOT NULL,
    [Crtd_DateTime] SMALLDATETIME NOT NULL,
    [Crtd_Prog]     CHAR (8)      NOT NULL,
    [Crtd_User]     CHAR (10)     NOT NULL,
    [DetailType]    CHAR (1)      NOT NULL,
    [EquipID]       CHAR (10)     NOT NULL,
    [Invtid]        CHAR (30)     NOT NULL,
    [LineNbr]       SMALLINT      NOT NULL,
    [Lupd_DateTime] SMALLDATETIME NOT NULL,
    [Lupd_Prog]     CHAR (8)      NOT NULL,
    [Lupd_User]     CHAR (10)     NOT NULL,
    [PMCode]        CHAR (10)     NOT NULL,
    [Quantity]      FLOAT (53)    NOT NULL,
    [Season]        CHAR (10)     NOT NULL,
    [UnitCost]      FLOAT (53)    NOT NULL,
    [UnitPrice]     FLOAT (53)    NOT NULL,
    [User1]         CHAR (30)     NOT NULL,
    [User2]         CHAR (30)     NOT NULL,
    [User3]         FLOAT (53)    NOT NULL,
    [User4]         FLOAT (53)    NOT NULL,
    [User5]         CHAR (10)     NOT NULL,
    [User6]         CHAR (10)     NOT NULL,
    [User7]         SMALLDATETIME NOT NULL,
    [User8]         SMALLDATETIME NOT NULL,
    [WorkArea]      CHAR (30)     NOT NULL,
    [WorkDesc]      CHAR (60)     NOT NULL,
    [tstamp]        ROWVERSION    NOT NULL,
    CONSTRAINT [smConEqTaskDet0] PRIMARY KEY CLUSTERED ([ContractID] ASC, [EquipID] ASC, [PMCode] ASC, [LineNbr] ASC) WITH (FILLFACTOR = 90)
);
