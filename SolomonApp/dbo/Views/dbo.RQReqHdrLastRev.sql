 

Create View RQReqHdrLastRev as
SELECT * from RQReqHdr 
 WHERE ReqCntr = (SELECT max(RQH2.ReqCntr) 
                    FROM RQReqHdr as RQH2 
                   WHERE RQReqHdr.ReqNbr = RQH2.ReqNbr)


 
