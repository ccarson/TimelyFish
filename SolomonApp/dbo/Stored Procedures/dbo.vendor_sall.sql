 create procedure  vendor_sall @parm1 varchar (15)  as
select * from  vendor
where vendid LIKE @parm1
order by vendid


