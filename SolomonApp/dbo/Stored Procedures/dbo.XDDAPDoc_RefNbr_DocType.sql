
CREATE PROCEDURE XDDAPDoc_RefNbr_DocType
   @RefNbr       varchar(10),
   @DocType      varchar(2)

AS
   Select        * from APDoc where
                 RefNbr = @RefNbr and
                 DocType = @DocType and
                 Rlsed = 1
