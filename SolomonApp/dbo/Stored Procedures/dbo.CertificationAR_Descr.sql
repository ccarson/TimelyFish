 Create Proc CertificationAR_Descr @parm1 varchar (2) as
    Select Descr from CertificationText where CertID = @parm1 order by CertID


