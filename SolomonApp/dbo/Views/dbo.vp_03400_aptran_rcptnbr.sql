 
CREATE VIEW vp_03400_aptran_rcptnbr as
select distinct w.useraddress ,rcptnbr, d.invcnbr as ExtRefNbr
  from  Wrkrelease w INNER LOOP Join 
             aptran a
             on w.batnbr = a.batnbr
		and w.module = "AP"
	INNER LOOP JOIN APDoc d ON d.BatNbr = a.BatNbr AND d.RefNbr = a.RefNbr

 
