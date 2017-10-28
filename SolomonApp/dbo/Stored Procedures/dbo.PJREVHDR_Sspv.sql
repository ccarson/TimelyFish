 create procedure PJREVHDR_Sspv @parm1 varchar (16) , @parm2 varchar (4)  as
SELECT  *    from PJREVHDR
WHERE       project like @parm1 and
revid Like @parm2
	ORDER BY  project,revid


