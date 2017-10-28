create procedure PJEMPLOYXREFMSP_delete 
	@Employee			char(10)
as	
	If Exists (	Select employee From PJEMPLOYXREFMSP Where employee = @Employee )
		begin	
			DELETE FROM PJEMPLOYXREFMSP WHERE Employee = @Employee 
		end

GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJEMPLOYXREFMSP_delete] TO [MSDSL]
    AS [dbo];

