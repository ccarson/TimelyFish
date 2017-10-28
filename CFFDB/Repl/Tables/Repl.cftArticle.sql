CREATE TABLE [Repl].[cftArticle] (
    [ArticleID]     INT        IDENTITY (1, 1) NOT NULL,
    [Publication]   [sysname]  NOT NULL,
    [PublisherDB]   [sysname]  NOT NULL,
    [ArticleName]   [sysname]  NOT NULL,
    [SourceSchema]  [sysname]  NOT NULL,
    [ArticleType]   [sysname]  NOT NULL,
    [SchemaOption]  BINARY (8) NOT NULL,
    [ArticleStatus] TINYINT    NOT NULL,
    CONSTRAINT [pk_cftArticle] PRIMARY KEY CLUSTERED ([ArticleID] ASC) WITH (FILLFACTOR = 90)
);

