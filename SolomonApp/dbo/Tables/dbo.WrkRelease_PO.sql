CREATE TABLE [dbo].[WrkRelease_PO] (
    [BatNbr]      CHAR (10)  NOT NULL,
    [Module]      CHAR (2)   NOT NULL,
    [UserAddress] CHAR (21)  NOT NULL,
    [PPVBatNbr]   CHAR (10)  NOT NULL,
    [PPVCount]    SMALLINT   NOT NULL,
    [PPVRefNbr]   CHAR (10)  NOT NULL,
    [tstamp]      ROWVERSION NOT NULL
);


GO
CREATE UNIQUE CLUSTERED INDEX [Wrkrelease_PO0]
    ON [dbo].[WrkRelease_PO]([UserAddress] ASC, [BatNbr] ASC, [Module] ASC);

