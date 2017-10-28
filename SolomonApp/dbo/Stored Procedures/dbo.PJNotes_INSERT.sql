
		CREATE PROCEDURE PJNotes_INSERT
            @crtd_datetime smalldatetime,
            @crtd_prog char(8),
            @crtd_user char(10),
            @key_index char(2),
            @key_value char(64),
            @lupd_datetime smalldatetime,
            @lupd_prog char(8),
            @lupd_user char(10),
            @notes1 char(254),
            @notes2 char(254),
            @notes3 char(254),
            @note_disp char(40),
            @note_type_cd char(4)
            AS
            BEGIN
            INSERT INTO [PJNotes]
            ([crtd_datetime],
            [crtd_prog],
            [crtd_user],
            [key_index],
            [key_value],
            [lupd_datetime],
            [lupd_prog],
            [lupd_user],
            [notes1],
            [notes2],
            [notes3],
            [note_disp],
            [note_type_cd])
            VALUES
            (@crtd_datetime,
            @crtd_prog,
            @crtd_user,
            @key_index,
            @key_value,
            @lupd_datetime,
            @lupd_prog,
            @lupd_user,
            @notes1,
            @notes2,
            @notes3,
            @note_disp,
            @note_type_cd);
            END


GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJNotes_INSERT] TO [MSDSL]
    AS [dbo];

