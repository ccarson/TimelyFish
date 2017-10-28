 create procedure batch_spk1 @parm1 varchar (2) , @parm2 varchar (10)  as
select * from batch
where module = @parm1 and
batnbr = @parm2
order by module, batnbr


