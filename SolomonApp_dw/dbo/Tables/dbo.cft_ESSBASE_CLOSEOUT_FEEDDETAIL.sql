CREATE TABLE [dbo].[cft_ESSBASE_CLOSEOUT_FEEDDETAIL] (
    [GroupNumber]    CHAR (32)  NOT NULL,
    [Phase]          CHAR (30)  NOT NULL,
    [ServiceManager] CHAR (50)  NOT NULL,
    [Pod]            CHAR (30)  NOT NULL,
    [System]         CHAR (30)  NOT NULL,
    [Time]           CHAR (10)  NOT NULL,
    [Scenario]       CHAR (20)  NOT NULL,
    [Account]        CHAR (16)  NOT NULL,
    [Value]          FLOAT (53) NOT NULL
);

