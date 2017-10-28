CREATE TABLE [dbo].[AbraSetup] (
    [CashOffsetAcct]  CHAR (10)  NOT NULL,
    [CashOffsetSub]   CHAR (24)  NOT NULL,
    [CashOffsetDescr] CHAR (30)  NOT NULL,
    [DfltOrgLevel1]   CHAR (2)   NOT NULL,
    [DfltOrgLevel2]   CHAR (2)   NOT NULL,
    [DfltOrgLevel3]   CHAR (2)   NOT NULL,
    [NonProjectID]    CHAR (16)  NOT NULL,
    [WCExpAcct]       CHAR (10)  NOT NULL,
    [WCOffsetAcct]    CHAR (10)  NOT NULL,
    [WCOffsetSub]     CHAR (24)  NOT NULL,
    [WCOTMult]        FLOAT (53) NOT NULL,
    [WCRateDivisor]   FLOAT (53) NOT NULL,
    [tstamp]          ROWVERSION NULL
);

