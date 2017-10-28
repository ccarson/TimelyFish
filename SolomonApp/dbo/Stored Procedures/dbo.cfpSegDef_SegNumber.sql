CREATE PROCEDURE cfpSegDef_SegNumber
	@SegNumber varchar(2),
	@ID varchar(24)
	As
	SELECT * FROM SegDef 
	WHERE fieldclass = '001' 
	AND segnumber =  @SegNumber -- in solomon this is parm1
	AND ID Like @ID
	ORDER BY ID


