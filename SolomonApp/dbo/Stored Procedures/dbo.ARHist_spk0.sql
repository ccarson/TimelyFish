 Create Procedure ARHist_spk0  @parm1 varchar (15) , @parm2 varchar (4) , @parm3 varchar (10) as
select * from ARHist
where CustId = @parm1 and
FiscYr = @parm2 and
Cpnyid = @parm3
order by CustId


