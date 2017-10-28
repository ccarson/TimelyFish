
CREATE PROCEDURE WS_PJCODE_UPDATE
@codeType char(4),
@codeValue char(30),
@data1 char(30),
@data2 char(16),
@data3 smalldatetime,
@data4 float,
@lupdProg char(8),
@lupdUser char(10)
AS
BEGIN
UPDATE [PJCODE]
   SET 
      [data1] = @data1,
      [data2] = @data2,
      [data3] = @data3,
      [data4] = @data4,
      [lupd_datetime] = GetDate(),
      [lupd_prog] = @lupdProg,
      [lupd_user] = @lupdUser
 WHERE 
      [code_type] = @codeType and 
      [code_value] = @codeValue
      
END

GO
GRANT CONTROL
    ON OBJECT::[dbo].[WS_PJCODE_UPDATE] TO [MSDSL]
    AS [dbo];

