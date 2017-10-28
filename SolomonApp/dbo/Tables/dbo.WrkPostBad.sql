CREATE TABLE [dbo].[WrkPostBad] (
    [BatNbr]      CHAR (10)  NOT NULL,
    [Module]      CHAR (2)   NOT NULL,
    [Situation]   CHAR (10)  NOT NULL,
    [UserAddress] CHAR (21)  NOT NULL,
    [tstamp]      ROWVERSION NOT NULL
);

