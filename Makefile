SBT = sbt

alu:
	$(SBT) "runMain AluMain"

alu-test:
	$(SBT) "testOnly AluTest -- -DwriteVcd=1"

fu:
	$(SBT) "runMain FuMain"

fu-test:
	$(SBT) "testOnly FuTest -- -DwriteVcd=1"

join:
	$(SBT) "runMain JoinMain"

join-test:
	$(SBT) "testOnly JoinTest -- -DwriteVcd=1"

d-eb:
	$(SBT) "runMain DEbMain"

d-eb-test:
	$(SBT) "testOnly DEbTest -- -DwriteVcd=1"

d-reg:
	$(SBT) "runMain DRegMain"

d-reg-test:
	$(SBT) "testOnly DRegTest -- -DwriteVcd=1"

fs:
	$(SBT) "runMain FsMain"

fs-test:
	$(SBT) "testOnly FsTest -- -DwriteVcd=1"

fr:
	$(SBT) "runMain FrMain"

fr-test:
	$(SBT) "testOnly FrTest -- -DwriteVcd=1"	

conf-mux:
	$(SBT) "runMain ConfMuxMain"

conf-mux-test:
	$(SBT) "testOnly ConfMuxTest -- -DwriteVcd=1"	

d-fifo:
	$(SBT) "runMain DFifoMain"

d-fifo-test:
	$(SBT) "testOnly DFifoTest -- -DwriteVcd=1"	

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
	
overlay-sum:
	$(SBT) "testOnly OverlayRoccTestSUM -- -DwriteVcd=1"

overlay-cap:
	$(SBT) "testOnly OverlayRoccTestCAP -- -DwriteVcd=1"

overlay-acc:
	$(SBT) "testOnly OverlayRoccTestACC -- -DwriteVcd=1"

overlay-mac:
	$(SBT) "testOnly OverlayRoccTestMAC -- -DwriteVcd=1"

overlay-mac2:
	$(SBT) "testOnly OverlayRoccTestMAC2 -- -DwriteVcd=1"	

clean:
	rm -R testrundir/
