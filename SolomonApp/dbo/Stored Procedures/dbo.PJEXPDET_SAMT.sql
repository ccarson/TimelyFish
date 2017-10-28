 /******Modified to retrieve total exp report total as well as emp paid amt. BK 09/28/05 ******/
create procedure PJEXPDET_SAMT  @parm1 varchar (10)   as
select
sum(pjexpdet.amt_employ), sum(pjexpdet.amt_employ) + sum(pjexpdet.amt_company)
FROM  pjexpdet
where    docnbr     =  @parm1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJEXPDET_SAMT] TO [MSDSL]
    AS [dbo];

