create procedure [dbo].[CURRNCY_ID_SREV]  @parm1 varchar (16), @parm2 varchar (24) , @parm3 varchar (10), @parm4 varchar(100) 
   WITH EXECUTE AS '07718158D19D4f5f9D23B55DBF5DF1' 
  as
select distinct c.CuryId from Currncy c 
inner join pjproj p on p.projcuryID = c.CuryId
inner join pjprojex x on x.project = p.project
where
p.project like @parm1 and
p.gl_subacct like @parm2 and
p.cpnyid = @parm3 and
(p.status_pa = 'A' or p.status_pa = 'I') and
p.project = x.project and
x.rev_flag = 'Y' and 
p.CpnyId in
(select cpnyid from dbo.UserAccessCpny(@parm4))   
order by c.CuryId


