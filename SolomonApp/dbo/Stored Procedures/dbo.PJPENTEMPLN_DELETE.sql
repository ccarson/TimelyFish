
CREATE PROCEDURE PJPENTEMPLN_DELETE
@Employee char(10),
@Period char(6),
@Pjt_entity char(32),
@Project char(16),
@Timeslot int,
@tstamp timestamp
AS
BEGIN
DELETE FROM [PJPENTEMPLN]
WHERE [Employee] = @Employee AND 
[Period] = @Period AND 
[Pjt_entity] = @Pjt_entity AND 
[Project] = @Project AND 
[Timeslot] = @Timeslot AND 
[tstamp] = @tstamp;
END


GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJPENTEMPLN_DELETE] TO [MSDSL]
    AS [dbo];

