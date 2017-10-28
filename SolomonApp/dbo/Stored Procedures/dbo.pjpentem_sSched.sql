 CREATE Procedure pjpentem_sSched
	@ParmEmp varchar(10), @PEndDate smalldatetime, @PStartDate smalldatetime, @DayRange integer AS
Select pjpentem.project, pjpentem.pjt_entity, pjpentem.subtask_name from pjpentem,pjproj,Pjpent
 where pjpentem.employee = @ParmEmp
and pjproj.project = pjpentem.project
and pjproj.project = Pjpent.project
and pjproj.status_pa='A' and pjproj.status_lb='A'
and Pjpent.status_pa='A' and Pjpent.status_lb='A'
and pjpentem.pjt_entity = Pjpent.pjt_entity
and (pjpentem.date_start <= DATEADD(day, @DayRange, @PEndDate) and pjpentem.date_end >= DATEADD(day, -@DayRange, @PStartDate))



GO
GRANT CONTROL
    ON OBJECT::[dbo].[pjpentem_sSched] TO [MSDSL]
    AS [dbo];

