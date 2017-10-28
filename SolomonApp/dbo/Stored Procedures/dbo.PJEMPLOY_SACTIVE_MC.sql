 create procedure [dbo].[PJEMPLOY_SACTIVE_MC] @parm1 varchar (10), @parm2 char(100), @parm3 char(10)
  
  WITH EXECUTE AS '07718158D19D4f5f9D23B55DBF5DF1' 
  as
select * from PJEMPLOY
where
 pjemploy.cpnyID like @parm1 and
emp_status   = 'A' and
PJEMPLOY.CpnyId in

(select cpnyid from dbo.UserAccessCpny(@parm2))  and 

EMPLOYEE like @parm3
order by employee

