CREATE TABLE [dbo].[Wrk_APTran] (
    [Acct]         CHAR (10)     NOT NULL,
    [BatNbr]       CHAR (10)     NOT NULL,
    [CpnyID]       CHAR (10)     NOT NULL,
    [Crtd_Prog]    CHAR (8)      NOT NULL,
    [Crtd_User]    CHAR (10)     NOT NULL,
    [CuryId]       CHAR (4)      NOT NULL,
    [CuryMultDiv]  CHAR (1)      NOT NULL,
    [CuryRate]     FLOAT (53)    NOT NULL,
    [CuryTranAmt]  FLOAT (53)    NOT NULL,
    [DrCr]         CHAR (1)      NOT NULL,
    [FiscYr]       CHAR (4)      NOT NULL,
    [InstallNbr]   SMALLINT      NOT NULL,
    [LineNbr]      SMALLINT      NOT NULL,
    [LUpd_Prog]    CHAR (8)      NOT NULL,
    [LUpd_User]    CHAR (10)     NOT NULL,
    [MasterDocNbr] CHAR (10)     NOT NULL,
    [PerEnt]       CHAR (6)      NOT NULL,
    [PerPost]      CHAR (6)      NOT NULL,
    [PmtMethod]    CHAR (1)      NOT NULL,
    [RecordID]     INT           IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [RefNbr]       CHAR (10)     NOT NULL,
    [Sub]          CHAR (24)     NOT NULL,
    [TranAmt]      FLOAT (53)    NOT NULL,
    [TranDate]     SMALLDATETIME NOT NULL,
    [TranDesc]     CHAR (30)     NOT NULL,
    [trantype]     CHAR (2)      NOT NULL,
    [VendId]       CHAR (15)     NOT NULL,
    [UserAddress]  CHAR (21)     NOT NULL,
    CONSTRAINT [Wrk_APTran0] PRIMARY KEY NONCLUSTERED ([RecordID] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE CLUSTERED INDEX [Wrk_APTran1]
    ON [dbo].[Wrk_APTran]([UserAddress] ASC) WITH (FILLFACTOR = 90);

