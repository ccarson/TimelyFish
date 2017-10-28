
CREATE PROCEDURE XDDSetup_LBUseCheckDate_Update
	@UseCheckDate	smallint
AS
	UPDATE XDDSetup 
	SET	LBUseCheckDate = @UseCheckDate
