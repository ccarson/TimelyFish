 create procedure VENDOR_SDLL  @parm1 varchar (15)   as
select name from VENDOR
where    vendid    =    @parm1
order by vendid


