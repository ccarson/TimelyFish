
CREATE PROCEDURE WS_PJCODE_INSERT
@codeType char(4),
@codeValue char(30),
@codeValue_desc char(30),
@crtdProg char(8),
@crtdUser char(10),
@data1 char(30),
@data2 char(16),
@data3 smalldatetime,
@data4 float,
@lupdProg char(8),
@lupdUser char(10)
AS
BEGIN
INSERT INTO [PJCODE]
           (
           [code_type],[code_value],[code_value_desc],[crtd_datetime],[crtd_prog],[crtd_user],
           [data1],[data2],[data3],[data4],[lupd_datetime],[lupd_prog],[lupd_user],[noteid])
     VALUES
           (@codeType,@codeValue,@codeValue_desc,GetDate(),@crtdProg,@crtdUser,
           @data1,@data2,@data3,@data4,GetDate(),@lupdProg,@lupdUser,0);
           
END

GO
GRANT CONTROL
    ON OBJECT::[dbo].[WS_PJCODE_INSERT] TO [MSDSL]
    AS [dbo];

