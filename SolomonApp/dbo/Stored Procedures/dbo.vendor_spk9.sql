 create procedure  vendor_spk9 @parm1 varchar (250) , @parm2 varchar (15)  as
select * from  vendor
where vendid = @parm2
order by vendid


