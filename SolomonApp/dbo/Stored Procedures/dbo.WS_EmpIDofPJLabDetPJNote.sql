
CREATE proc WS_EmpIDofPJLabDetPJNote 
@parm1 smalldatetime --Daily Post Date
,@parm2 varchar(16) --Project
,@parm3 varchar(32) --Task
as  
Begin
select pjLabhdr.employee from PJLabHDR, PJLABDET where pjlabdet.pjt_entity = @parm3 and pjlabdet.project = @parm2 and pjlabdet.ld_id08 = @parm1 and pjlabdet.docnbr = pjlabhdr.docnbr
End


GO
GRANT CONTROL
    ON OBJECT::[dbo].[WS_EmpIDofPJLabDetPJNote] TO [MSDSL]
    AS [dbo];

