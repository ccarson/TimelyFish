
Create Proc Account_Active_w @parm1 varchar ( 10) as
    Select acct,descr,acct_cat from Account where Acct = @parm1 and Active <> 0 

