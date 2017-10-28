 Create Proc  PRDoc_UPT_Status as
       Update PRDoc
           set status = "C"
                   where doctype = "CK"
                   and status = "O"



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PRDoc_UPT_Status] TO [MSDSL]
    AS [dbo];

