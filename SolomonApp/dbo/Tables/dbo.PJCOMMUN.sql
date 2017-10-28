CREATE TABLE [dbo].[PJCOMMUN] (
    [crtd_datetime]    SMALLDATETIME NOT NULL,
    [crtd_prog]        CHAR (8)      NOT NULL,
    [crtd_user]        CHAR (10)     NOT NULL,
    [destination]      CHAR (50)     NOT NULL,
    [destination_type] CHAR (1)      NOT NULL,
    [email_address]    CHAR (100)    NOT NULL,
    [exe_caption1]     CHAR (30)     NOT NULL,
    [exe_caption2]     CHAR (30)     NOT NULL,
    [exe_caption3]     CHAR (30)     NOT NULL,
    [exe_name1]        CHAR (100)    NOT NULL,
    [exe_name2]        CHAR (100)    NOT NULL,
    [exe_name3]        CHAR (100)    NOT NULL,
    [exe_parm1]        CHAR (100)    NOT NULL,
    [exe_parm2]        CHAR (100)    NOT NULL,
    [exe_parm3]        CHAR (100)    NOT NULL,
    [exe_type1]        CHAR (1)      NOT NULL,
    [exe_type2]        CHAR (1)      NOT NULL,
    [exe_type3]        CHAR (1)      NOT NULL,
    [lupd_datetime]    SMALLDATETIME NOT NULL,
    [lupd_prog]        CHAR (8)      NOT NULL,
    [lupd_user]        CHAR (10)     NOT NULL,
    [mail_flag]        CHAR (1)      NOT NULL,
    [msg_key]          CHAR (48)     NOT NULL,
    [msg_status]       CHAR (1)      NOT NULL,
    [msg_suffix]       CHAR (2)      NOT NULL,
    [msg_text]         CHAR (254)    NOT NULL,
    [msg_type]         CHAR (6)      NOT NULL,
    [sender]           CHAR (50)     NOT NULL,
    [source_function]  CHAR (30)     NOT NULL,
    [subject]          CHAR (50)     NOT NULL,
    [tstamp]           ROWVERSION    NOT NULL,
    CONSTRAINT [pjcommun0] PRIMARY KEY CLUSTERED ([msg_type] ASC, [msg_key] ASC, [msg_suffix] ASC) WITH (FILLFACTOR = 100)
);


GO
CREATE NONCLUSTERED INDEX [pjcommun1]
    ON [dbo].[PJCOMMUN]([destination] ASC, [msg_status] ASC, [crtd_datetime] ASC) WITH (FILLFACTOR = 100);

