 CREATE PROCEDURE PJInvTxt_INSERT      
     @crtd_datetime smalldatetime, @crtd_prog char(8), @crtd_user char(10),
     @draft_num char(10), @lupd_datetime smalldatetime, @lupd_prog char(8),
     @lupd_user char(10), @text_type char(1), @project char(16),
     @z_text text
 AS
 BEGIN
     INSERT INTO [PJInvTxt]
       ([crtd_datetime], [crtd_prog], [crtd_user],
        [draft_num], [lupd_datetime], [lupd_prog],
        [lupd_user], [text_type], [project],
        [z_text])
     VALUES
       (@crtd_datetime, @crtd_prog, @crtd_user,
        @draft_num, @lupd_datetime, @lupd_prog,
        @lupd_user, @text_type, @project,
        @z_text);
     END
     

GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJInvTxt_INSERT] TO [MSDSL]
    AS [dbo];

