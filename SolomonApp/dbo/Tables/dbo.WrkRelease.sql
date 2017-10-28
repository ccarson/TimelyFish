CREATE TABLE [dbo].[WrkRelease] (
    [BatNbr]      CHAR (10)  NOT NULL,
    [Module]      CHAR (2)   NOT NULL,
    [UserAddress] CHAR (21)  NOT NULL,
    [tstamp]      ROWVERSION NOT NULL,
    CONSTRAINT [WrkRelease0] PRIMARY KEY CLUSTERED ([BatNbr] ASC, [Module] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [WRKRelease1]
    ON [dbo].[WrkRelease]([UserAddress] ASC, [Module] ASC) WITH (FILLFACTOR = 90);

