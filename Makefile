SBT = sbt

alu:
	$(SBT) "runMain Alu_Main"

alu-test:
	$(SBT) "testOnly Alu_Test -- -DwriteVcd=1"

fu:
	$(SBT) "runMain Fu_Main"

fu-test:
	$(SBT) "testOnly Fu_Test -- -DwriteVcd=1"

join:
	$(SBT) "runMain Join_Main"

join-test:
	$(SBT) "testOnly Join_Test -- -DwriteVcd=1"

d-eb:
	$(SBT) "runMain D_Eb_Main"

d-eb-test:
	$(SBT) "testOnly D_Eb_Test -- -DwriteVcd=1"

d-reg:
	$(SBT) "runMain D_Reg_Main"

d-reg-test:
	$(SBT) "testOnly D_Reg_Test -- -DwriteVcd=1"

fs:
	$(SBT) "runMain Fs_Main"

fs-test:
	$(SBT) "testOnly Fs_Test -- -DwriteVcd=1"

fr:
	$(SBT) "runMain Fr_Main"

fr-test:
	$(SBT) "testOnly Fr_Test -- -DwriteVcd=1"	

conf-mux:
	$(SBT) "runMain Conf_Mux_Main"

conf-mux-test:
	$(SBT) "testOnly Conf_Mux_Test -- -DwriteVcd=1"	

d-fifo:
	$(SBT) "runMain D_Fifo_Main"

d-fifo-test:
	$(SBT) "testOnly D_Fifo_Test -- -DwriteVcd=1"	

cell-processing:
	$(SBT) "runMain Cell_Processing_Main"

cell-processing-test:
	$(SBT) "testOnly Cell_Processing_Test -- -DwriteVcd=1"	

processing-element:
	$(SBT) "runMain Processing_Element_Main"

processing-element-test:
	$(SBT) "testOnly Processing_Element_Test -- -DwriteVcd=1"	

overlay-rocc:
	$(SBT) "runMain Overlay_Rocc_Main"

overlay-rocc-test:
	$(SBT) "testOnly Overlay_Rocc_Test -- -DwriteVcd=1"
	
overlay-sum:
	$(SBT) "testOnly Overlay_Rocc_Test_SUM -- -DwriteVcd=1"

overlay-cap:
	$(SBT) "testOnly Overlay_Rocc_Test_CAP -- -DwriteVcd=1"

overlay-acc:
	$(SBT) "testOnly Overlay_Rocc_Test_ACC -- -DwriteVcd=1"

overlay-mac:
	$(SBT) "testOnly Overlay_Rocc_Test_MAC -- -DwriteVcd=1"

overlay-mac2:
	$(SBT) "testOnly Overlay_Rocc_Test_MAC2 -- -DwriteVcd=1"	

clean:
	rm -R test_run_dir/