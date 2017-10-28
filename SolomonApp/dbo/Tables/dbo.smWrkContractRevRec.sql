CREATE TABLE [dbo].[smWrkContractRevRec] (
    [BatNbr]       CHAR (10)  NOT NULL,
    [ContractId]   CHAR (10)  NOT NULL,
    [ContractType] CHAR (10)  NOT NULL,
    [MsgType]      CHAR (1)   NOT NULL,
    [UserAddress]  CHAR (21)  NOT NULL,
    [tstamp]       ROWVERSION NOT NULL
);

