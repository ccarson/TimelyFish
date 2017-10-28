
CREATE proc WS_GetEmpofPJNote 
@parm1 varchar(64) --Key Value
,@parm2 varchar(4) --Note Type Cd
as  
Begin

IF @parm2 = 'TEEX'
Begin
	select pjexphdr.Employee from PJEXPHDR, PJNOTES where pjnotes.key_value = @parm1 and pjnotes.key_value = pjexphdr.docnbr
End

IF @parm2 = 'TIME'
Begin
	select SUBSTRING(pjnotes.key_value,1,6) from PJNOTES where pjnotes.key_value = @parm1
End

IF @parm2 = 'TCIC'
Begin
	select SUBSTRING(key_value,18,6) from PJNOTES where pjnotes.key_value = @parm1
End

  If @parm2 = 'INV'
  Begin 
	select PJINVHDR.approver_id from PJINVHDR, PJNOTES where pjnotes.key_value = @parm1 and pjnotes.key_value = PJINVHDR.draft_num
  End
End


GO
GRANT CONTROL
    ON OBJECT::[dbo].[WS_GetEmpofPJNote] TO [MSDSL]
    AS [dbo];

