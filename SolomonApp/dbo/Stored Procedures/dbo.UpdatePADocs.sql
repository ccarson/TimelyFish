 Create Procedure UpdatePADocs @parm1 VARCHAR(21) as

update ardoc set discbal = 0, curydiscbal = 0 where doctype = "PA" and batnbr in
(select batnbr from wrkrelease where module = "AR" and useraddress = @parm1)


