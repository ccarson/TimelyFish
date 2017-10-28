
create procedure PJPROJ_sMSPSYNC @begproj varchar (16), @endproj varchar (16), @inactive varchar (1) as

if @inactive = 'Y'
	begin
		select p.project, t.pjt_entity, t.start_date, t.end_date, px.Project_MSPID from  
			PJPROJ p
				INNER JOIN
			PJPENT t on p.project = t.project 
				INNER JOIN
			PJPROJXREFMSP px on p.project = px.project
			
			where p.MSPInterface = 'Y' and 
				  t.MSPInterface = 'Y' and 
				  @begproj <= p.project and @endproj >= p.project and 
				  p.status_pa in ('A','I') 
	end
else
	begin
		select p.project, t.pjt_entity, t.start_date, t.end_date, px.Project_MSPID from  
			PJPROJ p
				INNER JOIN
			PJPENT t on p.project = t.project 
				INNER JOIN
			PJPROJXREFMSP px on p.project = px.project
			
			where p.MSPInterface = 'Y' and 
				  t.MSPInterface = 'Y' and 
				  @begproj <= p.project and @endproj >= p.project and 
				  p.status_pa in ('A') 
	end

