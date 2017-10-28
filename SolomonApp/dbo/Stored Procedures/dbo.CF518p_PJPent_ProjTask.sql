Create Procedure CF518p_PJPent_ProjTask @parm1 varchar (16), @parm2 varchar (32) as 
    Select * from PJPent Where Project = @parm1 and Pjt_Entity = @parm2
