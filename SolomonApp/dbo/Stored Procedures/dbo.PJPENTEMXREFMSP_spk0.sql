
create procedure PJPENTEMXREFMSP_spk0 @project varchar (16), @task varchar (32) , @employee varchar (10), @subtask varchar (50)   as
select	PJPENTEMXREFMSP.Assignment_MSPID
From	PJPENTEMXREFMSP
where	PJPENTEMXREFMSP.project         =    @project
and		PJPENTEMXREFMSP.pjt_entity      =	 @task
and		PJPENTEMXREFMSP.employee        =	 @employee
and		PJPENTEMXREFMSP.subtask_name    =	 @subtask

GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJPENTEMXREFMSP_spk0] TO [MSDSL]
    AS [dbo];

