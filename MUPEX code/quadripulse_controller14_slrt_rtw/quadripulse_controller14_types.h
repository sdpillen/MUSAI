/*
 * quadripulse_controller14_types.h
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

#ifndef RTW_HEADER_quadripulse_controller14_types_h_
#define RTW_HEADER_quadripulse_controller14_types_h_
#include "rtwtypes.h"
#include "builtin_typeid_types.h"
#include "multiword_types.h"
#include "zero_crossing_types.h"
#ifndef struct_md3f485c58d5a43463693a3f80b72d57ad
#define struct_md3f485c58d5a43463693a3f80b72d57ad

struct md3f485c58d5a43463693a3f80b72d57ad
{
  int32_T S0_isInitialized;
  real_T W0_states[400];
  real_T P0_InitialStates;
  real_T P1_Coefficients[201];
};

#endif                                 /*struct_md3f485c58d5a43463693a3f80b72d57ad*/

#ifndef typedef_dsp_FIRFilter_0_quadripulse_c_T
#define typedef_dsp_FIRFilter_0_quadripulse_c_T

typedef struct md3f485c58d5a43463693a3f80b72d57ad
  dsp_FIRFilter_0_quadripulse_c_T;

#endif                                 /*typedef_dsp_FIRFilter_0_quadripulse_c_T*/

#ifndef struct_mdTOi4sphHDDCmseKedwNmc
#define struct_mdTOi4sphHDDCmseKedwNmc

struct mdTOi4sphHDDCmseKedwNmc
{
  int32_T isInitialized;
  dsp_FIRFilter_0_quadripulse_c_T cSFunObject;
};

#endif                                 /*struct_mdTOi4sphHDDCmseKedwNmc*/

#ifndef typedef_dspcodegen_FIRFilter_quadripu_T
#define typedef_dspcodegen_FIRFilter_quadripu_T

typedef struct mdTOi4sphHDDCmseKedwNmc dspcodegen_FIRFilter_quadripu_T;

#endif                                 /*typedef_dspcodegen_FIRFilter_quadripu_T*/

#ifndef struct_mdONQ8g71TQMLCkTxckcPEOG
#define struct_mdONQ8g71TQMLCkTxckcPEOG

struct mdONQ8g71TQMLCkTxckcPEOG
{
  int32_T isInitialized;
  uint32_T inputVarSize1[8];
  real_T pSampleRateDialog;
  real_T NumChannels;
  dspcodegen_FIRFilter_quadripu_T *FilterObj;
};

#endif                                 /*struct_mdONQ8g71TQMLCkTxckcPEOG*/

#ifndef typedef_dsp_HighpassFilter_quadripuls_T
#define typedef_dsp_HighpassFilter_quadripuls_T

typedef struct mdONQ8g71TQMLCkTxckcPEOG dsp_HighpassFilter_quadripuls_T;

#endif                                 /*typedef_dsp_HighpassFilter_quadripuls_T*/

#ifndef typedef_struct_T_quadripulse_controll_T
#define typedef_struct_T_quadripulse_controll_T

typedef struct {
  char_T f0[7];
} struct_T_quadripulse_controll_T;

#endif                                 /*typedef_struct_T_quadripulse_controll_T*/

#ifndef typedef_struct_T_quadripulse_contro_m_T
#define typedef_struct_T_quadripulse_contro_m_T

typedef struct {
  char_T f0[6];
} struct_T_quadripulse_contro_m_T;

#endif                                 /*typedef_struct_T_quadripulse_contro_m_T*/

#ifndef typedef_struct_T_quadripulse_contr_mv_T
#define typedef_struct_T_quadripulse_contr_mv_T

typedef struct {
  char_T f0[6];
  char_T f1[6];
  char_T f2[4];
  char_T f3[7];
  char_T f4[8];
} struct_T_quadripulse_contr_mv_T;

#endif                                 /*typedef_struct_T_quadripulse_contr_mv_T*/

#ifndef typedef_struct_T_quadripulse_cont_mvi_T
#define typedef_struct_T_quadripulse_cont_mvi_T

typedef struct {
  char_T f0[6];
  char_T f1[6];
  char_T f2[4];
  char_T f3[8];
} struct_T_quadripulse_cont_mvi_T;

#endif                                 /*typedef_struct_T_quadripulse_cont_mvi_T*/

#ifndef typedef_struct_T_quadripulse_con_mvib_T
#define typedef_struct_T_quadripulse_con_mvib_T

typedef struct {
  char_T f0[6];
  char_T f1[6];
  char_T f2[4];
  char_T f3[8];
  char_T f4[2];
  real_T f5;
} struct_T_quadripulse_con_mvib_T;

#endif                                 /*typedef_struct_T_quadripulse_con_mvib_T*/

#ifndef typedef_struct_T_quadripulse_co_mvibr_T
#define typedef_struct_T_quadripulse_co_mvibr_T

typedef struct {
  char_T f0[6];
  char_T f1[6];
} struct_T_quadripulse_co_mvibr_T;

#endif                                 /*typedef_struct_T_quadripulse_co_mvibr_T*/

#ifndef typedef_struct_T_quadripulse_c_mvibrk_T
#define typedef_struct_T_quadripulse_c_mvibrk_T

typedef struct {
  char_T f0[4];
  char_T f1[6];
  char_T f2[8];
  char_T f3[6];
} struct_T_quadripulse_c_mvibrk_T;

#endif                                 /*typedef_struct_T_quadripulse_c_mvibrk_T*/

#ifndef typedef_struct_T_quadripulse__mvibrk1_T
#define typedef_struct_T_quadripulse__mvibrk1_T

typedef struct {
  char_T f0[6];
  char_T f1[6];
  char_T f2[4];
  char_T f3[8];
  char_T f4;
  real_T f5;
} struct_T_quadripulse__mvibrk1_T;

#endif                                 /*typedef_struct_T_quadripulse__mvibrk1_T*/

/* Parameters (auto storage) */
typedef struct P_quadripulse_controller14_T_ P_quadripulse_controller14_T;

/* Forward declaration for rtModel */
typedef struct tag_RTM_quadripulse_controller14_T
  RT_MODEL_quadripulse_controller14_T;

#endif                                 /* RTW_HEADER_quadripulse_controller14_types_h_ */
