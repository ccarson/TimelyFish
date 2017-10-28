
create procedure PJActsum_Activity @FSYear_num varchar (4), @ri_id smallint as 

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
		   from pjactsum
			where  pjactsum.fsyear_num = @FSYear_num
			  and (dbo.PJACTSUM.amount_01 <> 0 or  dbo.PJACTSUM.amount_02  <> 0 or  dbo.PJACTSUM.amount_03  <> 0 or  dbo.PJACTSUM.amount_04 <> 0 or 
				   dbo.PJACTSUM.amount_05 <> 0 or  dbo.PJACTSUM.amount_06  <> 0 or  dbo.PJACTSUM.amount_07  <> 0 or  dbo.PJACTSUM.amount_08 <> 0 or 
				   dbo.PJACTSUM.amount_09 <> 0 or  dbo.PJACTSUM.amount_10  <> 0 or  dbo.PJACTSUM.amount_11  <> 0 or  dbo.PJACTSUM.amount_12 <> 0 or 
				   dbo.PJACTSUM.amount_13 <> 0 or  dbo.PJACTSUM.amount_14  <> 0 or  dbo.PJACTSUM.amount_15  <> 0)
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
		   from pjptdsum --use ptdsum because budgets, commitments are in here
	End

GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJActsum_Activity] TO [MSDSL]
    AS [dbo];

