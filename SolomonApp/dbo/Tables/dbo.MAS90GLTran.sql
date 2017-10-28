CREATE TABLE [dbo].[MAS90GLTran] (
    [CpnyID]        CHAR (10)     NOT NULL,
    [AccountNumber] CHAR (11)     NOT NULL,
    [TranDate]      SMALLDATETIME NOT NULL,
    [SrcJournal]    CHAR (6)      NOT NULL,
    [BatNbr]        CHAR (10)     NOT NULL,
    [SeqCounter]    CHAR (3)      NULL,
    [SrcSystem]     CHAR (2)      NULL,
    [TranDesc]      CHAR (30)     NULL,
    [DocType]       CHAR (2)      NULL,
    [DocNbr]        CHAR (15)     NULL,
    [SeqRcptNo]     CHAR (3)      NULL,
    [TranAmt]       FLOAT (53)    NOT NULL,
    [FiscYr]        CHAR (4)      NOT NULL,
    [PerNbr]        CHAR (2)      NOT NULL
);

