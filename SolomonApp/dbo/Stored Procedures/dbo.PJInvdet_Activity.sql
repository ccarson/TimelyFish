
create procedure PJInvdet_Activity @FSYear_num varchar (4), @ri_id smallint as 

Delete from PJJOBSUMMARYWrk where ri_id = @ri_id

IF (select Substring(Control_data,1,1) from pjcontrl where control_type = 'PA' and control_code = 'SUPPRESS-PJTS-WITH-NO-YTD' ) = 'Y'
	Begin
		insert into PJJOBSUMMARYWrk
		(       ri_id,
				project,
				pjt_entity
		) select distinct
				@ri_id,
				project,
				pjt_entity
		   from pjinvdet
			where  Substring(pjinvdet.fiscalno,1,4) = @FSYear_num
			  and (dbo.PJINVDET.CuryTranamt <> 0 )
	End
Else
	Begin
		insert into PJJOBSUMMARYWrk
		(       ri_id,
		        project,
				pjt_entity
		) select distinct
				@ri_id,
				project,
				pjt_entity
		   from pjinvdet 
	End

GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJInvdet_Activity] TO [MSDSL]
    AS [dbo];

