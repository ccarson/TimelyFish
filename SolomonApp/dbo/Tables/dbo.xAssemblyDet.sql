﻿CREATE TABLE [dbo].[xAssemblyDet] (
    [AsyNbr]        CHAR (10)     NOT NULL,
    [BasePrice]     FLOAT (53)    NOT NULL,
    [Bushels]       FLOAT (53)    NOT NULL,
    [ChkOffFlg]     SMALLINT      NOT NULL,
    [ChkOffTotal]   FLOAT (53)    NOT NULL,
    [Crtd_DateTime] SMALLDATETIME NOT NULL,
    [Crtd_Prog]     CHAR (8)      NOT NULL,
    [Crtd_User]     CHAR (10)     NOT NULL,
    [CtrctNbr]      CHAR (10)     NOT NULL,
    [DiscTot]       FLOAT (53)    NOT NULL,
    [DmgDisc]       FLOAT (53)    NOT NULL,
    [FM]            FLOAT (53)    NOT NULL,
    [KeyFld]        CHAR (10)     NOT NULL,
    [LoadDate]      SMALLDATETIME NOT NULL,
    [Lupd_DateTime] SMALLDATETIME NOT NULL,
    [Lupd_Prog]     CHAR (8)      NOT NULL,
    [Lupd_User]     CHAR (10)     NOT NULL,
    [MstDisc]       FLOAT (53)    NOT NULL,
    [MstPct]        FLOAT (53)    NOT NULL,
    [NetDmg]        FLOAT (53)    NOT NULL,
    [NetPrice]      FLOAT (53)    NOT NULL,
    [NetWgt]        FLOAT (53)    NOT NULL,
    [PriceTotal]    FLOAT (53)    NOT NULL,
    [Rlsed]         SMALLINT      NOT NULL,
    [SplitStyle]    CHAR (1)      NOT NULL,
    [TktNbr]        CHAR (10)     NOT NULL,
    [TotDmg]        FLOAT (53)    NOT NULL,
    [TW]            FLOAT (53)    NOT NULL,
    [TWDisc]        FLOAT (53)    NOT NULL,
    [User1]         CHAR (30)     NOT NULL,
    [User2]         CHAR (10)     NOT NULL,
    [User3]         FLOAT (53)    NOT NULL,
    [User4]         SMALLDATETIME NOT NULL,
    [VendTotal]     FLOAT (53)    NOT NULL,
    [tstamp]        ROWVERSION    NULL,
    CONSTRAINT [xAssemblyDet0] PRIMARY KEY CLUSTERED ([AsyNbr] ASC, [KeyFld] ASC) WITH (FILLFACTOR = 90)
);

