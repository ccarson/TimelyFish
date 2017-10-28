CREATE TABLE [dbo].[CEPOldXBWrkImage] (
    [BatNbr]   CHAR (10)       NULL,
    [CpnyLogo] VARBINARY (MAX) NULL,
    [RI_ID]    SMALLINT        NOT NULL,
    [Sig1]     VARBINARY (MAX) NULL,
    [Sig2]     VARBINARY (MAX) NULL,
    [tstamp]   ROWVERSION      NOT NULL
);

