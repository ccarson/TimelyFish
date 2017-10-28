 


CREATE VIEW dbo.vp_03400_UpdateRcpt AS 

Select  a.useraddress,a.rcptnbr, a.ExtRefNbr,
        VouchStage = (select Max(VouchStage) 
                          FROM potran t
                         WHERE  a.rcptnbr = t.rcptnbr )


  From vp_03400_aptran_rcptnbr a
 WHERE EXISTS(select * 
                          FROM potran t
                         WHERE  a.rcptnbr = t.rcptnbr )


 
