 create procedure PJREVHDR_sunp @parm1 varchar (16) , @parm2 varchar (4)  as
SELECT  *    from PJREVHDR
WHERE       project = @parm1 and
revid Like @parm2
ORDER BY  project,revid


