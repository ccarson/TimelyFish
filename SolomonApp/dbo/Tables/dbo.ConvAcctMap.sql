CREATE TABLE [dbo].[ConvAcctMap] (
    [MAS90FullAcct] VARCHAR (11) NOT NULL,
    [MAS90CpnyID]   VARCHAR (3)  NOT NULL,
    [MAS90NatAcct]  VARCHAR (4)  NOT NULL,
    [MAS90Sub]      VARCHAR (15) NOT NULL,
    [MAS90Dept]     VARCHAR (1)  NOT NULL,
    [MAS90Site]     VARCHAR (4)  NOT NULL,
    [MAS90Descr]    VARCHAR (50) NOT NULL,
    [SolCpnyID]     VARCHAR (10) NOT NULL,
    [SolFullAcct]   VARCHAR (20) NOT NULL,
    [SolSub]        VARCHAR (10) NOT NULL,
    [SolAcct]       VARCHAR (10) NOT NULL,
    [tstamp]        ROWVERSION   NULL,
    CONSTRAINT [ConvAcctMap0] PRIMARY KEY CLUSTERED ([MAS90CpnyID] ASC, [MAS90FullAcct] ASC) WITH (FILLFACTOR = 90)
);

