 Create Procedure ARDoc_applbatnbr_applbatseq @parm1 varchar ( 10), @parm2beg int, @parm2end int, @parm3 varchar (10) as
    Select * from ARDoc where applbatnbr = @parm1
        and applbatseq between @parm2beg and @parm2end
        and refnbr like @parm3
        and doctype <> 'SB'
        order by custid, doctype, refnbr


