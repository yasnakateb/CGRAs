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