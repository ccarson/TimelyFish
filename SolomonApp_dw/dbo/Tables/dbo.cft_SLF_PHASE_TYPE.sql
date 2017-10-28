CREATE TABLE [dbo].[cft_SLF_PHASE_TYPE] (
    [FlowGroup] CHAR (10) NOT NULL,
    [PhaseType] CHAR (2)  NULL,
    PRIMARY KEY CLUSTERED ([FlowGroup] ASC) WITH (FILLFACTOR = 90)
);

