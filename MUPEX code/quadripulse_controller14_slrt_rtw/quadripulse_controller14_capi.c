/*
 * quadripulse_controller14_capi.c
 *
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * Code generation for model "quadripulse_controller14".
 *
 * Model version              : 1.175
 * Simulink Coder version : 8.10 (R2016a) 10-Feb-2016
 * C source code generated on : Thu Oct 05 19:37:43 2017
 *
 * Target selection: slrt.tlc
 * Note: GRT includes extra infrastructure and instrumentation for prototyping
 * Embedded hardware selection: Generic->32-bit x86 compatible
 * Code generation objectives: Unspecified
 * Validation result: Not run
 */

#include "rtw_capi.h"
#ifdef HOST_CAPI_BUILD
#include "quadripulse_controller14_capi_host.h"
#define sizeof(s)                      ((size_t)(0xFFFF))
#undef rt_offsetof
#define rt_offsetof(s,el)              ((uint16_T)(0xFFFF))
#define TARGET_CONST
#define TARGET_STRING(s)               (s)
#else                                  /* HOST_CAPI_BUILD */
#include "builtin_typeid_types.h"
#include "quadripulse_controller14.h"
#include "quadripulse_controller14_capi.h"
#include "quadripulse_controller14_private.h"
#ifdef LIGHT_WEIGHT_CAPI
#define TARGET_CONST
#define TARGET_STRING(s)               (NULL)
#else
#define TARGET_CONST                   const
#define TARGET_STRING(s)               (s)
#endif
#endif                                 /* HOST_CAPI_BUILD */

/* Block output signal information */
static const rtwCAPI_Signals rtBlockSignals[] = {
  /* addrMapIndex, sysNum, blockPath,
   * signalName, portNumber, dataTypeIndex, dimIndex, fxpIndex, sTimeIndex
   */
  { 0, 0, TARGET_STRING("Vector Concatenate"),
    TARGET_STRING(""), 0, 0, 0, 0, 0 },

  { 1, 0, TARGET_STRING("Data Type Conversion"),
    TARGET_STRING(""), 0, 0, 1, 0, 0 },

  { 2, 0, TARGET_STRING("Data Type Conversion1"),
    TARGET_STRING(""), 0, 0, 1, 0, 0 },

  { 3, 0, TARGET_STRING("Data Type Conversion2"),
    TARGET_STRING(""), 0, 0, 1, 0, 0 },

  { 4, 0, TARGET_STRING("Data Type Conversion3"),
    TARGET_STRING(""), 0, 0, 1, 0, 0 },

  { 5, 1, TARGET_STRING("Data Type Conversion4"),
    TARGET_STRING(""), 0, 1, 1, 0, 0 },

  { 6, 0, TARGET_STRING("Data Type Conversion5"),
    TARGET_STRING(""), 0, 0, 1, 0, 0 },

  { 7, 0, TARGET_STRING("AC Mode Scaling Factor"),
    TARGET_STRING(""), 0, 0, 2, 0, 0 },

  { 8, 0, TARGET_STRING("Hit  Crossing"),
    TARGET_STRING(""), 0, 2, 1, 0, 0 },

  { 9, 0, TARGET_STRING("Product"),
    TARGET_STRING(""), 0, 0, 1, 0, 0 },

  { 10, 0, TARGET_STRING("Rate Transition1"),
    TARGET_STRING(""), 0, 0, 1, 0, 0 },

  { 11, 0, TARGET_STRING("Rate Transition2"),
    TARGET_STRING(""), 0, 0, 1, 0, 1 },

  { 12, 0, TARGET_STRING("Rate Transition3"),
    TARGET_STRING(""), 0, 0, 3, 0, 0 },

  { 13, 0, TARGET_STRING("Reshape1"),
    TARGET_STRING(""), 0, 0, 2, 0, 0 },

  { 14, 0, TARGET_STRING("Row"),
    TARGET_STRING(""), 0, 0, 4, 0, 0 },

  { 15, 0, TARGET_STRING("Row1"),
    TARGET_STRING(""), 0, 0, 5, 0, 0 },

  { 16, 0, TARGET_STRING("Derepeat"),
    TARGET_STRING(""), 0, 0, 2, 0, 2 },

  { 17, 0, TARGET_STRING("Now"),
    TARGET_STRING(""), 0, 0, 1, 0, 0 },

  { 18, 0, TARGET_STRING("Remove Edges (first & last 64)"),
    TARGET_STRING(""), 0, 0, 6, 0, 0 },

  { 19, 0, TARGET_STRING("Single Row"),
    TARGET_STRING(""), 0, 0, 7, 0, 0 },

  { 20, 0, TARGET_STRING("Switch"),
    TARGET_STRING(""), 0, 2, 1, 0, 0 },

  { 21, 0, TARGET_STRING("Switch1"),
    TARGET_STRING(""), 0, 1, 1, 0, 0 },

  { 22, 0, TARGET_STRING("Manual Switch"),
    TARGET_STRING(""), 0, 0, 3, 0, 0 },

  { 23, 0, TARGET_STRING("Buffer"),
    TARGET_STRING(""), 0, 0, 8, 0, 0 },

  { 24, 0, TARGET_STRING("Delay1"),
    TARGET_STRING(""), 0, 0, 1, 0, 0 },

  { 25, 0, TARGET_STRING("Delay2"),
    TARGET_STRING(""), 0, 0, 1, 0, 0 },

  { 26, 5, TARGET_STRING("Highpass Filter"),
    TARGET_STRING(""), 0, 0, 7, 0, 0 },

  { 27, 0, TARGET_STRING("Unit Delay"),
    TARGET_STRING(""), 0, 2, 1, 0, 0 },

  { 28, 0, TARGET_STRING("Average Refernce/Mean"),
    TARGET_STRING(""), 0, 0, 1, 0, 0 },

  { 29, 0, TARGET_STRING("Average Refernce/Subtract"),
    TARGET_STRING(""), 0, 0, 5, 0, 0 },

  { 30, 0, TARGET_STRING("Compare To Constant/Compare"),
    TARGET_STRING(""), 0, 2, 1, 0, 0 },

  { 31, 0, TARGET_STRING("Compare To Constant1/Compare"),
    TARGET_STRING(""), 0, 2, 1, 0, 0 },

  { 32, 0, TARGET_STRING("Compare To Constant2/Compare"),
    TARGET_STRING(""), 0, 2, 1, 0, 0 },

  { 33, 0, TARGET_STRING("Compare To Constant3/Compare"),
    TARGET_STRING(""), 0, 2, 1, 0, 0 },

  { 34, 0, TARGET_STRING("Compare To Zero/Compare"),
    TARGET_STRING(""), 0, 2, 1, 0, 0 },

  { 35, 0, TARGET_STRING("De-Mean/Mean"),
    TARGET_STRING(""), 0, 0, 1, 0, 0 },

  { 36, 0, TARGET_STRING("De-Mean/Subtract"),
    TARGET_STRING(""), 0, 0, 8, 0, 0 },

  { 37, 0, TARGET_STRING("Detrend and FFT/Matrix Concatenation"),
    TARGET_STRING(""), 0, 0, 9, 0, 1 },

  { 38, 0, TARGET_STRING("Detrend and FFT/scale to per Hz"),
    TARGET_STRING(""), 0, 0, 10, 0, 3 },

  { 39, 0, TARGET_STRING("Detrend and FFT/Divide"),
    TARGET_STRING(""), 0, 0, 10, 0, 3 },

  { 40, 0, TARGET_STRING("Detrend and FFT/Rate Transition2"),
    TARGET_STRING(""), 0, 0, 8, 0, 3 },

  { 41, 0, TARGET_STRING("Detrend and FFT/Rate Transition3"),
    TARGET_STRING(""), 0, 0, 10, 0, 1 },

  { 42, 0, TARGET_STRING("Detrend and FFT/Selector"),
    TARGET_STRING(""), 0, 0, 11, 0, 3 },

  { 43, 0, TARGET_STRING("Detrend and FFT/Bins 2..51"),
    TARGET_STRING(""), 0, 0, 12, 0, 1 },

  { 44, 0, TARGET_STRING("Detrend and FFT/Data"),
    TARGET_STRING(""), 0, 0, 1, 0, 0 },

  { 45, 0, TARGET_STRING("Detrend and FFT/Mean"),
    TARGET_STRING(""), 0, 0, 1, 0, 3 },

  { 46, 0, TARGET_STRING("Detrend and FFT/Pad"),
    TARGET_STRING(""), 0, 0, 10, 0, 3 },

  { 47, 0, TARGET_STRING("Detrend and FFT/Trigger Signal"),
    TARGET_STRING(""), 0, 0, 1, 0, 0 },

  { 48, 0, TARGET_STRING("Detrend and FFT/Window Function/p1"),
    TARGET_STRING(""), 0, 0, 8, 0, 3 },

  { 49, 0, TARGET_STRING("Detrend and FFT/Window Function/p2"),
    TARGET_STRING(""), 1, 0, 8, 0, 3 },

  { 50, 0, TARGET_STRING("Detrend and FFT/Sum of Elements"),
    TARGET_STRING(""), 0, 0, 1, 0, 3 },

  { 51, 0, TARGET_STRING("Detrend and FFT/Unbuffer"),
    TARGET_STRING(""), 0, 0, 7, 0, 0 },

  { 52, 0, TARGET_STRING(
    "Fan Out with Offset for Scope Display /Rate Transition"),
    TARGET_STRING(""), 0, 0, 13, 0, 0 },

  { 53, 0, TARGET_STRING("Fan Out with Offset for Scope Display /Constant Ramp"),
    TARGET_STRING(""), 0, 0, 14, 0, 4 },

  { 54, 0, TARGET_STRING("Fan Out with Offset for Scope Display /Add"),
    TARGET_STRING(""), 0, 0, 13, 0, 0 },

  { 55, 0, TARGET_STRING(
    "Fan Out with Offset for Scope Display /Zero-Order Hold"),
    TARGET_STRING(""), 0, 0, 13, 0, 5 },

  { 56, 0, TARGET_STRING("Forward and Backward Band Pass Filter/Flip"),
    TARGET_STRING(""), 0, 0, 8, 0, 0 },

  { 57, 0, TARGET_STRING("Forward and Backward Band Pass Filter/Re-Flip"),
    TARGET_STRING(""), 0, 0, 8, 0, 0 },

  { 58, 0, TARGET_STRING(
    "Forward and Backward Band Pass Filter/FIR Bandpass Filter Backward"),
    TARGET_STRING(""), 0, 0, 8, 0, 0 },

  { 59, 0, TARGET_STRING(
    "Forward and Backward Band Pass Filter/FIR Bandpass Filter Forward"),
    TARGET_STRING(""), 0, 0, 8, 0, 0 },

  { 60, 0, TARGET_STRING("S-R Flip-Flop/Logic"),
    TARGET_STRING(""), 0, 2, 3, 0, 0 },

  { 61, 0, TARGET_STRING("S-R Flip-Flop/Memory"),
    TARGET_STRING(""), 0, 2, 1, 0, 0 },

  { 62, 0, TARGET_STRING("Safety Check/MinMax"),
    TARGET_STRING(""), 0, 0, 1, 0, 0 },

  { 63, 0, TARGET_STRING("Safety Check/Times 1..end-1"),
    TARGET_STRING(""), 0, 0, 1, 0, 0 },

  { 64, 0, TARGET_STRING("Safety Check/Times 2..end"),
    TARGET_STRING(""), 0, 0, 1, 0, 0 },

  { 65, 0, TARGET_STRING("Safety Check/Subtract"),
    TARGET_STRING(""), 0, 0, 1, 0, 0 },

  { 66, 0, TARGET_STRING("Subsystem/Probe"),
    TARGET_STRING(""), 0, 0, 3, 0, 1 },

  { 67, 0, TARGET_STRING("Subsystem/Multiply"),
    TARGET_STRING(""), 0, 0, 3, 0, 1 },

  { 68, 0, TARGET_STRING("Subsystem/Rate Transition"),
    TARGET_STRING(""), 0, 2, 1, 0, 1 },

  { 69, 0, TARGET_STRING("Subsystem/Reshape1"),
    TARGET_STRING(""), 0, 0, 3, 0, 1 },

  { 70, 0, TARGET_STRING("Subsystem/Rounding Function"),
    TARGET_STRING(""), 0, 0, 3, 0, 1 },

  { 71, 0, TARGET_STRING("Subsystem/Selector"),
    TARGET_STRING(""), 0, 0, 15, 0, 1 },

  { 72, 0, TARGET_STRING("Subsystem/Sort"),
    TARGET_STRING(""), 0, 0, 16, 0, 1 },

  { 73, 0, TARGET_STRING("Subsystem/Subtract"),
    TARGET_STRING(""), 0, 0, 1, 0, 1 },

  { 74, 3, TARGET_STRING("Trigger Condition/Trigger Condition Met"),
    TARGET_STRING(""), 0, 2, 1, 0, 0 },

  { 75, 3, TARGET_STRING("Trigger Condition/Within Range"),
    TARGET_STRING(""), 0, 2, 1, 0, 0 },

  { 76, 3, TARGET_STRING("Trigger Condition/Index Vector"),
    TARGET_STRING(""), 0, 2, 1, 0, 0 },

  { 77, 3, TARGET_STRING("Trigger Condition/<= max"),
    TARGET_STRING(""), 0, 2, 1, 0, 0 },

  { 78, 3, TARGET_STRING("Trigger Condition/>= min"),
    TARGET_STRING(""), 0, 2, 1, 0, 0 },

  { 79, 15, TARGET_STRING("Trigger Generator/Data Type Conversion1"),
    TARGET_STRING(""), 0, 0, 1, 0, 0 },

  { 80, 15, TARGET_STRING("Trigger Generator/Data Type Conversion4"),
    TARGET_STRING(""), 0, 0, 1, 0, 0 },

  { 81, 15, TARGET_STRING("Trigger Generator/Gain"),
    TARGET_STRING(""), 0, 0, 1, 0, 0 },

  { 82, 15, TARGET_STRING("Trigger Generator/Logical Operator"),
    TARGET_STRING(""), 0, 2, 1, 0, 0 },

  { 83, 14, TARGET_STRING("Trigger Generator/Channel Index"),
    TARGET_STRING(""), 0, 0, 1, 0, 0 },

  { 84, 15, TARGET_STRING("Trigger Generator/Time Index"),
    TARGET_STRING(""), 0, 0, 1, 0, 0 },

  { 85, 15, TARGET_STRING("Trigger Generator/Bounds check"),
    TARGET_STRING(""), 0, 2, 1, 0, 0 },

  { 86, 15, TARGET_STRING("Trigger Generator/Relational Operator"),
    TARGET_STRING(""), 0, 2, 1, 0, 0 },

  { 87, 14, TARGET_STRING("Trigger Generator/Channel Data"),
    TARGET_STRING(""), 0, 0, 15, 0, 0 },

  { 88, 15, TARGET_STRING("Trigger Generator/Time Data"),
    TARGET_STRING(""), 0, 0, 15, 0, 0 },

  { 89, 15, TARGET_STRING("Trigger Generator/Sum"),
    TARGET_STRING(""), 0, 0, 1, 0, 0 },

  { 90, 15, TARGET_STRING("Trigger Generator/Saturate"),
    TARGET_STRING(""), 0, 0, 1, 0, 0 },

  { 91, 15, TARGET_STRING("Trigger Generator/Switch"),
    TARGET_STRING(""), 0, 0, 1, 0, 0 },

  { 92, 15, TARGET_STRING("Trigger Generator/Width"),
    TARGET_STRING(""), 0, 0, 1, 0, 4 },

  { 93, 15, TARGET_STRING("Trigger Generator/Counter Delay"),
    TARGET_STRING(""), 0, 0, 1, 0, 0 },

  { 94, 0, TARGET_STRING("UDP EEG Data/Matrix Concatenate"),
    TARGET_STRING(""), 0, 1, 17, 0, 0 },

  { 95, 0, TARGET_STRING("UDP EEG Data/Data Type Conversion"),
    TARGET_STRING(""), 0, 0, 18, 0, 0 },

  { 96, 0, TARGET_STRING("UDP EEG Data/Flip"),
    TARGET_STRING(""), 0, 1, 19, 0, 0 },

  { 97, 0, TARGET_STRING("UDP EEG Data/Gain"),
    TARGET_STRING(""), 0, 0, 18, 0, 0 },

  { 98, 0, TARGET_STRING("UDP EEG Data/Math Function"),
    TARGET_STRING(""), 0, 0, 20, 0, 0 },

  { 99, 0, TARGET_STRING("UDP EEG Data/Reshape"),
    TARGET_STRING(""), 0, 1, 19, 0, 0 },

  { 100, 0, TARGET_STRING("UDP EEG Data/Reshape2"),
    TARGET_STRING(""), 0, 0, 21, 0, 0 },

  { 101, 0, TARGET_STRING("UDP EEG Data/Byte Unpacking "),
    TARGET_STRING(""), 0, 3, 18, 0, 0 },

  { 102, 0, TARGET_STRING("Detrend and FFT/Constant5/Constant"),
    TARGET_STRING(""), 0, 0, 12, 0, 1 },

  { 103, 0, TARGET_STRING("Detrend and FFT/Detrend/Merge"),
    TARGET_STRING("a"), 0, 0, 1, 0, 3 },

  { 104, 0, TARGET_STRING("Detrend and FFT/Detrend/Merge1"),
    TARGET_STRING("b"), 0, 0, 1, 0, 3 },

  { 105, 0, TARGET_STRING("Detrend and FFT/Detrend/linear term1"),
    TARGET_STRING(""), 0, 0, 22, 0, 3 },

  { 106, 0, TARGET_STRING("Detrend and FFT/Detrend/linear term2"),
    TARGET_STRING(""), 0, 0, 1, 0, 3 },

  { 107, 0, TARGET_STRING("Detrend and FFT/Detrend/linear term3"),
    TARGET_STRING(""), 0, 0, 1, 0, 3 },

  { 108, 0, TARGET_STRING("Detrend and FFT/Detrend/Reshape"),
    TARGET_STRING(""), 0, 0, 8, 0, 3 },

  { 109, 0, TARGET_STRING("Detrend and FFT/Detrend/Constant Ramp"),
    TARGET_STRING("ramp"), 0, 0, 22, 0, 4 },

  { 110, 0, TARGET_STRING("Detrend and FFT/Detrend/Maximum"),
    TARGET_STRING(""), 0, 0, 1, 0, 3 },

  { 111, 0, TARGET_STRING("Detrend and FFT/Detrend/Matrix Sum1"),
    TARGET_STRING(""), 0, 0, 1, 0, 3 },

  { 112, 0, TARGET_STRING("Detrend and FFT/Detrend/Matrix Sum2"),
    TARGET_STRING(""), 0, 0, 1, 0, 3 },

  { 113, 0, TARGET_STRING("Detrend and FFT/Detrend/Sum1"),
    TARGET_STRING(""), 0, 0, 1, 0, 3 },

  { 114, 0, TARGET_STRING("Detrend and FFT/Detrend/Sum4"),
    TARGET_STRING(""), 0, 0, 8, 0, 3 },

  { 115, 0, TARGET_STRING("Detrend and FFT/Detrend/Sum5"),
    TARGET_STRING(""), 0, 0, 22, 0, 3 },

  { 116, 0, TARGET_STRING("Detrend and FFT/Detrend/Dot Product"),
    TARGET_STRING(""), 0, 0, 1, 0, 3 },

  { 117, 0, TARGET_STRING("Detrend and FFT/Detrend/Dot Product2"),
    TARGET_STRING(""), 0, 0, 1, 0, 3 },

  { 118, 0, TARGET_STRING("Detrend and FFT/Magnitude FFT/Magnitude Squared"),
    TARGET_STRING(""), 0, 0, 10, 0, 3 },

  { 119, 0, TARGET_STRING("Detrend and FFT/Magnitude FFT/FFT"),
    TARGET_STRING(""), 0, 4, 10, 0, 3 },

  { 120, 0, TARGET_STRING(
    "Fan Out with Offset for Scope Display /Running Average/Gain"),
    TARGET_STRING(""), 0, 0, 13, 0, 0 },

  { 121, 0, TARGET_STRING(
    "Fan Out with Offset for Scope Display /Running Average/Add"),
    TARGET_STRING(""), 0, 0, 13, 0, 0 },

  { 122, 0, TARGET_STRING(
    "Fan Out with Offset for Scope Display /Running Average/Delay"),
    TARGET_STRING(""), 0, 0, 13, 0, 0 },

  { 123, 0, TARGET_STRING(
    "Fan Out with Offset for Scope Display /Running Average/Delay1"),
    TARGET_STRING(""), 0, 0, 13, 0, 0 },

  { 124, 0, TARGET_STRING("Safety Check/4-into-1 Unit Limit/Compare"),
    TARGET_STRING(""), 0, 2, 1, 0, 0 },

  { 125, 8, TARGET_STRING("Subsystem/Enabled Subsystem/Buffer"),
    TARGET_STRING(""), 0, 0, 16, 0, 1 },

  { 126, 10, TARGET_STRING("Subsystem/Prolonged Disable/Data Type Conversion"),
    TARGET_STRING(""), 0, 3, 1, 0, 0 },

  { 127, 10, TARGET_STRING("Subsystem/Prolonged Disable/Seconds"),
    TARGET_STRING(""), 0, 5, 1, 1, 0 },

  { 128, 9, TARGET_STRING("Subsystem/Prolonged Disable/Sum"),
    TARGET_STRING(""), 0, 3, 1, 0, 0 },

  { 129, 0, TARGET_STRING("Subsystem/Prolonged Disable/Keep Postive Switch"),
    TARGET_STRING(""), 0, 3, 1, 0, 0 },

  { 130, 0, TARGET_STRING("Subsystem/Prolonged Disable/Set Counter Switch"),
    TARGET_STRING(""), 0, 3, 1, 0, 0 },

  { 131, 0, TARGET_STRING("Subsystem/Prolonged Disable/Unit Delay"),
    TARGET_STRING(""), 0, 3, 1, 0, 0 },

  { 132, 10, TARGET_STRING("Subsystem/Prolonged Disable/Weighted Sample Time"),
    TARGET_STRING(""), 0, 6, 1, 2, 0 },

  { 133, 0, TARGET_STRING(
    "Time Series Forecast/Yule-Walker AR Estimator/Autocorrelation"),
    TARGET_STRING(""), 0, 0, 23, 0, 0 },

  { 134, 0, TARGET_STRING(
    "Time Series Forecast/Yule-Walker AR Estimator/Levinson-Durbin/p1"),
    TARGET_STRING(""), 0, 0, 24, 0, 0 },

  { 135, 0, TARGET_STRING(
    "Time Series Forecast/Yule-Walker AR Estimator/Levinson-Durbin/p2"),
    TARGET_STRING(""), 1, 0, 1, 0, 0 },

  { 136, 3, TARGET_STRING("Trigger Condition/Crossing Detector/Hit  Crossing"),
    TARGET_STRING(""), 0, 2, 1, 0, 0 },

  { 137, 3, TARGET_STRING("Trigger Condition/Crossing Detector/Hit  Crossing1"),
    TARGET_STRING(""), 0, 2, 1, 0, 0 },

  { 138, 3, TARGET_STRING("Trigger Condition/Crossing Detector/Hit  Crossing2"),
    TARGET_STRING(""), 0, 2, 1, 0, 0 },

  { 139, 3, TARGET_STRING("Trigger Condition/Crossing Detector/Hit  Crossing3"),
    TARGET_STRING(""), 0, 2, 1, 0, 0 },

  { 140, 15, TARGET_STRING("Trigger Generator/Counter Free-Running/Output"),
    TARGET_STRING(""), 0, 5, 1, 0, 0 },

  { 141, 0, TARGET_STRING("UDP EEG Data/Receive 1/Buffer 1"),
    TARGET_STRING(""), 0, 5, 1, 0, 0 },

  { 142, 0, TARGET_STRING("UDP EEG Data/Receive 1/Extract 1/p1"),
    TARGET_STRING(""), 0, 1, 25, 0, 0 },

  { 143, 0, TARGET_STRING("UDP EEG Data/Receive 1/Extract 1/p2"),
    TARGET_STRING(""), 1, 0, 1, 0, 0 },

  { 144, 0, TARGET_STRING("UDP EEG Data/Receive 1/UDP Consume 1/p1"),
    TARGET_STRING(""), 0, 5, 1, 0, 0 },

  { 145, 0, TARGET_STRING("UDP EEG Data/Receive 1/UDP Consume 1/p2"),
    TARGET_STRING(""), 1, 5, 1, 0, 0 },

  { 146, 0, TARGET_STRING("UDP EEG Data/Receive 1/UDP Rx 1"),
    TARGET_STRING(""), 0, 5, 1, 0, 0 },

  { 147, 6, TARGET_STRING(
    "Detrend and FFT/Detrend/If Action Subsystem/linear term1"),
    TARGET_STRING(""), 0, 0, 1, 0, 3 },

  { 148, 6, TARGET_STRING(
    "Detrend and FFT/Detrend/If Action Subsystem/linear term2"),
    TARGET_STRING(""), 0, 0, 1, 0, 3 },

  { 149, 6, TARGET_STRING(
    "Detrend and FFT/Detrend/If Action Subsystem/linear term3"),
    TARGET_STRING(""), 0, 0, 1, 0, 3 },

  { 150, 6, TARGET_STRING(
    "Detrend and FFT/Detrend/If Action Subsystem/linear term4"),
    TARGET_STRING(""), 0, 0, 1, 0, 3 },

  { 151, 0, TARGET_STRING(
    "Detrend and FFT/Detrend/If Action Subsystem/linear term5"),
    TARGET_STRING(""), 0, 0, 1, 0, 3 },

  { 152, 0, TARGET_STRING(
    "Detrend and FFT/Detrend/If Action Subsystem/linear term6"),
    TARGET_STRING(""), 0, 0, 1, 0, 3 },

  { 153, 6, TARGET_STRING("Detrend and FFT/Detrend/If Action Subsystem/Sum1"),
    TARGET_STRING(""), 0, 0, 1, 0, 3 },

  { 154, 6, TARGET_STRING("Detrend and FFT/Detrend/If Action Subsystem/Sum4"),
    TARGET_STRING(""), 0, 0, 1, 0, 3 },

  { 155, 7, TARGET_STRING(
    "Detrend and FFT/Detrend/If Action Subsystem1/Inherit Complexity"),
    TARGET_STRING(""), 0, 0, 1, 0, 3 },

  { 156, 7, TARGET_STRING(
    "Detrend and FFT/Detrend/If Action Subsystem1/Multiport Selector"),
    TARGET_STRING(""), 0, 0, 1, 0, 3 },

  { 157, 0, TARGET_STRING("Detrend and FFT/Detrend/Inherit Frame Status/Inherit"),
    TARGET_STRING(""), 0, 0, 8, 0, 3 },

  { 158, 0, TARGET_STRING("Subsystem/Prolonged Disable/Compare To Zero/Compare"),
    TARGET_STRING(""), 0, 2, 1, 0, 0 },

  { 159, 12, TARGET_STRING(
    "Time Series Forecast/Forecast of 128 samples/Forecast/Assignment"),
    TARGET_STRING(""), 0, 0, 26, 0, 6 },

  { 160, 12, TARGET_STRING(
    "Time Series Forecast/Forecast of 128 samples/Forecast/Flip"),
    TARGET_STRING(""), 0, 0, 27, 0, 6 },

  { 161, 12, TARGET_STRING(
    "Time Series Forecast/Forecast of 128 samples/Forecast/For Iterator"),
    TARGET_STRING(""), 0, 3, 1, 0, 6 },

  { 162, 12, TARGET_STRING(
    "Time Series Forecast/Forecast of 128 samples/Forecast/Frame Length"),
    TARGET_STRING(""), 0, 0, 1, 0, 6 },

  { 163, 12, TARGET_STRING(
    "Time Series Forecast/Forecast of 128 samples/Forecast/Number of Coefficients"),
    TARGET_STRING(""), 0, 0, 1, 0, 6 },

  { 164, 12, TARGET_STRING(
    "Time Series Forecast/Forecast of 128 samples/Forecast/Saturation"),
    TARGET_STRING(""), 0, 3, 1, 0, 6 },

  { 165, 12, TARGET_STRING(
    "Time Series Forecast/Forecast of 128 samples/Forecast/Constant Ramp"),
    TARGET_STRING(""), 0, 0, 28, 0, 4 },

  { 166, 12, TARGET_STRING(
    "Time Series Forecast/Forecast of 128 samples/Forecast/First Element"),
    TARGET_STRING(""), 0, 0, 1, 0, 6 },

  { 167, 12, TARGET_STRING(
    "Time Series Forecast/Forecast of 128 samples/Forecast/Second to Last"),
    TARGET_STRING(""), 0, 0, 27, 0, 6 },

  { 168, 12, TARGET_STRING(
    "Time Series Forecast/Forecast of 128 samples/Forecast/Variable Selector"),
    TARGET_STRING(""), 0, 0, 27, 0, 6 },

  { 169, 12, TARGET_STRING(
    "Time Series Forecast/Forecast of 128 samples/Forecast/Add"),
    TARGET_STRING(""), 0, 0, 1, 0, 6 },

  { 170, 12, TARGET_STRING(
    "Time Series Forecast/Forecast of 128 samples/Forecast/Sum"),
    TARGET_STRING(""), 0, 0, 1, 0, 6 },

  { 171, 12, TARGET_STRING(
    "Time Series Forecast/Forecast of 128 samples/Forecast/Sum1"),
    TARGET_STRING(""), 0, 0, 28, 0, 6 },

  { 172, 12, TARGET_STRING(
    "Time Series Forecast/Forecast of 128 samples/Forecast/Dot Product"),
    TARGET_STRING(""), 0, 0, 1, 0, 6 },

  { 173, 12, TARGET_STRING(
    "Time Series Forecast/Forecast of 128 samples/Forecast/Unit Delay"),
    TARGET_STRING(""), 0, 0, 1, 0, 6 },

  { 174, 12, TARGET_STRING(
    "Time Series Forecast/Forecast of 128 samples/Forecast/Unit Delay1"),
    TARGET_STRING(""), 0, 3, 1, 0, 6 },

  { 175, 3, TARGET_STRING("Trigger Condition/Crossing Detector/Difference/Diff"),
    TARGET_STRING(""), 0, 0, 1, 0, 0 },

  { 176, 0, TARGET_STRING("Trigger Condition/Crossing Detector/Difference/UD"),
    TARGET_STRING("U(k-1)"), 0, 0, 1, 0, 0 },

  { 177, 15, TARGET_STRING(
    "Trigger Generator/Counter Free-Running/Increment Real World/FixPt Sum1"),
    TARGET_STRING(""), 0, 5, 1, 0, 0 },

  { 178, 15, TARGET_STRING(
    "Trigger Generator/Counter Free-Running/Wrap To Zero/FixPt Switch"),
    TARGET_STRING(""), 0, 5, 1, 0, 0 },

  {
    0, 0, (NULL), (NULL), 0, 0, 0, 0, 0
  }
};

static const rtwCAPI_BlockParameters rtBlockParameters[] = {
  /* addrMapIndex, blockPath,
   * paramName, dataTypeIndex, dimIndex, fixPtIdx
   */
  { 179, TARGET_STRING("Compare To Constant"),
    TARGET_STRING("const"), 0, 1, 0 },

  { 180, TARGET_STRING("Compare To Constant1"),
    TARGET_STRING("const"), 0, 1, 0 },

  { 181, TARGET_STRING("Compare To Constant2"),
    TARGET_STRING("const"), 0, 1, 0 },

  { 182, TARGET_STRING("Compare To Constant3"),
    TARGET_STRING("const"), 0, 1, 0 },

  { 183, TARGET_STRING("S-R Flip-Flop"),
    TARGET_STRING("initial_condition"), 2, 1, 0 },

  { 184, TARGET_STRING("Constant4"),
    TARGET_STRING("Value"), 2, 1, 0 },

  { 185, TARGET_STRING("Constant6"),
    TARGET_STRING("Value"), 2, 1, 0 },

  { 186, TARGET_STRING("AC Mode Scaling Factor"),
    TARGET_STRING("Gain"), 0, 1, 0 },

  { 187, TARGET_STRING("Hit  Crossing"),
    TARGET_STRING("HitCrossingOffset"), 0, 1, 0 },

  { 188, TARGET_STRING("PD2-MF 12bit series"),
    TARGET_STRING("P1"), 0, 29, 0 },

  { 189, TARGET_STRING("PD2-MF 12bit series"),
    TARGET_STRING("P2"), 0, 29, 0 },

  { 190, TARGET_STRING("PD2-MF 12bit series"),
    TARGET_STRING("P3"), 0, 29, 0 },

  { 191, TARGET_STRING("PD2-MF 12bit series"),
    TARGET_STRING("P4"), 0, 1, 0 },

  { 192, TARGET_STRING("PD2-MF 12bit series"),
    TARGET_STRING("P5"), 0, 1, 0 },

  { 193, TARGET_STRING("PD2-MF 12bit series"),
    TARGET_STRING("P6"), 0, 1, 0 },

  { 194, TARGET_STRING("PD2-MF 12bit series"),
    TARGET_STRING("P7"), 0, 1, 0 },

  { 195, TARGET_STRING("PD2-MF 12bit series"),
    TARGET_STRING("P8"), 0, 30, 0 },

  { 196, TARGET_STRING("Parallel Port DO "),
    TARGET_STRING("P1"), 0, 1, 0 },

  { 197, TARGET_STRING("Parallel Port DO "),
    TARGET_STRING("P2"), 0, 1, 0 },

  { 198, TARGET_STRING("Parallel Port DO "),
    TARGET_STRING("P3"), 0, 1, 0 },

  { 199, TARGET_STRING("Parallel Port DO "),
    TARGET_STRING("P4"), 0, 1, 0 },

  { 200, TARGET_STRING("Parallel Port DO "),
    TARGET_STRING("P5"), 0, 1, 0 },

  { 201, TARGET_STRING("Parallel Port DO "),
    TARGET_STRING("P6"), 0, 1, 0 },

  { 202, TARGET_STRING("Parallel Port DO "),
    TARGET_STRING("P7"), 0, 1, 0 },

  { 203, TARGET_STRING("Parallel Port DO "),
    TARGET_STRING("P8"), 0, 1, 0 },

  { 204, TARGET_STRING("Parallel Port DO "),
    TARGET_STRING("P9"), 0, 1, 0 },

  { 205, TARGET_STRING("Manual Switch"),
    TARGET_STRING("CurrentSetting"), 1, 1, 0 },

  { 206, TARGET_STRING("Buffer"),
    TARGET_STRING("ic"), 0, 1, 0 },

  { 207, TARGET_STRING("Delay1"),
    TARGET_STRING("DelayLength"), 5, 1, 0 },

  { 208, TARGET_STRING("Delay1"),
    TARGET_STRING("InitialCondition"), 0, 1, 0 },

  { 209, TARGET_STRING("Delay2"),
    TARGET_STRING("DelayLength"), 5, 1, 0 },

  { 210, TARGET_STRING("Delay2"),
    TARGET_STRING("InitialCondition"), 0, 1, 0 },

  { 211, TARGET_STRING("Unit Delay"),
    TARGET_STRING("InitialCondition"), 2, 1, 0 },

  { 212, TARGET_STRING("Average Refernce/Constant"),
    TARGET_STRING("Value"), 0, 1, 0 },

  { 213, TARGET_STRING("Compare To Zero/Constant"),
    TARGET_STRING("Value"), 0, 1, 0 },

  { 214, TARGET_STRING("Detrend and FFT/Constant5"),
    TARGET_STRING("Value"), 0, 12, 0 },

  { 215, TARGET_STRING("Detrend and FFT/scale to per Hz"),
    TARGET_STRING("Gain"), 0, 1, 0 },

  { 216, TARGET_STRING("Detrend and FFT/Pad"),
    TARGET_STRING("padVal"), 0, 1, 0 },

  { 217, TARGET_STRING("Detrend and FFT/Pad"),
    TARGET_STRING("outDims"), 3, 31, 0 },

  { 218, TARGET_STRING("Detrend and FFT/Pad"),
    TARGET_STRING("padBefore"), 3, 31, 0 },

  { 219, TARGET_STRING("Detrend and FFT/Pad"),
    TARGET_STRING("padAfter"), 3, 31, 0 },

  { 220, TARGET_STRING("Detrend and FFT/Pad"),
    TARGET_STRING("inWorkAdd"), 3, 31, 0 },

  { 221, TARGET_STRING("Detrend and FFT/Pad"),
    TARGET_STRING("outWorkAdd"), 3, 31, 0 },

  { 222, TARGET_STRING("Detrend and FFT/Unbuffer"),
    TARGET_STRING("ic"), 0, 1, 0 },

  { 223, TARGET_STRING("Fan Out with Offset for Scope Display /Running Average"),
    TARGET_STRING("N"), 0, 1, 0 },

  { 224, TARGET_STRING("Forward and Backward Band Pass Filter/FIR Bandpass Filter Backward"),
    TARGET_STRING("InitialStates"), 0, 1, 0 },

  { 225, TARGET_STRING("Forward and Backward Band Pass Filter/FIR Bandpass Filter Forward"),
    TARGET_STRING("InitialStates"), 0, 1, 0 },

  { 226, TARGET_STRING("Real-time UDP  Configuration/ARP Init "),
    TARGET_STRING("P1"), 0, 1, 0 },

  { 227, TARGET_STRING("Real-time UDP  Configuration/ARP Init "),
    TARGET_STRING("P2"), 0, 1, 0 },

  { 228, TARGET_STRING("Real-time UDP  Configuration/ARP Init "),
    TARGET_STRING("P3"), 0, 1, 0 },

  { 229, TARGET_STRING("Real-time UDP  Configuration/ARP Init "),
    TARGET_STRING("P4"), 0, 1, 0 },

  { 230, TARGET_STRING("Real-time UDP  Configuration/ARP Init "),
    TARGET_STRING("P5"), 0, 1, 0 },

  { 231, TARGET_STRING("Real-time UDP  Configuration/ARP Init "),
    TARGET_STRING("P6"), 0, 1, 0 },

  { 232, TARGET_STRING("Real-time UDP  Configuration/ARP Init "),
    TARGET_STRING("P7"), 0, 1, 0 },

  { 233, TARGET_STRING("Real-time UDP  Configuration/ARP Init "),
    TARGET_STRING("P8"), 0, 1, 0 },

  { 234, TARGET_STRING("Real-time UDP  Configuration/ARP Init "),
    TARGET_STRING("P9"), 0, 1, 0 },

  { 235, TARGET_STRING("Real-time UDP  Configuration/ARP Init "),
    TARGET_STRING("P10"), 0, 1, 0 },

  { 236, TARGET_STRING("Real-time UDP  Configuration/ARP Init "),
    TARGET_STRING("P11"), 0, 1, 0 },

  { 237, TARGET_STRING("Real-time UDP  Configuration/ARP Init "),
    TARGET_STRING("P16"), 0, 1, 0 },

  { 238, TARGET_STRING("Real-time UDP  Configuration/Buffer Mngmt "),
    TARGET_STRING("P1"), 0, 29, 0 },

  { 239, TARGET_STRING("Real-time UDP  Configuration/Buffer Mngmt "),
    TARGET_STRING("P2"), 0, 1, 0 },

  { 240, TARGET_STRING("Real-time UDP  Configuration/Buffer Mngmt "),
    TARGET_STRING("P3"), 0, 1, 0 },

  { 241, TARGET_STRING("Real-time UDP  Configuration/Ethernet Init "),
    TARGET_STRING("P1"), 0, 1, 0 },

  { 242, TARGET_STRING("Real-time UDP  Configuration/Ethernet Init "),
    TARGET_STRING("P2"), 0, 1, 0 },

  { 243, TARGET_STRING("Real-time UDP  Configuration/Ethernet Init "),
    TARGET_STRING("P3"), 0, 1, 0 },

  { 244, TARGET_STRING("Real-time UDP  Configuration/Ethernet Init "),
    TARGET_STRING("P4"), 0, 1, 0 },

  { 245, TARGET_STRING("Real-time UDP  Configuration/Ethernet Init "),
    TARGET_STRING("P5"), 0, 1, 0 },

  { 246, TARGET_STRING("Real-time UDP  Configuration/Ethernet Init "),
    TARGET_STRING("P6"), 0, 1, 0 },

  { 247, TARGET_STRING("Real-time UDP  Configuration/Ethernet Init "),
    TARGET_STRING("P7"), 0, 1, 0 },

  { 248, TARGET_STRING("Real-time UDP  Configuration/Ethernet Init "),
    TARGET_STRING("P8"), 0, 32, 0 },

  { 249, TARGET_STRING("Real-time UDP  Configuration/Ethernet Init "),
    TARGET_STRING("P9"), 0, 1, 0 },

  { 250, TARGET_STRING("Real-time UDP  Configuration/Ethernet Init "),
    TARGET_STRING("P10"), 0, 1, 0 },

  { 251, TARGET_STRING("Real-time UDP  Configuration/Ethernet Init "),
    TARGET_STRING("P11"), 0, 1, 0 },

  { 252, TARGET_STRING("Real-time UDP  Configuration/Ethernet Init "),
    TARGET_STRING("P12"), 0, 1, 0 },

  { 253, TARGET_STRING("Real-time UDP  Configuration/Ethernet Init "),
    TARGET_STRING("P13"), 0, 1, 0 },

  { 254, TARGET_STRING("Real-time UDP  Configuration/Ethernet Init "),
    TARGET_STRING("P14"), 0, 1, 0 },

  { 255, TARGET_STRING("Real-time UDP  Configuration/Ethernet Init "),
    TARGET_STRING("P15"), 0, 1, 0 },

  { 256, TARGET_STRING("Real-time UDP  Configuration/Ethernet Init "),
    TARGET_STRING("P16"), 0, 1, 0 },

  { 257, TARGET_STRING("Real-time UDP  Configuration/Ethernet Init "),
    TARGET_STRING("P17"), 0, 1, 0 },

  { 258, TARGET_STRING("Real-time UDP  Configuration/Ethernet Init "),
    TARGET_STRING("P18"), 0, 1, 0 },

  { 259, TARGET_STRING("Real-time UDP  Configuration/Ethernet Init "),
    TARGET_STRING("P20"), 0, 1, 0 },

  { 260, TARGET_STRING("Real-time UDP  Configuration/Ethernet Init "),
    TARGET_STRING("P21"), 0, 1, 0 },

  { 261, TARGET_STRING("Real-time UDP  Configuration/IP Init "),
    TARGET_STRING("P1"), 0, 1, 0 },

  { 262, TARGET_STRING("Real-time UDP  Configuration/IP Init "),
    TARGET_STRING("P2"), 0, 1, 0 },

  { 263, TARGET_STRING("Real-time UDP  Configuration/IP Init "),
    TARGET_STRING("P3"), 0, 1, 0 },

  { 264, TARGET_STRING("Real-time UDP  Configuration/IP Init "),
    TARGET_STRING("P4"), 0, 1, 0 },

  { 265, TARGET_STRING("Real-time UDP  Configuration/IP Init "),
    TARGET_STRING("P5"), 0, 1, 0 },

  { 266, TARGET_STRING("Real-time UDP  Configuration/IP Init "),
    TARGET_STRING("P6"), 0, 1, 0 },

  { 267, TARGET_STRING("Real-time UDP  Configuration/IP Init "),
    TARGET_STRING("P7"), 0, 1, 0 },

  { 268, TARGET_STRING("Real-time UDP  Configuration/IP Init "),
    TARGET_STRING("P8"), 0, 1, 0 },

  { 269, TARGET_STRING("Real-time UDP  Configuration/IP Init "),
    TARGET_STRING("P9"), 0, 1, 0 },

  { 270, TARGET_STRING("Real-time UDP  Configuration/IP Init "),
    TARGET_STRING("P10"), 0, 1, 0 },

  { 271, TARGET_STRING("Real-time UDP  Configuration/IP Init "),
    TARGET_STRING("P11"), 0, 1, 0 },

  { 272, TARGET_STRING("Real-time UDP  Configuration/IP Init "),
    TARGET_STRING("P12"), 0, 1, 0 },

  { 273, TARGET_STRING("Real-time UDP  Configuration/UDP Init "),
    TARGET_STRING("P1"), 0, 1, 0 },

  { 274, TARGET_STRING("Real-time UDP  Configuration/UDP Init "),
    TARGET_STRING("P2"), 0, 1, 0 },

  { 275, TARGET_STRING("Real-time UDP  Configuration/UDP Init "),
    TARGET_STRING("P3"), 0, 1, 0 },

  { 276, TARGET_STRING("Real-time UDP  Configuration/UDP Init "),
    TARGET_STRING("P4"), 0, 1, 0 },

  { 277, TARGET_STRING("Real-time UDP  Configuration/UDP Init "),
    TARGET_STRING("P5"), 0, 1, 0 },

  { 278, TARGET_STRING("S-R Flip-Flop/Logic"),
    TARGET_STRING("TruthTable"), 2, 33, 0 },

  { 279, TARGET_STRING("Safety Check/4-into-1 Unit Limit"),
    TARGET_STRING("const"), 0, 1, 0 },

  { 280, TARGET_STRING("Subsystem/Constant"),
    TARGET_STRING("Value"), 0, 1, 0 },

  { 281, TARGET_STRING("Time Series Forecast/Forecast of 128 samples"),
    TARGET_STRING("num_iterations"), 3, 1, 0 },

  { 282, TARGET_STRING("Trigger Condition/Constant"),
    TARGET_STRING("Value"), 2, 1, 0 },

  { 283, TARGET_STRING("Trigger Generator/Channel"),
    TARGET_STRING("InitialOutput"), 0, 1, 0 },

  { 284, TARGET_STRING("Trigger Generator/Zero"),
    TARGET_STRING("Value"), 0, 1, 0 },

  { 285, TARGET_STRING("Trigger Generator/Gain"),
    TARGET_STRING("Gain"), 0, 1, 0 },

  { 286, TARGET_STRING("Trigger Generator/Counter Delay"),
    TARGET_STRING("DelayLength"), 5, 1, 0 },

  { 287, TARGET_STRING("Trigger Generator/Counter Delay"),
    TARGET_STRING("InitialCondition"), 0, 1, 0 },

  { 288, TARGET_STRING("UDP EEG Data/Constant"),
    TARGET_STRING("Value"), 1, 34, 0 },

  { 289, TARGET_STRING("UDP EEG Data/Gain"),
    TARGET_STRING("Gain"), 0, 1, 0 },

  { 290, TARGET_STRING("Fan Out with Offset for Scope Display /Running Average/Delay"),
    TARGET_STRING("DelayLength"), 5, 1, 0 },

  { 291, TARGET_STRING("Fan Out with Offset for Scope Display /Running Average/Delay"),
    TARGET_STRING("InitialCondition"), 0, 1, 0 },

  { 292, TARGET_STRING("Fan Out with Offset for Scope Display /Running Average/Delay1"),
    TARGET_STRING("DelayLength"), 5, 1, 0 },

  { 293, TARGET_STRING("Fan Out with Offset for Scope Display /Running Average/Delay1"),
    TARGET_STRING("InitialCondition"), 0, 1, 0 },

  { 294, TARGET_STRING("Subsystem/Enabled Subsystem/Out1"),
    TARGET_STRING("InitialOutput"), 0, 1, 0 },

  { 295, TARGET_STRING("Subsystem/Enabled Subsystem/Buffer"),
    TARGET_STRING("ic"), 0, 1, 0 },

  { 296, TARGET_STRING("Subsystem/Prolonged Disable/One"),
    TARGET_STRING("Value"), 3, 1, 0 },

  { 297, TARGET_STRING("Subsystem/Prolonged Disable/Zero"),
    TARGET_STRING("Value"), 3, 1, 0 },

  { 298, TARGET_STRING("Subsystem/Prolonged Disable/Seconds"),
    TARGET_STRING("Gain"), 6, 1, 3 },

  { 299, TARGET_STRING("Subsystem/Prolonged Disable/Keep Postive Switch"),
    TARGET_STRING("Threshold"), 3, 1, 0 },

  { 300, TARGET_STRING("Subsystem/Prolonged Disable/Unit Delay"),
    TARGET_STRING("InitialCondition"), 3, 1, 0 },

  { 301, TARGET_STRING("Subsystem/Prolonged Disable/Weighted Sample Time"),
    TARGET_STRING("WtEt"), 6, 1, 2 },

  { 302, TARGET_STRING("Trigger Condition/Crossing Detector/Difference"),
    TARGET_STRING("ICPrevInput"), 0, 1, 0 },

  { 303, TARGET_STRING("Trigger Condition/Crossing Detector/Hit  Crossing"),
    TARGET_STRING("HitCrossingOffset"), 0, 1, 0 },

  { 304, TARGET_STRING("Trigger Condition/Crossing Detector/Hit  Crossing1"),
    TARGET_STRING("HitCrossingOffset"), 0, 1, 0 },

  { 305, TARGET_STRING("Trigger Condition/Crossing Detector/Hit  Crossing2"),
    TARGET_STRING("HitCrossingOffset"), 0, 1, 0 },

  { 306, TARGET_STRING("Trigger Condition/Crossing Detector/Hit  Crossing3"),
    TARGET_STRING("HitCrossingOffset"), 0, 1, 0 },

  { 307, TARGET_STRING("Trigger Generator/Counter Free-Running/Wrap To Zero"),
    TARGET_STRING("Threshold"), 5, 1, 0 },

  { 308, TARGET_STRING("Trigger Generator/Counter Free-Running/Output"),
    TARGET_STRING("InitialCondition"), 5, 1, 0 },

  { 309, TARGET_STRING("UDP EEG Data/Receive 1/Buffer 1"),
    TARGET_STRING("P1"), 0, 1, 0 },

  { 310, TARGET_STRING("UDP EEG Data/Receive 1/Buffer 1"),
    TARGET_STRING("P2"), 0, 1, 0 },

  { 311, TARGET_STRING("UDP EEG Data/Receive 1/Buffer 1"),
    TARGET_STRING("P3"), 0, 1, 0 },

  { 312, TARGET_STRING("UDP EEG Data/Receive 1/Extract 1"),
    TARGET_STRING("P1"), 0, 1, 0 },

  { 313, TARGET_STRING("UDP EEG Data/Receive 1/UDP Consume 1"),
    TARGET_STRING("P1"), 0, 1, 0 },

  { 314, TARGET_STRING("UDP EEG Data/Receive 1/UDP Consume 1"),
    TARGET_STRING("P2"), 0, 1, 0 },

  { 315, TARGET_STRING("UDP EEG Data/Receive 1/UDP Consume 1"),
    TARGET_STRING("P3"), 0, 1, 0 },

  { 316, TARGET_STRING("UDP EEG Data/Receive 1/UDP Rx 1"),
    TARGET_STRING("P1"), 0, 1, 0 },

  { 317, TARGET_STRING("UDP EEG Data/Receive 1/UDP Rx 1"),
    TARGET_STRING("P2"), 0, 1, 0 },

  { 318, TARGET_STRING("UDP EEG Data/Receive 1/UDP Rx 1"),
    TARGET_STRING("P3"), 0, 1, 0 },

  { 319, TARGET_STRING("UDP EEG Data/Receive 1/UDP Rx 1"),
    TARGET_STRING("P4"), 0, 1, 0 },

  { 320, TARGET_STRING("UDP EEG Data/Receive 1/UDP Rx 1"),
    TARGET_STRING("P5"), 0, 1, 0 },

  { 321, TARGET_STRING("UDP EEG Data/Receive 1/UDP Rx 1"),
    TARGET_STRING("P6"), 0, 1, 0 },

  { 322, TARGET_STRING("Subsystem/Prolonged Disable/Compare To Zero/Constant"),
    TARGET_STRING("Value"), 3, 1, 0 },

  { 323, TARGET_STRING("Time Series Forecast/Forecast of 128 samples/Forecast/Forecast"),
    TARGET_STRING("InitialOutput"), 0, 1, 0 },

  { 324, TARGET_STRING("Time Series Forecast/Forecast of 128 samples/Forecast/For Iterator"),
    TARGET_STRING("IterationLimit"), 3, 1, 0 },

  { 325, TARGET_STRING("Time Series Forecast/Forecast of 128 samples/Forecast/Saturation"),
    TARGET_STRING("LowerLimit"), 3, 1, 0 },

  { 326, TARGET_STRING("Time Series Forecast/Forecast of 128 samples/Forecast/Unit Delay"),
    TARGET_STRING("InitialCondition"), 0, 1, 0 },

  { 327, TARGET_STRING("Time Series Forecast/Forecast of 128 samples/Forecast/Unit Delay1"),
    TARGET_STRING("InitialCondition"), 3, 1, 0 },

  { 328, TARGET_STRING("Trigger Generator/Counter Free-Running/Increment Real World/FixPt Constant"),
    TARGET_STRING("Value"), 5, 1, 0 },

  { 329, TARGET_STRING("Trigger Generator/Counter Free-Running/Wrap To Zero/Constant"),
    TARGET_STRING("Value"), 5, 1, 0 },

  {
    0, (NULL), (NULL), 0, 0, 0
  }
};

/* Tunable variable parameters */
static const rtwCAPI_ModelParameters rtModelParameters[] = {
  /* addrMapIndex, varName, dataTypeIndex, dimIndex, fixPtIndex */
  { 330, TARGET_STRING("amplitudeinterval"), 0, 31, 0 },

  { 331, TARGET_STRING("amplitudeinterval_percentiles"), 0, 31, 0 },

  { 332, TARGET_STRING("fft_bin_indices_zero_based"), 0, 31, 0 },

  { 333, TARGET_STRING("fir_filter_coefficients"), 0, 35, 0 },

  { 334, TARGET_STRING("phasecondition"), 0, 1, 0 },

  { 335, TARGET_STRING("spatial_filter"), 0, 36, 0 },

  { 336, TARGET_STRING("timeinsecondsandtriggerchannel"), 0, 37, 0 },

  { 337, TARGET_STRING("marker_id"), 1, 1, 0 },

  { 338, TARGET_STRING("closedloopmode"), 2, 1, 0 },

  { 339, TARGET_STRING("reset"), 2, 1, 0 },

  { 0, (NULL), 0, 0, 0 }
};

#ifndef HOST_CAPI_BUILD

/* Declare Data Addresses statically */
static void* rtDataAddrMap[] = {
  &quadripulse_controller14_B.VectorConcatenate[0],/* 0: Signal */
  &quadripulse_controller14_B.DataTypeConversion_l,/* 1: Signal */
  &quadripulse_controller14_B.DataTypeConversion1,/* 2: Signal */
  &quadripulse_controller14_B.DataTypeConversion2,/* 3: Signal */
  &quadripulse_controller14_B.DataTypeConversion3,/* 4: Signal */
  &quadripulse_controller14_B.DataTypeConversion4_k,/* 5: Signal */
  &quadripulse_controller14_B.DataTypeConversion5,/* 6: Signal */
  &quadripulse_controller14_B.ACModeScalingFactor[0],/* 7: Signal */
  &quadripulse_controller14_B.HitCrossing,/* 8: Signal */
  &quadripulse_controller14_B.Product, /* 9: Signal */
  &quadripulse_controller14_B.RateTransition1,/* 10: Signal */
  &quadripulse_controller14_B.RateTransition2_n,/* 11: Signal */
  &quadripulse_controller14_B.RateTransition3[0],/* 12: Signal */
  &quadripulse_controller14_B.Reshape1[0],/* 13: Signal */
  &quadripulse_controller14_B.Row[0],  /* 14: Signal */
  &quadripulse_controller14_B.Row1[0], /* 15: Signal */
  &quadripulse_controller14_B.Derepeat[0],/* 16: Signal */
  &quadripulse_controller14_B.Now,     /* 17: Signal */
  &quadripulse_controller14_B.RemoveEdgesfirstlast64[0],/* 18: Signal */
  &quadripulse_controller14_B.SingleRow[0],/* 19: Signal */
  &quadripulse_controller14_B.Switch_g,/* 20: Signal */
  &quadripulse_controller14_B.Switch1, /* 21: Signal */
  &quadripulse_controller14_B.ManualSwitch[0],/* 22: Signal */
  &quadripulse_controller14_B.Buffer[0],/* 23: Signal */
  &quadripulse_controller14_B.Delay1,  /* 24: Signal */
  &quadripulse_controller14_B.Delay2,  /* 25: Signal */
  &quadripulse_controller14_B.HighpassFilter[0],/* 26: Signal */
  &quadripulse_controller14_B.UnitDelay_b,/* 27: Signal */
  &quadripulse_controller14_B.Mean,    /* 28: Signal */
  &quadripulse_controller14_B.Subtract[0],/* 29: Signal */
  &quadripulse_controller14_B.Compare_l,/* 30: Signal */
  &quadripulse_controller14_B.Compare_h,/* 31: Signal */
  &quadripulse_controller14_B.Compare_ln,/* 32: Signal */
  &quadripulse_controller14_B.Compare_n,/* 33: Signal */
  &quadripulse_controller14_B.Compare_d,/* 34: Signal */
  &quadripulse_controller14_B.Mean_d,  /* 35: Signal */
  &quadripulse_controller14_B.Subtract_i[0],/* 36: Signal */
  &quadripulse_controller14_B.MatrixConcatenation[0],/* 37: Signal */
  &quadripulse_controller14_B.scaletoperHz[0],/* 38: Signal */
  &quadripulse_controller14_B.Divide[0],/* 39: Signal */
  &quadripulse_controller14_B.RateTransition2[0],/* 40: Signal */
  &quadripulse_controller14_B.RateTransition3_e[0],/* 41: Signal */
  &quadripulse_controller14_B.Selector[0],/* 42: Signal */
  (( &quadripulse_controller14_B.MatrixConcatenation[0]) + 100),/* 43: Signal */
  &quadripulse_controller14_B.Data,    /* 44: Signal */
  &quadripulse_controller14_B.Mean_l,  /* 45: Signal */
  &quadripulse_controller14_B.Pad[0],  /* 46: Signal */
  &quadripulse_controller14_B.TriggerSignal,/* 47: Signal */
  &quadripulse_controller14_B.WindowFunction_o1[0],/* 48: Signal */
  &quadripulse_controller14_B.WindowFunction_o2[0],/* 49: Signal */
  &quadripulse_controller14_B.SumofElements,/* 50: Signal */
  &quadripulse_controller14_B.Unbuffer[0],/* 51: Signal */
  &quadripulse_controller14_B.RateTransition[0],/* 52: Signal */
  (void *) &quadripulse_controller14_ConstB.ConstantRamp[0],/* 53: Signal */
  &quadripulse_controller14_B.Add_o[0],/* 54: Signal */
  &quadripulse_controller14_B.ZeroOrderHold[0],/* 55: Signal */
  &quadripulse_controller14_B.Flip[0], /* 56: Signal */
  &quadripulse_controller14_B.ReFlip[0],/* 57: Signal */
  &quadripulse_controller14_B.FIRBandpassFilterBackward[0],/* 58: Signal */
  &quadripulse_controller14_B.FIRBandpassFilterForward[0],/* 59: Signal */
  &quadripulse_controller14_B.Logic[0],/* 60: Signal */
  &quadripulse_controller14_B.Memory,  /* 61: Signal */
  &quadripulse_controller14_B.MinMax,  /* 62: Signal */
  &quadripulse_controller14_B.Times1end1,/* 63: Signal */
  &quadripulse_controller14_B.Times2end,/* 64: Signal */
  &quadripulse_controller14_B.Subtract_n,/* 65: Signal */
  &quadripulse_controller14_B.Probe[0],/* 66: Signal */
  &quadripulse_controller14_B.Multiply[0],/* 67: Signal */
  &quadripulse_controller14_B.RateTransition_j,/* 68: Signal */
  &quadripulse_controller14_B.Reshape1_a[0],/* 69: Signal */
  &quadripulse_controller14_B.RoundingFunction[0],/* 70: Signal */
  &quadripulse_controller14_B.Selector_m[0],/* 71: Signal */
  &quadripulse_controller14_B.Sort[0], /* 72: Signal */
  &quadripulse_controller14_B.Subtract_f,/* 73: Signal */
  &quadripulse_controller14_B.TriggerConditionMet,/* 74: Signal */
  &quadripulse_controller14_B.WithinRange,/* 75: Signal */
  &quadripulse_controller14_B.IndexVector,/* 76: Signal */
  &quadripulse_controller14_B.max,     /* 77: Signal */
  &quadripulse_controller14_B.min,     /* 78: Signal */
  &quadripulse_controller14_B.DataTypeConversion1_b,/* 79: Signal */
  &quadripulse_controller14_B.DataTypeConversion4,/* 80: Signal */
  &quadripulse_controller14_B.Gain_p,  /* 81: Signal */
  &quadripulse_controller14_B.LogicalOperator,/* 82: Signal */
  &quadripulse_controller14_B.ChannelIndex,/* 83: Signal */
  &quadripulse_controller14_B.TimeIndex,/* 84: Signal */
  &quadripulse_controller14_B.Boundscheck,/* 85: Signal */
  &quadripulse_controller14_B.RelationalOperator,/* 86: Signal */
  &quadripulse_controller14_B.ChannelData[0],/* 87: Signal */
  &quadripulse_controller14_B.TimeData[0],/* 88: Signal */
  &quadripulse_controller14_B.Sum,     /* 89: Signal */
  &quadripulse_controller14_B.Saturate,/* 90: Signal */
  &quadripulse_controller14_B.Switch,  /* 91: Signal */
  (void *) &quadripulse_controller14_ConstB.Width,/* 92: Signal */
  &quadripulse_controller14_B.CounterDelay,/* 93: Signal */
  &quadripulse_controller14_B.MatrixConcatenate[0],/* 94: Signal */
  &quadripulse_controller14_B.DataTypeConversion[0],/* 95: Signal */
  &quadripulse_controller14_B.Flip_b[0],/* 96: Signal */
  &quadripulse_controller14_B.Gain[0], /* 97: Signal */
  &quadripulse_controller14_B.MathFunction[0],/* 98: Signal */
  &quadripulse_controller14_B.Reshape_p[0],/* 99: Signal */
  &quadripulse_controller14_B.Reshape2[0],/* 100: Signal */
  &quadripulse_controller14_B.ByteUnpacking[0],/* 101: Signal */
  &quadripulse_controller14_B.MatrixConcatenation[0],/* 102: Signal */
  &quadripulse_controller14_B.a,       /* 103: Signal */
  &quadripulse_controller14_B.b,       /* 104: Signal */
  &quadripulse_controller14_B.linearterm1[0],/* 105: Signal */
  &quadripulse_controller14_B.linearterm2,/* 106: Signal */
  &quadripulse_controller14_B.linearterm3,/* 107: Signal */
  &quadripulse_controller14_B.Reshape[0],/* 108: Signal */
  (void *) &quadripulse_controller14_ConstB.ramp[0],/* 109: Signal */
  &quadripulse_controller14_B.Maximum, /* 110: Signal */
  &quadripulse_controller14_B.MatrixSum1,/* 111: Signal */
  &quadripulse_controller14_B.MatrixSum2,/* 112: Signal */
  &quadripulse_controller14_B.Sum1,    /* 113: Signal */
  &quadripulse_controller14_B.Sum4[0], /* 114: Signal */
  &quadripulse_controller14_B.Sum5[0], /* 115: Signal */
  &quadripulse_controller14_B.DotProduct,/* 116: Signal */
  &quadripulse_controller14_B.DotProduct2,/* 117: Signal */
  &quadripulse_controller14_B.MagnitudeSquared[0],/* 118: Signal */
  &quadripulse_controller14_B.FFT[0].re,/* 119: Signal */
  &quadripulse_controller14_B.Gain_c[0],/* 120: Signal */
  &quadripulse_controller14_B.Add[0],  /* 121: Signal */
  &quadripulse_controller14_B.Delay[0],/* 122: Signal */
  &quadripulse_controller14_B.Delay1_b[0],/* 123: Signal */
  &quadripulse_controller14_B.Compare_e,/* 124: Signal */
  &quadripulse_controller14_B.Buffer_p[0],/* 125: Signal */
  &quadripulse_controller14_B.DataTypeConversion_k,/* 126: Signal */
  &quadripulse_controller14_B.Seconds, /* 127: Signal */
  &quadripulse_controller14_B.Sum_n,   /* 128: Signal */
  &quadripulse_controller14_B.KeepPostiveSwitch,/* 129: Signal */
  &quadripulse_controller14_B.SetCounterSwitch,/* 130: Signal */
  &quadripulse_controller14_B.UnitDelay_n,/* 131: Signal */
  &quadripulse_controller14_B.WeightedSampleTime,/* 132: Signal */
  &quadripulse_controller14_B.Autocorrelation[0],/* 133: Signal */
  &quadripulse_controller14_B.LevinsonDurbin_o1[0],/* 134: Signal */
  &quadripulse_controller14_B.LevinsonDurbin_o2,/* 135: Signal */
  &quadripulse_controller14_B.HitCrossing_i,/* 136: Signal */
  &quadripulse_controller14_B.HitCrossing1,/* 137: Signal */
  &quadripulse_controller14_B.HitCrossing2,/* 138: Signal */
  &quadripulse_controller14_B.HitCrossing3,/* 139: Signal */
  &quadripulse_controller14_B.Output,  /* 140: Signal */
  &quadripulse_controller14_B.Buffer1, /* 141: Signal */
  &quadripulse_controller14_B.Extract1_o1[0],/* 142: Signal */
  &quadripulse_controller14_B.Extract1_o2,/* 143: Signal */
  &quadripulse_controller14_B.UDPConsume1_o1,/* 144: Signal */
  &quadripulse_controller14_B.UDPConsume1_o2,/* 145: Signal */
  &quadripulse_controller14_B.UDPRx1,  /* 146: Signal */
  &quadripulse_controller14_B.linearterm1_m,/* 147: Signal */
  &quadripulse_controller14_B.linearterm2_j,/* 148: Signal */
  &quadripulse_controller14_B.linearterm3_j,/* 149: Signal */
  &quadripulse_controller14_B.linearterm4,/* 150: Signal */
  &quadripulse_controller14_B.a,       /* 151: Signal */
  &quadripulse_controller14_B.b,       /* 152: Signal */
  &quadripulse_controller14_B.Sum1_m,  /* 153: Signal */
  &quadripulse_controller14_B.Sum4_e,  /* 154: Signal */
  &quadripulse_controller14_B.InheritComplexity,/* 155: Signal */
  &quadripulse_controller14_B.MultiportSelector,/* 156: Signal */
  &quadripulse_controller14_B.Inherit[0],/* 157: Signal */
  &quadripulse_controller14_B.Compare, /* 158: Signal */
  &quadripulse_controller14_B.Assignment[0],/* 159: Signal */
  &quadripulse_controller14_B.Flip_a[0],/* 160: Signal */
  &quadripulse_controller14_B.ForIterator,/* 161: Signal */
  &quadripulse_controller14_B.FrameLength,/* 162: Signal */
  &quadripulse_controller14_B.NumberofCoefficients,/* 163: Signal */
  &quadripulse_controller14_B.Saturation,/* 164: Signal */
  (void *) &quadripulse_controller14_ConstB.ConstantRamp_i[0],/* 165: Signal */
  &quadripulse_controller14_B.FirstElement,/* 166: Signal */
  &quadripulse_controller14_B.SecondtoLast[0],/* 167: Signal */
  &quadripulse_controller14_B.VariableSelector[0],/* 168: Signal */
  &quadripulse_controller14_B.Add_d,   /* 169: Signal */
  &quadripulse_controller14_B.Sum_e,   /* 170: Signal */
  &quadripulse_controller14_B.Sum1_k[0],/* 171: Signal */
  &quadripulse_controller14_B.DotProduct_n,/* 172: Signal */
  &quadripulse_controller14_B.UnitDelay,/* 173: Signal */
  &quadripulse_controller14_B.UnitDelay1,/* 174: Signal */
  &quadripulse_controller14_B.Diff,    /* 175: Signal */
  &quadripulse_controller14_B.Uk1,     /* 176: Signal */
  &quadripulse_controller14_B.FixPtSum1,/* 177: Signal */
  &quadripulse_controller14_B.FixPtSwitch,/* 178: Signal */
  &quadripulse_controller14_P.CompareToConstant_const,/* 179: Mask Parameter */
  &quadripulse_controller14_P.CompareToConstant1_const,/* 180: Mask Parameter */
  &quadripulse_controller14_P.CompareToConstant2_const,/* 181: Mask Parameter */
  &quadripulse_controller14_P.CompareToConstant3_const,/* 182: Mask Parameter */
  &quadripulse_controller14_P.SRFlipFlop_initial_condition,/* 183: Mask Parameter */
  &quadripulse_controller14_P.Constant4_Value,/* 184: Block Parameter */
  &quadripulse_controller14_P.Constant6_Value,/* 185: Block Parameter */
  &quadripulse_controller14_P.ACModeScalingFactor_Gain,/* 186: Block Parameter */
  &quadripulse_controller14_P.HitCrossing_Offset_b,/* 187: Block Parameter */
  &quadripulse_controller14_P.PD2MF12bitseries_P1[0],/* 188: Block Parameter */
  &quadripulse_controller14_P.PD2MF12bitseries_P2[0],/* 189: Block Parameter */
  &quadripulse_controller14_P.PD2MF12bitseries_P3[0],/* 190: Block Parameter */
  &quadripulse_controller14_P.PD2MF12bitseries_P4,/* 191: Block Parameter */
  &quadripulse_controller14_P.PD2MF12bitseries_P5,/* 192: Block Parameter */
  &quadripulse_controller14_P.PD2MF12bitseries_P6,/* 193: Block Parameter */
  &quadripulse_controller14_P.PD2MF12bitseries_P7,/* 194: Block Parameter */
  &quadripulse_controller14_P.PD2MF12bitseries_P8[0],/* 195: Block Parameter */
  &quadripulse_controller14_P.ParallelPortDO_P1,/* 196: Block Parameter */
  &quadripulse_controller14_P.ParallelPortDO_P2,/* 197: Block Parameter */
  &quadripulse_controller14_P.ParallelPortDO_P3,/* 198: Block Parameter */
  &quadripulse_controller14_P.ParallelPortDO_P4,/* 199: Block Parameter */
  &quadripulse_controller14_P.ParallelPortDO_P5,/* 200: Block Parameter */
  &quadripulse_controller14_P.ParallelPortDO_P6,/* 201: Block Parameter */
  &quadripulse_controller14_P.ParallelPortDO_P7,/* 202: Block Parameter */
  &quadripulse_controller14_P.ParallelPortDO_P8,/* 203: Block Parameter */
  &quadripulse_controller14_P.ParallelPortDO_P9,/* 204: Block Parameter */
  &quadripulse_controller14_P.ManualSwitch_CurrentSetting,/* 205: Block Parameter */
  &quadripulse_controller14_P.Buffer_ic_n,/* 206: Block Parameter */
  &quadripulse_controller14_P.Delay1_DelayLength,/* 207: Block Parameter */
  &quadripulse_controller14_P.Delay1_InitialCondition,/* 208: Block Parameter */
  &quadripulse_controller14_P.Delay2_DelayLength,/* 209: Block Parameter */
  &quadripulse_controller14_P.Delay2_InitialCondition,/* 210: Block Parameter */
  &quadripulse_controller14_P.UnitDelay_InitialCondition_i,/* 211: Block Parameter */
  &quadripulse_controller14_P.Constant_Value,/* 212: Block Parameter */
  &quadripulse_controller14_P.Constant_Value_i,/* 213: Block Parameter */
  &quadripulse_controller14_P.Constant5_Value[0],/* 214: Mask Parameter */
  &quadripulse_controller14_P.scaletoperHz_Gain,/* 215: Block Parameter */
  &quadripulse_controller14_P.Pad_padVal,/* 216: Block Parameter */
  &quadripulse_controller14_P.Pad_outDims[0],/* 217: Block Parameter */
  &quadripulse_controller14_P.Pad_padBefore[0],/* 218: Block Parameter */
  &quadripulse_controller14_P.Pad_padAfter[0],/* 219: Block Parameter */
  &quadripulse_controller14_P.Pad_inWorkAdd[0],/* 220: Block Parameter */
  &quadripulse_controller14_P.Pad_outWorkAdd[0],/* 221: Block Parameter */
  &quadripulse_controller14_P.Unbuffer_ic,/* 222: Block Parameter */
  &quadripulse_controller14_P.RunningAverage_N,/* 223: Mask Parameter */
  &quadripulse_controller14_P.FIRBandpassFilterBackward_Initi,/* 224: Block Parameter */
  &quadripulse_controller14_P.FIRBandpassFilterForward_Initia,/* 225: Block Parameter */
  &quadripulse_controller14_P.ARPInit_P1,/* 226: Block Parameter */
  &quadripulse_controller14_P.ARPInit_P2,/* 227: Block Parameter */
  &quadripulse_controller14_P.ARPInit_P3,/* 228: Block Parameter */
  &quadripulse_controller14_P.ARPInit_P4,/* 229: Block Parameter */
  &quadripulse_controller14_P.ARPInit_P5,/* 230: Block Parameter */
  &quadripulse_controller14_P.ARPInit_P6,/* 231: Block Parameter */
  &quadripulse_controller14_P.ARPInit_P7,/* 232: Block Parameter */
  &quadripulse_controller14_P.ARPInit_P8,/* 233: Block Parameter */
  &quadripulse_controller14_P.ARPInit_P9,/* 234: Block Parameter */
  &quadripulse_controller14_P.ARPInit_P10,/* 235: Block Parameter */
  &quadripulse_controller14_P.ARPInit_P11,/* 236: Block Parameter */
  &quadripulse_controller14_P.ARPInit_P16,/* 237: Block Parameter */
  &quadripulse_controller14_P.BufferMngmt_P1[0],/* 238: Block Parameter */
  &quadripulse_controller14_P.BufferMngmt_P2,/* 239: Block Parameter */
  &quadripulse_controller14_P.BufferMngmt_P3,/* 240: Block Parameter */
  &quadripulse_controller14_P.EthernetInit_P1,/* 241: Block Parameter */
  &quadripulse_controller14_P.EthernetInit_P2,/* 242: Block Parameter */
  &quadripulse_controller14_P.EthernetInit_P3,/* 243: Block Parameter */
  &quadripulse_controller14_P.EthernetInit_P4,/* 244: Block Parameter */
  &quadripulse_controller14_P.EthernetInit_P5,/* 245: Block Parameter */
  &quadripulse_controller14_P.EthernetInit_P6,/* 246: Block Parameter */
  &quadripulse_controller14_P.EthernetInit_P7,/* 247: Block Parameter */
  &quadripulse_controller14_P.EthernetInit_P8[0],/* 248: Block Parameter */
  &quadripulse_controller14_P.EthernetInit_P9,/* 249: Block Parameter */
  &quadripulse_controller14_P.EthernetInit_P10,/* 250: Block Parameter */
  &quadripulse_controller14_P.EthernetInit_P11,/* 251: Block Parameter */
  &quadripulse_controller14_P.EthernetInit_P12,/* 252: Block Parameter */
  &quadripulse_controller14_P.EthernetInit_P13,/* 253: Block Parameter */
  &quadripulse_controller14_P.EthernetInit_P14,/* 254: Block Parameter */
  &quadripulse_controller14_P.EthernetInit_P15,/* 255: Block Parameter */
  &quadripulse_controller14_P.EthernetInit_P16,/* 256: Block Parameter */
  &quadripulse_controller14_P.EthernetInit_P17,/* 257: Block Parameter */
  &quadripulse_controller14_P.EthernetInit_P18,/* 258: Block Parameter */
  &quadripulse_controller14_P.EthernetInit_P20,/* 259: Block Parameter */
  &quadripulse_controller14_P.EthernetInit_P21,/* 260: Block Parameter */
  &quadripulse_controller14_P.IPInit_P1,/* 261: Block Parameter */
  &quadripulse_controller14_P.IPInit_P2,/* 262: Block Parameter */
  &quadripulse_controller14_P.IPInit_P3,/* 263: Block Parameter */
  &quadripulse_controller14_P.IPInit_P4,/* 264: Block Parameter */
  &quadripulse_controller14_P.IPInit_P5,/* 265: Block Parameter */
  &quadripulse_controller14_P.IPInit_P6,/* 266: Block Parameter */
  &quadripulse_controller14_P.IPInit_P7,/* 267: Block Parameter */
  &quadripulse_controller14_P.IPInit_P8,/* 268: Block Parameter */
  &quadripulse_controller14_P.IPInit_P9,/* 269: Block Parameter */
  &quadripulse_controller14_P.IPInit_P10,/* 270: Block Parameter */
  &quadripulse_controller14_P.IPInit_P11,/* 271: Block Parameter */
  &quadripulse_controller14_P.IPInit_P12,/* 272: Block Parameter */
  &quadripulse_controller14_P.UDPInit_P1,/* 273: Block Parameter */
  &quadripulse_controller14_P.UDPInit_P2,/* 274: Block Parameter */
  &quadripulse_controller14_P.UDPInit_P3,/* 275: Block Parameter */
  &quadripulse_controller14_P.UDPInit_P4,/* 276: Block Parameter */
  &quadripulse_controller14_P.UDPInit_P5,/* 277: Block Parameter */
  &quadripulse_controller14_P.Logic_table[0],/* 278: Block Parameter */
  &quadripulse_controller14_P.uinto1UnitLimit_const,/* 279: Mask Parameter */
  &quadripulse_controller14_P.Constant_Value_g,/* 280: Block Parameter */
  &quadripulse_controller14_P.Forecastof128samples_num_iterat,/* 281: Mask Parameter */
  &quadripulse_controller14_P.Constant_Value_l,/* 282: Block Parameter */
  &quadripulse_controller14_P.Channel_Y0,/* 283: Block Parameter */
  &quadripulse_controller14_P.Zero_Value,/* 284: Block Parameter */
  &quadripulse_controller14_P.Gain_Gain,/* 285: Block Parameter */
  &quadripulse_controller14_P.CounterDelay_DelayLength,/* 286: Block Parameter */
  &quadripulse_controller14_P.CounterDelay_InitialCondition,/* 287: Block Parameter */
  &quadripulse_controller14_P.Constant_Value_c[0],/* 288: Block Parameter */
  &quadripulse_controller14_P.Gain_Gain_p,/* 289: Block Parameter */
  &quadripulse_controller14_P.Delay_DelayLength,/* 290: Block Parameter */
  &quadripulse_controller14_P.Delay_InitialCondition,/* 291: Block Parameter */
  &quadripulse_controller14_P.Delay1_DelayLength_h,/* 292: Block Parameter */
  &quadripulse_controller14_P.Delay1_InitialCondition_i,/* 293: Block Parameter */
  &quadripulse_controller14_P.Out1_Y0, /* 294: Block Parameter */
  &quadripulse_controller14_P.Buffer_ic,/* 295: Block Parameter */
  &quadripulse_controller14_P.One_Value,/* 296: Block Parameter */
  &quadripulse_controller14_P.Zero_Value_f,/* 297: Block Parameter */
  &quadripulse_controller14_P.Seconds_Gain,/* 298: Block Parameter */
  &quadripulse_controller14_P.KeepPostiveSwitch_Threshold,/* 299: Block Parameter */
  &quadripulse_controller14_P.UnitDelay_InitialCondition_m,/* 300: Block Parameter */
  &quadripulse_controller14_P.WeightedSampleTime_WtEt,/* 301: Block Parameter */
  &quadripulse_controller14_P.Difference_ICPrevInput,/* 302: Mask Parameter */
  &quadripulse_controller14_P.HitCrossing_Offset,/* 303: Block Parameter */
  &quadripulse_controller14_P.HitCrossing1_Offset,/* 304: Block Parameter */
  &quadripulse_controller14_P.HitCrossing2_Offset,/* 305: Block Parameter */
  &quadripulse_controller14_P.HitCrossing3_Offset,/* 306: Block Parameter */
  &quadripulse_controller14_P.WrapToZero_Threshold,/* 307: Mask Parameter */
  &quadripulse_controller14_P.Output_InitialCondition,/* 308: Block Parameter */
  &quadripulse_controller14_P.Buffer1_P1,/* 309: Block Parameter */
  &quadripulse_controller14_P.Buffer1_P2,/* 310: Block Parameter */
  &quadripulse_controller14_P.Buffer1_P3,/* 311: Block Parameter */
  &quadripulse_controller14_P.Extract1_P1,/* 312: Block Parameter */
  &quadripulse_controller14_P.UDPConsume1_P1,/* 313: Block Parameter */
  &quadripulse_controller14_P.UDPConsume1_P2,/* 314: Block Parameter */
  &quadripulse_controller14_P.UDPConsume1_P3,/* 315: Block Parameter */
  &quadripulse_controller14_P.UDPRx1_P1,/* 316: Block Parameter */
  &quadripulse_controller14_P.UDPRx1_P2,/* 317: Block Parameter */
  &quadripulse_controller14_P.UDPRx1_P3,/* 318: Block Parameter */
  &quadripulse_controller14_P.UDPRx1_P4,/* 319: Block Parameter */
  &quadripulse_controller14_P.UDPRx1_P5,/* 320: Block Parameter */
  &quadripulse_controller14_P.UDPRx1_P6,/* 321: Block Parameter */
  &quadripulse_controller14_P.Constant_Value_j,/* 322: Block Parameter */
  &quadripulse_controller14_P.Forecast_Y0,/* 323: Block Parameter */
  &quadripulse_controller14_P.ForIterator_IterationLimit,/* 324: Block Parameter */
  &quadripulse_controller14_P.Saturation_LowerSat,/* 325: Block Parameter */
  &quadripulse_controller14_P.UnitDelay_InitialCondition,/* 326: Block Parameter */
  &quadripulse_controller14_P.UnitDelay1_InitialCondition,/* 327: Block Parameter */
  &quadripulse_controller14_P.FixPtConstant_Value,/* 328: Block Parameter */
  &quadripulse_controller14_P.Constant_Value_m,/* 329: Block Parameter */
  &quadripulse_controller14_P.amplitudeinterval[0],/* 330: Model Parameter */
  &quadripulse_controller14_P.amplitudeinterval_percentiles[0],/* 331: Model Parameter */
  &quadripulse_controller14_P.fft_bin_indices_zero_based[0],/* 332: Model Parameter */
  &quadripulse_controller14_P.fir_filter_coefficients[0],/* 333: Model Parameter */
  &quadripulse_controller14_P.phasecondition,/* 334: Model Parameter */
  &quadripulse_controller14_P.spatial_filter[0],/* 335: Model Parameter */
  &quadripulse_controller14_P.timeinsecondsandtriggerchannel[0],/* 336: Model Parameter */
  &quadripulse_controller14_P.marker_id,/* 337: Model Parameter */
  &quadripulse_controller14_P.closedloopmode,/* 338: Model Parameter */
  &quadripulse_controller14_P.reset,   /* 339: Model Parameter */
};

/* Declare Data Run-Time Dimension Buffer Addresses statically */
static int32_T* rtVarDimsAddrMap[] = {
  (NULL),
  &quadripulse_controller14_DW.Selector_DIMS1[0]
};

#endif

/* Data Type Map - use dataTypeMapIndex to access this structure */
static TARGET_CONST rtwCAPI_DataTypeMap rtDataTypeMap[] = {
  /* cName, mwName, numElements, elemMapIndex, dataSize, slDataId, *
   * isComplex, isPointer */
  { "double", "real_T", 0, 0, sizeof(real_T), SS_DOUBLE, 0, 0 },

  { "unsigned char", "uint8_T", 0, 0, sizeof(uint8_T), SS_UINT8, 0, 0 },

  { "unsigned char", "boolean_T", 0, 0, sizeof(boolean_T), SS_BOOLEAN, 0, 0 },

  { "int", "int32_T", 0, 0, sizeof(int32_T), SS_INT32, 0, 0 },

  { "struct", "creal_T", 0, 0, sizeof(creal_T), SS_DOUBLE, 1, 0 },

  { "unsigned int", "uint32_T", 0, 0, sizeof(uint32_T), SS_UINT32, 0, 0 },

  { "unsigned short", "uint16_T", 0, 0, sizeof(uint16_T), SS_UINT16, 0, 0 }
};

#ifdef HOST_CAPI_BUILD
#undef sizeof
#endif

/* Structure Element Map - use elemMapIndex to access this structure */
static TARGET_CONST rtwCAPI_ElementMap rtElementMap[] = {
  /* elementName, elementOffset, dataTypeIndex, dimIndex, fxpIndex */
  { (NULL), 0, 0, 0, 0 },
};

/* Dimension Map - use dimensionMapIndex to access elements of ths structure*/
static const rtwCAPI_DimensionMap rtDimensionMap[] = {
  /* dataOrientation, dimArrayIndex, numDims, vardimsIndex */
  { rtwCAPI_MATRIX_COL_MAJOR, 0, 2, 0 },

  { rtwCAPI_SCALAR, 2, 2, 0 },

  { rtwCAPI_MATRIX_COL_MAJOR, 4, 2, 0 },

  { rtwCAPI_VECTOR, 6, 2, 0 },

  { rtwCAPI_MATRIX_COL_MAJOR, 8, 2, 0 },

  { rtwCAPI_MATRIX_COL_MAJOR, 10, 2, 0 },

  { rtwCAPI_MATRIX_COL_MAJOR, 12, 2, 0 },

  { rtwCAPI_MATRIX_COL_MAJOR, 14, 2, 0 },

  { rtwCAPI_MATRIX_COL_MAJOR, 16, 2, 0 },

  { rtwCAPI_MATRIX_COL_MAJOR, 18, 2, 0 },

  { rtwCAPI_MATRIX_COL_MAJOR, 20, 2, 0 },

  { rtwCAPI_MATRIX_COL_MAJOR, 20, 2, 1 },

  { rtwCAPI_VECTOR, 22, 2, 0 },

  { rtwCAPI_MATRIX_COL_MAJOR, 24, 2, 0 },

  { rtwCAPI_VECTOR, 26, 2, 0 },

  { rtwCAPI_MATRIX_COL_MAJOR, 6, 2, 0 },

  { rtwCAPI_MATRIX_COL_MAJOR, 28, 2, 0 },

  { rtwCAPI_MATRIX_COL_MAJOR, 30, 2, 0 },

  { rtwCAPI_VECTOR, 32, 2, 0 },

  { rtwCAPI_MATRIX_COL_MAJOR, 34, 2, 0 },

  { rtwCAPI_MATRIX_COL_MAJOR, 36, 2, 0 },

  { rtwCAPI_MATRIX_COL_MAJOR, 38, 2, 0 },

  { rtwCAPI_VECTOR, 16, 2, 0 },

  { rtwCAPI_MATRIX_COL_MAJOR, 40, 2, 0 },

  { rtwCAPI_VECTOR, 40, 2, 0 },

  { rtwCAPI_VECTOR, 42, 2, 0 },

  { rtwCAPI_VECTOR, 44, 2, 0 },

  { rtwCAPI_MATRIX_COL_MAJOR, 46, 2, 0 },

  { rtwCAPI_VECTOR, 46, 2, 0 },

  { rtwCAPI_VECTOR, 48, 2, 0 },

  { rtwCAPI_VECTOR, 50, 2, 0 },

  { rtwCAPI_VECTOR, 14, 2, 0 },

  { rtwCAPI_VECTOR, 52, 2, 0 },

  { rtwCAPI_MATRIX_COL_MAJOR, 54, 2, 0 },

  { rtwCAPI_VECTOR, 56, 2, 0 },

  { rtwCAPI_VECTOR, 58, 2, 0 },

  { rtwCAPI_VECTOR, 10, 2, 0 },

  { rtwCAPI_MATRIX_COL_MAJOR, 60, 2, 0 }
};

/* Dimension Array- use dimArrayIndex to access elements of this array */
static const uint_T rtDimensionArray[] = {
  512,                                 /* 0 */
  2,                                   /* 1 */
  1,                                   /* 2 */
  1,                                   /* 3 */
  1,                                   /* 4 */
  66,                                  /* 5 */
  2,                                   /* 6 */
  1,                                   /* 7 */
  65,                                  /* 8 */
  1,                                   /* 9 */
  1,                                   /* 10 */
  65,                                  /* 11 */
  384,                                 /* 12 */
  1,                                   /* 13 */
  1,                                   /* 14 */
  2,                                   /* 15 */
  512,                                 /* 16 */
  1,                                   /* 17 */
  100,                                 /* 18 */
  2,                                   /* 19 */
  1024,                                /* 20 */
  1,                                   /* 21 */
  100,                                 /* 22 */
  1,                                   /* 23 */
  1,                                   /* 24 */
  5,                                   /* 25 */
  5,                                   /* 26 */
  1,                                   /* 27 */
  600,                                 /* 28 */
  1,                                   /* 29 */
  4,                                   /* 30 */
  330,                                 /* 31 */
  330,                                 /* 32 */
  1,                                   /* 33 */
  3,                                   /* 34 */
  330,                                 /* 35 */
  5,                                   /* 36 */
  66,                                  /* 37 */
  66,                                  /* 38 */
  5,                                   /* 39 */
  31,                                  /* 40 */
  1,                                   /* 41 */
  1018,                                /* 42 */
  1,                                   /* 43 */
  128,                                 /* 44 */
  1,                                   /* 45 */
  30,                                  /* 46 */
  1,                                   /* 47 */
  1,                                   /* 48 */
  4,                                   /* 49 */
  1,                                   /* 50 */
  23,                                  /* 51 */
  1,                                   /* 52 */
  6,                                   /* 53 */
  8,                                   /* 54 */
  2,                                   /* 55 */
  1,                                   /* 56 */
  330,                                 /* 57 */
  1,                                   /* 58 */
  129,                                 /* 59 */
  2,                                   /* 60 */
  2                                    /* 61 */
};

/* C-API stores floating point values in an array. The elements of this  *
 * are unique. This ensures that values which are shared across the model*
 * are stored in the most efficient way. These values are referenced by  *
 *           - rtwCAPI_FixPtMap.fracSlopePtr,                            *
 *           - rtwCAPI_FixPtMap.biasPtr,                                 *
 *           - rtwCAPI_SampleTimeMap.samplePeriodPtr,                    *
 *           - rtwCAPI_SampleTimeMap.sampleOffsetPtr                     */
static const real_T rtcapiStoredFloats[] = {
  0.001, 0.0, 0.1, 0.01, 0.5, 1.0
};

/* Fixed Point Map */
static const rtwCAPI_FixPtMap rtFixPtMap[] = {
  /* fracSlopePtr, biasPtr, scaleType, wordLength, exponent, isSigned */
  { (NULL), (NULL), rtwCAPI_FIX_RESERVED, 0, 0, 0 },

  { (const void *) &rtcapiStoredFloats[5], (const void *) &rtcapiStoredFloats[1],
    rtwCAPI_FIX_UNIFORM_SCALING, 32, -12, 0 },

  { (const void *) &rtcapiStoredFloats[5], (const void *) &rtcapiStoredFloats[1],
    rtwCAPI_FIX_UNIFORM_SCALING, 16, 3, 0 },

  { (const void *) &rtcapiStoredFloats[5], (const void *) &rtcapiStoredFloats[1],
    rtwCAPI_FIX_UNIFORM_SCALING, 16, -15, 0 }
};

/* Sample Time Map - use sTimeIndex to access elements of ths structure */
static const rtwCAPI_SampleTimeMap rtSampleTimeMap[] = {
  /* samplePeriodPtr, sampleOffsetPtr, tid, samplingMode */
  { (const void *) &rtcapiStoredFloats[0], (const void *) &rtcapiStoredFloats[1],
    0, 0 },

  { (const void *) &rtcapiStoredFloats[2], (const void *) &rtcapiStoredFloats[1],
    2, 0 },

  { (const void *) &rtcapiStoredFloats[0], (const void *) &rtcapiStoredFloats[1],
    0, 1 },

  { (const void *) &rtcapiStoredFloats[3], (const void *) &rtcapiStoredFloats[1],
    1, 0 },

  { (NULL), (NULL), -2, 0 },

  { (const void *) &rtcapiStoredFloats[4], (const void *) &rtcapiStoredFloats[1],
    3, 0 },

  { (NULL), (NULL), -1, 0 }
};

static rtwCAPI_ModelMappingStaticInfo mmiStatic = {
  /* Signals:{signals, numSignals,
   *           rootInputs, numRootInputs,
   *           rootOutputs, numRootOutputs},
   * Params: {blockParameters, numBlockParameters,
   *          modelParameters, numModelParameters},
   * States: {states, numStates},
   * Maps:   {dataTypeMap, dimensionMap, fixPtMap,
   *          elementMap, sampleTimeMap, dimensionArray},
   * TargetType: targetType
   */
  { rtBlockSignals, 179,
    (NULL), 0,
    (NULL), 0 },

  { rtBlockParameters, 151,
    rtModelParameters, 10 },

  { (NULL), 0 },

  { rtDataTypeMap, rtDimensionMap, rtFixPtMap,
    rtElementMap, rtSampleTimeMap, rtDimensionArray },
  "float",

  { 2776450659U,
    98268920U,
    2699329541U,
    534079728U },
  (NULL), 0,
  0
};

/* Function to get C API Model Mapping Static Info */
const rtwCAPI_ModelMappingStaticInfo*
  quadripulse_controller14_GetCAPIStaticMap()
{
  return &mmiStatic;
}

/* Cache pointers into DataMapInfo substructure of RTModel */
#ifndef HOST_CAPI_BUILD

void quadripulse_controller14_InitializeDataMapInfo
  (RT_MODEL_quadripulse_controller14_T *const quadripulse_controller14_M)
{
  /* Set C-API version */
  rtwCAPI_SetVersion(quadripulse_controller14_M->DataMapInfo.mmi, 1);

  /* Cache static C-API data into the Real-time Model Data structure */
  rtwCAPI_SetStaticMap(quadripulse_controller14_M->DataMapInfo.mmi, &mmiStatic);

  /* Cache static C-API logging data into the Real-time Model Data structure */
  rtwCAPI_SetLoggingStaticMap(quadripulse_controller14_M->DataMapInfo.mmi, (NULL));

  /* Cache C-API Data Addresses into the Real-Time Model Data structure */
  rtwCAPI_SetDataAddressMap(quadripulse_controller14_M->DataMapInfo.mmi,
    rtDataAddrMap);

  /* Cache C-API Data Run-Time Dimension Buffer Addresses into the Real-Time Model Data structure */
  rtwCAPI_SetVarDimsAddressMap(quadripulse_controller14_M->DataMapInfo.mmi,
    rtVarDimsAddrMap);

  /* Cache C-API rtp Address and size  into the Real-Time Model Data structure */
  quadripulse_controller14_M->DataMapInfo.mmi.InstanceMap.rtpAddress =
    rtmGetDefaultParam(quadripulse_controller14_M);
  quadripulse_controller14_M->DataMapInfo.mmi.staticMap->rtpSize = sizeof
    (P_quadripulse_controller14_T);

  /* Cache the instance C-API logging pointer */
  rtwCAPI_SetInstanceLoggingInfo(quadripulse_controller14_M->DataMapInfo.mmi,
    (NULL));

  /* Set reference to submodels */
  rtwCAPI_SetChildMMIArray(quadripulse_controller14_M->DataMapInfo.mmi, (NULL));
  rtwCAPI_SetChildMMIArrayLen(quadripulse_controller14_M->DataMapInfo.mmi, 0);
}

#else                                  /* HOST_CAPI_BUILD */
#ifdef __cplusplus

extern "C" {

#endif

  void quadripulse_controller14_host_InitializeDataMapInfo
    (quadripulse_controller14_host_DataMapInfo_T *dataMap, const char *path)
  {
    /* Set C-API version */
    rtwCAPI_SetVersion(dataMap->mmi, 1);

    /* Cache static C-API data into the Real-time Model Data structure */
    rtwCAPI_SetStaticMap(dataMap->mmi, &mmiStatic);

    /* host data address map is NULL */
    rtwCAPI_SetDataAddressMap(dataMap->mmi, NULL);

    /* host vardims address map is NULL */
    rtwCAPI_SetVarDimsAddressMap(dataMap->mmi, NULL);

    /* Set Instance specific path */
    rtwCAPI_SetPath(dataMap->mmi, path);
    rtwCAPI_SetFullPath(dataMap->mmi, NULL);

    /* Set reference to submodels */
    rtwCAPI_SetChildMMIArray(dataMap->mmi, (NULL));
    rtwCAPI_SetChildMMIArrayLen(dataMap->mmi, 0);
  }

#ifdef __cplusplus

}
#endif
#endif                                 /* HOST_CAPI_BUILD */

/* EOF: quadripulse_controller14_capi.c */
