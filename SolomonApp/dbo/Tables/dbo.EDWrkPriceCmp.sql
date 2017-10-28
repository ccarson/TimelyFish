CREATE TABLE [dbo].[EDWrkPriceCmp] (
    [ComputerID] CHAR (21)     CONSTRAINT [DF_EDWrkPriceCmp_ComputerID] DEFAULT (' ') NOT NULL,
    [CpnyID]     CHAR (10)     CONSTRAINT [DF_EDWrkPriceCmp_CpnyID] DEFAULT (' ') NOT NULL,
    [CustID]     CHAR (15)     CONSTRAINT [DF_EDWrkPriceCmp_CustID] DEFAULT (' ') NOT NULL,
    [EDIPOID]    CHAR (10)     CONSTRAINT [DF_EDWrkPriceCmp_EDIPOID] DEFAULT (' ') NOT NULL,
    [EDIPrice]   FLOAT (53)    CONSTRAINT [DF_EDWrkPriceCmp_EDIPrice] DEFAULT ((0)) NOT NULL,
    [InvtID]     CHAR (30)     CONSTRAINT [DF_EDWrkPriceCmp_InvtID] DEFAULT (' ') NOT NULL,
    [LineNbr]    SMALLINT      CONSTRAINT [DF_EDWrkPriceCmp_LineNbr] DEFAULT ((0)) NOT NULL,
    [PODate]     SMALLDATETIME CONSTRAINT [DF_EDWrkPriceCmp_PODate] DEFAULT ('01/01/1900') NOT NULL,
    [QtyPO]      FLOAT (53)    CONSTRAINT [DF_EDWrkPriceCmp_QtyPO] DEFAULT ((0)) NOT NULL,
    [RI_ID]      SMALLINT      CONSTRAINT [DF_EDWrkPriceCmp_RI_ID] DEFAULT ((0)) NOT NULL,
    [SolDisc]    FLOAT (53)    CONSTRAINT [DF_EDWrkPriceCmp_SolDisc] DEFAULT ((0)) NOT NULL,
    [SolPrice]   FLOAT (53)    CONSTRAINT [DF_EDWrkPriceCmp_SolPrice] DEFAULT ((0)) NOT NULL,
    [UOMPO]      CHAR (6)      CONSTRAINT [DF_EDWrkPriceCmp_UOMPO] DEFAULT (' ') NOT NULL,
    [tstamp]     ROWVERSION    NOT NULL,
    CONSTRAINT [EDWrkPriceCmp0] PRIMARY KEY CLUSTERED ([ComputerID] ASC, [RI_ID] ASC, [EDIPOID] ASC, [LineNbr] ASC) WITH (FILLFACTOR = 90)
);

