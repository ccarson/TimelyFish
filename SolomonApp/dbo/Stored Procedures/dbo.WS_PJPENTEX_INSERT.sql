CREATE PROCEDURE WS_PJPENTEX_INSERT
@COMPUTED_DATE smalldatetime, @COMPUTED_PC float, @crtd_datetime smalldatetime, @crtd_prog char(8), @crtd_user char(10), 
@ENTERED_PC float, @fee_percent float, @lupd_datetime smalldatetime, @lupd_prog char(8), @lupd_user char(10), @NOTEID int, 
@PE_ID11 char(30), @PE_ID12 char(30), @PE_ID13 char(16), @PE_ID14 char(16), @PE_ID15 char(4), @PE_ID16 float, @PE_ID17 float, 
@PE_ID18 smalldatetime, @PE_ID19 smalldatetime, @PE_ID20 int, @PE_ID21 char(30), @PE_ID22 char(30), @PE_ID23 char(16), 
@PE_ID24 char(16), @PE_ID25 char(4), @PE_ID26 float, @PE_ID27 float, @PE_ID28 smalldatetime, @PE_ID29 smalldatetime, 
@PE_ID30 int, @PJT_ENTITY char(32), @PROJECT char(16), @REVISION_DATE smalldatetime
AS
BEGIN
INSERT INTO [PJPENTEX]
([COMPUTED_DATE], [COMPUTED_PC], [crtd_datetime], [crtd_prog], [crtd_user], [ENTERED_PC], [fee_percent], [lupd_datetime], 
[lupd_prog], [lupd_user], [NOTEID], [PE_ID11], [PE_ID12], [PE_ID13], [PE_ID14], [PE_ID15], [PE_ID16], [PE_ID17], [PE_ID18], 
[PE_ID19], [PE_ID20], [PE_ID21], [PE_ID22], [PE_ID23], [PE_ID24], [PE_ID25], [PE_ID26], [PE_ID27], [PE_ID28], [PE_ID29], 
[PE_ID30], [PJT_ENTITY], [PROJECT], [REVISION_DATE])
VALUES
(@COMPUTED_DATE, @COMPUTED_PC, @crtd_datetime, @crtd_prog, @crtd_user, @ENTERED_PC, @fee_percent, @lupd_datetime, @lupd_prog, 
@lupd_user, @NOTEID, @PE_ID11, @PE_ID12, @PE_ID13, @PE_ID14, @PE_ID15, @PE_ID16, @PE_ID17, @PE_ID18, @PE_ID19, @PE_ID20, @PE_ID21, 
@PE_ID22, @PE_ID23, @PE_ID24, @PE_ID25, @PE_ID26, @PE_ID27, @PE_ID28, @PE_ID29, @PE_ID30, @PJT_ENTITY, @PROJECT, @REVISION_DATE);
END
