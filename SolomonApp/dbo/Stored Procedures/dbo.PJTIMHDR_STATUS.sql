 create procedure PJTIMHDR_STATUS  @parm1 varchar (10)   as
   SELECT th_status, preparer_id 
     FROM PJTIMHDR WITH(NOLOCK)
    WHERE PJTIMHDR.docnbr = @parm1

