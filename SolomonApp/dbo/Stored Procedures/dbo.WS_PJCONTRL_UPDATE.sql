
CREATE PROCEDURE WS_PJCONTRL_UPDATE
@controlType char(2),
@controlCode char(30),
@controlData char(255),
@lupdProg char(8),
@lupdUser char(10)
AS
BEGIN
UPDATE [PJCONTRL]
   SET 
      [control_data] = @controlData,
      [lupd_datetime] = GETDATE(),
      [lupd_prog] = @lupdProg,
      [lupd_user] = @lupdUser
 WHERE 
      [control_type] = @controlType and
      [control_code] = @controlCode
END

GO
GRANT CONTROL
    ON OBJECT::[dbo].[WS_PJCONTRL_UPDATE] TO [MSDSL]
    AS [dbo];

