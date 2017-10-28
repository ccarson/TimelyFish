 create procedure PJREVDET_sdetail @parm1 varchar (10) , @parm2 varchar (16) , @parm3 varchar (6) , @parm4 varchar (6) , @parm5 varchar (1) as
select pjrevdet.period, pjrevdet.date, pjrevdet.project, min(pjproj.project_desc),
        pjrevdet.task,  min(pjpent.pjt_entity_desc), pjrevdet.laborclass,
        round(sum(round(hours,2)),2), round(sum(round(labor,2)),2),
        round(sum(round(revenue,2)),2),  round(sum(round(revadj,2)),2),
        round(round(sum(round(revenue,2)),2)+round(sum(round(revadj,2)),2)-round(sum(round(labor,2)),2),2),
        'Rate' = case when round(sum(round(hours,2)),2) = 0 then 0 else
        round(abs((round(sum(round(revenue,2)),2) + round(sum(round(revadj,2)),2))/round(sum(round(hours,2)),2)),2) end,
        'NLM' = case when round(sum(round(labor,2)),2) = 0 then 0 else
        round((round(sum(round(revenue,2)),2)+round(sum(round(revadj,2)),2)),2)/round(sum(round(labor,2)),2) end
from PJREVDET, pjproj , pjpent, pjuttype, pjacct
where   employee = @parm1
and    pjrevdet.project like @parm2
and    period >= @parm3
and    period <= @parm4
and      pjrevdet.project = pjproj.project
and      pjrevdet.project = pjpent.project
and      pjrevdet.task = pjpent.pjt_entity
and      pjrevdet.srcacct = pjacct.acct
and      pjacct.id5_sw in ('L','A','R','X')
and      pjproj.pm_id37 = pjuttype.utilization_type
and      pjuttype.direct = @parm5
group by pjrevdet.period, pjrevdet.date, pjrevdet.project, pjrevdet.task, pjrevdet.laborclass
order by pjrevdet.period, pjrevdet.date, pjrevdet.project, pjrevdet.task, pjrevdet.laborclass


