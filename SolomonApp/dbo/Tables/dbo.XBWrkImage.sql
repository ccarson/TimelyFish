CREATE TABLE [dbo].[XBWrkImage] (
    [BatNbr]   CHAR (10)       NULL,
    [CpnyLogo] VARBINARY (MAX) NULL,
    [RI_ID]    SMALLINT        NULL,
    [Sig1]     VARBINARY (MAX) NULL,
    [Sig2]     VARBINARY (MAX) NULL,
    [tstamp]   ROWVERSION      NOT NULL
);

