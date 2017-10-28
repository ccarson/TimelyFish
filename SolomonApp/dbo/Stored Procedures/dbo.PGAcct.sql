
/****** Object:  Stored Procedure dbo.PJACCT_spk9    Script Date: 10/14/2004 11:18:40 AM ******/
CREATE  procedure PGAcct @parm1 varchar (16)  as
select * from PJACCT
where    acct        like @parm1
and    acct_status =    'A'
and    acct_group_cd = 'PG'
order by acct

GO
GRANT CONTROL
    ON OBJECT::[dbo].[PGAcct] TO [MSDSL]
    AS [dbo];

