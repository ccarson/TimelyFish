CREATE TABLE [dbo].[PJJOBSUMMARYWrk] (
    [ri_id]      SMALLINT  NOT NULL,
    [project]    CHAR (16) NOT NULL,
    [pjt_entity] CHAR (32) NOT NULL
);


GO
CREATE NONCLUSTERED INDEX [PJJOBSUMMARYWrk0]
    ON [dbo].[PJJOBSUMMARYWrk]([ri_id] ASC, [project] ASC, [pjt_entity] ASC);


GO
CREATE NONCLUSTERED INDEX [PJJOBSUMMARYWrk1]
    ON [dbo].[PJJOBSUMMARYWrk]([project] ASC, [pjt_entity] ASC);

