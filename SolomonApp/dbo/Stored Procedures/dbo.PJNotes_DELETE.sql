		CREATE PROCEDURE PJNotes_DELETE
            @key_index char(2),
            @key_value char(64),
            @note_type_cd char(4),
            @tstamp timestamp
            AS
            BEGIN
            DELETE FROM [PJNotes]
            WHERE [key_index] = @key_index AND 
            [key_value] = @key_value AND 
            [note_type_cd] = @note_type_cd AND 
            [tstamp] = @tstamp;
            END


GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJNotes_DELETE] TO [MSDSL]
    AS [dbo];

