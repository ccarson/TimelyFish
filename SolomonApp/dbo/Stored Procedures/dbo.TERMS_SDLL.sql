 create procedure TERMS_SDLL  @parm1 varchar (2)   as
select descr from TERMS
where    termsid    =    @parm1
order by termsid



GO
GRANT CONTROL
    ON OBJECT::[dbo].[TERMS_SDLL] TO [MSDSL]
    AS [dbo];

