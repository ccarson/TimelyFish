 create procedure PJREVDET_sumbypjt @parm1 varchar (10) , @parm2 varchar (6) , @parm3 varchar (6) , @parm4 varchar (1) as
select pjrevdet.project, min(pjproj.project_desc), round(sum(round(hours,2)),2), round(sum(round(labor,2)),2),
      round(sum(round(revenue,2)),2),  round(sum(round(revadj,2)),2),
        round(round(sum(round(revenue,2)),2) + round(sum(round(revadj,2)),2)-round(sum(round(labor,2)),2),2),
        'Rate' = case when round(sum(round(hours,2)),2) = 0 then 0 else
        round(abs((round(sum(round(revenue,2)),2) + round(sum(round(revadj,2)),2))/round(sum(round(hours,2)),2)),2) end,
        'NLM' = case when round(sum(round(labor,2)),2) = 0 then 0 else
        round((round(sum(round(revenue,2)),2)+round(sum(round(revadj,2)),2)),2)/round(sum(round(labor,2)),2) end
from PJREVDET, pjproj, pjuttype, pjacct
where   employee = @parm1
and    period >= @parm2
and    period <= @parm3
and      pjrevdet.project = pjproj.project
and      pjrevdet.srcacct = pjacct.acct
and      pjacct.id5_sw in ('L','A','R','X')
and      pjproj.pm_id37 = pjuttype.utilization_type
and      pjuttype.direct = @parm4
group by pjrevdet.project
order by pjrevdet.project


