 create procedure batch_spk0 @parm1 varchar (10) , @parm2 varchar (2)  as
select * from batch
where batnbr = @parm1 and
module = @parm2
order by module, batnbr


