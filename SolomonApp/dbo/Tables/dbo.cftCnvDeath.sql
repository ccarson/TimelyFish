CREATE TABLE [dbo].[cftCnvDeath] (
    [Factory]    CHAR (2)  NOT NULL,
    [JobNbr]     CHAR (4)  NOT NULL,
    [PigGroupID] CHAR (10) NOT NULL,
    [Qty]        INT       NOT NULL,
    [Reason]     CHAR (10) NOT NULL,
    [ReasonDesc] CHAR (30) NOT NULL,
    [SDI_Ref]    INT       NOT NULL,
    [Stage]      CHAR (4)  NOT NULL,
    [SubTypeID]  CHAR (2)  NOT NULL,
    [TranDate]   DATETIME  NOT NULL,
    [TranTypeID] CHAR (2)  NOT NULL,
    [Type]       CHAR (4)  NOT NULL,
    [tstamp]     CHAR (10) NOT NULL
);

