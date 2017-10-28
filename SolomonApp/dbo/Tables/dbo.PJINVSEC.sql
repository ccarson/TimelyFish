CREATE TABLE [dbo].[PJINVSEC] (
    [acct]          CHAR (16)     NOT NULL,
    [crtd_datetime] SMALLDATETIME NOT NULL,
    [crtd_prog]     CHAR (8)      NOT NULL,
    [crtd_user]     CHAR (10)     NOT NULL,
    [desc_print_sw] CHAR (1)      NOT NULL,
    [inv_format_cd] CHAR (4)      NOT NULL,
    [is_id01]       CHAR (30)     NOT NULL,
    [is_id02]       CHAR (16)     NOT NULL,
    [is_id03]       CHAR (4)      NOT NULL,
    [is_id04]       CHAR (4)      NOT NULL,
    [is_id05]       CHAR (4)      NOT NULL,
    [is_id06]       CHAR (4)      NOT NULL,
    [is_id07]       CHAR (1)      NOT NULL,
    [is_id08]       CHAR (1)      NOT NULL,
    [is_id09]       CHAR (1)      NOT NULL,
    [is_id10]       CHAR (1)      NOT NULL,
    [lupd_datetime] SMALLDATETIME NOT NULL,
    [lupd_prog]     CHAR (8)      NOT NULL,
    [lupd_user]     CHAR (10)     NOT NULL,
    [noteid]        INT           NOT NULL,
    [section_desc]  CHAR (40)     NOT NULL,
    [section_num]   CHAR (4)      NOT NULL,
    [section_type]  CHAR (30)     NOT NULL,
    [subtotal_sw]   CHAR (1)      NOT NULL,
    [tstamp]        ROWVERSION    NOT NULL,
    CONSTRAINT [pjinvsec0] PRIMARY KEY CLUSTERED ([inv_format_cd] ASC, [section_num] ASC, [acct] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [pjinvsec1]
    ON [dbo].[PJINVSEC]([acct] ASC) WITH (FILLFACTOR = 90);

