CREATE TABLE [dbo].[cftInsuranceProgram] (
    [Crtd_DateTime]      SMALLDATETIME NOT NULL,
    [Crtd_Prog]          CHAR (8)      NOT NULL,
    [Crtd_User]          CHAR (10)     NOT NULL,
    [Description]        CHAR (30)     NOT NULL,
    [InsuranceProgramID] CHAR (2)      NOT NULL,
    [Lupd_DateTime]      SMALLDATETIME NOT NULL,
    [Lupd_Prog]          CHAR (8)      NOT NULL,
    [Lupd_User]          CHAR (10)     NOT NULL,
    [tstamp]             ROWVERSION    NULL,
    CONSTRAINT [cftInsuranceProgram0] PRIMARY KEY CLUSTERED ([InsuranceProgramID] ASC) WITH (FILLFACTOR = 90)
);

