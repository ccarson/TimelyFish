CREATE TABLE [dbo].[GeneticAliasDefault] (
    [ID]           INT        NULL,
    [Genetic]      CHAR (20)  NOT NULL,
    [GeneticAlias] CHAR (20)  NOT NULL,
    [DefaultGP]    FLOAT (53) NULL,
    [DefaultPIC]   FLOAT (53) NULL,
    [DefaultNL]    FLOAT (53) NULL,
    [DefaultOther] FLOAT (53) NULL,
    [OtherCompany] CHAR (10)  NULL,
    [OverRide]     SMALLINT   NULL
);

