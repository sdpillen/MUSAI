function bio=quadripulse_controller14bio
bio = [];
bio(1).blkName='Vector Concatenate';
bio(1).sigName='';
bio(1).portIdx=0;
bio(1).dim=[512,2];
bio(1).sigWidth=1024;
bio(1).sigAddress='&quadripulse_controller14_B.VectorConcatenate[0]';
bio(1).ndims=2;
bio(1).size=[];
bio(1).isStruct=false;
bio(getlenBIO) = bio(1);

bio(2).blkName='Data Type Conversion';
bio(2).sigName='';
bio(2).portIdx=0;
bio(2).dim=[1,1];
bio(2).sigWidth=1;
bio(2).sigAddress='&quadripulse_controller14_B.DataTypeConversion_l';
bio(2).ndims=2;
bio(2).size=[];
bio(2).isStruct=false;

bio(3).blkName='Data Type Conversion1';
bio(3).sigName='';
bio(3).portIdx=0;
bio(3).dim=[1,1];
bio(3).sigWidth=1;
bio(3).sigAddress='&quadripulse_controller14_B.DataTypeConversion1';
bio(3).ndims=2;
bio(3).size=[];
bio(3).isStruct=false;

bio(4).blkName='Data Type Conversion2';
bio(4).sigName='';
bio(4).portIdx=0;
bio(4).dim=[1,1];
bio(4).sigWidth=1;
bio(4).sigAddress='&quadripulse_controller14_B.DataTypeConversion2';
bio(4).ndims=2;
bio(4).size=[];
bio(4).isStruct=false;

bio(5).blkName='Data Type Conversion3';
bio(5).sigName='';
bio(5).portIdx=0;
bio(5).dim=[1,1];
bio(5).sigWidth=1;
bio(5).sigAddress='&quadripulse_controller14_B.DataTypeConversion3';
bio(5).ndims=2;
bio(5).size=[];
bio(5).isStruct=false;

bio(6).blkName='Data Type Conversion4';
bio(6).sigName='';
bio(6).portIdx=0;
bio(6).dim=[1,1];
bio(6).sigWidth=1;
bio(6).sigAddress='&quadripulse_controller14_B.DataTypeConversion4_k';
bio(6).ndims=2;
bio(6).size=[];
bio(6).isStruct=false;

bio(7).blkName='Data Type Conversion5';
bio(7).sigName='';
bio(7).portIdx=0;
bio(7).dim=[1,1];
bio(7).sigWidth=1;
bio(7).sigAddress='&quadripulse_controller14_B.DataTypeConversion5';
bio(7).ndims=2;
bio(7).size=[];
bio(7).isStruct=false;

bio(8).blkName='AC Mode Scaling Factor';
bio(8).sigName='';
bio(8).portIdx=0;
bio(8).dim=[1,66];
bio(8).sigWidth=66;
bio(8).sigAddress='&quadripulse_controller14_B.ACModeScalingFactor[0]';
bio(8).ndims=2;
bio(8).size=[];
bio(8).isStruct=false;

bio(9).blkName='Hit  Crossing';
bio(9).sigName='';
bio(9).portIdx=0;
bio(9).dim=[1,1];
bio(9).sigWidth=1;
bio(9).sigAddress='&quadripulse_controller14_B.HitCrossing';
bio(9).ndims=2;
bio(9).size=[];
bio(9).isStruct=false;

bio(10).blkName='Product';
bio(10).sigName='';
bio(10).portIdx=0;
bio(10).dim=[1,1];
bio(10).sigWidth=1;
bio(10).sigAddress='&quadripulse_controller14_B.Product';
bio(10).ndims=2;
bio(10).size=[];
bio(10).isStruct=false;

bio(11).blkName='Rate Transition1';
bio(11).sigName='';
bio(11).portIdx=0;
bio(11).dim=[1,1];
bio(11).sigWidth=1;
bio(11).sigAddress='&quadripulse_controller14_B.RateTransition1';
bio(11).ndims=2;
bio(11).size=[];
bio(11).isStruct=false;

bio(12).blkName='Rate Transition2';
bio(12).sigName='';
bio(12).portIdx=0;
bio(12).dim=[1,1];
bio(12).sigWidth=1;
bio(12).sigAddress='&quadripulse_controller14_B.RateTransition2_n';
bio(12).ndims=2;
bio(12).size=[];
bio(12).isStruct=false;

bio(13).blkName='Rate Transition3';
bio(13).sigName='';
bio(13).portIdx=0;
bio(13).dim=[2,1];
bio(13).sigWidth=2;
bio(13).sigAddress='&quadripulse_controller14_B.RateTransition3[0]';
bio(13).ndims=2;
bio(13).size=[];
bio(13).isStruct=false;

bio(14).blkName='Reshape1';
bio(14).sigName='';
bio(14).portIdx=0;
bio(14).dim=[1,66];
bio(14).sigWidth=66;
bio(14).sigAddress='&quadripulse_controller14_B.Reshape1[0]';
bio(14).ndims=2;
bio(14).size=[];
bio(14).isStruct=false;

bio(15).blkName='Row';
bio(15).sigName='';
bio(15).portIdx=0;
bio(15).dim=[65,1];
bio(15).sigWidth=65;
bio(15).sigAddress='&quadripulse_controller14_B.Row[0]';
bio(15).ndims=2;
bio(15).size=[];
bio(15).isStruct=false;

bio(16).blkName='Row1';
bio(16).sigName='';
bio(16).portIdx=0;
bio(16).dim=[1,65];
bio(16).sigWidth=65;
bio(16).sigAddress='&quadripulse_controller14_B.Row1[0]';
bio(16).ndims=2;
bio(16).size=[];
bio(16).isStruct=false;

bio(17).blkName='Derepeat';
bio(17).sigName='';
bio(17).portIdx=0;
bio(17).dim=[1,66];
bio(17).sigWidth=66;
bio(17).sigAddress='&quadripulse_controller14_B.Derepeat[0]';
bio(17).ndims=2;
bio(17).size=[];
bio(17).isStruct=false;

bio(18).blkName='Now';
bio(18).sigName='';
bio(18).portIdx=0;
bio(18).dim=[1,1];
bio(18).sigWidth=1;
bio(18).sigAddress='&quadripulse_controller14_B.Now';
bio(18).ndims=2;
bio(18).size=[];
bio(18).isStruct=false;

bio(19).blkName='Remove Edges (first & last 64)';
bio(19).sigName='';
bio(19).portIdx=0;
bio(19).dim=[384,1];
bio(19).sigWidth=384;
bio(19).sigAddress='&quadripulse_controller14_B.RemoveEdgesfirstlast64[0]';
bio(19).ndims=2;
bio(19).size=[];
bio(19).isStruct=false;

bio(20).blkName='Single Row';
bio(20).sigName='';
bio(20).portIdx=0;
bio(20).dim=[1,2];
bio(20).sigWidth=2;
bio(20).sigAddress='&quadripulse_controller14_B.SingleRow[0]';
bio(20).ndims=2;
bio(20).size=[];
bio(20).isStruct=false;

bio(21).blkName='Switch';
bio(21).sigName='';
bio(21).portIdx=0;
bio(21).dim=[1,1];
bio(21).sigWidth=1;
bio(21).sigAddress='&quadripulse_controller14_B.Switch_g';
bio(21).ndims=2;
bio(21).size=[];
bio(21).isStruct=false;

bio(22).blkName='Switch1';
bio(22).sigName='';
bio(22).portIdx=0;
bio(22).dim=[1,1];
bio(22).sigWidth=1;
bio(22).sigAddress='&quadripulse_controller14_B.Switch1';
bio(22).ndims=2;
bio(22).size=[];
bio(22).isStruct=false;

bio(23).blkName='Manual Switch';
bio(23).sigName='';
bio(23).portIdx=0;
bio(23).dim=[2,1];
bio(23).sigWidth=2;
bio(23).sigAddress='&quadripulse_controller14_B.ManualSwitch[0]';
bio(23).ndims=2;
bio(23).size=[];
bio(23).isStruct=false;

bio(24).blkName='Buffer';
bio(24).sigName='';
bio(24).portIdx=0;
bio(24).dim=[512,1];
bio(24).sigWidth=512;
bio(24).sigAddress='&quadripulse_controller14_B.Buffer[0]';
bio(24).ndims=2;
bio(24).size=[];
bio(24).isStruct=false;

bio(25).blkName='Delay1';
bio(25).sigName='';
bio(25).portIdx=0;
bio(25).dim=[1,1];
bio(25).sigWidth=1;
bio(25).sigAddress='&quadripulse_controller14_B.Delay1';
bio(25).ndims=2;
bio(25).size=[];
bio(25).isStruct=false;

bio(26).blkName='Delay2';
bio(26).sigName='';
bio(26).portIdx=0;
bio(26).dim=[1,1];
bio(26).sigWidth=1;
bio(26).sigAddress='&quadripulse_controller14_B.Delay2';
bio(26).ndims=2;
bio(26).size=[];
bio(26).isStruct=false;

bio(27).blkName='Highpass Filter';
bio(27).sigName='';
bio(27).portIdx=0;
bio(27).dim=[1,2];
bio(27).sigWidth=2;
bio(27).sigAddress='&quadripulse_controller14_B.HighpassFilter[0]';
bio(27).ndims=2;
bio(27).size=[];
bio(27).isStruct=false;

bio(28).blkName='Unit Delay';
bio(28).sigName='';
bio(28).portIdx=0;
bio(28).dim=[1,1];
bio(28).sigWidth=1;
bio(28).sigAddress='&quadripulse_controller14_B.UnitDelay_b';
bio(28).ndims=2;
bio(28).size=[];
bio(28).isStruct=false;

bio(29).blkName='Average Refernce/Mean';
bio(29).sigName='';
bio(29).portIdx=0;
bio(29).dim=[1,1];
bio(29).sigWidth=1;
bio(29).sigAddress='&quadripulse_controller14_B.Mean';
bio(29).ndims=2;
bio(29).size=[];
bio(29).isStruct=false;

bio(30).blkName='Average Refernce/Subtract';
bio(30).sigName='';
bio(30).portIdx=0;
bio(30).dim=[1,65];
bio(30).sigWidth=65;
bio(30).sigAddress='&quadripulse_controller14_B.Subtract[0]';
bio(30).ndims=2;
bio(30).size=[];
bio(30).isStruct=false;

bio(31).blkName='Compare To Constant/Compare';
bio(31).sigName='';
bio(31).portIdx=0;
bio(31).dim=[1,1];
bio(31).sigWidth=1;
bio(31).sigAddress='&quadripulse_controller14_B.Compare_l';
bio(31).ndims=2;
bio(31).size=[];
bio(31).isStruct=false;

bio(32).blkName='Compare To Constant1/Compare';
bio(32).sigName='';
bio(32).portIdx=0;
bio(32).dim=[1,1];
bio(32).sigWidth=1;
bio(32).sigAddress='&quadripulse_controller14_B.Compare_h';
bio(32).ndims=2;
bio(32).size=[];
bio(32).isStruct=false;

bio(33).blkName='Compare To Constant2/Compare';
bio(33).sigName='';
bio(33).portIdx=0;
bio(33).dim=[1,1];
bio(33).sigWidth=1;
bio(33).sigAddress='&quadripulse_controller14_B.Compare_ln';
bio(33).ndims=2;
bio(33).size=[];
bio(33).isStruct=false;

bio(34).blkName='Compare To Constant3/Compare';
bio(34).sigName='';
bio(34).portIdx=0;
bio(34).dim=[1,1];
bio(34).sigWidth=1;
bio(34).sigAddress='&quadripulse_controller14_B.Compare_n';
bio(34).ndims=2;
bio(34).size=[];
bio(34).isStruct=false;

bio(35).blkName='Compare To Zero/Compare';
bio(35).sigName='';
bio(35).portIdx=0;
bio(35).dim=[1,1];
bio(35).sigWidth=1;
bio(35).sigAddress='&quadripulse_controller14_B.Compare_d';
bio(35).ndims=2;
bio(35).size=[];
bio(35).isStruct=false;

bio(36).blkName='De-Mean/Mean';
bio(36).sigName='';
bio(36).portIdx=0;
bio(36).dim=[1,1];
bio(36).sigWidth=1;
bio(36).sigAddress='&quadripulse_controller14_B.Mean_d';
bio(36).ndims=2;
bio(36).size=[];
bio(36).isStruct=false;

bio(37).blkName='De-Mean/Subtract';
bio(37).sigName='';
bio(37).portIdx=0;
bio(37).dim=[512,1];
bio(37).sigWidth=512;
bio(37).sigAddress='&quadripulse_controller14_B.Subtract_i[0]';
bio(37).ndims=2;
bio(37).size=[];
bio(37).isStruct=false;

bio(38).blkName='Detrend and FFT/Matrix Concatenation';
bio(38).sigName='';
bio(38).portIdx=0;
bio(38).dim=[100,2];
bio(38).sigWidth=200;
bio(38).sigAddress='&quadripulse_controller14_B.MatrixConcatenation[0]';
bio(38).ndims=2;
bio(38).size=[];
bio(38).isStruct=false;

bio(39).blkName='Detrend and FFT/scale to per Hz';
bio(39).sigName='';
bio(39).portIdx=0;
bio(39).dim=[1024,1];
bio(39).sigWidth=1024;
bio(39).sigAddress='&quadripulse_controller14_B.scaletoperHz[0]';
bio(39).ndims=2;
bio(39).size=[];
bio(39).isStruct=false;

bio(40).blkName='Detrend and FFT/Divide';
bio(40).sigName='';
bio(40).portIdx=0;
bio(40).dim=[1024,1];
bio(40).sigWidth=1024;
bio(40).sigAddress='&quadripulse_controller14_B.Divide[0]';
bio(40).ndims=2;
bio(40).size=[];
bio(40).isStruct=false;

bio(41).blkName='Detrend and FFT/Rate Transition2';
bio(41).sigName='';
bio(41).portIdx=0;
bio(41).dim=[512,1];
bio(41).sigWidth=512;
bio(41).sigAddress='&quadripulse_controller14_B.RateTransition2[0]';
bio(41).ndims=2;
bio(41).size=[];
bio(41).isStruct=false;

bio(42).blkName='Detrend and FFT/Rate Transition3';
bio(42).sigName='';
bio(42).portIdx=0;
bio(42).dim=[1024,1];
bio(42).sigWidth=1024;
bio(42).sigAddress='&quadripulse_controller14_B.RateTransition3_e[0]';
bio(42).ndims=2;
bio(42).size=[];
bio(42).isStruct=false;

bio(43).blkName='Detrend and FFT/Selector';
bio(43).sigName='';
bio(43).portIdx=0;
bio(43).dim=[1024,1];
bio(43).sigWidth=1024;
bio(43).sigAddress='&quadripulse_controller14_B.Selector[0]';
bio(43).ndims=2;
bio(43).size=[];
bio(43).isStruct=false;

bio(44).blkName='Detrend and FFT/Bins 2..51';
bio(44).sigName='';
bio(44).portIdx=0;
bio(44).dim=[100,2];
bio(44).sigWidth=200;
bio(44).sigAddress='&quadripulse_controller14_B.MatrixConcatenation[0]';
bio(44).ndims=2;
bio(44).size=[];
bio(44).isStruct=false;

bio(45).blkName='Detrend and FFT/Data';
bio(45).sigName='';
bio(45).portIdx=0;
bio(45).dim=[1,1];
bio(45).sigWidth=1;
bio(45).sigAddress='&quadripulse_controller14_B.Data';
bio(45).ndims=2;
bio(45).size=[];
bio(45).isStruct=false;

bio(46).blkName='Detrend and FFT/Mean';
bio(46).sigName='';
bio(46).portIdx=0;
bio(46).dim=[1,1];
bio(46).sigWidth=1;
bio(46).sigAddress='&quadripulse_controller14_B.Mean_l';
bio(46).ndims=2;
bio(46).size=[];
bio(46).isStruct=false;

bio(47).blkName='Detrend and FFT/Pad';
bio(47).sigName='';
bio(47).portIdx=0;
bio(47).dim=[1024,1];
bio(47).sigWidth=1024;
bio(47).sigAddress='&quadripulse_controller14_B.Pad[0]';
bio(47).ndims=2;
bio(47).size=[];
bio(47).isStruct=false;

bio(48).blkName='Detrend and FFT/Trigger Signal';
bio(48).sigName='';
bio(48).portIdx=0;
bio(48).dim=[1,1];
bio(48).sigWidth=1;
bio(48).sigAddress='&quadripulse_controller14_B.TriggerSignal';
bio(48).ndims=2;
bio(48).size=[];
bio(48).isStruct=false;

bio(49).blkName='Detrend and FFT/Window Function/p1';
bio(49).sigName='';
bio(49).portIdx=0;
bio(49).dim=[512,1];
bio(49).sigWidth=512;
bio(49).sigAddress='&quadripulse_controller14_B.WindowFunction_o1[0]';
bio(49).ndims=2;
bio(49).size=[];
bio(49).isStruct=false;

bio(50).blkName='Detrend and FFT/Window Function/p2';
bio(50).sigName='';
bio(50).portIdx=1;
bio(50).dim=[512,1];
bio(50).sigWidth=512;
bio(50).sigAddress='&quadripulse_controller14_B.WindowFunction_o2[0]';
bio(50).ndims=2;
bio(50).size=[];
bio(50).isStruct=false;

bio(51).blkName='Detrend and FFT/Sum of Elements';
bio(51).sigName='';
bio(51).portIdx=0;
bio(51).dim=[1,1];
bio(51).sigWidth=1;
bio(51).sigAddress='&quadripulse_controller14_B.SumofElements';
bio(51).ndims=2;
bio(51).size=[];
bio(51).isStruct=false;

bio(52).blkName='Detrend and FFT/Unbuffer';
bio(52).sigName='';
bio(52).portIdx=0;
bio(52).dim=[1,2];
bio(52).sigWidth=2;
bio(52).sigAddress='&quadripulse_controller14_B.Unbuffer[0]';
bio(52).ndims=2;
bio(52).size=[];
bio(52).isStruct=false;

bio(53).blkName='Fan Out with Offset for Scope Display /Rate Transition';
bio(53).sigName='';
bio(53).portIdx=0;
bio(53).dim=[1,5];
bio(53).sigWidth=5;
bio(53).sigAddress='&quadripulse_controller14_B.RateTransition[0]';
bio(53).ndims=2;
bio(53).size=[];
bio(53).isStruct=false;

bio(54).blkName='Fan Out with Offset for Scope Display /Constant Ramp';
bio(54).sigName='';
bio(54).portIdx=0;
bio(54).dim=[5,1];
bio(54).sigWidth=5;
bio(54).sigAddress='&quadripulse_controller14_ConstB.ConstantRamp[0]';
bio(54).ndims=2;
bio(54).size=[];
bio(54).isStruct=false;

bio(55).blkName='Fan Out with Offset for Scope Display /Add';
bio(55).sigName='';
bio(55).portIdx=0;
bio(55).dim=[1,5];
bio(55).sigWidth=5;
bio(55).sigAddress='&quadripulse_controller14_B.Add_o[0]';
bio(55).ndims=2;
bio(55).size=[];
bio(55).isStruct=false;

bio(56).blkName='Fan Out with Offset for Scope Display /Zero-Order Hold';
bio(56).sigName='';
bio(56).portIdx=0;
bio(56).dim=[1,5];
bio(56).sigWidth=5;
bio(56).sigAddress='&quadripulse_controller14_B.ZeroOrderHold[0]';
bio(56).ndims=2;
bio(56).size=[];
bio(56).isStruct=false;

bio(57).blkName='Forward and Backward Band Pass Filter/Flip';
bio(57).sigName='';
bio(57).portIdx=0;
bio(57).dim=[512,1];
bio(57).sigWidth=512;
bio(57).sigAddress='&quadripulse_controller14_B.Flip[0]';
bio(57).ndims=2;
bio(57).size=[];
bio(57).isStruct=false;

bio(58).blkName='Forward and Backward Band Pass Filter/Re-Flip';
bio(58).sigName='';
bio(58).portIdx=0;
bio(58).dim=[512,1];
bio(58).sigWidth=512;
bio(58).sigAddress='&quadripulse_controller14_B.ReFlip[0]';
bio(58).ndims=2;
bio(58).size=[];
bio(58).isStruct=false;

bio(59).blkName='Forward and Backward Band Pass Filter/FIR Bandpass Filter Backward';
bio(59).sigName='';
bio(59).portIdx=0;
bio(59).dim=[512,1];
bio(59).sigWidth=512;
bio(59).sigAddress='&quadripulse_controller14_B.FIRBandpassFilterBackward[0]';
bio(59).ndims=2;
bio(59).size=[];
bio(59).isStruct=false;

bio(60).blkName='Forward and Backward Band Pass Filter/FIR Bandpass Filter Forward';
bio(60).sigName='';
bio(60).portIdx=0;
bio(60).dim=[512,1];
bio(60).sigWidth=512;
bio(60).sigAddress='&quadripulse_controller14_B.FIRBandpassFilterForward[0]';
bio(60).ndims=2;
bio(60).size=[];
bio(60).isStruct=false;

bio(61).blkName='S-R Flip-Flop/Logic';
bio(61).sigName='';
bio(61).portIdx=0;
bio(61).dim=[2,1];
bio(61).sigWidth=2;
bio(61).sigAddress='&quadripulse_controller14_B.Logic[0]';
bio(61).ndims=2;
bio(61).size=[];
bio(61).isStruct=false;

bio(62).blkName='S-R Flip-Flop/Memory';
bio(62).sigName='';
bio(62).portIdx=0;
bio(62).dim=[1,1];
bio(62).sigWidth=1;
bio(62).sigAddress='&quadripulse_controller14_B.Memory';
bio(62).ndims=2;
bio(62).size=[];
bio(62).isStruct=false;

bio(63).blkName='Safety Check/MinMax';
bio(63).sigName='';
bio(63).portIdx=0;
bio(63).dim=[1,1];
bio(63).sigWidth=1;
bio(63).sigAddress='&quadripulse_controller14_B.MinMax';
bio(63).ndims=2;
bio(63).size=[];
bio(63).isStruct=false;

bio(64).blkName='Safety Check/Times 1..end-1';
bio(64).sigName='';
bio(64).portIdx=0;
bio(64).dim=[1,1];
bio(64).sigWidth=1;
bio(64).sigAddress='&quadripulse_controller14_B.Times1end1';
bio(64).ndims=2;
bio(64).size=[];
bio(64).isStruct=false;

bio(65).blkName='Safety Check/Times 2..end';
bio(65).sigName='';
bio(65).portIdx=0;
bio(65).dim=[1,1];
bio(65).sigWidth=1;
bio(65).sigAddress='&quadripulse_controller14_B.Times2end';
bio(65).ndims=2;
bio(65).size=[];
bio(65).isStruct=false;

bio(66).blkName='Safety Check/Subtract';
bio(66).sigName='';
bio(66).portIdx=0;
bio(66).dim=[1,1];
bio(66).sigWidth=1;
bio(66).sigAddress='&quadripulse_controller14_B.Subtract_n';
bio(66).ndims=2;
bio(66).size=[];
bio(66).isStruct=false;

bio(67).blkName='Subsystem/Probe';
bio(67).sigName='';
bio(67).portIdx=0;
bio(67).dim=[2,1];
bio(67).sigWidth=2;
bio(67).sigAddress='&quadripulse_controller14_B.Probe[0]';
bio(67).ndims=2;
bio(67).size=[];
bio(67).isStruct=false;

bio(68).blkName='Subsystem/Multiply';
bio(68).sigName='';
bio(68).portIdx=0;
bio(68).dim=[2,1];
bio(68).sigWidth=2;
bio(68).sigAddress='&quadripulse_controller14_B.Multiply[0]';
bio(68).ndims=2;
bio(68).size=[];
bio(68).isStruct=false;

bio(69).blkName='Subsystem/Rate Transition';
bio(69).sigName='';
bio(69).portIdx=0;
bio(69).dim=[1,1];
bio(69).sigWidth=1;
bio(69).sigAddress='&quadripulse_controller14_B.RateTransition_j';
bio(69).ndims=2;
bio(69).size=[];
bio(69).isStruct=false;

bio(70).blkName='Subsystem/Reshape1';
bio(70).sigName='';
bio(70).portIdx=0;
bio(70).dim=[2,1];
bio(70).sigWidth=2;
bio(70).sigAddress='&quadripulse_controller14_B.Reshape1_a[0]';
bio(70).ndims=2;
bio(70).size=[];
bio(70).isStruct=false;

bio(71).blkName='Subsystem/Rounding Function';
bio(71).sigName='';
bio(71).portIdx=0;
bio(71).dim=[2,1];
bio(71).sigWidth=2;
bio(71).sigAddress='&quadripulse_controller14_B.RoundingFunction[0]';
bio(71).ndims=2;
bio(71).size=[];
bio(71).isStruct=false;

bio(72).blkName='Subsystem/Selector';
bio(72).sigName='';
bio(72).portIdx=0;
bio(72).dim=[2,1];
bio(72).sigWidth=2;
bio(72).sigAddress='&quadripulse_controller14_B.Selector_m[0]';
bio(72).ndims=2;
bio(72).size=[];
bio(72).isStruct=false;

bio(73).blkName='Subsystem/Sort';
bio(73).sigName='';
bio(73).portIdx=0;
bio(73).dim=[600,1];
bio(73).sigWidth=600;
bio(73).sigAddress='&quadripulse_controller14_B.Sort[0]';
bio(73).ndims=2;
bio(73).size=[];
bio(73).isStruct=false;

bio(74).blkName='Subsystem/Subtract';
bio(74).sigName='';
bio(74).portIdx=0;
bio(74).dim=[1,1];
bio(74).sigWidth=1;
bio(74).sigAddress='&quadripulse_controller14_B.Subtract_f';
bio(74).ndims=2;
bio(74).size=[];
bio(74).isStruct=false;

bio(75).blkName='Trigger Condition/Trigger Condition Met';
bio(75).sigName='';
bio(75).portIdx=0;
bio(75).dim=[1,1];
bio(75).sigWidth=1;
bio(75).sigAddress='&quadripulse_controller14_B.TriggerConditionMet';
bio(75).ndims=2;
bio(75).size=[];
bio(75).isStruct=false;

bio(76).blkName='Trigger Condition/Within Range';
bio(76).sigName='';
bio(76).portIdx=0;
bio(76).dim=[1,1];
bio(76).sigWidth=1;
bio(76).sigAddress='&quadripulse_controller14_B.WithinRange';
bio(76).ndims=2;
bio(76).size=[];
bio(76).isStruct=false;

bio(77).blkName='Trigger Condition/Index Vector';
bio(77).sigName='';
bio(77).portIdx=0;
bio(77).dim=[1,1];
bio(77).sigWidth=1;
bio(77).sigAddress='&quadripulse_controller14_B.IndexVector';
bio(77).ndims=2;
bio(77).size=[];
bio(77).isStruct=false;

bio(78).blkName='Trigger Condition/<= max';
bio(78).sigName='';
bio(78).portIdx=0;
bio(78).dim=[1,1];
bio(78).sigWidth=1;
bio(78).sigAddress='&quadripulse_controller14_B.max';
bio(78).ndims=2;
bio(78).size=[];
bio(78).isStruct=false;

bio(79).blkName='Trigger Condition/>= min';
bio(79).sigName='';
bio(79).portIdx=0;
bio(79).dim=[1,1];
bio(79).sigWidth=1;
bio(79).sigAddress='&quadripulse_controller14_B.min';
bio(79).ndims=2;
bio(79).size=[];
bio(79).isStruct=false;

bio(80).blkName='Trigger Generator/Data Type Conversion1';
bio(80).sigName='';
bio(80).portIdx=0;
bio(80).dim=[1,1];
bio(80).sigWidth=1;
bio(80).sigAddress='&quadripulse_controller14_B.DataTypeConversion1_b';
bio(80).ndims=2;
bio(80).size=[];
bio(80).isStruct=false;

bio(81).blkName='Trigger Generator/Data Type Conversion4';
bio(81).sigName='';
bio(81).portIdx=0;
bio(81).dim=[1,1];
bio(81).sigWidth=1;
bio(81).sigAddress='&quadripulse_controller14_B.DataTypeConversion4';
bio(81).ndims=2;
bio(81).size=[];
bio(81).isStruct=false;

bio(82).blkName='Trigger Generator/Gain';
bio(82).sigName='';
bio(82).portIdx=0;
bio(82).dim=[1,1];
bio(82).sigWidth=1;
bio(82).sigAddress='&quadripulse_controller14_B.Gain_p';
bio(82).ndims=2;
bio(82).size=[];
bio(82).isStruct=false;

bio(83).blkName='Trigger Generator/Logical Operator';
bio(83).sigName='';
bio(83).portIdx=0;
bio(83).dim=[1,1];
bio(83).sigWidth=1;
bio(83).sigAddress='&quadripulse_controller14_B.LogicalOperator';
bio(83).ndims=2;
bio(83).size=[];
bio(83).isStruct=false;

bio(84).blkName='Trigger Generator/Channel Index';
bio(84).sigName='';
bio(84).portIdx=0;
bio(84).dim=[1,1];
bio(84).sigWidth=1;
bio(84).sigAddress='&quadripulse_controller14_B.ChannelIndex';
bio(84).ndims=2;
bio(84).size=[];
bio(84).isStruct=false;

bio(85).blkName='Trigger Generator/Time Index';
bio(85).sigName='';
bio(85).portIdx=0;
bio(85).dim=[1,1];
bio(85).sigWidth=1;
bio(85).sigAddress='&quadripulse_controller14_B.TimeIndex';
bio(85).ndims=2;
bio(85).size=[];
bio(85).isStruct=false;

bio(86).blkName='Trigger Generator/Bounds check';
bio(86).sigName='';
bio(86).portIdx=0;
bio(86).dim=[1,1];
bio(86).sigWidth=1;
bio(86).sigAddress='&quadripulse_controller14_B.Boundscheck';
bio(86).ndims=2;
bio(86).size=[];
bio(86).isStruct=false;

bio(87).blkName='Trigger Generator/Relational Operator';
bio(87).sigName='';
bio(87).portIdx=0;
bio(87).dim=[1,1];
bio(87).sigWidth=1;
bio(87).sigAddress='&quadripulse_controller14_B.RelationalOperator';
bio(87).ndims=2;
bio(87).size=[];
bio(87).isStruct=false;

bio(88).blkName='Trigger Generator/Channel Data';
bio(88).sigName='';
bio(88).portIdx=0;
bio(88).dim=[2,1];
bio(88).sigWidth=2;
bio(88).sigAddress='&quadripulse_controller14_B.ChannelData[0]';
bio(88).ndims=2;
bio(88).size=[];
bio(88).isStruct=false;

bio(89).blkName='Trigger Generator/Time Data';
bio(89).sigName='';
bio(89).portIdx=0;
bio(89).dim=[2,1];
bio(89).sigWidth=2;
bio(89).sigAddress='&quadripulse_controller14_B.TimeData[0]';
bio(89).ndims=2;
bio(89).size=[];
bio(89).isStruct=false;

bio(90).blkName='Trigger Generator/Sum';
bio(90).sigName='';
bio(90).portIdx=0;
bio(90).dim=[1,1];
bio(90).sigWidth=1;
bio(90).sigAddress='&quadripulse_controller14_B.Sum';
bio(90).ndims=2;
bio(90).size=[];
bio(90).isStruct=false;

bio(91).blkName='Trigger Generator/Saturate';
bio(91).sigName='';
bio(91).portIdx=0;
bio(91).dim=[1,1];
bio(91).sigWidth=1;
bio(91).sigAddress='&quadripulse_controller14_B.Saturate';
bio(91).ndims=2;
bio(91).size=[];
bio(91).isStruct=false;

bio(92).blkName='Trigger Generator/Switch';
bio(92).sigName='';
bio(92).portIdx=0;
bio(92).dim=[1,1];
bio(92).sigWidth=1;
bio(92).sigAddress='&quadripulse_controller14_B.Switch';
bio(92).ndims=2;
bio(92).size=[];
bio(92).isStruct=false;

bio(93).blkName='Trigger Generator/Width';
bio(93).sigName='';
bio(93).portIdx=0;
bio(93).dim=[1,1];
bio(93).sigWidth=1;
bio(93).sigAddress='&quadripulse_controller14_ConstB.Width';
bio(93).ndims=2;
bio(93).size=[];
bio(93).isStruct=false;

bio(94).blkName='Trigger Generator/Counter Delay';
bio(94).sigName='';
bio(94).portIdx=0;
bio(94).dim=[1,1];
bio(94).sigWidth=1;
bio(94).sigAddress='&quadripulse_controller14_B.CounterDelay';
bio(94).ndims=2;
bio(94).size=[];
bio(94).isStruct=false;

bio(95).blkName='UDP EEG Data/Matrix Concatenate';
bio(95).sigName='';
bio(95).portIdx=0;
bio(95).dim=[4,330];
bio(95).sigWidth=1320;
bio(95).sigAddress='&quadripulse_controller14_B.MatrixConcatenate[0]';
bio(95).ndims=2;
bio(95).size=[];
bio(95).isStruct=false;

bio(96).blkName='UDP EEG Data/Data Type Conversion';
bio(96).sigName='';
bio(96).portIdx=0;
bio(96).dim=[330,1];
bio(96).sigWidth=330;
bio(96).sigAddress='&quadripulse_controller14_B.DataTypeConversion[0]';
bio(96).ndims=2;
bio(96).size=[];
bio(96).isStruct=false;

bio(97).blkName='UDP EEG Data/Flip';
bio(97).sigName='';
bio(97).portIdx=0;
bio(97).dim=[3,330];
bio(97).sigWidth=990;
bio(97).sigAddress='&quadripulse_controller14_B.Flip_b[0]';
bio(97).ndims=2;
bio(97).size=[];
bio(97).isStruct=false;

bio(98).blkName='UDP EEG Data/Gain';
bio(98).sigName='';
bio(98).portIdx=0;
bio(98).dim=[330,1];
bio(98).sigWidth=330;
bio(98).sigAddress='&quadripulse_controller14_B.Gain[0]';
bio(98).ndims=2;
bio(98).size=[];
bio(98).isStruct=false;

bio(99).blkName='UDP EEG Data/Math Function';
bio(99).sigName='';
bio(99).portIdx=0;
bio(99).dim=[5,66];
bio(99).sigWidth=330;
bio(99).sigAddress='&quadripulse_controller14_B.MathFunction[0]';
bio(99).ndims=2;
bio(99).size=[];
bio(99).isStruct=false;

bio(100).blkName='UDP EEG Data/Reshape';
bio(100).sigName='';
bio(100).portIdx=0;
bio(100).dim=[3,330];
bio(100).sigWidth=990;
bio(100).sigAddress='&quadripulse_controller14_B.Reshape_p[0]';
bio(100).ndims=2;
bio(100).size=[];
bio(100).isStruct=false;

bio(101).blkName='UDP EEG Data/Reshape2';
bio(101).sigName='';
bio(101).portIdx=0;
bio(101).dim=[66,5];
bio(101).sigWidth=330;
bio(101).sigAddress='&quadripulse_controller14_B.Reshape2[0]';
bio(101).ndims=2;
bio(101).size=[];
bio(101).isStruct=false;

bio(102).blkName='UDP EEG Data/Byte Unpacking ';
bio(102).sigName='';
bio(102).portIdx=0;
bio(102).dim=[330,1];
bio(102).sigWidth=330;
bio(102).sigAddress='&quadripulse_controller14_B.ByteUnpacking[0]';
bio(102).ndims=2;
bio(102).size=[];
bio(102).isStruct=false;

bio(103).blkName='Detrend and FFT/Constant5/Constant';
bio(103).sigName='';
bio(103).portIdx=0;
bio(103).dim=[100,2];
bio(103).sigWidth=200;
bio(103).sigAddress='&quadripulse_controller14_B.MatrixConcatenation[0]';
bio(103).ndims=2;
bio(103).size=[];
bio(103).isStruct=false;

bio(104).blkName='Detrend and FFT/Detrend/Merge';
bio(104).sigName='a';
bio(104).portIdx=0;
bio(104).dim=[1,1];
bio(104).sigWidth=1;
bio(104).sigAddress='&quadripulse_controller14_B.a';
bio(104).ndims=2;
bio(104).size=[];
bio(104).isStruct=false;

bio(105).blkName='Detrend and FFT/Detrend/Merge1';
bio(105).sigName='b';
bio(105).portIdx=0;
bio(105).dim=[1,1];
bio(105).sigWidth=1;
bio(105).sigAddress='&quadripulse_controller14_B.b';
bio(105).ndims=2;
bio(105).size=[];
bio(105).isStruct=false;

bio(106).blkName='Detrend and FFT/Detrend/linear term1';
bio(106).sigName='';
bio(106).portIdx=0;
bio(106).dim=[512,1];
bio(106).sigWidth=512;
bio(106).sigAddress='&quadripulse_controller14_B.linearterm1[0]';
bio(106).ndims=2;
bio(106).size=[];
bio(106).isStruct=false;

bio(107).blkName='Detrend and FFT/Detrend/linear term2';
bio(107).sigName='';
bio(107).portIdx=0;
bio(107).dim=[1,1];
bio(107).sigWidth=1;
bio(107).sigAddress='&quadripulse_controller14_B.linearterm2';
bio(107).ndims=2;
bio(107).size=[];
bio(107).isStruct=false;

bio(108).blkName='Detrend and FFT/Detrend/linear term3';
bio(108).sigName='';
bio(108).portIdx=0;
bio(108).dim=[1,1];
bio(108).sigWidth=1;
bio(108).sigAddress='&quadripulse_controller14_B.linearterm3';
bio(108).ndims=2;
bio(108).size=[];
bio(108).isStruct=false;

bio(109).blkName='Detrend and FFT/Detrend/Reshape';
bio(109).sigName='';
bio(109).portIdx=0;
bio(109).dim=[512,1];
bio(109).sigWidth=512;
bio(109).sigAddress='&quadripulse_controller14_B.Reshape[0]';
bio(109).ndims=2;
bio(109).size=[];
bio(109).isStruct=false;

bio(110).blkName='Detrend and FFT/Detrend/Constant Ramp';
bio(110).sigName='ramp';
bio(110).portIdx=0;
bio(110).dim=[512,1];
bio(110).sigWidth=512;
bio(110).sigAddress='&quadripulse_controller14_ConstB.ramp[0]';
bio(110).ndims=2;
bio(110).size=[];
bio(110).isStruct=false;

bio(111).blkName='Detrend and FFT/Detrend/Maximum';
bio(111).sigName='';
bio(111).portIdx=0;
bio(111).dim=[1,1];
bio(111).sigWidth=1;
bio(111).sigAddress='&quadripulse_controller14_B.Maximum';
bio(111).ndims=2;
bio(111).size=[];
bio(111).isStruct=false;

bio(112).blkName='Detrend and FFT/Detrend/Matrix Sum1';
bio(112).sigName='';
bio(112).portIdx=0;
bio(112).dim=[1,1];
bio(112).sigWidth=1;
bio(112).sigAddress='&quadripulse_controller14_B.MatrixSum1';
bio(112).ndims=2;
bio(112).size=[];
bio(112).isStruct=false;

bio(113).blkName='Detrend and FFT/Detrend/Matrix Sum2';
bio(113).sigName='';
bio(113).portIdx=0;
bio(113).dim=[1,1];
bio(113).sigWidth=1;
bio(113).sigAddress='&quadripulse_controller14_B.MatrixSum2';
bio(113).ndims=2;
bio(113).size=[];
bio(113).isStruct=false;

bio(114).blkName='Detrend and FFT/Detrend/Sum1';
bio(114).sigName='';
bio(114).portIdx=0;
bio(114).dim=[1,1];
bio(114).sigWidth=1;
bio(114).sigAddress='&quadripulse_controller14_B.Sum1';
bio(114).ndims=2;
bio(114).size=[];
bio(114).isStruct=false;

bio(115).blkName='Detrend and FFT/Detrend/Sum4';
bio(115).sigName='';
bio(115).portIdx=0;
bio(115).dim=[512,1];
bio(115).sigWidth=512;
bio(115).sigAddress='&quadripulse_controller14_B.Sum4[0]';
bio(115).ndims=2;
bio(115).size=[];
bio(115).isStruct=false;

bio(116).blkName='Detrend and FFT/Detrend/Sum5';
bio(116).sigName='';
bio(116).portIdx=0;
bio(116).dim=[512,1];
bio(116).sigWidth=512;
bio(116).sigAddress='&quadripulse_controller14_B.Sum5[0]';
bio(116).ndims=2;
bio(116).size=[];
bio(116).isStruct=false;

bio(117).blkName='Detrend and FFT/Detrend/Dot Product';
bio(117).sigName='';
bio(117).portIdx=0;
bio(117).dim=[1,1];
bio(117).sigWidth=1;
bio(117).sigAddress='&quadripulse_controller14_B.DotProduct';
bio(117).ndims=2;
bio(117).size=[];
bio(117).isStruct=false;

bio(118).blkName='Detrend and FFT/Detrend/Dot Product2';
bio(118).sigName='';
bio(118).portIdx=0;
bio(118).dim=[1,1];
bio(118).sigWidth=1;
bio(118).sigAddress='&quadripulse_controller14_B.DotProduct2';
bio(118).ndims=2;
bio(118).size=[];
bio(118).isStruct=false;

bio(119).blkName='Detrend and FFT/Magnitude FFT/Magnitude Squared';
bio(119).sigName='';
bio(119).portIdx=0;
bio(119).dim=[1024,1];
bio(119).sigWidth=1024;
bio(119).sigAddress='&quadripulse_controller14_B.MagnitudeSquared[0]';
bio(119).ndims=2;
bio(119).size=[];
bio(119).isStruct=false;

bio(120).blkName='Detrend and FFT/Magnitude FFT/FFT';
bio(120).sigName='';
bio(120).portIdx=0;
bio(120).dim=[1024,1];
bio(120).sigWidth=1024;
bio(120).sigAddress='&quadripulse_controller14_B.FFT[0].re';
bio(120).ndims=2;
bio(120).size=[];
bio(120).isStruct=true;

bio(121).blkName='Fan Out with Offset for Scope Display /Running Average/Gain';
bio(121).sigName='';
bio(121).portIdx=0;
bio(121).dim=[1,5];
bio(121).sigWidth=5;
bio(121).sigAddress='&quadripulse_controller14_B.Gain_c[0]';
bio(121).ndims=2;
bio(121).size=[];
bio(121).isStruct=false;

bio(122).blkName='Fan Out with Offset for Scope Display /Running Average/Add';
bio(122).sigName='';
bio(122).portIdx=0;
bio(122).dim=[1,5];
bio(122).sigWidth=5;
bio(122).sigAddress='&quadripulse_controller14_B.Add[0]';
bio(122).ndims=2;
bio(122).size=[];
bio(122).isStruct=false;

bio(123).blkName='Fan Out with Offset for Scope Display /Running Average/Delay';
bio(123).sigName='';
bio(123).portIdx=0;
bio(123).dim=[1,5];
bio(123).sigWidth=5;
bio(123).sigAddress='&quadripulse_controller14_B.Delay[0]';
bio(123).ndims=2;
bio(123).size=[];
bio(123).isStruct=false;

bio(124).blkName='Fan Out with Offset for Scope Display /Running Average/Delay1';
bio(124).sigName='';
bio(124).portIdx=0;
bio(124).dim=[1,5];
bio(124).sigWidth=5;
bio(124).sigAddress='&quadripulse_controller14_B.Delay1_b[0]';
bio(124).ndims=2;
bio(124).size=[];
bio(124).isStruct=false;

bio(125).blkName='Safety Check/4-into-1 Unit Limit/Compare';
bio(125).sigName='';
bio(125).portIdx=0;
bio(125).dim=[1,1];
bio(125).sigWidth=1;
bio(125).sigAddress='&quadripulse_controller14_B.Compare_e';
bio(125).ndims=2;
bio(125).size=[];
bio(125).isStruct=false;

bio(126).blkName='Subsystem/Enabled Subsystem/Buffer';
bio(126).sigName='';
bio(126).portIdx=0;
bio(126).dim=[600,1];
bio(126).sigWidth=600;
bio(126).sigAddress='&quadripulse_controller14_B.Buffer_p[0]';
bio(126).ndims=2;
bio(126).size=[];
bio(126).isStruct=false;

bio(127).blkName='Subsystem/Prolonged Disable/Data Type Conversion';
bio(127).sigName='';
bio(127).portIdx=0;
bio(127).dim=[1,1];
bio(127).sigWidth=1;
bio(127).sigAddress='&quadripulse_controller14_B.DataTypeConversion_k';
bio(127).ndims=2;
bio(127).size=[];
bio(127).isStruct=false;

bio(128).blkName='Subsystem/Prolonged Disable/Seconds';
bio(128).sigName='';
bio(128).portIdx=0;
bio(128).dim=[1,1];
bio(128).sigWidth=1;
bio(128).sigAddress='&quadripulse_controller14_B.Seconds';
bio(128).ndims=2;
bio(128).size=[];
bio(128).isStruct=false;

bio(129).blkName='Subsystem/Prolonged Disable/Sum';
bio(129).sigName='';
bio(129).portIdx=0;
bio(129).dim=[1,1];
bio(129).sigWidth=1;
bio(129).sigAddress='&quadripulse_controller14_B.Sum_n';
bio(129).ndims=2;
bio(129).size=[];
bio(129).isStruct=false;

bio(130).blkName='Subsystem/Prolonged Disable/Keep Postive Switch';
bio(130).sigName='';
bio(130).portIdx=0;
bio(130).dim=[1,1];
bio(130).sigWidth=1;
bio(130).sigAddress='&quadripulse_controller14_B.KeepPostiveSwitch';
bio(130).ndims=2;
bio(130).size=[];
bio(130).isStruct=false;

bio(131).blkName='Subsystem/Prolonged Disable/Set Counter Switch';
bio(131).sigName='';
bio(131).portIdx=0;
bio(131).dim=[1,1];
bio(131).sigWidth=1;
bio(131).sigAddress='&quadripulse_controller14_B.SetCounterSwitch';
bio(131).ndims=2;
bio(131).size=[];
bio(131).isStruct=false;

bio(132).blkName='Subsystem/Prolonged Disable/Unit Delay';
bio(132).sigName='';
bio(132).portIdx=0;
bio(132).dim=[1,1];
bio(132).sigWidth=1;
bio(132).sigAddress='&quadripulse_controller14_B.UnitDelay_n';
bio(132).ndims=2;
bio(132).size=[];
bio(132).isStruct=false;

bio(133).blkName='Subsystem/Prolonged Disable/Weighted Sample Time';
bio(133).sigName='';
bio(133).portIdx=0;
bio(133).dim=[1,1];
bio(133).sigWidth=1;
bio(133).sigAddress='&quadripulse_controller14_B.WeightedSampleTime';
bio(133).ndims=2;
bio(133).size=[];
bio(133).isStruct=false;

bio(134).blkName='Time Series Forecast/Yule-Walker AR Estimator/Autocorrelation';
bio(134).sigName='';
bio(134).portIdx=0;
bio(134).dim=[31,1];
bio(134).sigWidth=31;
bio(134).sigAddress='&quadripulse_controller14_B.Autocorrelation[0]';
bio(134).ndims=2;
bio(134).size=[];
bio(134).isStruct=false;

bio(135).blkName='Time Series Forecast/Yule-Walker AR Estimator/Levinson-Durbin/p1';
bio(135).sigName='';
bio(135).portIdx=0;
bio(135).dim=[31,1];
bio(135).sigWidth=31;
bio(135).sigAddress='&quadripulse_controller14_B.LevinsonDurbin_o1[0]';
bio(135).ndims=2;
bio(135).size=[];
bio(135).isStruct=false;

bio(136).blkName='Time Series Forecast/Yule-Walker AR Estimator/Levinson-Durbin/p2';
bio(136).sigName='';
bio(136).portIdx=1;
bio(136).dim=[1,1];
bio(136).sigWidth=1;
bio(136).sigAddress='&quadripulse_controller14_B.LevinsonDurbin_o2';
bio(136).ndims=2;
bio(136).size=[];
bio(136).isStruct=false;

bio(137).blkName='Trigger Condition/Crossing Detector/Hit  Crossing';
bio(137).sigName='';
bio(137).portIdx=0;
bio(137).dim=[1,1];
bio(137).sigWidth=1;
bio(137).sigAddress='&quadripulse_controller14_B.HitCrossing_i';
bio(137).ndims=2;
bio(137).size=[];
bio(137).isStruct=false;

bio(138).blkName='Trigger Condition/Crossing Detector/Hit  Crossing1';
bio(138).sigName='';
bio(138).portIdx=0;
bio(138).dim=[1,1];
bio(138).sigWidth=1;
bio(138).sigAddress='&quadripulse_controller14_B.HitCrossing1';
bio(138).ndims=2;
bio(138).size=[];
bio(138).isStruct=false;

bio(139).blkName='Trigger Condition/Crossing Detector/Hit  Crossing2';
bio(139).sigName='';
bio(139).portIdx=0;
bio(139).dim=[1,1];
bio(139).sigWidth=1;
bio(139).sigAddress='&quadripulse_controller14_B.HitCrossing2';
bio(139).ndims=2;
bio(139).size=[];
bio(139).isStruct=false;

bio(140).blkName='Trigger Condition/Crossing Detector/Hit  Crossing3';
bio(140).sigName='';
bio(140).portIdx=0;
bio(140).dim=[1,1];
bio(140).sigWidth=1;
bio(140).sigAddress='&quadripulse_controller14_B.HitCrossing3';
bio(140).ndims=2;
bio(140).size=[];
bio(140).isStruct=false;

bio(141).blkName='Trigger Generator/Counter Free-Running/Output';
bio(141).sigName='';
bio(141).portIdx=0;
bio(141).dim=[1,1];
bio(141).sigWidth=1;
bio(141).sigAddress='&quadripulse_controller14_B.Output';
bio(141).ndims=2;
bio(141).size=[];
bio(141).isStruct=false;

bio(142).blkName='UDP EEG Data/Receive 1/Buffer 1';
bio(142).sigName='';
bio(142).portIdx=0;
bio(142).dim=[1,1];
bio(142).sigWidth=1;
bio(142).sigAddress='&quadripulse_controller14_B.Buffer1';
bio(142).ndims=2;
bio(142).size=[];
bio(142).isStruct=false;

bio(143).blkName='UDP EEG Data/Receive 1/Extract 1/p1';
bio(143).sigName='';
bio(143).portIdx=0;
bio(143).dim=[1018,1];
bio(143).sigWidth=1018;
bio(143).sigAddress='&quadripulse_controller14_B.Extract1_o1[0]';
bio(143).ndims=2;
bio(143).size=[];
bio(143).isStruct=false;

bio(144).blkName='UDP EEG Data/Receive 1/Extract 1/p2';
bio(144).sigName='';
bio(144).portIdx=1;
bio(144).dim=[1,1];
bio(144).sigWidth=1;
bio(144).sigAddress='&quadripulse_controller14_B.Extract1_o2';
bio(144).ndims=2;
bio(144).size=[];
bio(144).isStruct=false;

bio(145).blkName='UDP EEG Data/Receive 1/UDP Consume 1/p1';
bio(145).sigName='';
bio(145).portIdx=0;
bio(145).dim=[1,1];
bio(145).sigWidth=1;
bio(145).sigAddress='&quadripulse_controller14_B.UDPConsume1_o1';
bio(145).ndims=2;
bio(145).size=[];
bio(145).isStruct=false;

bio(146).blkName='UDP EEG Data/Receive 1/UDP Consume 1/p2';
bio(146).sigName='';
bio(146).portIdx=1;
bio(146).dim=[1,1];
bio(146).sigWidth=1;
bio(146).sigAddress='&quadripulse_controller14_B.UDPConsume1_o2';
bio(146).ndims=2;
bio(146).size=[];
bio(146).isStruct=false;

bio(147).blkName='UDP EEG Data/Receive 1/UDP Rx 1';
bio(147).sigName='';
bio(147).portIdx=0;
bio(147).dim=[1,1];
bio(147).sigWidth=1;
bio(147).sigAddress='&quadripulse_controller14_B.UDPRx1';
bio(147).ndims=2;
bio(147).size=[];
bio(147).isStruct=false;

bio(148).blkName='Detrend and FFT/Detrend/If Action Subsystem/linear term1';
bio(148).sigName='';
bio(148).portIdx=0;
bio(148).dim=[1,1];
bio(148).sigWidth=1;
bio(148).sigAddress='&quadripulse_controller14_B.linearterm1_m';
bio(148).ndims=2;
bio(148).size=[];
bio(148).isStruct=false;

bio(149).blkName='Detrend and FFT/Detrend/If Action Subsystem/linear term2';
bio(149).sigName='';
bio(149).portIdx=0;
bio(149).dim=[1,1];
bio(149).sigWidth=1;
bio(149).sigAddress='&quadripulse_controller14_B.linearterm2_j';
bio(149).ndims=2;
bio(149).size=[];
bio(149).isStruct=false;

bio(150).blkName='Detrend and FFT/Detrend/If Action Subsystem/linear term3';
bio(150).sigName='';
bio(150).portIdx=0;
bio(150).dim=[1,1];
bio(150).sigWidth=1;
bio(150).sigAddress='&quadripulse_controller14_B.linearterm3_j';
bio(150).ndims=2;
bio(150).size=[];
bio(150).isStruct=false;

bio(151).blkName='Detrend and FFT/Detrend/If Action Subsystem/linear term4';
bio(151).sigName='';
bio(151).portIdx=0;
bio(151).dim=[1,1];
bio(151).sigWidth=1;
bio(151).sigAddress='&quadripulse_controller14_B.linearterm4';
bio(151).ndims=2;
bio(151).size=[];
bio(151).isStruct=false;

bio(152).blkName='Detrend and FFT/Detrend/If Action Subsystem/linear term5';
bio(152).sigName='';
bio(152).portIdx=0;
bio(152).dim=[1,1];
bio(152).sigWidth=1;
bio(152).sigAddress='&quadripulse_controller14_B.a';
bio(152).ndims=2;
bio(152).size=[];
bio(152).isStruct=false;

bio(153).blkName='Detrend and FFT/Detrend/If Action Subsystem/linear term6';
bio(153).sigName='';
bio(153).portIdx=0;
bio(153).dim=[1,1];
bio(153).sigWidth=1;
bio(153).sigAddress='&quadripulse_controller14_B.b';
bio(153).ndims=2;
bio(153).size=[];
bio(153).isStruct=false;

bio(154).blkName='Detrend and FFT/Detrend/If Action Subsystem/Sum1';
bio(154).sigName='';
bio(154).portIdx=0;
bio(154).dim=[1,1];
bio(154).sigWidth=1;
bio(154).sigAddress='&quadripulse_controller14_B.Sum1_m';
bio(154).ndims=2;
bio(154).size=[];
bio(154).isStruct=false;

bio(155).blkName='Detrend and FFT/Detrend/If Action Subsystem/Sum4';
bio(155).sigName='';
bio(155).portIdx=0;
bio(155).dim=[1,1];
bio(155).sigWidth=1;
bio(155).sigAddress='&quadripulse_controller14_B.Sum4_e';
bio(155).ndims=2;
bio(155).size=[];
bio(155).isStruct=false;

bio(156).blkName='Detrend and FFT/Detrend/If Action Subsystem1/Inherit Complexity';
bio(156).sigName='';
bio(156).portIdx=0;
bio(156).dim=[1,1];
bio(156).sigWidth=1;
bio(156).sigAddress='&quadripulse_controller14_B.InheritComplexity';
bio(156).ndims=2;
bio(156).size=[];
bio(156).isStruct=false;

bio(157).blkName='Detrend and FFT/Detrend/If Action Subsystem1/Multiport Selector';
bio(157).sigName='';
bio(157).portIdx=0;
bio(157).dim=[1,1];
bio(157).sigWidth=1;
bio(157).sigAddress='&quadripulse_controller14_B.MultiportSelector';
bio(157).ndims=2;
bio(157).size=[];
bio(157).isStruct=false;

bio(158).blkName='Detrend and FFT/Detrend/Inherit Frame Status/Inherit';
bio(158).sigName='';
bio(158).portIdx=0;
bio(158).dim=[512,1];
bio(158).sigWidth=512;
bio(158).sigAddress='&quadripulse_controller14_B.Inherit[0]';
bio(158).ndims=2;
bio(158).size=[];
bio(158).isStruct=false;

bio(159).blkName='Subsystem/Prolonged Disable/Compare To Zero/Compare';
bio(159).sigName='';
bio(159).portIdx=0;
bio(159).dim=[1,1];
bio(159).sigWidth=1;
bio(159).sigAddress='&quadripulse_controller14_B.Compare';
bio(159).ndims=2;
bio(159).size=[];
bio(159).isStruct=false;

bio(160).blkName='Time Series Forecast/Forecast of 128 samples/Forecast/Assignment';
bio(160).sigName='';
bio(160).portIdx=0;
bio(160).dim=[128,1];
bio(160).sigWidth=128;
bio(160).sigAddress='&quadripulse_controller14_B.Assignment[0]';
bio(160).ndims=2;
bio(160).size=[];
bio(160).isStruct=false;

bio(161).blkName='Time Series Forecast/Forecast of 128 samples/Forecast/Flip';
bio(161).sigName='';
bio(161).portIdx=0;
bio(161).dim=[30,1];
bio(161).sigWidth=30;
bio(161).sigAddress='&quadripulse_controller14_B.Flip_a[0]';
bio(161).ndims=2;
bio(161).size=[];
bio(161).isStruct=false;

bio(162).blkName='Time Series Forecast/Forecast of 128 samples/Forecast/For Iterator';
bio(162).sigName='';
bio(162).portIdx=0;
bio(162).dim=[1,1];
bio(162).sigWidth=1;
bio(162).sigAddress='&quadripulse_controller14_B.ForIterator';
bio(162).ndims=2;
bio(162).size=[];
bio(162).isStruct=false;

bio(163).blkName='Time Series Forecast/Forecast of 128 samples/Forecast/Frame Length';
bio(163).sigName='';
bio(163).portIdx=0;
bio(163).dim=[1,1];
bio(163).sigWidth=1;
bio(163).sigAddress='&quadripulse_controller14_B.FrameLength';
bio(163).ndims=2;
bio(163).size=[];
bio(163).isStruct=false;

bio(164).blkName='Time Series Forecast/Forecast of 128 samples/Forecast/Number of Coefficients';
bio(164).sigName='';
bio(164).portIdx=0;
bio(164).dim=[1,1];
bio(164).sigWidth=1;
bio(164).sigAddress='&quadripulse_controller14_B.NumberofCoefficients';
bio(164).ndims=2;
bio(164).size=[];
bio(164).isStruct=false;

bio(165).blkName='Time Series Forecast/Forecast of 128 samples/Forecast/Saturation';
bio(165).sigName='';
bio(165).portIdx=0;
bio(165).dim=[1,1];
bio(165).sigWidth=1;
bio(165).sigAddress='&quadripulse_controller14_B.Saturation';
bio(165).ndims=2;
bio(165).size=[];
bio(165).isStruct=false;

bio(166).blkName='Time Series Forecast/Forecast of 128 samples/Forecast/Constant Ramp';
bio(166).sigName='';
bio(166).portIdx=0;
bio(166).dim=[30,1];
bio(166).sigWidth=30;
bio(166).sigAddress='&quadripulse_controller14_ConstB.ConstantRamp_i[0]';
bio(166).ndims=2;
bio(166).size=[];
bio(166).isStruct=false;

bio(167).blkName='Time Series Forecast/Forecast of 128 samples/Forecast/First Element';
bio(167).sigName='';
bio(167).portIdx=0;
bio(167).dim=[1,1];
bio(167).sigWidth=1;
bio(167).sigAddress='&quadripulse_controller14_B.FirstElement';
bio(167).ndims=2;
bio(167).size=[];
bio(167).isStruct=false;

bio(168).blkName='Time Series Forecast/Forecast of 128 samples/Forecast/Second to Last';
bio(168).sigName='';
bio(168).portIdx=0;
bio(168).dim=[30,1];
bio(168).sigWidth=30;
bio(168).sigAddress='&quadripulse_controller14_B.SecondtoLast[0]';
bio(168).ndims=2;
bio(168).size=[];
bio(168).isStruct=false;

bio(169).blkName='Time Series Forecast/Forecast of 128 samples/Forecast/Variable Selector';
bio(169).sigName='';
bio(169).portIdx=0;
bio(169).dim=[30,1];
bio(169).sigWidth=30;
bio(169).sigAddress='&quadripulse_controller14_B.VariableSelector[0]';
bio(169).ndims=2;
bio(169).size=[];
bio(169).isStruct=false;

bio(170).blkName='Time Series Forecast/Forecast of 128 samples/Forecast/Add';
bio(170).sigName='';
bio(170).portIdx=0;
bio(170).dim=[1,1];
bio(170).sigWidth=1;
bio(170).sigAddress='&quadripulse_controller14_B.Add_d';
bio(170).ndims=2;
bio(170).size=[];
bio(170).isStruct=false;

bio(171).blkName='Time Series Forecast/Forecast of 128 samples/Forecast/Sum';
bio(171).sigName='';
bio(171).portIdx=0;
bio(171).dim=[1,1];
bio(171).sigWidth=1;
bio(171).sigAddress='&quadripulse_controller14_B.Sum_e';
bio(171).ndims=2;
bio(171).size=[];
bio(171).isStruct=false;

bio(172).blkName='Time Series Forecast/Forecast of 128 samples/Forecast/Sum1';
bio(172).sigName='';
bio(172).portIdx=0;
bio(172).dim=[30,1];
bio(172).sigWidth=30;
bio(172).sigAddress='&quadripulse_controller14_B.Sum1_k[0]';
bio(172).ndims=2;
bio(172).size=[];
bio(172).isStruct=false;

bio(173).blkName='Time Series Forecast/Forecast of 128 samples/Forecast/Dot Product';
bio(173).sigName='';
bio(173).portIdx=0;
bio(173).dim=[1,1];
bio(173).sigWidth=1;
bio(173).sigAddress='&quadripulse_controller14_B.DotProduct_n';
bio(173).ndims=2;
bio(173).size=[];
bio(173).isStruct=false;

bio(174).blkName='Time Series Forecast/Forecast of 128 samples/Forecast/Unit Delay';
bio(174).sigName='';
bio(174).portIdx=0;
bio(174).dim=[1,1];
bio(174).sigWidth=1;
bio(174).sigAddress='&quadripulse_controller14_B.UnitDelay';
bio(174).ndims=2;
bio(174).size=[];
bio(174).isStruct=false;

bio(175).blkName='Time Series Forecast/Forecast of 128 samples/Forecast/Unit Delay1';
bio(175).sigName='';
bio(175).portIdx=0;
bio(175).dim=[1,1];
bio(175).sigWidth=1;
bio(175).sigAddress='&quadripulse_controller14_B.UnitDelay1';
bio(175).ndims=2;
bio(175).size=[];
bio(175).isStruct=false;

bio(176).blkName='Trigger Condition/Crossing Detector/Difference/Diff';
bio(176).sigName='';
bio(176).portIdx=0;
bio(176).dim=[1,1];
bio(176).sigWidth=1;
bio(176).sigAddress='&quadripulse_controller14_B.Diff';
bio(176).ndims=2;
bio(176).size=[];
bio(176).isStruct=false;

bio(177).blkName='Trigger Condition/Crossing Detector/Difference/UD';
bio(177).sigName='U(k-1)';
bio(177).portIdx=0;
bio(177).dim=[1,1];
bio(177).sigWidth=1;
bio(177).sigAddress='&quadripulse_controller14_B.Uk1';
bio(177).ndims=2;
bio(177).size=[];
bio(177).isStruct=false;

bio(178).blkName='Trigger Generator/Counter Free-Running/Increment Real World/FixPt Sum1';
bio(178).sigName='';
bio(178).portIdx=0;
bio(178).dim=[1,1];
bio(178).sigWidth=1;
bio(178).sigAddress='&quadripulse_controller14_B.FixPtSum1';
bio(178).ndims=2;
bio(178).size=[];
bio(178).isStruct=false;

bio(179).blkName='Trigger Generator/Counter Free-Running/Wrap To Zero/FixPt Switch';
bio(179).sigName='';
bio(179).portIdx=0;
bio(179).dim=[1,1];
bio(179).sigWidth=1;
bio(179).sigAddress='&quadripulse_controller14_B.FixPtSwitch';
bio(179).ndims=2;
bio(179).size=[];
bio(179).isStruct=false;

function len = getlenBIO
len = 179;

