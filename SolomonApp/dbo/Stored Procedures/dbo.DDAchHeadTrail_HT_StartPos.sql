 Create Proc DDAchHeadTrail_HT_StartPos @parm1 varchar ( 1), @parm2 varchar ( 2) as
    Select * from DDAchHeadTrail where Header_Trailer LIKE @parm1 and StartPos LIKE @Parm2 ORDER by Header_Trailer, StartPos



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DDAchHeadTrail_HT_StartPos] TO [MSDSL]
    AS [dbo];

