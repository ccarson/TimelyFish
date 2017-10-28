 create procedure PJALERT_spk0  @parm1 varchar (4) , @parm2beg smallint , @parm2end smallint   as
select * from PJALERT
where   alert_group_cd     =  @parm1 and
alert_id  between  @parm2beg and @parm2end
order by alert_group_cd, alert_id



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJALERT_spk0] TO [MSDSL]
    AS [dbo];

