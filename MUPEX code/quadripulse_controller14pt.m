function pt=quadripulse_controller14pt
pt = [];

  
pt(1).blockname = 'Compare To Constant';
pt(1).paramname = 'const';
pt(1).class     = 'scalar';
pt(1).nrows     = 1;
pt(1).ncols     = 1;
pt(1).subsource = 'SS_DOUBLE';
pt(1).ndims     = '2';
pt(1).size      = '[]';
pt(1).isStruct  = false;
pt(1).symbol     = 'quadripulse_controller14_P.CompareToConstant_const';
pt(1).baseaddr   = '&quadripulse_controller14_P.CompareToConstant_const';
pt(1).dtname     = 'real_T';

pt(getlenPT) = pt(1);


  
pt(2).blockname = 'Compare To Constant1';
pt(2).paramname = 'const';
pt(2).class     = 'scalar';
pt(2).nrows     = 1;
pt(2).ncols     = 1;
pt(2).subsource = 'SS_DOUBLE';
pt(2).ndims     = '2';
pt(2).size      = '[]';
pt(2).isStruct  = false;
pt(2).symbol     = 'quadripulse_controller14_P.CompareToConstant1_const';
pt(2).baseaddr   = '&quadripulse_controller14_P.CompareToConstant1_const';
pt(2).dtname     = 'real_T';



  
pt(3).blockname = 'Compare To Constant2';
pt(3).paramname = 'const';
pt(3).class     = 'scalar';
pt(3).nrows     = 1;
pt(3).ncols     = 1;
pt(3).subsource = 'SS_DOUBLE';
pt(3).ndims     = '2';
pt(3).size      = '[]';
pt(3).isStruct  = false;
pt(3).symbol     = 'quadripulse_controller14_P.CompareToConstant2_const';
pt(3).baseaddr   = '&quadripulse_controller14_P.CompareToConstant2_const';
pt(3).dtname     = 'real_T';



  
pt(4).blockname = 'Compare To Constant3';
pt(4).paramname = 'const';
pt(4).class     = 'scalar';
pt(4).nrows     = 1;
pt(4).ncols     = 1;
pt(4).subsource = 'SS_DOUBLE';
pt(4).ndims     = '2';
pt(4).size      = '[]';
pt(4).isStruct  = false;
pt(4).symbol     = 'quadripulse_controller14_P.CompareToConstant3_const';
pt(4).baseaddr   = '&quadripulse_controller14_P.CompareToConstant3_const';
pt(4).dtname     = 'real_T';



  
pt(5).blockname = 'S-R Flip-Flop';
pt(5).paramname = 'initial_condition';
pt(5).class     = 'scalar';
pt(5).nrows     = 1;
pt(5).ncols     = 1;
pt(5).subsource = 'SS_BOOLEAN';
pt(5).ndims     = '2';
pt(5).size      = '[]';
pt(5).isStruct  = false;
pt(5).symbol     = 'quadripulse_controller14_P.SRFlipFlop_initial_condition';
pt(5).baseaddr   = '&quadripulse_controller14_P.SRFlipFlop_initial_condition';
pt(5).dtname     = 'boolean_T';



  
pt(6).blockname = 'Constant4';
pt(6).paramname = 'Value';
pt(6).class     = 'scalar';
pt(6).nrows     = 1;
pt(6).ncols     = 1;
pt(6).subsource = 'SS_BOOLEAN';
pt(6).ndims     = '2';
pt(6).size      = '[]';
pt(6).isStruct  = false;
pt(6).symbol     = 'quadripulse_controller14_P.Constant4_Value';
pt(6).baseaddr   = '&quadripulse_controller14_P.Constant4_Value';
pt(6).dtname     = 'boolean_T';



  
pt(7).blockname = 'Constant6';
pt(7).paramname = 'Value';
pt(7).class     = 'scalar';
pt(7).nrows     = 1;
pt(7).ncols     = 1;
pt(7).subsource = 'SS_BOOLEAN';
pt(7).ndims     = '2';
pt(7).size      = '[]';
pt(7).isStruct  = false;
pt(7).symbol     = 'quadripulse_controller14_P.Constant6_Value';
pt(7).baseaddr   = '&quadripulse_controller14_P.Constant6_Value';
pt(7).dtname     = 'boolean_T';



  
pt(8).blockname = 'AC Mode Scaling Factor';
pt(8).paramname = 'Gain';
pt(8).class     = 'scalar';
pt(8).nrows     = 1;
pt(8).ncols     = 1;
pt(8).subsource = 'SS_DOUBLE';
pt(8).ndims     = '2';
pt(8).size      = '[]';
pt(8).isStruct  = false;
pt(8).symbol     = 'quadripulse_controller14_P.ACModeScalingFactor_Gain';
pt(8).baseaddr   = '&quadripulse_controller14_P.ACModeScalingFactor_Gain';
pt(8).dtname     = 'real_T';



  
pt(9).blockname = 'Hit  Crossing';
pt(9).paramname = 'HitCrossingOffset';
pt(9).class     = 'scalar';
pt(9).nrows     = 1;
pt(9).ncols     = 1;
pt(9).subsource = 'SS_DOUBLE';
pt(9).ndims     = '2';
pt(9).size      = '[]';
pt(9).isStruct  = false;
pt(9).symbol     = 'quadripulse_controller14_P.HitCrossing_Offset_b';
pt(9).baseaddr   = '&quadripulse_controller14_P.HitCrossing_Offset_b';
pt(9).dtname     = 'real_T';



  
pt(10).blockname = 'PD2-MF 12bit series';
pt(10).paramname = 'P1';
pt(10).class     = 'vector';
pt(10).nrows     = 1;
pt(10).ncols     = 4;
pt(10).subsource = 'SS_DOUBLE';
pt(10).ndims     = '2';
pt(10).size      = '[]';
pt(10).isStruct  = false;
pt(10).symbol     = 'quadripulse_controller14_P.PD2MF12bitseries_P1';
pt(10).baseaddr   = '&quadripulse_controller14_P.PD2MF12bitseries_P1[0]';
pt(10).dtname     = 'real_T';



  
pt(11).blockname = 'PD2-MF 12bit series';
pt(11).paramname = 'P2';
pt(11).class     = 'vector';
pt(11).nrows     = 1;
pt(11).ncols     = 4;
pt(11).subsource = 'SS_DOUBLE';
pt(11).ndims     = '2';
pt(11).size      = '[]';
pt(11).isStruct  = false;
pt(11).symbol     = 'quadripulse_controller14_P.PD2MF12bitseries_P2';
pt(11).baseaddr   = '&quadripulse_controller14_P.PD2MF12bitseries_P2[0]';
pt(11).dtname     = 'real_T';



  
pt(12).blockname = 'PD2-MF 12bit series';
pt(12).paramname = 'P3';
pt(12).class     = 'vector';
pt(12).nrows     = 1;
pt(12).ncols     = 4;
pt(12).subsource = 'SS_DOUBLE';
pt(12).ndims     = '2';
pt(12).size      = '[]';
pt(12).isStruct  = false;
pt(12).symbol     = 'quadripulse_controller14_P.PD2MF12bitseries_P3';
pt(12).baseaddr   = '&quadripulse_controller14_P.PD2MF12bitseries_P3[0]';
pt(12).dtname     = 'real_T';



  
pt(13).blockname = 'PD2-MF 12bit series';
pt(13).paramname = 'P4';
pt(13).class     = 'scalar';
pt(13).nrows     = 1;
pt(13).ncols     = 1;
pt(13).subsource = 'SS_DOUBLE';
pt(13).ndims     = '2';
pt(13).size      = '[]';
pt(13).isStruct  = false;
pt(13).symbol     = 'quadripulse_controller14_P.PD2MF12bitseries_P4';
pt(13).baseaddr   = '&quadripulse_controller14_P.PD2MF12bitseries_P4';
pt(13).dtname     = 'real_T';



  
pt(14).blockname = 'PD2-MF 12bit series';
pt(14).paramname = 'P5';
pt(14).class     = 'scalar';
pt(14).nrows     = 1;
pt(14).ncols     = 1;
pt(14).subsource = 'SS_DOUBLE';
pt(14).ndims     = '2';
pt(14).size      = '[]';
pt(14).isStruct  = false;
pt(14).symbol     = 'quadripulse_controller14_P.PD2MF12bitseries_P5';
pt(14).baseaddr   = '&quadripulse_controller14_P.PD2MF12bitseries_P5';
pt(14).dtname     = 'real_T';



  
pt(15).blockname = 'PD2-MF 12bit series';
pt(15).paramname = 'P6';
pt(15).class     = 'scalar';
pt(15).nrows     = 1;
pt(15).ncols     = 1;
pt(15).subsource = 'SS_DOUBLE';
pt(15).ndims     = '2';
pt(15).size      = '[]';
pt(15).isStruct  = false;
pt(15).symbol     = 'quadripulse_controller14_P.PD2MF12bitseries_P6';
pt(15).baseaddr   = '&quadripulse_controller14_P.PD2MF12bitseries_P6';
pt(15).dtname     = 'real_T';



  
pt(16).blockname = 'PD2-MF 12bit series';
pt(16).paramname = 'P7';
pt(16).class     = 'scalar';
pt(16).nrows     = 1;
pt(16).ncols     = 1;
pt(16).subsource = 'SS_DOUBLE';
pt(16).ndims     = '2';
pt(16).size      = '[]';
pt(16).isStruct  = false;
pt(16).symbol     = 'quadripulse_controller14_P.PD2MF12bitseries_P7';
pt(16).baseaddr   = '&quadripulse_controller14_P.PD2MF12bitseries_P7';
pt(16).dtname     = 'real_T';



  
pt(17).blockname = 'PD2-MF 12bit series';
pt(17).paramname = 'P8';
pt(17).class     = 'vector';
pt(17).nrows     = 1;
pt(17).ncols     = 23;
pt(17).subsource = 'SS_DOUBLE';
pt(17).ndims     = '2';
pt(17).size      = '[]';
pt(17).isStruct  = false;
pt(17).symbol     = 'quadripulse_controller14_P.PD2MF12bitseries_P8';
pt(17).baseaddr   = '&quadripulse_controller14_P.PD2MF12bitseries_P8[0]';
pt(17).dtname     = 'real_T';



  
pt(18).blockname = 'Parallel Port DO ';
pt(18).paramname = 'P1';
pt(18).class     = 'scalar';
pt(18).nrows     = 1;
pt(18).ncols     = 1;
pt(18).subsource = 'SS_DOUBLE';
pt(18).ndims     = '2';
pt(18).size      = '[]';
pt(18).isStruct  = false;
pt(18).symbol     = 'quadripulse_controller14_P.ParallelPortDO_P1';
pt(18).baseaddr   = '&quadripulse_controller14_P.ParallelPortDO_P1';
pt(18).dtname     = 'real_T';



  
pt(19).blockname = 'Parallel Port DO ';
pt(19).paramname = 'P2';
pt(19).class     = 'scalar';
pt(19).nrows     = 1;
pt(19).ncols     = 1;
pt(19).subsource = 'SS_DOUBLE';
pt(19).ndims     = '2';
pt(19).size      = '[]';
pt(19).isStruct  = false;
pt(19).symbol     = 'quadripulse_controller14_P.ParallelPortDO_P2';
pt(19).baseaddr   = '&quadripulse_controller14_P.ParallelPortDO_P2';
pt(19).dtname     = 'real_T';



  
pt(20).blockname = 'Parallel Port DO ';
pt(20).paramname = 'P3';
pt(20).class     = 'scalar';
pt(20).nrows     = 1;
pt(20).ncols     = 1;
pt(20).subsource = 'SS_DOUBLE';
pt(20).ndims     = '2';
pt(20).size      = '[]';
pt(20).isStruct  = false;
pt(20).symbol     = 'quadripulse_controller14_P.ParallelPortDO_P3';
pt(20).baseaddr   = '&quadripulse_controller14_P.ParallelPortDO_P3';
pt(20).dtname     = 'real_T';



  
pt(21).blockname = 'Parallel Port DO ';
pt(21).paramname = 'P4';
pt(21).class     = 'scalar';
pt(21).nrows     = 1;
pt(21).ncols     = 1;
pt(21).subsource = 'SS_DOUBLE';
pt(21).ndims     = '2';
pt(21).size      = '[]';
pt(21).isStruct  = false;
pt(21).symbol     = 'quadripulse_controller14_P.ParallelPortDO_P4';
pt(21).baseaddr   = '&quadripulse_controller14_P.ParallelPortDO_P4';
pt(21).dtname     = 'real_T';



  
pt(22).blockname = 'Parallel Port DO ';
pt(22).paramname = 'P5';
pt(22).class     = 'scalar';
pt(22).nrows     = 1;
pt(22).ncols     = 1;
pt(22).subsource = 'SS_DOUBLE';
pt(22).ndims     = '2';
pt(22).size      = '[]';
pt(22).isStruct  = false;
pt(22).symbol     = 'quadripulse_controller14_P.ParallelPortDO_P5';
pt(22).baseaddr   = '&quadripulse_controller14_P.ParallelPortDO_P5';
pt(22).dtname     = 'real_T';



  
pt(23).blockname = 'Parallel Port DO ';
pt(23).paramname = 'P6';
pt(23).class     = 'scalar';
pt(23).nrows     = 1;
pt(23).ncols     = 1;
pt(23).subsource = 'SS_DOUBLE';
pt(23).ndims     = '2';
pt(23).size      = '[]';
pt(23).isStruct  = false;
pt(23).symbol     = 'quadripulse_controller14_P.ParallelPortDO_P6';
pt(23).baseaddr   = '&quadripulse_controller14_P.ParallelPortDO_P6';
pt(23).dtname     = 'real_T';



  
pt(24).blockname = 'Parallel Port DO ';
pt(24).paramname = 'P7';
pt(24).class     = 'scalar';
pt(24).nrows     = 1;
pt(24).ncols     = 1;
pt(24).subsource = 'SS_DOUBLE';
pt(24).ndims     = '2';
pt(24).size      = '[]';
pt(24).isStruct  = false;
pt(24).symbol     = 'quadripulse_controller14_P.ParallelPortDO_P7';
pt(24).baseaddr   = '&quadripulse_controller14_P.ParallelPortDO_P7';
pt(24).dtname     = 'real_T';



  
pt(25).blockname = 'Parallel Port DO ';
pt(25).paramname = 'P8';
pt(25).class     = 'scalar';
pt(25).nrows     = 1;
pt(25).ncols     = 1;
pt(25).subsource = 'SS_DOUBLE';
pt(25).ndims     = '2';
pt(25).size      = '[]';
pt(25).isStruct  = false;
pt(25).symbol     = 'quadripulse_controller14_P.ParallelPortDO_P8';
pt(25).baseaddr   = '&quadripulse_controller14_P.ParallelPortDO_P8';
pt(25).dtname     = 'real_T';



  
pt(26).blockname = 'Parallel Port DO ';
pt(26).paramname = 'P9';
pt(26).class     = 'scalar';
pt(26).nrows     = 1;
pt(26).ncols     = 1;
pt(26).subsource = 'SS_DOUBLE';
pt(26).ndims     = '2';
pt(26).size      = '[]';
pt(26).isStruct  = false;
pt(26).symbol     = 'quadripulse_controller14_P.ParallelPortDO_P9';
pt(26).baseaddr   = '&quadripulse_controller14_P.ParallelPortDO_P9';
pt(26).dtname     = 'real_T';



  
pt(27).blockname = 'Manual Switch';
pt(27).paramname = 'CurrentSetting';
pt(27).class     = 'scalar';
pt(27).nrows     = 1;
pt(27).ncols     = 1;
pt(27).subsource = 'SS_UINT8';
pt(27).ndims     = '2';
pt(27).size      = '[]';
pt(27).isStruct  = false;
pt(27).symbol     = 'quadripulse_controller14_P.ManualSwitch_CurrentSetting';
pt(27).baseaddr   = '&quadripulse_controller14_P.ManualSwitch_CurrentSetting';
pt(27).dtname     = 'uint8_T';



  
pt(28).blockname = 'Buffer';
pt(28).paramname = 'ic';
pt(28).class     = 'scalar';
pt(28).nrows     = 1;
pt(28).ncols     = 1;
pt(28).subsource = 'SS_DOUBLE';
pt(28).ndims     = '2';
pt(28).size      = '[]';
pt(28).isStruct  = false;
pt(28).symbol     = 'quadripulse_controller14_P.Buffer_ic_n';
pt(28).baseaddr   = '&quadripulse_controller14_P.Buffer_ic_n';
pt(28).dtname     = 'real_T';



  
pt(29).blockname = 'Delay1';
pt(29).paramname = 'DelayLength';
pt(29).class     = 'scalar';
pt(29).nrows     = 1;
pt(29).ncols     = 1;
pt(29).subsource = 'SS_UINT32';
pt(29).ndims     = '2';
pt(29).size      = '[]';
pt(29).isStruct  = false;
pt(29).symbol     = 'quadripulse_controller14_P.Delay1_DelayLength';
pt(29).baseaddr   = '&quadripulse_controller14_P.Delay1_DelayLength';
pt(29).dtname     = 'uint32_T';



  
pt(30).blockname = 'Delay1';
pt(30).paramname = 'InitialCondition';
pt(30).class     = 'scalar';
pt(30).nrows     = 1;
pt(30).ncols     = 1;
pt(30).subsource = 'SS_DOUBLE';
pt(30).ndims     = '2';
pt(30).size      = '[]';
pt(30).isStruct  = false;
pt(30).symbol     = 'quadripulse_controller14_P.Delay1_InitialCondition';
pt(30).baseaddr   = '&quadripulse_controller14_P.Delay1_InitialCondition';
pt(30).dtname     = 'real_T';



  
pt(31).blockname = 'Delay2';
pt(31).paramname = 'DelayLength';
pt(31).class     = 'scalar';
pt(31).nrows     = 1;
pt(31).ncols     = 1;
pt(31).subsource = 'SS_UINT32';
pt(31).ndims     = '2';
pt(31).size      = '[]';
pt(31).isStruct  = false;
pt(31).symbol     = 'quadripulse_controller14_P.Delay2_DelayLength';
pt(31).baseaddr   = '&quadripulse_controller14_P.Delay2_DelayLength';
pt(31).dtname     = 'uint32_T';



  
pt(32).blockname = 'Delay2';
pt(32).paramname = 'InitialCondition';
pt(32).class     = 'scalar';
pt(32).nrows     = 1;
pt(32).ncols     = 1;
pt(32).subsource = 'SS_DOUBLE';
pt(32).ndims     = '2';
pt(32).size      = '[]';
pt(32).isStruct  = false;
pt(32).symbol     = 'quadripulse_controller14_P.Delay2_InitialCondition';
pt(32).baseaddr   = '&quadripulse_controller14_P.Delay2_InitialCondition';
pt(32).dtname     = 'real_T';



  
pt(33).blockname = 'Unit Delay';
pt(33).paramname = 'InitialCondition';
pt(33).class     = 'scalar';
pt(33).nrows     = 1;
pt(33).ncols     = 1;
pt(33).subsource = 'SS_BOOLEAN';
pt(33).ndims     = '2';
pt(33).size      = '[]';
pt(33).isStruct  = false;
pt(33).symbol     = 'quadripulse_controller14_P.UnitDelay_InitialCondition_i';
pt(33).baseaddr   = '&quadripulse_controller14_P.UnitDelay_InitialCondition_i';
pt(33).dtname     = 'boolean_T';



  
pt(34).blockname = 'Average Refernce/Constant';
pt(34).paramname = 'Value';
pt(34).class     = 'scalar';
pt(34).nrows     = 1;
pt(34).ncols     = 1;
pt(34).subsource = 'SS_DOUBLE';
pt(34).ndims     = '2';
pt(34).size      = '[]';
pt(34).isStruct  = false;
pt(34).symbol     = 'quadripulse_controller14_P.Constant_Value';
pt(34).baseaddr   = '&quadripulse_controller14_P.Constant_Value';
pt(34).dtname     = 'real_T';



  
pt(35).blockname = 'Compare To Zero/Constant';
pt(35).paramname = 'Value';
pt(35).class     = 'scalar';
pt(35).nrows     = 1;
pt(35).ncols     = 1;
pt(35).subsource = 'SS_DOUBLE';
pt(35).ndims     = '2';
pt(35).size      = '[]';
pt(35).isStruct  = false;
pt(35).symbol     = 'quadripulse_controller14_P.Constant_Value_i';
pt(35).baseaddr   = '&quadripulse_controller14_P.Constant_Value_i';
pt(35).dtname     = 'real_T';



  
pt(36).blockname = 'Detrend and FFT/Constant5';
pt(36).paramname = 'Value';
pt(36).class     = 'vector';
pt(36).nrows     = 100;
pt(36).ncols     = 1;
pt(36).subsource = 'SS_DOUBLE';
pt(36).ndims     = '2';
pt(36).size      = '[]';
pt(36).isStruct  = false;
pt(36).symbol     = 'quadripulse_controller14_P.Constant5_Value';
pt(36).baseaddr   = '&quadripulse_controller14_P.Constant5_Value[0]';
pt(36).dtname     = 'real_T';



  
pt(37).blockname = 'Detrend and FFT/scale to per Hz';
pt(37).paramname = 'Gain';
pt(37).class     = 'scalar';
pt(37).nrows     = 1;
pt(37).ncols     = 1;
pt(37).subsource = 'SS_DOUBLE';
pt(37).ndims     = '2';
pt(37).size      = '[]';
pt(37).isStruct  = false;
pt(37).symbol     = 'quadripulse_controller14_P.scaletoperHz_Gain';
pt(37).baseaddr   = '&quadripulse_controller14_P.scaletoperHz_Gain';
pt(37).dtname     = 'real_T';



  
pt(38).blockname = 'Detrend and FFT/Pad';
pt(38).paramname = 'padVal';
pt(38).class     = 'scalar';
pt(38).nrows     = 1;
pt(38).ncols     = 1;
pt(38).subsource = 'SS_DOUBLE';
pt(38).ndims     = '2';
pt(38).size      = '[]';
pt(38).isStruct  = false;
pt(38).symbol     = 'quadripulse_controller14_P.Pad_padVal';
pt(38).baseaddr   = '&quadripulse_controller14_P.Pad_padVal';
pt(38).dtname     = 'real_T';



  
pt(39).blockname = 'Detrend and FFT/Pad';
pt(39).paramname = 'outDims';
pt(39).class     = 'vector';
pt(39).nrows     = 1;
pt(39).ncols     = 2;
pt(39).subsource = 'SS_INT32';
pt(39).ndims     = '2';
pt(39).size      = '[]';
pt(39).isStruct  = false;
pt(39).symbol     = 'quadripulse_controller14_P.Pad_outDims';
pt(39).baseaddr   = '&quadripulse_controller14_P.Pad_outDims[0]';
pt(39).dtname     = 'int32_T';



  
pt(40).blockname = 'Detrend and FFT/Pad';
pt(40).paramname = 'padBefore';
pt(40).class     = 'vector';
pt(40).nrows     = 1;
pt(40).ncols     = 2;
pt(40).subsource = 'SS_INT32';
pt(40).ndims     = '2';
pt(40).size      = '[]';
pt(40).isStruct  = false;
pt(40).symbol     = 'quadripulse_controller14_P.Pad_padBefore';
pt(40).baseaddr   = '&quadripulse_controller14_P.Pad_padBefore[0]';
pt(40).dtname     = 'int32_T';



  
pt(41).blockname = 'Detrend and FFT/Pad';
pt(41).paramname = 'padAfter';
pt(41).class     = 'vector';
pt(41).nrows     = 1;
pt(41).ncols     = 2;
pt(41).subsource = 'SS_INT32';
pt(41).ndims     = '2';
pt(41).size      = '[]';
pt(41).isStruct  = false;
pt(41).symbol     = 'quadripulse_controller14_P.Pad_padAfter';
pt(41).baseaddr   = '&quadripulse_controller14_P.Pad_padAfter[0]';
pt(41).dtname     = 'int32_T';



  
pt(42).blockname = 'Detrend and FFT/Pad';
pt(42).paramname = 'inWorkAdd';
pt(42).class     = 'vector';
pt(42).nrows     = 1;
pt(42).ncols     = 2;
pt(42).subsource = 'SS_INT32';
pt(42).ndims     = '2';
pt(42).size      = '[]';
pt(42).isStruct  = false;
pt(42).symbol     = 'quadripulse_controller14_P.Pad_inWorkAdd';
pt(42).baseaddr   = '&quadripulse_controller14_P.Pad_inWorkAdd[0]';
pt(42).dtname     = 'int32_T';



  
pt(43).blockname = 'Detrend and FFT/Pad';
pt(43).paramname = 'outWorkAdd';
pt(43).class     = 'vector';
pt(43).nrows     = 1;
pt(43).ncols     = 2;
pt(43).subsource = 'SS_INT32';
pt(43).ndims     = '2';
pt(43).size      = '[]';
pt(43).isStruct  = false;
pt(43).symbol     = 'quadripulse_controller14_P.Pad_outWorkAdd';
pt(43).baseaddr   = '&quadripulse_controller14_P.Pad_outWorkAdd[0]';
pt(43).dtname     = 'int32_T';



  
pt(44).blockname = 'Detrend and FFT/Unbuffer';
pt(44).paramname = 'ic';
pt(44).class     = 'scalar';
pt(44).nrows     = 1;
pt(44).ncols     = 1;
pt(44).subsource = 'SS_DOUBLE';
pt(44).ndims     = '2';
pt(44).size      = '[]';
pt(44).isStruct  = false;
pt(44).symbol     = 'quadripulse_controller14_P.Unbuffer_ic';
pt(44).baseaddr   = '&quadripulse_controller14_P.Unbuffer_ic';
pt(44).dtname     = 'real_T';



  
pt(45).blockname = 'Fan Out with Offset for Scope Display /Running Average';
pt(45).paramname = 'N';
pt(45).class     = 'scalar';
pt(45).nrows     = 1;
pt(45).ncols     = 1;
pt(45).subsource = 'SS_DOUBLE';
pt(45).ndims     = '2';
pt(45).size      = '[]';
pt(45).isStruct  = false;
pt(45).symbol     = 'quadripulse_controller14_P.RunningAverage_N';
pt(45).baseaddr   = '&quadripulse_controller14_P.RunningAverage_N';
pt(45).dtname     = 'real_T';



  
pt(46).blockname = 'Forward and Backward Band Pass Filter/FIR Bandpass Filter Backward';
pt(46).paramname = 'InitialStates';
pt(46).class     = 'scalar';
pt(46).nrows     = 1;
pt(46).ncols     = 1;
pt(46).subsource = 'SS_DOUBLE';
pt(46).ndims     = '2';
pt(46).size      = '[]';
pt(46).isStruct  = false;
pt(46).symbol     = 'quadripulse_controller14_P.FIRBandpassFilterBackward_Initi';
pt(46).baseaddr   = '&quadripulse_controller14_P.FIRBandpassFilterBackward_Initi';
pt(46).dtname     = 'real_T';



  
pt(47).blockname = 'Forward and Backward Band Pass Filter/FIR Bandpass Filter Forward';
pt(47).paramname = 'InitialStates';
pt(47).class     = 'scalar';
pt(47).nrows     = 1;
pt(47).ncols     = 1;
pt(47).subsource = 'SS_DOUBLE';
pt(47).ndims     = '2';
pt(47).size      = '[]';
pt(47).isStruct  = false;
pt(47).symbol     = 'quadripulse_controller14_P.FIRBandpassFilterForward_Initia';
pt(47).baseaddr   = '&quadripulse_controller14_P.FIRBandpassFilterForward_Initia';
pt(47).dtname     = 'real_T';



  
pt(48).blockname = 'Real-time UDP  Configuration/ARP Init ';
pt(48).paramname = 'P1';
pt(48).class     = 'scalar';
pt(48).nrows     = 1;
pt(48).ncols     = 1;
pt(48).subsource = 'SS_DOUBLE';
pt(48).ndims     = '2';
pt(48).size      = '[]';
pt(48).isStruct  = false;
pt(48).symbol     = 'quadripulse_controller14_P.ARPInit_P1';
pt(48).baseaddr   = '&quadripulse_controller14_P.ARPInit_P1';
pt(48).dtname     = 'real_T';



  
pt(49).blockname = 'Real-time UDP  Configuration/ARP Init ';
pt(49).paramname = 'P2';
pt(49).class     = 'scalar';
pt(49).nrows     = 1;
pt(49).ncols     = 1;
pt(49).subsource = 'SS_DOUBLE';
pt(49).ndims     = '2';
pt(49).size      = '[]';
pt(49).isStruct  = false;
pt(49).symbol     = 'quadripulse_controller14_P.ARPInit_P2';
pt(49).baseaddr   = '&quadripulse_controller14_P.ARPInit_P2';
pt(49).dtname     = 'real_T';



  
pt(50).blockname = 'Real-time UDP  Configuration/ARP Init ';
pt(50).paramname = 'P3';
pt(50).class     = 'scalar';
pt(50).nrows     = 1;
pt(50).ncols     = 1;
pt(50).subsource = 'SS_DOUBLE';
pt(50).ndims     = '2';
pt(50).size      = '[]';
pt(50).isStruct  = false;
pt(50).symbol     = 'quadripulse_controller14_P.ARPInit_P3';
pt(50).baseaddr   = '&quadripulse_controller14_P.ARPInit_P3';
pt(50).dtname     = 'real_T';



  
pt(51).blockname = 'Real-time UDP  Configuration/ARP Init ';
pt(51).paramname = 'P4';
pt(51).class     = 'scalar';
pt(51).nrows     = 1;
pt(51).ncols     = 1;
pt(51).subsource = 'SS_DOUBLE';
pt(51).ndims     = '2';
pt(51).size      = '[]';
pt(51).isStruct  = false;
pt(51).symbol     = 'quadripulse_controller14_P.ARPInit_P4';
pt(51).baseaddr   = '&quadripulse_controller14_P.ARPInit_P4';
pt(51).dtname     = 'real_T';



  
pt(52).blockname = 'Real-time UDP  Configuration/ARP Init ';
pt(52).paramname = 'P5';
pt(52).class     = 'scalar';
pt(52).nrows     = 1;
pt(52).ncols     = 1;
pt(52).subsource = 'SS_DOUBLE';
pt(52).ndims     = '2';
pt(52).size      = '[]';
pt(52).isStruct  = false;
pt(52).symbol     = 'quadripulse_controller14_P.ARPInit_P5';
pt(52).baseaddr   = '&quadripulse_controller14_P.ARPInit_P5';
pt(52).dtname     = 'real_T';



  
pt(53).blockname = 'Real-time UDP  Configuration/ARP Init ';
pt(53).paramname = 'P6';
pt(53).class     = 'scalar';
pt(53).nrows     = 1;
pt(53).ncols     = 1;
pt(53).subsource = 'SS_DOUBLE';
pt(53).ndims     = '2';
pt(53).size      = '[]';
pt(53).isStruct  = false;
pt(53).symbol     = 'quadripulse_controller14_P.ARPInit_P6';
pt(53).baseaddr   = '&quadripulse_controller14_P.ARPInit_P6';
pt(53).dtname     = 'real_T';



  
pt(54).blockname = 'Real-time UDP  Configuration/ARP Init ';
pt(54).paramname = 'P7';
pt(54).class     = 'scalar';
pt(54).nrows     = 1;
pt(54).ncols     = 1;
pt(54).subsource = 'SS_DOUBLE';
pt(54).ndims     = '2';
pt(54).size      = '[]';
pt(54).isStruct  = false;
pt(54).symbol     = 'quadripulse_controller14_P.ARPInit_P7';
pt(54).baseaddr   = '&quadripulse_controller14_P.ARPInit_P7';
pt(54).dtname     = 'real_T';



  
pt(55).blockname = 'Real-time UDP  Configuration/ARP Init ';
pt(55).paramname = 'P8';
pt(55).class     = 'scalar';
pt(55).nrows     = 1;
pt(55).ncols     = 1;
pt(55).subsource = 'SS_DOUBLE';
pt(55).ndims     = '2';
pt(55).size      = '[]';
pt(55).isStruct  = false;
pt(55).symbol     = 'quadripulse_controller14_P.ARPInit_P8';
pt(55).baseaddr   = '&quadripulse_controller14_P.ARPInit_P8';
pt(55).dtname     = 'real_T';



  
pt(56).blockname = 'Real-time UDP  Configuration/ARP Init ';
pt(56).paramname = 'P9';
pt(56).class     = 'scalar';
pt(56).nrows     = 1;
pt(56).ncols     = 1;
pt(56).subsource = 'SS_DOUBLE';
pt(56).ndims     = '2';
pt(56).size      = '[]';
pt(56).isStruct  = false;
pt(56).symbol     = 'quadripulse_controller14_P.ARPInit_P9';
pt(56).baseaddr   = '&quadripulse_controller14_P.ARPInit_P9';
pt(56).dtname     = 'real_T';



  
pt(57).blockname = 'Real-time UDP  Configuration/ARP Init ';
pt(57).paramname = 'P10';
pt(57).class     = 'scalar';
pt(57).nrows     = 1;
pt(57).ncols     = 1;
pt(57).subsource = 'SS_DOUBLE';
pt(57).ndims     = '2';
pt(57).size      = '[]';
pt(57).isStruct  = false;
pt(57).symbol     = 'quadripulse_controller14_P.ARPInit_P10';
pt(57).baseaddr   = '&quadripulse_controller14_P.ARPInit_P10';
pt(57).dtname     = 'real_T';



  
pt(58).blockname = 'Real-time UDP  Configuration/ARP Init ';
pt(58).paramname = 'P11';
pt(58).class     = 'scalar';
pt(58).nrows     = 1;
pt(58).ncols     = 1;
pt(58).subsource = 'SS_DOUBLE';
pt(58).ndims     = '2';
pt(58).size      = '[]';
pt(58).isStruct  = false;
pt(58).symbol     = 'quadripulse_controller14_P.ARPInit_P11';
pt(58).baseaddr   = '&quadripulse_controller14_P.ARPInit_P11';
pt(58).dtname     = 'real_T';



  
pt(59).blockname = 'Real-time UDP  Configuration/ARP Init ';
pt(59).paramname = 'P16';
pt(59).class     = 'scalar';
pt(59).nrows     = 1;
pt(59).ncols     = 1;
pt(59).subsource = 'SS_DOUBLE';
pt(59).ndims     = '2';
pt(59).size      = '[]';
pt(59).isStruct  = false;
pt(59).symbol     = 'quadripulse_controller14_P.ARPInit_P16';
pt(59).baseaddr   = '&quadripulse_controller14_P.ARPInit_P16';
pt(59).dtname     = 'real_T';



  
pt(60).blockname = 'Real-time UDP  Configuration/Buffer Mngmt ';
pt(60).paramname = 'P1';
pt(60).class     = 'vector';
pt(60).nrows     = 1;
pt(60).ncols     = 4;
pt(60).subsource = 'SS_DOUBLE';
pt(60).ndims     = '2';
pt(60).size      = '[]';
pt(60).isStruct  = false;
pt(60).symbol     = 'quadripulse_controller14_P.BufferMngmt_P1';
pt(60).baseaddr   = '&quadripulse_controller14_P.BufferMngmt_P1[0]';
pt(60).dtname     = 'real_T';



  
pt(61).blockname = 'Real-time UDP  Configuration/Buffer Mngmt ';
pt(61).paramname = 'P2';
pt(61).class     = 'scalar';
pt(61).nrows     = 1;
pt(61).ncols     = 1;
pt(61).subsource = 'SS_DOUBLE';
pt(61).ndims     = '2';
pt(61).size      = '[]';
pt(61).isStruct  = false;
pt(61).symbol     = 'quadripulse_controller14_P.BufferMngmt_P2';
pt(61).baseaddr   = '&quadripulse_controller14_P.BufferMngmt_P2';
pt(61).dtname     = 'real_T';



  
pt(62).blockname = 'Real-time UDP  Configuration/Buffer Mngmt ';
pt(62).paramname = 'P3';
pt(62).class     = 'scalar';
pt(62).nrows     = 1;
pt(62).ncols     = 1;
pt(62).subsource = 'SS_DOUBLE';
pt(62).ndims     = '2';
pt(62).size      = '[]';
pt(62).isStruct  = false;
pt(62).symbol     = 'quadripulse_controller14_P.BufferMngmt_P3';
pt(62).baseaddr   = '&quadripulse_controller14_P.BufferMngmt_P3';
pt(62).dtname     = 'real_T';



  
pt(63).blockname = 'Real-time UDP  Configuration/Ethernet Init ';
pt(63).paramname = 'P1';
pt(63).class     = 'scalar';
pt(63).nrows     = 1;
pt(63).ncols     = 1;
pt(63).subsource = 'SS_DOUBLE';
pt(63).ndims     = '2';
pt(63).size      = '[]';
pt(63).isStruct  = false;
pt(63).symbol     = 'quadripulse_controller14_P.EthernetInit_P1';
pt(63).baseaddr   = '&quadripulse_controller14_P.EthernetInit_P1';
pt(63).dtname     = 'real_T';



  
pt(64).blockname = 'Real-time UDP  Configuration/Ethernet Init ';
pt(64).paramname = 'P2';
pt(64).class     = 'scalar';
pt(64).nrows     = 1;
pt(64).ncols     = 1;
pt(64).subsource = 'SS_DOUBLE';
pt(64).ndims     = '2';
pt(64).size      = '[]';
pt(64).isStruct  = false;
pt(64).symbol     = 'quadripulse_controller14_P.EthernetInit_P2';
pt(64).baseaddr   = '&quadripulse_controller14_P.EthernetInit_P2';
pt(64).dtname     = 'real_T';



  
pt(65).blockname = 'Real-time UDP  Configuration/Ethernet Init ';
pt(65).paramname = 'P3';
pt(65).class     = 'scalar';
pt(65).nrows     = 1;
pt(65).ncols     = 1;
pt(65).subsource = 'SS_DOUBLE';
pt(65).ndims     = '2';
pt(65).size      = '[]';
pt(65).isStruct  = false;
pt(65).symbol     = 'quadripulse_controller14_P.EthernetInit_P3';
pt(65).baseaddr   = '&quadripulse_controller14_P.EthernetInit_P3';
pt(65).dtname     = 'real_T';



  
pt(66).blockname = 'Real-time UDP  Configuration/Ethernet Init ';
pt(66).paramname = 'P4';
pt(66).class     = 'scalar';
pt(66).nrows     = 1;
pt(66).ncols     = 1;
pt(66).subsource = 'SS_DOUBLE';
pt(66).ndims     = '2';
pt(66).size      = '[]';
pt(66).isStruct  = false;
pt(66).symbol     = 'quadripulse_controller14_P.EthernetInit_P4';
pt(66).baseaddr   = '&quadripulse_controller14_P.EthernetInit_P4';
pt(66).dtname     = 'real_T';



  
pt(67).blockname = 'Real-time UDP  Configuration/Ethernet Init ';
pt(67).paramname = 'P5';
pt(67).class     = 'scalar';
pt(67).nrows     = 1;
pt(67).ncols     = 1;
pt(67).subsource = 'SS_DOUBLE';
pt(67).ndims     = '2';
pt(67).size      = '[]';
pt(67).isStruct  = false;
pt(67).symbol     = 'quadripulse_controller14_P.EthernetInit_P5';
pt(67).baseaddr   = '&quadripulse_controller14_P.EthernetInit_P5';
pt(67).dtname     = 'real_T';



  
pt(68).blockname = 'Real-time UDP  Configuration/Ethernet Init ';
pt(68).paramname = 'P6';
pt(68).class     = 'scalar';
pt(68).nrows     = 1;
pt(68).ncols     = 1;
pt(68).subsource = 'SS_DOUBLE';
pt(68).ndims     = '2';
pt(68).size      = '[]';
pt(68).isStruct  = false;
pt(68).symbol     = 'quadripulse_controller14_P.EthernetInit_P6';
pt(68).baseaddr   = '&quadripulse_controller14_P.EthernetInit_P6';
pt(68).dtname     = 'real_T';



  
pt(69).blockname = 'Real-time UDP  Configuration/Ethernet Init ';
pt(69).paramname = 'P7';
pt(69).class     = 'scalar';
pt(69).nrows     = 1;
pt(69).ncols     = 1;
pt(69).subsource = 'SS_DOUBLE';
pt(69).ndims     = '2';
pt(69).size      = '[]';
pt(69).isStruct  = false;
pt(69).symbol     = 'quadripulse_controller14_P.EthernetInit_P7';
pt(69).baseaddr   = '&quadripulse_controller14_P.EthernetInit_P7';
pt(69).dtname     = 'real_T';



  
pt(70).blockname = 'Real-time UDP  Configuration/Ethernet Init ';
pt(70).paramname = 'P8';
pt(70).class     = 'vector';
pt(70).nrows     = 1;
pt(70).ncols     = 6;
pt(70).subsource = 'SS_DOUBLE';
pt(70).ndims     = '2';
pt(70).size      = '[]';
pt(70).isStruct  = false;
pt(70).symbol     = 'quadripulse_controller14_P.EthernetInit_P8';
pt(70).baseaddr   = '&quadripulse_controller14_P.EthernetInit_P8[0]';
pt(70).dtname     = 'real_T';



  
pt(71).blockname = 'Real-time UDP  Configuration/Ethernet Init ';
pt(71).paramname = 'P9';
pt(71).class     = 'scalar';
pt(71).nrows     = 1;
pt(71).ncols     = 1;
pt(71).subsource = 'SS_DOUBLE';
pt(71).ndims     = '2';
pt(71).size      = '[]';
pt(71).isStruct  = false;
pt(71).symbol     = 'quadripulse_controller14_P.EthernetInit_P9';
pt(71).baseaddr   = '&quadripulse_controller14_P.EthernetInit_P9';
pt(71).dtname     = 'real_T';



  
pt(72).blockname = 'Real-time UDP  Configuration/Ethernet Init ';
pt(72).paramname = 'P10';
pt(72).class     = 'scalar';
pt(72).nrows     = 1;
pt(72).ncols     = 1;
pt(72).subsource = 'SS_DOUBLE';
pt(72).ndims     = '2';
pt(72).size      = '[]';
pt(72).isStruct  = false;
pt(72).symbol     = 'quadripulse_controller14_P.EthernetInit_P10';
pt(72).baseaddr   = '&quadripulse_controller14_P.EthernetInit_P10';
pt(72).dtname     = 'real_T';



  
pt(73).blockname = 'Real-time UDP  Configuration/Ethernet Init ';
pt(73).paramname = 'P11';
pt(73).class     = 'scalar';
pt(73).nrows     = 1;
pt(73).ncols     = 1;
pt(73).subsource = 'SS_DOUBLE';
pt(73).ndims     = '2';
pt(73).size      = '[]';
pt(73).isStruct  = false;
pt(73).symbol     = 'quadripulse_controller14_P.EthernetInit_P11';
pt(73).baseaddr   = '&quadripulse_controller14_P.EthernetInit_P11';
pt(73).dtname     = 'real_T';



  
pt(74).blockname = 'Real-time UDP  Configuration/Ethernet Init ';
pt(74).paramname = 'P12';
pt(74).class     = 'scalar';
pt(74).nrows     = 1;
pt(74).ncols     = 1;
pt(74).subsource = 'SS_DOUBLE';
pt(74).ndims     = '2';
pt(74).size      = '[]';
pt(74).isStruct  = false;
pt(74).symbol     = 'quadripulse_controller14_P.EthernetInit_P12';
pt(74).baseaddr   = '&quadripulse_controller14_P.EthernetInit_P12';
pt(74).dtname     = 'real_T';



  
pt(75).blockname = 'Real-time UDP  Configuration/Ethernet Init ';
pt(75).paramname = 'P13';
pt(75).class     = 'scalar';
pt(75).nrows     = 1;
pt(75).ncols     = 1;
pt(75).subsource = 'SS_DOUBLE';
pt(75).ndims     = '2';
pt(75).size      = '[]';
pt(75).isStruct  = false;
pt(75).symbol     = 'quadripulse_controller14_P.EthernetInit_P13';
pt(75).baseaddr   = '&quadripulse_controller14_P.EthernetInit_P13';
pt(75).dtname     = 'real_T';



  
pt(76).blockname = 'Real-time UDP  Configuration/Ethernet Init ';
pt(76).paramname = 'P14';
pt(76).class     = 'scalar';
pt(76).nrows     = 1;
pt(76).ncols     = 1;
pt(76).subsource = 'SS_DOUBLE';
pt(76).ndims     = '2';
pt(76).size      = '[]';
pt(76).isStruct  = false;
pt(76).symbol     = 'quadripulse_controller14_P.EthernetInit_P14';
pt(76).baseaddr   = '&quadripulse_controller14_P.EthernetInit_P14';
pt(76).dtname     = 'real_T';



  
pt(77).blockname = 'Real-time UDP  Configuration/Ethernet Init ';
pt(77).paramname = 'P15';
pt(77).class     = 'scalar';
pt(77).nrows     = 1;
pt(77).ncols     = 1;
pt(77).subsource = 'SS_DOUBLE';
pt(77).ndims     = '2';
pt(77).size      = '[]';
pt(77).isStruct  = false;
pt(77).symbol     = 'quadripulse_controller14_P.EthernetInit_P15';
pt(77).baseaddr   = '&quadripulse_controller14_P.EthernetInit_P15';
pt(77).dtname     = 'real_T';



  
pt(78).blockname = 'Real-time UDP  Configuration/Ethernet Init ';
pt(78).paramname = 'P16';
pt(78).class     = 'scalar';
pt(78).nrows     = 1;
pt(78).ncols     = 1;
pt(78).subsource = 'SS_DOUBLE';
pt(78).ndims     = '2';
pt(78).size      = '[]';
pt(78).isStruct  = false;
pt(78).symbol     = 'quadripulse_controller14_P.EthernetInit_P16';
pt(78).baseaddr   = '&quadripulse_controller14_P.EthernetInit_P16';
pt(78).dtname     = 'real_T';



  
pt(79).blockname = 'Real-time UDP  Configuration/Ethernet Init ';
pt(79).paramname = 'P17';
pt(79).class     = 'scalar';
pt(79).nrows     = 1;
pt(79).ncols     = 1;
pt(79).subsource = 'SS_DOUBLE';
pt(79).ndims     = '2';
pt(79).size      = '[]';
pt(79).isStruct  = false;
pt(79).symbol     = 'quadripulse_controller14_P.EthernetInit_P17';
pt(79).baseaddr   = '&quadripulse_controller14_P.EthernetInit_P17';
pt(79).dtname     = 'real_T';



  
pt(80).blockname = 'Real-time UDP  Configuration/Ethernet Init ';
pt(80).paramname = 'P18';
pt(80).class     = 'scalar';
pt(80).nrows     = 1;
pt(80).ncols     = 1;
pt(80).subsource = 'SS_DOUBLE';
pt(80).ndims     = '2';
pt(80).size      = '[]';
pt(80).isStruct  = false;
pt(80).symbol     = 'quadripulse_controller14_P.EthernetInit_P18';
pt(80).baseaddr   = '&quadripulse_controller14_P.EthernetInit_P18';
pt(80).dtname     = 'real_T';



  
pt(81).blockname = 'Real-time UDP  Configuration/Ethernet Init ';
pt(81).paramname = 'P20';
pt(81).class     = 'scalar';
pt(81).nrows     = 1;
pt(81).ncols     = 1;
pt(81).subsource = 'SS_DOUBLE';
pt(81).ndims     = '2';
pt(81).size      = '[]';
pt(81).isStruct  = false;
pt(81).symbol     = 'quadripulse_controller14_P.EthernetInit_P20';
pt(81).baseaddr   = '&quadripulse_controller14_P.EthernetInit_P20';
pt(81).dtname     = 'real_T';



  
pt(82).blockname = 'Real-time UDP  Configuration/Ethernet Init ';
pt(82).paramname = 'P21';
pt(82).class     = 'scalar';
pt(82).nrows     = 1;
pt(82).ncols     = 1;
pt(82).subsource = 'SS_DOUBLE';
pt(82).ndims     = '2';
pt(82).size      = '[]';
pt(82).isStruct  = false;
pt(82).symbol     = 'quadripulse_controller14_P.EthernetInit_P21';
pt(82).baseaddr   = '&quadripulse_controller14_P.EthernetInit_P21';
pt(82).dtname     = 'real_T';



  
pt(83).blockname = 'Real-time UDP  Configuration/IP Init ';
pt(83).paramname = 'P1';
pt(83).class     = 'scalar';
pt(83).nrows     = 1;
pt(83).ncols     = 1;
pt(83).subsource = 'SS_DOUBLE';
pt(83).ndims     = '2';
pt(83).size      = '[]';
pt(83).isStruct  = false;
pt(83).symbol     = 'quadripulse_controller14_P.IPInit_P1';
pt(83).baseaddr   = '&quadripulse_controller14_P.IPInit_P1';
pt(83).dtname     = 'real_T';



  
pt(84).blockname = 'Real-time UDP  Configuration/IP Init ';
pt(84).paramname = 'P2';
pt(84).class     = 'scalar';
pt(84).nrows     = 1;
pt(84).ncols     = 1;
pt(84).subsource = 'SS_DOUBLE';
pt(84).ndims     = '2';
pt(84).size      = '[]';
pt(84).isStruct  = false;
pt(84).symbol     = 'quadripulse_controller14_P.IPInit_P2';
pt(84).baseaddr   = '&quadripulse_controller14_P.IPInit_P2';
pt(84).dtname     = 'real_T';



  
pt(85).blockname = 'Real-time UDP  Configuration/IP Init ';
pt(85).paramname = 'P3';
pt(85).class     = 'scalar';
pt(85).nrows     = 1;
pt(85).ncols     = 1;
pt(85).subsource = 'SS_DOUBLE';
pt(85).ndims     = '2';
pt(85).size      = '[]';
pt(85).isStruct  = false;
pt(85).symbol     = 'quadripulse_controller14_P.IPInit_P3';
pt(85).baseaddr   = '&quadripulse_controller14_P.IPInit_P3';
pt(85).dtname     = 'real_T';



  
pt(86).blockname = 'Real-time UDP  Configuration/IP Init ';
pt(86).paramname = 'P4';
pt(86).class     = 'scalar';
pt(86).nrows     = 1;
pt(86).ncols     = 1;
pt(86).subsource = 'SS_DOUBLE';
pt(86).ndims     = '2';
pt(86).size      = '[]';
pt(86).isStruct  = false;
pt(86).symbol     = 'quadripulse_controller14_P.IPInit_P4';
pt(86).baseaddr   = '&quadripulse_controller14_P.IPInit_P4';
pt(86).dtname     = 'real_T';



  
pt(87).blockname = 'Real-time UDP  Configuration/IP Init ';
pt(87).paramname = 'P5';
pt(87).class     = 'scalar';
pt(87).nrows     = 1;
pt(87).ncols     = 1;
pt(87).subsource = 'SS_DOUBLE';
pt(87).ndims     = '2';
pt(87).size      = '[]';
pt(87).isStruct  = false;
pt(87).symbol     = 'quadripulse_controller14_P.IPInit_P5';
pt(87).baseaddr   = '&quadripulse_controller14_P.IPInit_P5';
pt(87).dtname     = 'real_T';



  
pt(88).blockname = 'Real-time UDP  Configuration/IP Init ';
pt(88).paramname = 'P6';
pt(88).class     = 'scalar';
pt(88).nrows     = 1;
pt(88).ncols     = 1;
pt(88).subsource = 'SS_DOUBLE';
pt(88).ndims     = '2';
pt(88).size      = '[]';
pt(88).isStruct  = false;
pt(88).symbol     = 'quadripulse_controller14_P.IPInit_P6';
pt(88).baseaddr   = '&quadripulse_controller14_P.IPInit_P6';
pt(88).dtname     = 'real_T';



  
pt(89).blockname = 'Real-time UDP  Configuration/IP Init ';
pt(89).paramname = 'P7';
pt(89).class     = 'scalar';
pt(89).nrows     = 1;
pt(89).ncols     = 1;
pt(89).subsource = 'SS_DOUBLE';
pt(89).ndims     = '2';
pt(89).size      = '[]';
pt(89).isStruct  = false;
pt(89).symbol     = 'quadripulse_controller14_P.IPInit_P7';
pt(89).baseaddr   = '&quadripulse_controller14_P.IPInit_P7';
pt(89).dtname     = 'real_T';



  
pt(90).blockname = 'Real-time UDP  Configuration/IP Init ';
pt(90).paramname = 'P8';
pt(90).class     = 'scalar';
pt(90).nrows     = 1;
pt(90).ncols     = 1;
pt(90).subsource = 'SS_DOUBLE';
pt(90).ndims     = '2';
pt(90).size      = '[]';
pt(90).isStruct  = false;
pt(90).symbol     = 'quadripulse_controller14_P.IPInit_P8';
pt(90).baseaddr   = '&quadripulse_controller14_P.IPInit_P8';
pt(90).dtname     = 'real_T';



  
pt(91).blockname = 'Real-time UDP  Configuration/IP Init ';
pt(91).paramname = 'P9';
pt(91).class     = 'scalar';
pt(91).nrows     = 1;
pt(91).ncols     = 1;
pt(91).subsource = 'SS_DOUBLE';
pt(91).ndims     = '2';
pt(91).size      = '[]';
pt(91).isStruct  = false;
pt(91).symbol     = 'quadripulse_controller14_P.IPInit_P9';
pt(91).baseaddr   = '&quadripulse_controller14_P.IPInit_P9';
pt(91).dtname     = 'real_T';



  
pt(92).blockname = 'Real-time UDP  Configuration/IP Init ';
pt(92).paramname = 'P10';
pt(92).class     = 'scalar';
pt(92).nrows     = 1;
pt(92).ncols     = 1;
pt(92).subsource = 'SS_DOUBLE';
pt(92).ndims     = '2';
pt(92).size      = '[]';
pt(92).isStruct  = false;
pt(92).symbol     = 'quadripulse_controller14_P.IPInit_P10';
pt(92).baseaddr   = '&quadripulse_controller14_P.IPInit_P10';
pt(92).dtname     = 'real_T';



  
pt(93).blockname = 'Real-time UDP  Configuration/IP Init ';
pt(93).paramname = 'P11';
pt(93).class     = 'scalar';
pt(93).nrows     = 1;
pt(93).ncols     = 1;
pt(93).subsource = 'SS_DOUBLE';
pt(93).ndims     = '2';
pt(93).size      = '[]';
pt(93).isStruct  = false;
pt(93).symbol     = 'quadripulse_controller14_P.IPInit_P11';
pt(93).baseaddr   = '&quadripulse_controller14_P.IPInit_P11';
pt(93).dtname     = 'real_T';



  
pt(94).blockname = 'Real-time UDP  Configuration/IP Init ';
pt(94).paramname = 'P12';
pt(94).class     = 'scalar';
pt(94).nrows     = 1;
pt(94).ncols     = 1;
pt(94).subsource = 'SS_DOUBLE';
pt(94).ndims     = '2';
pt(94).size      = '[]';
pt(94).isStruct  = false;
pt(94).symbol     = 'quadripulse_controller14_P.IPInit_P12';
pt(94).baseaddr   = '&quadripulse_controller14_P.IPInit_P12';
pt(94).dtname     = 'real_T';



  
pt(95).blockname = 'Real-time UDP  Configuration/UDP Init ';
pt(95).paramname = 'P1';
pt(95).class     = 'scalar';
pt(95).nrows     = 1;
pt(95).ncols     = 1;
pt(95).subsource = 'SS_DOUBLE';
pt(95).ndims     = '2';
pt(95).size      = '[]';
pt(95).isStruct  = false;
pt(95).symbol     = 'quadripulse_controller14_P.UDPInit_P1';
pt(95).baseaddr   = '&quadripulse_controller14_P.UDPInit_P1';
pt(95).dtname     = 'real_T';



  
pt(96).blockname = 'Real-time UDP  Configuration/UDP Init ';
pt(96).paramname = 'P2';
pt(96).class     = 'scalar';
pt(96).nrows     = 1;
pt(96).ncols     = 1;
pt(96).subsource = 'SS_DOUBLE';
pt(96).ndims     = '2';
pt(96).size      = '[]';
pt(96).isStruct  = false;
pt(96).symbol     = 'quadripulse_controller14_P.UDPInit_P2';
pt(96).baseaddr   = '&quadripulse_controller14_P.UDPInit_P2';
pt(96).dtname     = 'real_T';



  
pt(97).blockname = 'Real-time UDP  Configuration/UDP Init ';
pt(97).paramname = 'P3';
pt(97).class     = 'scalar';
pt(97).nrows     = 1;
pt(97).ncols     = 1;
pt(97).subsource = 'SS_DOUBLE';
pt(97).ndims     = '2';
pt(97).size      = '[]';
pt(97).isStruct  = false;
pt(97).symbol     = 'quadripulse_controller14_P.UDPInit_P3';
pt(97).baseaddr   = '&quadripulse_controller14_P.UDPInit_P3';
pt(97).dtname     = 'real_T';



  
pt(98).blockname = 'Real-time UDP  Configuration/UDP Init ';
pt(98).paramname = 'P4';
pt(98).class     = 'scalar';
pt(98).nrows     = 1;
pt(98).ncols     = 1;
pt(98).subsource = 'SS_DOUBLE';
pt(98).ndims     = '2';
pt(98).size      = '[]';
pt(98).isStruct  = false;
pt(98).symbol     = 'quadripulse_controller14_P.UDPInit_P4';
pt(98).baseaddr   = '&quadripulse_controller14_P.UDPInit_P4';
pt(98).dtname     = 'real_T';



  
pt(99).blockname = 'Real-time UDP  Configuration/UDP Init ';
pt(99).paramname = 'P5';
pt(99).class     = 'scalar';
pt(99).nrows     = 1;
pt(99).ncols     = 1;
pt(99).subsource = 'SS_DOUBLE';
pt(99).ndims     = '2';
pt(99).size      = '[]';
pt(99).isStruct  = false;
pt(99).symbol     = 'quadripulse_controller14_P.UDPInit_P5';
pt(99).baseaddr   = '&quadripulse_controller14_P.UDPInit_P5';
pt(99).dtname     = 'real_T';



  
pt(100).blockname = 'S-R Flip-Flop/Logic';
pt(100).paramname = 'TruthTable';
pt(100).class     = 'col-mat';
pt(100).nrows     = 8;
pt(100).ncols     = 2;
pt(100).subsource = 'SS_BOOLEAN';
pt(100).ndims     = '2';
pt(100).size      = '[]';
pt(100).isStruct  = false;
pt(100).symbol     = 'quadripulse_controller14_P.Logic_table';
pt(100).baseaddr   = '&quadripulse_controller14_P.Logic_table[0]';
pt(100).dtname     = 'boolean_T';



  
pt(101).blockname = 'Safety Check/4-into-1 Unit Limit';
pt(101).paramname = 'const';
pt(101).class     = 'scalar';
pt(101).nrows     = 1;
pt(101).ncols     = 1;
pt(101).subsource = 'SS_DOUBLE';
pt(101).ndims     = '2';
pt(101).size      = '[]';
pt(101).isStruct  = false;
pt(101).symbol     = 'quadripulse_controller14_P.uinto1UnitLimit_const';
pt(101).baseaddr   = '&quadripulse_controller14_P.uinto1UnitLimit_const';
pt(101).dtname     = 'real_T';



  
pt(102).blockname = 'Subsystem/Constant';
pt(102).paramname = 'Value';
pt(102).class     = 'scalar';
pt(102).nrows     = 1;
pt(102).ncols     = 1;
pt(102).subsource = 'SS_DOUBLE';
pt(102).ndims     = '2';
pt(102).size      = '[]';
pt(102).isStruct  = false;
pt(102).symbol     = 'quadripulse_controller14_P.Constant_Value_g';
pt(102).baseaddr   = '&quadripulse_controller14_P.Constant_Value_g';
pt(102).dtname     = 'real_T';



  
pt(103).blockname = 'Time Series Forecast/Forecast of 128 samples';
pt(103).paramname = 'num_iterations';
pt(103).class     = 'scalar';
pt(103).nrows     = 1;
pt(103).ncols     = 1;
pt(103).subsource = 'SS_INT32';
pt(103).ndims     = '2';
pt(103).size      = '[]';
pt(103).isStruct  = false;
pt(103).symbol     = 'quadripulse_controller14_P.Forecastof128samples_num_iterat';
pt(103).baseaddr   = '&quadripulse_controller14_P.Forecastof128samples_num_iterat';
pt(103).dtname     = 'int32_T';



  
pt(104).blockname = 'Trigger Condition/Constant';
pt(104).paramname = 'Value';
pt(104).class     = 'scalar';
pt(104).nrows     = 1;
pt(104).ncols     = 1;
pt(104).subsource = 'SS_BOOLEAN';
pt(104).ndims     = '2';
pt(104).size      = '[]';
pt(104).isStruct  = false;
pt(104).symbol     = 'quadripulse_controller14_P.Constant_Value_l';
pt(104).baseaddr   = '&quadripulse_controller14_P.Constant_Value_l';
pt(104).dtname     = 'boolean_T';



  
pt(105).blockname = 'Trigger Generator/Channel';
pt(105).paramname = 'InitialOutput';
pt(105).class     = 'scalar';
pt(105).nrows     = 1;
pt(105).ncols     = 1;
pt(105).subsource = 'SS_DOUBLE';
pt(105).ndims     = '2';
pt(105).size      = '[]';
pt(105).isStruct  = false;
pt(105).symbol     = 'quadripulse_controller14_P.Channel_Y0';
pt(105).baseaddr   = '&quadripulse_controller14_P.Channel_Y0';
pt(105).dtname     = 'real_T';



  
pt(106).blockname = 'Trigger Generator/Zero';
pt(106).paramname = 'Value';
pt(106).class     = 'scalar';
pt(106).nrows     = 1;
pt(106).ncols     = 1;
pt(106).subsource = 'SS_DOUBLE';
pt(106).ndims     = '2';
pt(106).size      = '[]';
pt(106).isStruct  = false;
pt(106).symbol     = 'quadripulse_controller14_P.Zero_Value';
pt(106).baseaddr   = '&quadripulse_controller14_P.Zero_Value';
pt(106).dtname     = 'real_T';



  
pt(107).blockname = 'Trigger Generator/Gain';
pt(107).paramname = 'Gain';
pt(107).class     = 'scalar';
pt(107).nrows     = 1;
pt(107).ncols     = 1;
pt(107).subsource = 'SS_DOUBLE';
pt(107).ndims     = '2';
pt(107).size      = '[]';
pt(107).isStruct  = false;
pt(107).symbol     = 'quadripulse_controller14_P.Gain_Gain';
pt(107).baseaddr   = '&quadripulse_controller14_P.Gain_Gain';
pt(107).dtname     = 'real_T';



  
pt(108).blockname = 'Trigger Generator/Counter Delay';
pt(108).paramname = 'DelayLength';
pt(108).class     = 'scalar';
pt(108).nrows     = 1;
pt(108).ncols     = 1;
pt(108).subsource = 'SS_UINT32';
pt(108).ndims     = '2';
pt(108).size      = '[]';
pt(108).isStruct  = false;
pt(108).symbol     = 'quadripulse_controller14_P.CounterDelay_DelayLength';
pt(108).baseaddr   = '&quadripulse_controller14_P.CounterDelay_DelayLength';
pt(108).dtname     = 'uint32_T';



  
pt(109).blockname = 'Trigger Generator/Counter Delay';
pt(109).paramname = 'InitialCondition';
pt(109).class     = 'scalar';
pt(109).nrows     = 1;
pt(109).ncols     = 1;
pt(109).subsource = 'SS_DOUBLE';
pt(109).ndims     = '2';
pt(109).size      = '[]';
pt(109).isStruct  = false;
pt(109).symbol     = 'quadripulse_controller14_P.CounterDelay_InitialCondition';
pt(109).baseaddr   = '&quadripulse_controller14_P.CounterDelay_InitialCondition';
pt(109).dtname     = 'real_T';



  
pt(110).blockname = 'UDP EEG Data/Constant';
pt(110).paramname = 'Value';
pt(110).class     = 'vector';
pt(110).nrows     = 1;
pt(110).ncols     = 330;
pt(110).subsource = 'SS_UINT8';
pt(110).ndims     = '2';
pt(110).size      = '[]';
pt(110).isStruct  = false;
pt(110).symbol     = 'quadripulse_controller14_P.Constant_Value_c';
pt(110).baseaddr   = '&quadripulse_controller14_P.Constant_Value_c[0]';
pt(110).dtname     = 'uint8_T';



  
pt(111).blockname = 'UDP EEG Data/Gain';
pt(111).paramname = 'Gain';
pt(111).class     = 'scalar';
pt(111).nrows     = 1;
pt(111).ncols     = 1;
pt(111).subsource = 'SS_DOUBLE';
pt(111).ndims     = '2';
pt(111).size      = '[]';
pt(111).isStruct  = false;
pt(111).symbol     = 'quadripulse_controller14_P.Gain_Gain_p';
pt(111).baseaddr   = '&quadripulse_controller14_P.Gain_Gain_p';
pt(111).dtname     = 'real_T';



  
pt(112).blockname = 'Fan Out with Offset for Scope Display /Running Average/Delay';
pt(112).paramname = 'DelayLength';
pt(112).class     = 'scalar';
pt(112).nrows     = 1;
pt(112).ncols     = 1;
pt(112).subsource = 'SS_UINT32';
pt(112).ndims     = '2';
pt(112).size      = '[]';
pt(112).isStruct  = false;
pt(112).symbol     = 'quadripulse_controller14_P.Delay_DelayLength';
pt(112).baseaddr   = '&quadripulse_controller14_P.Delay_DelayLength';
pt(112).dtname     = 'uint32_T';



  
pt(113).blockname = 'Fan Out with Offset for Scope Display /Running Average/Delay';
pt(113).paramname = 'InitialCondition';
pt(113).class     = 'scalar';
pt(113).nrows     = 1;
pt(113).ncols     = 1;
pt(113).subsource = 'SS_DOUBLE';
pt(113).ndims     = '2';
pt(113).size      = '[]';
pt(113).isStruct  = false;
pt(113).symbol     = 'quadripulse_controller14_P.Delay_InitialCondition';
pt(113).baseaddr   = '&quadripulse_controller14_P.Delay_InitialCondition';
pt(113).dtname     = 'real_T';



  
pt(114).blockname = 'Fan Out with Offset for Scope Display /Running Average/Delay1';
pt(114).paramname = 'DelayLength';
pt(114).class     = 'scalar';
pt(114).nrows     = 1;
pt(114).ncols     = 1;
pt(114).subsource = 'SS_UINT32';
pt(114).ndims     = '2';
pt(114).size      = '[]';
pt(114).isStruct  = false;
pt(114).symbol     = 'quadripulse_controller14_P.Delay1_DelayLength_h';
pt(114).baseaddr   = '&quadripulse_controller14_P.Delay1_DelayLength_h';
pt(114).dtname     = 'uint32_T';



  
pt(115).blockname = 'Fan Out with Offset for Scope Display /Running Average/Delay1';
pt(115).paramname = 'InitialCondition';
pt(115).class     = 'scalar';
pt(115).nrows     = 1;
pt(115).ncols     = 1;
pt(115).subsource = 'SS_DOUBLE';
pt(115).ndims     = '2';
pt(115).size      = '[]';
pt(115).isStruct  = false;
pt(115).symbol     = 'quadripulse_controller14_P.Delay1_InitialCondition_i';
pt(115).baseaddr   = '&quadripulse_controller14_P.Delay1_InitialCondition_i';
pt(115).dtname     = 'real_T';



  
pt(116).blockname = 'Subsystem/Enabled Subsystem/Out1';
pt(116).paramname = 'InitialOutput';
pt(116).class     = 'scalar';
pt(116).nrows     = 1;
pt(116).ncols     = 1;
pt(116).subsource = 'SS_DOUBLE';
pt(116).ndims     = '2';
pt(116).size      = '[]';
pt(116).isStruct  = false;
pt(116).symbol     = 'quadripulse_controller14_P.Out1_Y0';
pt(116).baseaddr   = '&quadripulse_controller14_P.Out1_Y0';
pt(116).dtname     = 'real_T';



  
pt(117).blockname = 'Subsystem/Enabled Subsystem/Buffer';
pt(117).paramname = 'ic';
pt(117).class     = 'scalar';
pt(117).nrows     = 1;
pt(117).ncols     = 1;
pt(117).subsource = 'SS_DOUBLE';
pt(117).ndims     = '2';
pt(117).size      = '[]';
pt(117).isStruct  = false;
pt(117).symbol     = 'quadripulse_controller14_P.Buffer_ic';
pt(117).baseaddr   = '&quadripulse_controller14_P.Buffer_ic';
pt(117).dtname     = 'real_T';



  
pt(118).blockname = 'Subsystem/Prolonged Disable/One';
pt(118).paramname = 'Value';
pt(118).class     = 'scalar';
pt(118).nrows     = 1;
pt(118).ncols     = 1;
pt(118).subsource = 'SS_INT32';
pt(118).ndims     = '2';
pt(118).size      = '[]';
pt(118).isStruct  = false;
pt(118).symbol     = 'quadripulse_controller14_P.One_Value';
pt(118).baseaddr   = '&quadripulse_controller14_P.One_Value';
pt(118).dtname     = 'int32_T';



  
pt(119).blockname = 'Subsystem/Prolonged Disable/Zero';
pt(119).paramname = 'Value';
pt(119).class     = 'scalar';
pt(119).nrows     = 1;
pt(119).ncols     = 1;
pt(119).subsource = 'SS_INT32';
pt(119).ndims     = '2';
pt(119).size      = '[]';
pt(119).isStruct  = false;
pt(119).symbol     = 'quadripulse_controller14_P.Zero_Value_f';
pt(119).baseaddr   = '&quadripulse_controller14_P.Zero_Value_f';
pt(119).dtname     = 'int32_T';



  
pt(120).blockname = 'Subsystem/Prolonged Disable/Seconds';
pt(120).paramname = 'Gain';
pt(120).class     = 'scalar';
pt(120).nrows     = 1;
pt(120).ncols     = 1;
pt(120).subsource = 'SS_UINT16';
pt(120).ndims     = '2';
pt(120).size      = '[]';
pt(120).isStruct  = false;
pt(120).symbol     = 'quadripulse_controller14_P.Seconds_Gain';
pt(120).baseaddr   = '&quadripulse_controller14_P.Seconds_Gain';
pt(120).dtname     = 'uint16_T';



  
pt(121).blockname = 'Subsystem/Prolonged Disable/Keep Postive Switch';
pt(121).paramname = 'Threshold';
pt(121).class     = 'scalar';
pt(121).nrows     = 1;
pt(121).ncols     = 1;
pt(121).subsource = 'SS_INT32';
pt(121).ndims     = '2';
pt(121).size      = '[]';
pt(121).isStruct  = false;
pt(121).symbol     = 'quadripulse_controller14_P.KeepPostiveSwitch_Threshold';
pt(121).baseaddr   = '&quadripulse_controller14_P.KeepPostiveSwitch_Threshold';
pt(121).dtname     = 'int32_T';



  
pt(122).blockname = 'Subsystem/Prolonged Disable/Unit Delay';
pt(122).paramname = 'InitialCondition';
pt(122).class     = 'scalar';
pt(122).nrows     = 1;
pt(122).ncols     = 1;
pt(122).subsource = 'SS_INT32';
pt(122).ndims     = '2';
pt(122).size      = '[]';
pt(122).isStruct  = false;
pt(122).symbol     = 'quadripulse_controller14_P.UnitDelay_InitialCondition_m';
pt(122).baseaddr   = '&quadripulse_controller14_P.UnitDelay_InitialCondition_m';
pt(122).dtname     = 'int32_T';



  
pt(123).blockname = 'Subsystem/Prolonged Disable/Weighted Sample Time';
pt(123).paramname = 'WtEt';
pt(123).class     = 'scalar';
pt(123).nrows     = 1;
pt(123).ncols     = 1;
pt(123).subsource = 'SS_UINT16';
pt(123).ndims     = '2';
pt(123).size      = '[]';
pt(123).isStruct  = false;
pt(123).symbol     = 'quadripulse_controller14_P.WeightedSampleTime_WtEt';
pt(123).baseaddr   = '&quadripulse_controller14_P.WeightedSampleTime_WtEt';
pt(123).dtname     = 'uint16_T';



  
pt(124).blockname = 'Trigger Condition/Crossing Detector/Difference';
pt(124).paramname = 'ICPrevInput';
pt(124).class     = 'scalar';
pt(124).nrows     = 1;
pt(124).ncols     = 1;
pt(124).subsource = 'SS_DOUBLE';
pt(124).ndims     = '2';
pt(124).size      = '[]';
pt(124).isStruct  = false;
pt(124).symbol     = 'quadripulse_controller14_P.Difference_ICPrevInput';
pt(124).baseaddr   = '&quadripulse_controller14_P.Difference_ICPrevInput';
pt(124).dtname     = 'real_T';



  
pt(125).blockname = 'Trigger Condition/Crossing Detector/Hit  Crossing';
pt(125).paramname = 'HitCrossingOffset';
pt(125).class     = 'scalar';
pt(125).nrows     = 1;
pt(125).ncols     = 1;
pt(125).subsource = 'SS_DOUBLE';
pt(125).ndims     = '2';
pt(125).size      = '[]';
pt(125).isStruct  = false;
pt(125).symbol     = 'quadripulse_controller14_P.HitCrossing_Offset';
pt(125).baseaddr   = '&quadripulse_controller14_P.HitCrossing_Offset';
pt(125).dtname     = 'real_T';



  
pt(126).blockname = 'Trigger Condition/Crossing Detector/Hit  Crossing1';
pt(126).paramname = 'HitCrossingOffset';
pt(126).class     = 'scalar';
pt(126).nrows     = 1;
pt(126).ncols     = 1;
pt(126).subsource = 'SS_DOUBLE';
pt(126).ndims     = '2';
pt(126).size      = '[]';
pt(126).isStruct  = false;
pt(126).symbol     = 'quadripulse_controller14_P.HitCrossing1_Offset';
pt(126).baseaddr   = '&quadripulse_controller14_P.HitCrossing1_Offset';
pt(126).dtname     = 'real_T';



  
pt(127).blockname = 'Trigger Condition/Crossing Detector/Hit  Crossing2';
pt(127).paramname = 'HitCrossingOffset';
pt(127).class     = 'scalar';
pt(127).nrows     = 1;
pt(127).ncols     = 1;
pt(127).subsource = 'SS_DOUBLE';
pt(127).ndims     = '2';
pt(127).size      = '[]';
pt(127).isStruct  = false;
pt(127).symbol     = 'quadripulse_controller14_P.HitCrossing2_Offset';
pt(127).baseaddr   = '&quadripulse_controller14_P.HitCrossing2_Offset';
pt(127).dtname     = 'real_T';



  
pt(128).blockname = 'Trigger Condition/Crossing Detector/Hit  Crossing3';
pt(128).paramname = 'HitCrossingOffset';
pt(128).class     = 'scalar';
pt(128).nrows     = 1;
pt(128).ncols     = 1;
pt(128).subsource = 'SS_DOUBLE';
pt(128).ndims     = '2';
pt(128).size      = '[]';
pt(128).isStruct  = false;
pt(128).symbol     = 'quadripulse_controller14_P.HitCrossing3_Offset';
pt(128).baseaddr   = '&quadripulse_controller14_P.HitCrossing3_Offset';
pt(128).dtname     = 'real_T';



  
pt(129).blockname = 'Trigger Generator/Counter Free-Running/Wrap To Zero';
pt(129).paramname = 'Threshold';
pt(129).class     = 'scalar';
pt(129).nrows     = 1;
pt(129).ncols     = 1;
pt(129).subsource = 'SS_UINT32';
pt(129).ndims     = '2';
pt(129).size      = '[]';
pt(129).isStruct  = false;
pt(129).symbol     = 'quadripulse_controller14_P.WrapToZero_Threshold';
pt(129).baseaddr   = '&quadripulse_controller14_P.WrapToZero_Threshold';
pt(129).dtname     = 'uint32_T';



  
pt(130).blockname = 'Trigger Generator/Counter Free-Running/Output';
pt(130).paramname = 'InitialCondition';
pt(130).class     = 'scalar';
pt(130).nrows     = 1;
pt(130).ncols     = 1;
pt(130).subsource = 'SS_UINT32';
pt(130).ndims     = '2';
pt(130).size      = '[]';
pt(130).isStruct  = false;
pt(130).symbol     = 'quadripulse_controller14_P.Output_InitialCondition';
pt(130).baseaddr   = '&quadripulse_controller14_P.Output_InitialCondition';
pt(130).dtname     = 'uint32_T';



  
pt(131).blockname = 'UDP EEG Data/Receive 1/Buffer 1';
pt(131).paramname = 'P1';
pt(131).class     = 'scalar';
pt(131).nrows     = 1;
pt(131).ncols     = 1;
pt(131).subsource = 'SS_DOUBLE';
pt(131).ndims     = '2';
pt(131).size      = '[]';
pt(131).isStruct  = false;
pt(131).symbol     = 'quadripulse_controller14_P.Buffer1_P1';
pt(131).baseaddr   = '&quadripulse_controller14_P.Buffer1_P1';
pt(131).dtname     = 'real_T';



  
pt(132).blockname = 'UDP EEG Data/Receive 1/Buffer 1';
pt(132).paramname = 'P2';
pt(132).class     = 'scalar';
pt(132).nrows     = 1;
pt(132).ncols     = 1;
pt(132).subsource = 'SS_DOUBLE';
pt(132).ndims     = '2';
pt(132).size      = '[]';
pt(132).isStruct  = false;
pt(132).symbol     = 'quadripulse_controller14_P.Buffer1_P2';
pt(132).baseaddr   = '&quadripulse_controller14_P.Buffer1_P2';
pt(132).dtname     = 'real_T';



  
pt(133).blockname = 'UDP EEG Data/Receive 1/Buffer 1';
pt(133).paramname = 'P3';
pt(133).class     = 'scalar';
pt(133).nrows     = 1;
pt(133).ncols     = 1;
pt(133).subsource = 'SS_DOUBLE';
pt(133).ndims     = '2';
pt(133).size      = '[]';
pt(133).isStruct  = false;
pt(133).symbol     = 'quadripulse_controller14_P.Buffer1_P3';
pt(133).baseaddr   = '&quadripulse_controller14_P.Buffer1_P3';
pt(133).dtname     = 'real_T';



  
pt(134).blockname = 'UDP EEG Data/Receive 1/Extract 1';
pt(134).paramname = 'P1';
pt(134).class     = 'scalar';
pt(134).nrows     = 1;
pt(134).ncols     = 1;
pt(134).subsource = 'SS_DOUBLE';
pt(134).ndims     = '2';
pt(134).size      = '[]';
pt(134).isStruct  = false;
pt(134).symbol     = 'quadripulse_controller14_P.Extract1_P1';
pt(134).baseaddr   = '&quadripulse_controller14_P.Extract1_P1';
pt(134).dtname     = 'real_T';



  
pt(135).blockname = 'UDP EEG Data/Receive 1/UDP Consume 1';
pt(135).paramname = 'P1';
pt(135).class     = 'scalar';
pt(135).nrows     = 1;
pt(135).ncols     = 1;
pt(135).subsource = 'SS_DOUBLE';
pt(135).ndims     = '2';
pt(135).size      = '[]';
pt(135).isStruct  = false;
pt(135).symbol     = 'quadripulse_controller14_P.UDPConsume1_P1';
pt(135).baseaddr   = '&quadripulse_controller14_P.UDPConsume1_P1';
pt(135).dtname     = 'real_T';



  
pt(136).blockname = 'UDP EEG Data/Receive 1/UDP Consume 1';
pt(136).paramname = 'P2';
pt(136).class     = 'scalar';
pt(136).nrows     = 1;
pt(136).ncols     = 1;
pt(136).subsource = 'SS_DOUBLE';
pt(136).ndims     = '2';
pt(136).size      = '[]';
pt(136).isStruct  = false;
pt(136).symbol     = 'quadripulse_controller14_P.UDPConsume1_P2';
pt(136).baseaddr   = '&quadripulse_controller14_P.UDPConsume1_P2';
pt(136).dtname     = 'real_T';



  
pt(137).blockname = 'UDP EEG Data/Receive 1/UDP Consume 1';
pt(137).paramname = 'P3';
pt(137).class     = 'scalar';
pt(137).nrows     = 1;
pt(137).ncols     = 1;
pt(137).subsource = 'SS_DOUBLE';
pt(137).ndims     = '2';
pt(137).size      = '[]';
pt(137).isStruct  = false;
pt(137).symbol     = 'quadripulse_controller14_P.UDPConsume1_P3';
pt(137).baseaddr   = '&quadripulse_controller14_P.UDPConsume1_P3';
pt(137).dtname     = 'real_T';



  
pt(138).blockname = 'UDP EEG Data/Receive 1/UDP Rx 1';
pt(138).paramname = 'P1';
pt(138).class     = 'scalar';
pt(138).nrows     = 1;
pt(138).ncols     = 1;
pt(138).subsource = 'SS_DOUBLE';
pt(138).ndims     = '2';
pt(138).size      = '[]';
pt(138).isStruct  = false;
pt(138).symbol     = 'quadripulse_controller14_P.UDPRx1_P1';
pt(138).baseaddr   = '&quadripulse_controller14_P.UDPRx1_P1';
pt(138).dtname     = 'real_T';



  
pt(139).blockname = 'UDP EEG Data/Receive 1/UDP Rx 1';
pt(139).paramname = 'P2';
pt(139).class     = 'scalar';
pt(139).nrows     = 1;
pt(139).ncols     = 1;
pt(139).subsource = 'SS_DOUBLE';
pt(139).ndims     = '2';
pt(139).size      = '[]';
pt(139).isStruct  = false;
pt(139).symbol     = 'quadripulse_controller14_P.UDPRx1_P2';
pt(139).baseaddr   = '&quadripulse_controller14_P.UDPRx1_P2';
pt(139).dtname     = 'real_T';



  
pt(140).blockname = 'UDP EEG Data/Receive 1/UDP Rx 1';
pt(140).paramname = 'P3';
pt(140).class     = 'scalar';
pt(140).nrows     = 1;
pt(140).ncols     = 1;
pt(140).subsource = 'SS_DOUBLE';
pt(140).ndims     = '2';
pt(140).size      = '[]';
pt(140).isStruct  = false;
pt(140).symbol     = 'quadripulse_controller14_P.UDPRx1_P3';
pt(140).baseaddr   = '&quadripulse_controller14_P.UDPRx1_P3';
pt(140).dtname     = 'real_T';



  
pt(141).blockname = 'UDP EEG Data/Receive 1/UDP Rx 1';
pt(141).paramname = 'P4';
pt(141).class     = 'scalar';
pt(141).nrows     = 1;
pt(141).ncols     = 1;
pt(141).subsource = 'SS_DOUBLE';
pt(141).ndims     = '2';
pt(141).size      = '[]';
pt(141).isStruct  = false;
pt(141).symbol     = 'quadripulse_controller14_P.UDPRx1_P4';
pt(141).baseaddr   = '&quadripulse_controller14_P.UDPRx1_P4';
pt(141).dtname     = 'real_T';



  
pt(142).blockname = 'UDP EEG Data/Receive 1/UDP Rx 1';
pt(142).paramname = 'P5';
pt(142).class     = 'scalar';
pt(142).nrows     = 1;
pt(142).ncols     = 1;
pt(142).subsource = 'SS_DOUBLE';
pt(142).ndims     = '2';
pt(142).size      = '[]';
pt(142).isStruct  = false;
pt(142).symbol     = 'quadripulse_controller14_P.UDPRx1_P5';
pt(142).baseaddr   = '&quadripulse_controller14_P.UDPRx1_P5';
pt(142).dtname     = 'real_T';



  
pt(143).blockname = 'UDP EEG Data/Receive 1/UDP Rx 1';
pt(143).paramname = 'P6';
pt(143).class     = 'scalar';
pt(143).nrows     = 1;
pt(143).ncols     = 1;
pt(143).subsource = 'SS_DOUBLE';
pt(143).ndims     = '2';
pt(143).size      = '[]';
pt(143).isStruct  = false;
pt(143).symbol     = 'quadripulse_controller14_P.UDPRx1_P6';
pt(143).baseaddr   = '&quadripulse_controller14_P.UDPRx1_P6';
pt(143).dtname     = 'real_T';



  
pt(144).blockname = 'Subsystem/Prolonged Disable/Compare To Zero/Constant';
pt(144).paramname = 'Value';
pt(144).class     = 'scalar';
pt(144).nrows     = 1;
pt(144).ncols     = 1;
pt(144).subsource = 'SS_INT32';
pt(144).ndims     = '2';
pt(144).size      = '[]';
pt(144).isStruct  = false;
pt(144).symbol     = 'quadripulse_controller14_P.Constant_Value_j';
pt(144).baseaddr   = '&quadripulse_controller14_P.Constant_Value_j';
pt(144).dtname     = 'int32_T';



  
pt(145).blockname = 'Time Series Forecast/Forecast of 128 samples/Forecast/Forecast';
pt(145).paramname = 'InitialOutput';
pt(145).class     = 'scalar';
pt(145).nrows     = 1;
pt(145).ncols     = 1;
pt(145).subsource = 'SS_DOUBLE';
pt(145).ndims     = '2';
pt(145).size      = '[]';
pt(145).isStruct  = false;
pt(145).symbol     = 'quadripulse_controller14_P.Forecast_Y0';
pt(145).baseaddr   = '&quadripulse_controller14_P.Forecast_Y0';
pt(145).dtname     = 'real_T';



  
pt(146).blockname = 'Time Series Forecast/Forecast of 128 samples/Forecast/For Iterator';
pt(146).paramname = 'IterationLimit';
pt(146).class     = 'scalar';
pt(146).nrows     = 1;
pt(146).ncols     = 1;
pt(146).subsource = 'SS_INT32';
pt(146).ndims     = '2';
pt(146).size      = '[]';
pt(146).isStruct  = false;
pt(146).symbol     = 'quadripulse_controller14_P.ForIterator_IterationLimit';
pt(146).baseaddr   = '&quadripulse_controller14_P.ForIterator_IterationLimit';
pt(146).dtname     = 'int32_T';



  
pt(147).blockname = 'Time Series Forecast/Forecast of 128 samples/Forecast/Saturation';
pt(147).paramname = 'LowerLimit';
pt(147).class     = 'scalar';
pt(147).nrows     = 1;
pt(147).ncols     = 1;
pt(147).subsource = 'SS_INT32';
pt(147).ndims     = '2';
pt(147).size      = '[]';
pt(147).isStruct  = false;
pt(147).symbol     = 'quadripulse_controller14_P.Saturation_LowerSat';
pt(147).baseaddr   = '&quadripulse_controller14_P.Saturation_LowerSat';
pt(147).dtname     = 'int32_T';



  
pt(148).blockname = 'Time Series Forecast/Forecast of 128 samples/Forecast/Unit Delay';
pt(148).paramname = 'InitialCondition';
pt(148).class     = 'scalar';
pt(148).nrows     = 1;
pt(148).ncols     = 1;
pt(148).subsource = 'SS_DOUBLE';
pt(148).ndims     = '2';
pt(148).size      = '[]';
pt(148).isStruct  = false;
pt(148).symbol     = 'quadripulse_controller14_P.UnitDelay_InitialCondition';
pt(148).baseaddr   = '&quadripulse_controller14_P.UnitDelay_InitialCondition';
pt(148).dtname     = 'real_T';



  
pt(149).blockname = 'Time Series Forecast/Forecast of 128 samples/Forecast/Unit Delay1';
pt(149).paramname = 'InitialCondition';
pt(149).class     = 'scalar';
pt(149).nrows     = 1;
pt(149).ncols     = 1;
pt(149).subsource = 'SS_INT32';
pt(149).ndims     = '2';
pt(149).size      = '[]';
pt(149).isStruct  = false;
pt(149).symbol     = 'quadripulse_controller14_P.UnitDelay1_InitialCondition';
pt(149).baseaddr   = '&quadripulse_controller14_P.UnitDelay1_InitialCondition';
pt(149).dtname     = 'int32_T';



  
pt(150).blockname = 'Trigger Generator/Counter Free-Running/Increment Real World/FixPt Constant';
pt(150).paramname = 'Value';
pt(150).class     = 'scalar';
pt(150).nrows     = 1;
pt(150).ncols     = 1;
pt(150).subsource = 'SS_UINT32';
pt(150).ndims     = '2';
pt(150).size      = '[]';
pt(150).isStruct  = false;
pt(150).symbol     = 'quadripulse_controller14_P.FixPtConstant_Value';
pt(150).baseaddr   = '&quadripulse_controller14_P.FixPtConstant_Value';
pt(150).dtname     = 'uint32_T';



  
pt(151).blockname = 'Trigger Generator/Counter Free-Running/Wrap To Zero/Constant';
pt(151).paramname = 'Value';
pt(151).class     = 'scalar';
pt(151).nrows     = 1;
pt(151).ncols     = 1;
pt(151).subsource = 'SS_UINT32';
pt(151).ndims     = '2';
pt(151).size      = '[]';
pt(151).isStruct  = false;
pt(151).symbol     = 'quadripulse_controller14_P.Constant_Value_m';
pt(151).baseaddr   = '&quadripulse_controller14_P.Constant_Value_m';
pt(151).dtname     = 'uint32_T';



  
pt(152).blockname = '';
pt(152).paramname = 'amplitudeinterval';
pt(152).class     = 'vector';
pt(152).nrows     = 1;
pt(152).ncols     = 2;
pt(152).subsource = 'SS_DOUBLE';
pt(152).ndims     = '2';
pt(152).size      = '[]';
pt(152).isStruct  = false;
pt(152).symbol     = 'quadripulse_controller14_P.amplitudeinterval';
pt(152).baseaddr   = '&quadripulse_controller14_P.amplitudeinterval[0]';
pt(152).dtname     = 'real_T';



  
pt(153).blockname = '';
pt(153).paramname = 'amplitudeinterval_percentiles';
pt(153).class     = 'vector';
pt(153).nrows     = 1;
pt(153).ncols     = 2;
pt(153).subsource = 'SS_DOUBLE';
pt(153).ndims     = '2';
pt(153).size      = '[]';
pt(153).isStruct  = false;
pt(153).symbol     = 'quadripulse_controller14_P.amplitudeinterval_percentiles';
pt(153).baseaddr   = '&quadripulse_controller14_P.amplitudeinterval_percentiles[0]';
pt(153).dtname     = 'real_T';



  
pt(154).blockname = '';
pt(154).paramname = 'fft_bin_indices_zero_based';
pt(154).class     = 'vector';
pt(154).nrows     = 1;
pt(154).ncols     = 2;
pt(154).subsource = 'SS_DOUBLE';
pt(154).ndims     = '2';
pt(154).size      = '[]';
pt(154).isStruct  = false;
pt(154).symbol     = 'quadripulse_controller14_P.fft_bin_indices_zero_based';
pt(154).baseaddr   = '&quadripulse_controller14_P.fft_bin_indices_zero_based[0]';
pt(154).dtname     = 'real_T';



  
pt(155).blockname = '';
pt(155).paramname = 'fir_filter_coefficients';
pt(155).class     = 'vector';
pt(155).nrows     = 1;
pt(155).ncols     = 129;
pt(155).subsource = 'SS_DOUBLE';
pt(155).ndims     = '2';
pt(155).size      = '[]';
pt(155).isStruct  = false;
pt(155).symbol     = 'quadripulse_controller14_P.fir_filter_coefficients';
pt(155).baseaddr   = '&quadripulse_controller14_P.fir_filter_coefficients[0]';
pt(155).dtname     = 'real_T';



  
pt(156).blockname = '';
pt(156).paramname = 'phasecondition';
pt(156).class     = 'scalar';
pt(156).nrows     = 1;
pt(156).ncols     = 1;
pt(156).subsource = 'SS_DOUBLE';
pt(156).ndims     = '2';
pt(156).size      = '[]';
pt(156).isStruct  = false;
pt(156).symbol     = 'quadripulse_controller14_P.phasecondition';
pt(156).baseaddr   = '&quadripulse_controller14_P.phasecondition';
pt(156).dtname     = 'real_T';



  
pt(157).blockname = '';
pt(157).paramname = 'spatial_filter';
pt(157).class     = 'vector';
pt(157).nrows     = 1;
pt(157).ncols     = 65;
pt(157).subsource = 'SS_DOUBLE';
pt(157).ndims     = '2';
pt(157).size      = '[]';
pt(157).isStruct  = false;
pt(157).symbol     = 'quadripulse_controller14_P.spatial_filter';
pt(157).baseaddr   = '&quadripulse_controller14_P.spatial_filter[0]';
pt(157).dtname     = 'real_T';



  
pt(158).blockname = '';
pt(158).paramname = 'timeinsecondsandtriggerchannel';
pt(158).class     = 'col-mat';
pt(158).nrows     = 2;
pt(158).ncols     = 2;
pt(158).subsource = 'SS_DOUBLE';
pt(158).ndims     = '2';
pt(158).size      = '[]';
pt(158).isStruct  = false;
pt(158).symbol     = 'quadripulse_controller14_P.timeinsecondsandtriggerchannel';
pt(158).baseaddr   = '&quadripulse_controller14_P.timeinsecondsandtriggerchannel[0]';
pt(158).dtname     = 'real_T';



  
pt(159).blockname = '';
pt(159).paramname = 'marker_id';
pt(159).class     = 'scalar';
pt(159).nrows     = 1;
pt(159).ncols     = 1;
pt(159).subsource = 'SS_UINT8';
pt(159).ndims     = '2';
pt(159).size      = '[]';
pt(159).isStruct  = false;
pt(159).symbol     = 'quadripulse_controller14_P.marker_id';
pt(159).baseaddr   = '&quadripulse_controller14_P.marker_id';
pt(159).dtname     = 'uint8_T';



  
pt(160).blockname = '';
pt(160).paramname = 'closedloopmode';
pt(160).class     = 'scalar';
pt(160).nrows     = 1;
pt(160).ncols     = 1;
pt(160).subsource = 'SS_BOOLEAN';
pt(160).ndims     = '2';
pt(160).size      = '[]';
pt(160).isStruct  = false;
pt(160).symbol     = 'quadripulse_controller14_P.closedloopmode';
pt(160).baseaddr   = '&quadripulse_controller14_P.closedloopmode';
pt(160).dtname     = 'boolean_T';



  
pt(161).blockname = '';
pt(161).paramname = 'reset';
pt(161).class     = 'scalar';
pt(161).nrows     = 1;
pt(161).ncols     = 1;
pt(161).subsource = 'SS_BOOLEAN';
pt(161).ndims     = '2';
pt(161).size      = '[]';
pt(161).isStruct  = false;
pt(161).symbol     = 'quadripulse_controller14_P.reset';
pt(161).baseaddr   = '&quadripulse_controller14_P.reset';
pt(161).dtname     = 'boolean_T';


function len = getlenPT
len = 161;

