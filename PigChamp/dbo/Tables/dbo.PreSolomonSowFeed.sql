CREATE TABLE [dbo].[PreSolomonSowFeed] (
    [ContactID] CHAR (6)      NOT NULL,
    [DelDate]   SMALLDATETIME NOT NULL,
    [InvtIdDel] CHAR (30)     NOT NULL,
    [OrdNbr]    CHAR (10)     NOT NULL,
    [QtyDel]    FLOAT (53)    NOT NULL,
    [Reversal]  SMALLINT      NOT NULL
);

