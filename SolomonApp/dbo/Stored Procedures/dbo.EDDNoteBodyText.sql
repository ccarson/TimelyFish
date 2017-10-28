
Create PROCEDURE [dbo].[EDDNoteBodyText]
	@RcptID varchar(max),
	@Doctype varchar(max),
	@RequestID int
    AS  
    if exists(select * from empedd where empedd.empid = @RcptID and empedd.DocType = @Doctype) 
	Begin
		if exists(select * from empedd, snote where sTableName = 'empedd' and EmpEDD.EmpID = @RcptID and EmpEDD.DocType = @Doctype and Snote.nID = empedd.NoteId) 
		Begin
			(select 1 as [order], cast(substring(NewBody, 1, 8000) as varchar(8000)) as NewBody
			from
				(select REPLACE(cast(vs_AsrreqEdd.BodyText as varchar(max)), '<note>', cast(snote.sNoteText as varchar(max))) as NewBody
				from vs_AsrreqEdd
				Left outer join empedd on empEDD.EmpID = @Rcptid and EmpEDD.DocType = @DocType
				left outer join snote on snote.NID = EmpEDD.NoteID and snote.stablename = 'empedd' 
				Where vs_asrreqedd.ID = @RequestID ) A)
			union
			(select 2 as [order], cast(substring(NewBody, 8001, 8000) as varchar(8000)) as NewBody
			from
				(select REPLACE(cast(vs_AsrreqEdd.BodyText as varchar(max)), '<note>', cast(snote.sNoteText as varchar(max))) as NewBody
				from vs_AsrreqEdd
				Left outer join empedd on empEDD.EmpID = @Rcptid and EmpEDD.DocType = @DocType
				left outer join snote on snote.NID = EmpEDD.NoteID and snote.stablename = 'empedd' 
				Where vs_asrreqedd.ID = @RequestID ) A )
			union
			(select 3 as [order], cast(substring(NewBody, 16001, 8000) as varchar(8000)) as NewBody
			from
				(select REPLACE(cast(vs_AsrreqEdd.BodyText as varchar(max)), '<note>', cast(snote.sNoteText as varchar(max))) as NewBody
				from vs_AsrreqEdd
				Left outer join empedd on empEDD.EmpID = @Rcptid and EmpEDD.DocType = @DocType
				left outer join snote on snote.NID = EmpEDD.NoteID and snote.stablename = 'empedd' 
				Where vs_asrreqedd.ID = @RequestID ) A)
			union
			(select 4 as [order], cast(substring(NewBody, 24001, 8000) as varchar(8000)) as NewBody
			from
				(select REPLACE(cast(vs_AsrreqEdd.BodyText as varchar(max)), '<note>', cast(snote.sNoteText as varchar(max))) as NewBody
				from vs_AsrreqEdd
				Left outer join empedd on empEDD.EmpID = @Rcptid and EmpEDD.DocType = @DocType
				left outer join snote on snote.NID = EmpEDD.NoteID and snote.stablename = 'empedd' 
				Where vs_asrreqedd.ID = @RequestID ) A)
		end 
		else 
		begin
			select 1 as [order], vs_AsrreqEdd.BodyText as NewBody
			from vs_asrreqedd
			where vs_asrreqedd.ID = @RequestID and vs_asrreqedd.EDDRcptID = @Rcptid and vs_asrreqedd.DocType = @DocType
		end 
	end 
	else if exists(select * from custedd where custedd.custid = @RcptID and custedd.DocType = @Doctype) 
	Begin
		if exists(select * from custedd, snote where sTableName = 'custedd' and custedd.custid = @RcptID and custedd.DocType = @Doctype and Snote.nID = custedd.NoteId) 
		Begin
			(select 1 as [order], cast(substring(NewBody, 1, 8000) as varchar(8000)) as NewBody
			from
				(select REPLACE(cast(vs_AsrreqEdd.BodyText as varchar(max)), '<note>', cast(snote.sNoteText as varchar(max))) as NewBody
				from vs_AsrreqEdd
				Left outer join custedd on custEDD.custID = @Rcptid and custeDD.DocType = @DocType
				left outer join snote on snote.NID = custEDD.NoteID and snote.stablename = 'custedd' 
				Where vs_asrreqedd.ID = @RequestID ) A)
			union
			(select 2 as [order], cast(substring(NewBody, 8001, 8000) as varchar(8000)) as NewBody
			from
				(select REPLACE(cast(vs_AsrreqEdd.BodyText as varchar(max)), '<note>', cast(snote.sNoteText as varchar(max))) as NewBody
				from vs_AsrreqEdd
				Left outer join custedd on custEDD.custID = @Rcptid and custeDD.DocType = @DocType
				left outer join snote on snote.NID = custEDD.NoteID and snote.stablename = 'custedd' 
				Where vs_asrreqedd.ID = @RequestID ) A)
			union
			(select 3 as [order], cast(substring(NewBody, 16001, 8000) as varchar(8000)) as NewBody
			from
				(select REPLACE(cast(vs_AsrreqEdd.BodyText as varchar(max)), '<note>', cast(snote.sNoteText as varchar(max))) as NewBody
				from vs_AsrreqEdd
				Left outer join custedd on custEDD.custID = @Rcptid and custeDD.DocType = @DocType
				left outer join snote on snote.NID = custEDD.NoteID and snote.stablename = 'custedd' 
				Where vs_asrreqedd.ID = @RequestID ) A)
			union
			(select 4 as [order], cast(substring(NewBody, 24001, 8000) as varchar(8000)) as NewBody
			from
				(select REPLACE(cast(vs_AsrreqEdd.BodyText as varchar(max)), '<note>', cast(snote.sNoteText as varchar(max))) as NewBody
				from vs_AsrreqEdd
				Left outer join custedd on custEDD.custID = @Rcptid and custeDD.DocType = @DocType
				left outer join snote on snote.NID = custEDD.NoteID and snote.stablename = 'custedd' 
				Where vs_asrreqedd.ID = @RequestID ) A)
		end 
		else 
		begin
			select 1 as [order], vs_AsrreqEdd.BodyText as NewBody
			from vs_asrreqedd
			where vs_asrreqedd.ID = @RequestID and vs_asrreqedd.EDDRcptID = @Rcptid and vs_asrreqedd.DocType = @DocType
		end 
	end 
	else if exists(select * from VendEDD where VendEDD.VendID = @RcptID and VendEDD.DocType = @Doctype) 
	Begin
		if exists(select * from VendEDD, snote where sTableName = 'VendEDD' and VendEDD.VendID = @RcptID and VendEDD.DocType = @Doctype and Snote.nID = VendEDD.NoteId) 
		Begin
			(select 1 as [order], cast(substring(NewBody, 1, 8000) as varchar(8000)) as NewBody
			from
				(select REPLACE(cast(vs_AsrreqEdd.BodyText as varchar(max)), '<note>', cast(snote.sNoteText as varchar(max))) as NewBody
				from vs_AsrreqEdd
				Left outer join vendedd on vendEDD.vendID = @Rcptid and vendEDD.DocType = @DocType
				left outer join snote on snote.NID = vendEDD.NoteID and snote.stablename = 'vendedd' 
				Where vs_asrreqedd.ID = @RequestID ) A)
			union
			(select 2 as [order], cast(substring(NewBody, 8001, 8000) as varchar(8000)) as NewBody
			from
				(select REPLACE(cast(vs_AsrreqEdd.BodyText as varchar(max)), '<note>', cast(snote.sNoteText as varchar(max))) as NewBody
				from vs_AsrreqEdd
				Left outer join vendedd on vendEDD.vendID = @Rcptid and vendEDD.DocType = @DocType
				left outer join snote on snote.NID = vendEDD.NoteID and snote.stablename = 'vendedd' 
				Where vs_asrreqedd.ID = @RequestID ) A)
			union
			(select 3 as [order], cast(substring(NewBody, 16001, 8000) as varchar(8000)) as NewBody
			from
				(select REPLACE(cast(vs_AsrreqEdd.BodyText as varchar(max)), '<note>', cast(snote.sNoteText as varchar(max))) as NewBody
				from vs_AsrreqEdd
				Left outer join vendedd on vendEDD.vendID = @Rcptid and vendEDD.DocType = @DocType
				left outer join snote on snote.NID = vendEDD.NoteID and snote.stablename = 'vendedd' 
				Where vs_asrreqedd.ID = @RequestID ) A)
			union
			(select 4 as [order], cast(substring(NewBody, 24001, 8000) as varchar(8000)) as NewBody
			from
				(select REPLACE(cast(vs_AsrreqEdd.BodyText as varchar(max)), '<note>', cast(snote.sNoteText as varchar(max))) as NewBody
				from vs_AsrreqEdd
				Left outer join vendedd on vendEDD.vendID = @Rcptid and vendEDD.DocType = @DocType
				left outer join snote on snote.NID = vendEDD.NoteID and snote.stablename = 'vendedd' 
				Where vs_asrreqedd.ID = @RequestID ) A)
			
		end 
		else
		begin
			select 1 as [order], vs_AsrreqEdd.BodyText as NewBody
			from vs_asrreqedd
			where vs_asrreqedd.ID = @RequestID and vs_asrreqedd.EDDRcptID = @Rcptid and vs_asrreqedd.DocType = @DocType
		end 
	end 
	else if exists(select * from pjprojedd where pjprojedd.Project = @RcptID and pjprojedd.DocType = @Doctype) 
	Begin
		if exists(select * from pjprojedd, snote where sTableName = 'pjprojedd' and pjprojedd.Project = @RcptID and pjprojedd.DocType = @Doctype and Snote.nID = pjprojedd.NoteId) 
		Begin
		    -- If there is a NOTE record, then got get it and use it
			(select 1 as [order], cast(substring(NewBody, 1, 8000) as varchar(8000)) as NewBody
			from
				(select REPLACE(cast(vs_AsrreqEdd.BodyText as varchar(max)), '<note>', cast(snote.sNoteText as varchar(max))) as NewBody
				from vs_AsrreqEdd
				Left outer join pjprojedd on pjprojEDD.Project = @Rcptid and pjprojEDD.DocType = @DocType
				left outer join snote on snote.NID = pjprojEDD.NoteID and snote.stablename = 'pjprojedd' 
				Where vs_asrreqedd.ID = @RequestID ) A)
			union
			(select 2 as [order], cast(substring(NewBody, 8001, 8000) as varchar(8000)) as NewBody
			from
				(select REPLACE(cast(vs_AsrreqEdd.BodyText as varchar(max)), '<note>', cast(snote.sNoteText as varchar(max))) as NewBody
				from vs_AsrreqEdd
				Left outer join pjprojedd on pjprojEDD.Project = @Rcptid and pjprojEDD.DocType = @DocType
				left outer join snote on snote.NID = pjprojEDD.NoteID and snote.stablename = 'pjprojedd' 
				Where vs_asrreqedd.ID = @RequestID ) A)
			union
			(select 3 as [order], cast(substring(NewBody, 16001, 8000) as varchar(8000)) as NewBody
			from
				(select REPLACE(cast(vs_AsrreqEdd.BodyText as varchar(max)), '<note>', cast(snote.sNoteText as varchar(max))) as NewBody
				from vs_AsrreqEdd
				Left outer join pjprojedd on pjprojEDD.Project = @Rcptid and pjprojEDD.DocType = @DocType
				left outer join snote on snote.NID = pjprojEDD.NoteID and snote.stablename = 'pjprojedd' 
				Where vs_asrreqedd.ID = @RequestID ) A)
			union
		    	(select 4 as [order], cast(substring(NewBody, 24001, 8000) as varchar(8000)) as NewBody
			from
				(select REPLACE(cast(vs_AsrreqEdd.BodyText as varchar(max)), '<note>', cast(snote.sNoteText as varchar(max))) as NewBody
				from vs_AsrreqEdd
				Left outer join pjprojedd on pjprojEDD.Project = @Rcptid and pjprojEDD.DocType = @DocType
				left outer join snote on snote.NID = pjprojEDD.NoteID and snote.stablename = 'pjprojedd' 
				Where vs_asrreqedd.ID = @RequestID ) A)
			
		end 
		else 
		begin
		    -- NO NOTE record, use the value in the asrreqedd record
			select 1 as [order], vs_AsrreqEdd.BodyText as NewBody
			from vs_asrreqedd
			where vs_asrreqedd.ID = @RequestID and vs_asrreqedd.EDDRcptID = @Rcptid and vs_asrreqedd.DocType = @DocType
		end 
	end 
	else 
	begin
		-- No custedd, Vendedd, empedd or projedd record so use the eddsetup record
		if exists(select * from eddsetup, snote where sTableName = 'eddsetup' and eddsetup.DocType = @Doctype and Snote.nID = eddsetup.NoteId) 
		begin
		    -- If there is a NOTE record, then got get it and use it
			(select 1 as [order], cast(substring(NewBody, 1, 8000) as varchar(8000)) as NewBody
			from
				(select REPLACE(cast(vs_AsrreqEdd.BodyText as varchar(max)), '<note>', cast(snote.sNoteText as varchar(max))) as NewBody
				from vs_AsrreqEdd
				left outer join eddsetup on eddsetup .DocType = @DocType
				left outer join snote on snote.NID = eddsetup.NoteID and snote.stablename = 'eddsetup' 
				Where vs_asrreqedd.ID = @RequestID ) A)
			union
			(select 2 as [order], cast(substring(NewBody, 8001, 8000) as varchar(8000)) as NewBody
			from
				(select REPLACE(cast(vs_AsrreqEdd.BodyText as varchar(max)), '<note>', cast(snote.sNoteText as varchar(max))) as NewBody
				from vs_AsrreqEdd
				Left outer join eddsetup on eddsetup.DocType = @DocType
				left outer join snote on snote.NID = eddsetup.NoteID and snote.stablename = 'eddsetup' 
				Where vs_asrreqedd.ID = @RequestID ) A)
			union
			(select 3 as [order], cast(substring(NewBody, 16001, 8000) as varchar(8000)) as NewBody
			from
				(select REPLACE(cast(vs_AsrreqEdd.BodyText as varchar(max)), '<note>', cast(snote.sNoteText as varchar(max))) as NewBody
				from vs_AsrreqEdd
				Left outer join eddsetup on eddsetup.DocType = @DocType
				left outer join snote on snote.NID = eddsetup.NoteID and snote.stablename = 'eddsetup' 
				Where vs_asrreqedd.ID = @RequestID ) A)
			union
		    	(select 4 as [order], cast(substring(NewBody, 24001, 8000) as varchar(8000)) as NewBody
			from
				(select REPLACE(cast(vs_AsrreqEdd.BodyText as varchar(max)), '<note>', cast(snote.sNoteText as varchar(max))) as NewBody
				from vs_AsrreqEdd
				Left outer join eddsetup on eddsetup.DocType = @DocType
				left outer join snote on snote.NID = eddsetup.NoteID and snote.stablename = 'eddsetup' 
				Where vs_asrreqedd.ID = @RequestID ) A)

		end
		else
		begin
		    -- No Note record with the eddsetup record
		    select 1 as [order], vs_AsrreqEdd.BodyText as NewBody
   		    from vs_asrreqedd
		    where vs_asrreqedd.ID = @RequestID and vs_asrreqedd.EDDRcptID = @Rcptid and vs_asrreqedd.DocType = @DocType
                end
	end
	
