 create procedure PJREVCAT_Sbubrm @parm1 varchar (16) , @parm2 varchar (4) , @parm3 varchar (32) , @parm4 varchar (16)  as
SELECT  *    from PJREVCAT, PJACCT
WHERE       pjrevcat.project = @parm1 and
pjrevcat.revid = @parm2 and
pjrevcat.pjt_entity = @parm3 and
pjrevcat.acct LIKE @parm4 and
pjrevcat.acct = PJACCT.acct
ORDER BY pjacct.sort_num


