 create procedure PJREVTIM_sCurrAmt  @parm1 varchar (16) ,  @parm2 varchar (6)  as
SELECT  *    from PJREVTIM
WHERE
Project = @parm1 and
fiscalno Like @parm2 and
(amount <> 0 or units <> 0 or ProjCury_Amount <> 0)



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJREVTIM_sCurrAmt] TO [MSDSL]
    AS [dbo];

