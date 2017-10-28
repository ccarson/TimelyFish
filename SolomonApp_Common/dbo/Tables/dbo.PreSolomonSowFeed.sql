CREATE TABLE [dbo].[PreSolomonSowFeed] (
    [ContactID] CHAR (6)      NOT NULL,
    [DelDate]   SMALLDATETIME NOT NULL,
    [InvtIdDel] CHAR (30)     NOT NULL,
    [OrdNbr]    CHAR (10)     NOT NULL,
    [QtyDel]    FLOAT (53)    NOT NULL,
    [Reversal]  SMALLINT      NOT NULL,
    CONSTRAINT [PK_PreSolomonSowFeed] PRIMARY KEY CLUSTERED ([OrdNbr] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [idxContact]
    ON [dbo].[PreSolomonSowFeed]([ContactID] ASC) WITH (FILLFACTOR = 90);

