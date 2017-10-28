 Create Proc ED810Header_DuplicateChk @InvcNbr varchar(15), @GSNbr int, @IsaNbr int, @STNbr int As
Select EDIInvId From ED810Header Where InvcNbr = @InvcNbr And GSNbr = @GSNbr And IsaNbr = @IsaNbr
And StNbr = @StNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ED810Header_DuplicateChk] TO [MSDSL]
    AS [dbo];

