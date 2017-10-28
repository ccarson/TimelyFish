
CREATE proc WS_DoesCorrectedTimeCardExist 
@parm1 varchar (10)	--DocNbr
as  
Begin

			SELECT docnbr [Document] FROM PJLABHDR(nolock)
			 where le_key = @parm1
End


GO
GRANT CONTROL
    ON OBJECT::[dbo].[WS_DoesCorrectedTimeCardExist] TO [MSDSL]
    AS [dbo];

