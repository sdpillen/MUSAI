/*
 * quadripulse_controller14_private.h
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

#ifndef RTW_HEADER_quadripulse_controller14_private_h_
#define RTW_HEADER_quadripulse_controller14_private_h_
#include "rtwtypes.h"
#include "builtin_typeid_types.h"
#include "multiword_types.h"
#include "zero_crossing_types.h"
#include "dsp_rt.h"                    /* DSP System Toolbox general run time support functions */
#ifndef UCHAR_MAX
#include <limits.h>
#endif

#if ( UCHAR_MAX != (0xFFU) ) || ( SCHAR_MAX != (0x7F) )
#error Code was generated for compiler with different sized uchar/char. \
Consider adjusting Test hardware word size settings on the \
Hardware Implementation pane to match your compiler word sizes as \
defined in limits.h of the compiler. Alternatively, you can \
select the Test hardware is the same as production hardware option and \
select the Enable portable word sizes option on the Code Generation > \
Verification pane for ERT based targets, which will disable the \
preprocessor word size checks.
#endif

#if ( USHRT_MAX != (0xFFFFU) ) || ( SHRT_MAX != (0x7FFF) )
#error Code was generated for compiler with different sized ushort/short. \
Consider adjusting Test hardware word size settings on the \
Hardware Implementation pane to match your compiler word sizes as \
defined in limits.h of the compiler. Alternatively, you can \
select the Test hardware is the same as production hardware option and \
select the Enable portable word sizes option on the Code Generation > \
Verification pane for ERT based targets, which will disable the \
preprocessor word size checks.
#endif

#if ( UINT_MAX != (0xFFFFFFFFU) ) || ( INT_MAX != (0x7FFFFFFF) )
#error Code was generated for compiler with different sized uint/int. \
Consider adjusting Test hardware word size settings on the \
Hardware Implementation pane to match your compiler word sizes as \
defined in limits.h of the compiler. Alternatively, you can \
select the Test hardware is the same as production hardware option and \
select the Enable portable word sizes option on the Code Generation > \
Verification pane for ERT based targets, which will disable the \
preprocessor word size checks.
#endif

#if ( ULONG_MAX != (0xFFFFFFFFU) ) || ( LONG_MAX != (0x7FFFFFFF) )
#error Code was generated for compiler with different sized ulong/long. \
Consider adjusting Test hardware word size settings on the \
Hardware Implementation pane to match your compiler word sizes as \
defined in limits.h of the compiler. Alternatively, you can \
select the Test hardware is the same as production hardware option and \
select the Enable portable word sizes option on the Code Generation > \
Verification pane for ERT based targets, which will disable the \
preprocessor word size checks.
#endif

#include "dspsrt_rt.h"                 /* DSP System Toolbox run time support library */

extern const serialfifoptr serialfifoground;
extern const bcmsglist1553 bcmsg1553ground;
extern const bcstatus1553 bcstatground;
extern const bmmsglist1553 bmmsg1553ground;
extern void MWDSPCG_FFT_Interleave_R2BR_D(const real_T x[], creal_T y[], int32_T
  nChans, int32_T nRows);
extern void MWDSPCG_R2DIT_TBLS_Z(creal_T y[], int32_T nChans, int32_T nRows,
  int32_T fftLen, int32_T offset, const real_T tablePtr[], int32_T twiddleStep,
  boolean_T isInverse);
extern void MWDSPCG_FFT_DblLen_Z(creal_T y[], int32_T nChans, int32_T nRows,
  const real_T twiddleTable[], int32_T twiddleStep);
extern real_T rt_roundd_snf(real_T u);
extern const char *getRefMdlPath(const char *refMdl);
extern int getRefMdlSignalNumber(const char *mdlBlock, const char *signalName);
extern void xpcnb(SimStruct *rts);
extern void xpcetherinit(SimStruct *rts);
extern void xpcdebugarpinit(SimStruct *rts);
extern void xpcdebugipinit(SimStruct *rts);
extern void xpcdebugudpinit(SimStruct *rts);
extern void xpcudprx(SimStruct *rts);
extern void xpcnbbuffer(SimStruct *rts);
extern void xpcudpconsume(SimStruct *rts);
extern void xpcnbextract(SimStruct *rts);
extern void doueipd2mfx(SimStruct *rts);
extern void parallelportdio(SimStruct *rts);

#endif                                 /* RTW_HEADER_quadripulse_controller14_private_h_ */
