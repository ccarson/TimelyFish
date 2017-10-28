 create procedure PJBILLSB_spk0 @parm1 varchar (16) , @parm2 varchar (15)   as
select * from PJBILLSB, CUSTOMER
where project =  @parm1 and
pjbillsb.customer like  @parm2 and
pjbillsb.customer = customer.custid
order by project, customer


