 create procedure  ARDOC_sinvoice @parm1 varchar (15) , @parm2 varchar (10)   as
select * from  ARDOC
where ARDOC.custid      =  @parm1 and
ARDOC.doctype     =  'IN'   and
ARDOC.refnbr      =  @parm2
order by ARDOC.custid, ARDOC.doctype, ARDOC.refnbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ARDOC_sinvoice] TO [MSDSL]
    AS [dbo];

