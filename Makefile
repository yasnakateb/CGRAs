SBT = sbt

# Run the tests
alu:
	$(SBT) "runMain ALUMain"

alu-test:
	$(SBT) "testOnly ALU_Test -- -DwriteVcd=1"

fu:
	$(SBT) "runMain FUMain"

fu-test:
	$(SBT) "testOnly FU_Test -- -DwriteVcd=1"

join:
	$(SBT) "runMain JoinMain"

join-test:
	$(SBT) "testOnly Join_Test -- -DwriteVcd=1"

d-eb:
	$(SBT) "runMain D_EBMain"

d-eb-test:
	$(SBT) "testOnly D_EB_Test -- -DwriteVcd=1"

d-reg:
	$(SBT) "runMain D_REGMain"

d-reg-test:
	$(SBT) "testOnly D_REG_Test -- -DwriteVcd=1"

fs:
	$(SBT) "runMain FSMain"

fs-test:
	$(SBT) "testOnly FS_Test -- -DwriteVcd=1"

fr:
	$(SBT) "runMain FRMain"

fr-test:
	$(SBT) "testOnly FR_Test -- -DwriteVcd=1"	

reg-enable:
	$(SBT) "runMain RegEnableMain"

conf-mux:
	$(SBT) "runMain ConfMuxMain"

conf-mux-test:
	$(SBT) "testOnly ConfMux_Test -- -DwriteVcd=1"	

d-fifo:
	$(SBT) "runMain D_FIFOMain"

d-fifo-test:
	$(SBT) "testOnly D_FIFO_Test -- -DwriteVcd=1"	

cell-processing:
	$(SBT) "runMain CellProcessingMain"

cell-processing-test:
	$(SBT) "testOnly CellProcessing_Test -- -DwriteVcd=1"	

processing-element:
	$(SBT) "runMain ProcessingElementMain"

processing-element-test:
	$(SBT) "testOnly ProcessingElement_Test -- -DwriteVcd=1"	

overlay-rocc:
	$(SBT) "runMain OverlayRoccMain"

overlay-rocc-test:
	$(SBT) "testOnly OverlayRocc_Test -- -DwriteVcd=1"
	
barrel-shifter:
	$(SBT) "runMain BarrelShifterMain"

barrel-shifter-test:
	$(SBT) "testOnly BarrelShifter_Test -- -DwriteVcd=1"

	
	
