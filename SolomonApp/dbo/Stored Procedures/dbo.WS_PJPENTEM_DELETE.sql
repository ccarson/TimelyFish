CREATE PROCEDURE WS_PJPENTEM_DELETE
@Employee char(10), @Pjt_entity char(32), @Project char(16), @SubTask_Name char(50), @tstamp timestamp
AS
BEGIN
DELETE FROM [PJPENTEM]
WHERE [Employee] = @Employee AND 
[Pjt_entity] = @Pjt_entity AND 
[Project] = @Project AND 
[SubTask_Name] = @SubTask_Name AND 
[tstamp] = @tstamp;
END
