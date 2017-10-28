 create procedure PJEMPLOY_sALL @parm1 varchar (10)  as
select * from PJEMPLOY
where EMPLOYEE like @parm1
order by employee


