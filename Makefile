SBT = sbt

# Run the tests
alu:
	$(SBT) "runMain ALUMain"

alu-test:
	$(SBT) "testOnly ALUTest -- -DwriteVcd=1"

fu:
	$(SBT) "runMain FUMain"

fu-test:
	$(SBT) "testOnly FUTest -- -DwriteVcd=1"

join:
	$(SBT) "runMain JoinMain"

join-test:
	$(SBT) "testOnly JoinTest -- -DwriteVcd=1"

d-eb:
	$(SBT) "runMain D_EBMain"

d-eb-test:
	$(SBT) "testOnly D_EBTest -- -DwriteVcd=1"

d-buf:
	$(SBT) "runMain D_BUFMain"

d-buf-test:
	$(SBT) "testOnly D_BUFTest -- -DwriteVcd=1"

d-reg:
	$(SBT) "runMain D_REGMain"

d-reg-test:
	$(SBT) "testOnly D_REGTest -- -DwriteVcd=1"

d-seb:
	$(SBT) "runMain D_SEBMain"

d-seb-test:
	$(SBT) "testOnly D_SEBTest -- -DwriteVcd=1"

fs:
	$(SBT) "runMain FSMain"

fs-test:
	$(SBT) "testOnly FSTest -- -DwriteVcd=1"

fr:
	$(SBT) "runMain FRMain"

fr-test:
	$(SBT) "testOnly FRTest -- -DwriteVcd=1"	

reg-enable:
	$(SBT) "runMain RegEnableMain"

conf-mux:
	$(SBT) "runMain ConfMuxMain"

conf-mux-test:
	$(SBT) "testOnly ConfMuxTest -- -DwriteVcd=1"	

d-fifo:
	$(SBT) "runMain D_FIFOMain"

d-fifo-test:
	$(SBT) "testOnly D_FIFOTest -- -DwriteVcd=1"	

cell-processing:
	$(SBT) "runMain CellProcessingMain"

cell-processing-test:
	$(SBT) "testOnly CellProcessingTest -- -DwriteVcd=1"	

processing-element:
	$(SBT) "runMain ProcessingElementMain"

processing-element-test:
	$(SBT) "testOnly ProcessingElementTest -- -DwriteVcd=1"	

overlay-rocc:
	$(SBT) "runMain OverlayRoccMain"

overlay-rocc-test:
	$(SBT) "testOnly OverlayRoccTest -- -DwriteVcd=1"	
	