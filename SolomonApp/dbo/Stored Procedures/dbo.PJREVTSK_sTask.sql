 create procedure PJREVTSK_sTask @parm1 varchar (16) , @parm2 varchar (32)   as
SELECT  *    from PJREVTSK T, PJREVHDR H
WHERE      T.project = @PARM1 AND
           T.pjt_entity = @parm2 and
T.project = H.project and
T.Revid = H.revid and
H.Status <> 'P'
ORDER BY       t.lupd_datetime DESC



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJREVTSK_sTask] TO [MSDSL]
    AS [dbo];

