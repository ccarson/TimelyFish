 create procedure PJWAGEPR_SPK0  @parm1 varchar (4) , @parm2 varchar (4) , @parm3 varchar (2)   as
select * from PJWAGEPR
where    prev_wage_cd    = @parm1
and    labor_class_cd     LIKE @parm2
and    group_code           LIKE @parm3
order by prev_wage_cd,
labor_class_cd,
group_code


