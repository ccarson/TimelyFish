CREATE TABLE [dbo].[WrkReleaseBad] (
    [BatNbr]      CHAR (10)  NOT NULL,
    [Module]      CHAR (2)   NOT NULL,
    [MsgID]       INT        NOT NULL,
    [UserAddress] CHAR (21)  NOT NULL,
    [tstamp]      ROWVERSION NOT NULL,
    CONSTRAINT [WrkReleaseBad0] PRIMARY KEY CLUSTERED ([BatNbr] ASC, [Module] ASC, [MsgID] ASC) WITH (FILLFACTOR = 90)
);

