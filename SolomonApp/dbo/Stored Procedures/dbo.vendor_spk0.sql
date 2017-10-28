 create procedure  vendor_spk0 @parm1 varchar (15)  as
select * from  vendor
where vendid = @parm1
order by vendid


