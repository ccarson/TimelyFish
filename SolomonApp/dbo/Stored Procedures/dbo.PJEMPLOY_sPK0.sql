 create procedure PJEMPLOY_sPK0 @parm1 varchar (10)  as
select * from PJEMPLOY
where EMPLOYEE = @parm1
order by employee


