CREATE TABLE [dbo].[WrkPost] (
    [BatNbr]      CHAR (10)  NOT NULL,
    [Module]      CHAR (2)   NOT NULL,
    [UserAddress] CHAR (21)  NOT NULL,
    [tstamp]      ROWVERSION NOT NULL
);


GO
CREATE CLUSTERED INDEX [WrkPost0]
    ON [dbo].[WrkPost]([UserAddress] ASC, [BatNbr] ASC, [Module] ASC) WITH (FILLFACTOR = 90);

