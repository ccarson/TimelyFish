CREATE TABLE [dbo].[cft_logshipcheck] (
    [curr_datetime] DATETIME     NOT NULL,
    [comment]       VARCHAR (30) NOT NULL,
    CONSTRAINT [PK_cft_logshipcheck] PRIMARY KEY CLUSTERED ([curr_datetime] ASC) WITH (FILLFACTOR = 90)
);

