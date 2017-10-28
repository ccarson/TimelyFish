 CREATE PROCEDURE DMG_ProcessQueueCPSOff_ComputerName
	@ComputerName    VARCHAR(21)
AS
	SELECT		TOP 1 *
	FROM		ProcessQueue (TABLOCK)
	WHERE		ProcessCPSOff = 1
	AND		ComputerName LIKE @ComputerName
	ORDER BY	ProcessPriority, ProcessQueueID


