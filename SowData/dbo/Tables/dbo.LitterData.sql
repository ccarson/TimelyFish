CREATE TABLE [dbo].[LitterData] (
    [LineNbr]               BIGINT       IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [FARM]                  VARCHAR (10) NULL,
    [SOW_BIRTHDATE]         VARCHAR (10) NULL,
    [DAM_LINE]              VARCHAR (10) NULL,
    [SIRE_LINE]             VARCHAR (10) NULL,
    [LITTER_LINE]           VARCHAR (10) NULL,
    [LITTER_ID]             FLOAT (53)   NULL,
    [PIC_FINAL_SERVICE_DAY] FLOAT (53)   NULL,
    [XLS_FINAL_SERVICE_DAY] FLOAT (53)   NULL,
    [PIC_FARROW_DAY]        FLOAT (53)   NULL,
    [XLS_FARROW_DAY]        FLOAT (53)   NULL,
    [BORN_ALIVE]            INT          NULL,
    [GEN_LEVEL_DAM]         INT          NULL,
    [SOWID]                 VARCHAR (20) NULL
);

