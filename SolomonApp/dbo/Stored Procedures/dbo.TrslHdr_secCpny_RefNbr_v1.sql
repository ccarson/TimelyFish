
Create Proc TrslHdr_secCpny_RefNbr_v1 @parm1 varchar (10) AS
Select distinct FSTrslHd.* from FSTrslHd join RptCompany on FSTrslHd.CpnyID = RptCompany.cpnyid where RefNbr like @parm1 Order by RefNbr

GO
GRANT CONTROL
    ON OBJECT::[dbo].[TrslHdr_secCpny_RefNbr_v1] TO [MSDSL]
    AS [dbo];

