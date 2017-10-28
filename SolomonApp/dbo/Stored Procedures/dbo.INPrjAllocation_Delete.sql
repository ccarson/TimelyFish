Create proc INPrjAllocation_Delete @RefNbr varchar(15), @SrcType varchar (3),  @LineRef varchar(5), @CpnyID varchar (10)  as
Delete From INPrjAllocation 
   where  SrcNbr = @RefNbr AND
          SrcType = @SrcType AND
          SrcLineref = @LineRef AND
          CpnyID = @CpnyID

