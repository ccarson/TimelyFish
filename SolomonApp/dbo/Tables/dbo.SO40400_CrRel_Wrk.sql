﻿CREATE TABLE [dbo].[SO40400_CrRel_Wrk] (
    [AutoAdvanceDone] SMALLINT      CONSTRAINT [DF_SO40400_CrRel_Wrk_AutoAdvanceDone] DEFAULT ((0)) NOT NULL,
    [CpnyID]          CHAR (10)     CONSTRAINT [DF_SO40400_CrRel_Wrk_CpnyID] DEFAULT (' ') NOT NULL,
    [OrdNbr]          CHAR (15)     CONSTRAINT [DF_SO40400_CrRel_Wrk_OrdNbr] DEFAULT (' ') NOT NULL,
    [S4Future01]      CHAR (30)     CONSTRAINT [DF_SO40400_CrRel_Wrk_S4Future01] DEFAULT (' ') NOT NULL,
    [S4Future02]      CHAR (30)     CONSTRAINT [DF_SO40400_CrRel_Wrk_S4Future02] DEFAULT (' ') NOT NULL,
    [S4Future03]      FLOAT (53)    CONSTRAINT [DF_SO40400_CrRel_Wrk_S4Future03] DEFAULT ((0)) NOT NULL,
    [S4Future04]      FLOAT (53)    CONSTRAINT [DF_SO40400_CrRel_Wrk_S4Future04] DEFAULT ((0)) NOT NULL,
    [S4Future05]      FLOAT (53)    CONSTRAINT [DF_SO40400_CrRel_Wrk_S4Future05] DEFAULT ((0)) NOT NULL,
    [S4Future06]      FLOAT (53)    CONSTRAINT [DF_SO40400_CrRel_Wrk_S4Future06] DEFAULT ((0)) NOT NULL,
    [S4Future07]      SMALLDATETIME CONSTRAINT [DF_SO40400_CrRel_Wrk_S4Future07] DEFAULT ('01/01/1900') NOT NULL,
    [S4Future08]      SMALLDATETIME CONSTRAINT [DF_SO40400_CrRel_Wrk_S4Future08] DEFAULT ('01/01/1900') NOT NULL,
    [S4Future09]      INT           CONSTRAINT [DF_SO40400_CrRel_Wrk_S4Future09] DEFAULT ((0)) NOT NULL,
    [S4Future10]      INT           CONSTRAINT [DF_SO40400_CrRel_Wrk_S4Future10] DEFAULT ((0)) NOT NULL,
    [S4Future11]      CHAR (10)     CONSTRAINT [DF_SO40400_CrRel_Wrk_S4Future11] DEFAULT (' ') NOT NULL,
    [S4Future12]      CHAR (10)     CONSTRAINT [DF_SO40400_CrRel_Wrk_S4Future12] DEFAULT (' ') NOT NULL,
    [ShipperID]       CHAR (15)     CONSTRAINT [DF_SO40400_CrRel_Wrk_ShipperID] DEFAULT (' ') NOT NULL,
    [tstamp]          ROWVERSION    NOT NULL,
    CONSTRAINT [SO40400_CrRel_Wrk0] PRIMARY KEY CLUSTERED ([CpnyID] ASC, [OrdNbr] ASC, [ShipperID] ASC) WITH (FILLFACTOR = 90)
);
