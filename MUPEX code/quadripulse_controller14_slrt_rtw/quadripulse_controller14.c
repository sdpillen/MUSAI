/*
 * quadripulse_controller14.c
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

#include "rt_logging_mmi.h"
#include "quadripulse_controller14_capi.h"
#include "quadripulse_controller14.h"
#include "quadripulse_controller14_private.h"
#define quadripulse_controll_SampleRate (1000.0)

/* Block signals (auto storage) */
B_quadripulse_controller14_T quadripulse_controller14_B;

/* Block states (auto storage) */
DW_quadripulse_controller14_T quadripulse_controller14_DW;

/* Previous zero-crossings (trigger) states */
PrevZCX_quadripulse_controller14_T quadripulse_controller14_PrevZCX;

/* Real-time model */
RT_MODEL_quadripulse_controller14_T quadripulse_controller14_M_;
RT_MODEL_quadripulse_controller14_T *const quadripulse_controller14_M =
  &quadripulse_controller14_M_;
static void rate_monotonic_scheduler(void);
time_T rt_SimUpdateDiscreteEvents(
  int_T rtmNumSampTimes, void *rtmTimingData, int_T *rtmSampleHitPtr, int_T
  *rtmPerTaskSampleHits )
{
  rtmSampleHitPtr[1] = rtmStepTask(quadripulse_controller14_M, 1);
  rtmSampleHitPtr[2] = rtmStepTask(quadripulse_controller14_M, 2);
  rtmSampleHitPtr[3] = rtmStepTask(quadripulse_controller14_M, 3);
  UNUSED_PARAMETER(rtmNumSampTimes);
  UNUSED_PARAMETER(rtmTimingData);
  UNUSED_PARAMETER(rtmPerTaskSampleHits);
  return(-1);
}

/*
 *   This function updates active task flag for each subrate
 * and rate transition flags for tasks that exchange data.
 * The function assumes rate-monotonic multitasking scheduler.
 * The function must be called at model base rate so that
 * the generated code self-manages all its subrates and rate
 * transition flags.
 */
static void rate_monotonic_scheduler(void)
{
  /* To ensure a deterministic data transfer between two rates,
   * data is transferred at the priority of a fast task and the frequency
   * of the slow task.  The following flags indicate when the data transfer
   * happens.  That is, a rate interaction flag is set true when both rates
   * will run, and false otherwise.
   */

  /* tid 0 shares data with slower tid rates: 2, 3 */
  quadripulse_controller14_M->Timing.RateInteraction.TID0_2 =
    (quadripulse_controller14_M->Timing.TaskCounters.TID[2] == 0);

  /* update PerTaskSampleHits matrix for non-inline sfcn */
  quadripulse_controller14_M->Timing.perTaskSampleHits[2] =
    quadripulse_controller14_M->Timing.RateInteraction.TID0_2;
  quadripulse_controller14_M->Timing.RateInteraction.TID0_3 =
    (quadripulse_controller14_M->Timing.TaskCounters.TID[3] == 0);

  /* update PerTaskSampleHits matrix for non-inline sfcn */
  quadripulse_controller14_M->Timing.perTaskSampleHits[3] =
    quadripulse_controller14_M->Timing.RateInteraction.TID0_3;

  /* Compute which subrates run during the next base time step.  Subrates
   * are an integer multiple of the base rate counter.  Therefore, the subtask
   * counter is reset when it reaches its limit (zero means run).
   */
  (quadripulse_controller14_M->Timing.TaskCounters.TID[1])++;
  if ((quadripulse_controller14_M->Timing.TaskCounters.TID[1]) > 9) {/* Sample time: [0.01s, 0.0s] */
    quadripulse_controller14_M->Timing.TaskCounters.TID[1] = 0;
  }

  (quadripulse_controller14_M->Timing.TaskCounters.TID[2])++;
  if ((quadripulse_controller14_M->Timing.TaskCounters.TID[2]) > 99) {/* Sample time: [0.1s, 0.0s] */
    quadripulse_controller14_M->Timing.TaskCounters.TID[2] = 0;
  }

  (quadripulse_controller14_M->Timing.TaskCounters.TID[3])++;
  if ((quadripulse_controller14_M->Timing.TaskCounters.TID[3]) > 499) {/* Sample time: [0.5s, 0.0s] */
    quadripulse_controller14_M->Timing.TaskCounters.TID[3] = 0;
  }
}

void MWDSPCG_FFT_Interleave_R2BR_D(const real_T x[], creal_T y[], int32_T nChans,
  int32_T nRows)
{
  int32_T br_j;
  int32_T yIdx;
  int32_T uIdx;
  int32_T j;
  int32_T nChansBy2;
  int32_T bit_fftLen;

  /* S-Function (sdspfft2): '<S30>/FFT' */
  /* Bit-reverses the input data simultaneously with the interleaving operation,
     obviating the need for explicit data reordering later.  This requires an
     FFT with bit-reversed inputs.
   */
  br_j = 0;
  yIdx = 0;
  uIdx = 0;
  for (nChansBy2 = nChans >> 1; nChansBy2 != 0; nChansBy2--) {
    for (j = nRows; j - 1 > 0; j--) {
      y[yIdx + br_j].re = x[uIdx];
      y[yIdx + br_j].im = x[uIdx + nRows];
      uIdx++;

      /* Compute next bit-reversed destination index */
      bit_fftLen = nRows;
      do {
        bit_fftLen = (int32_T)((uint32_T)bit_fftLen >> 1);
        br_j ^= bit_fftLen;
      } while (!((br_j & bit_fftLen) != 0));
    }

    y[yIdx + br_j].re = x[uIdx];
    y[yIdx + br_j].im = x[uIdx + nRows];
    uIdx = (uIdx + nRows) + 1;
    yIdx += nRows << 1;
    br_j = 0;
  }

  /* For an odd number of channels, prepare the last channel
     for a double-length real signal algorithm.  No actual
     interleaving is required, just a copy of the last column
     of real data, but now placed in bit-reversed order.
     We need to cast the real u pointer to a cDType_T pointer,
     in order to fake the interleaving, and cut the number
     of elements in half (half as many complex interleaved
     elements as compared to real non-interleaved elements).
   */
  if ((nChans & 1) != 0) {
    for (j = nRows >> 1; j - 1 > 0; j--) {
      y[yIdx + br_j].re = x[uIdx];
      y[yIdx + br_j].im = x[uIdx + 1];
      uIdx += 2;

      /* Compute next bit-reversed destination index */
      bit_fftLen = nRows >> 1;
      do {
        bit_fftLen = (int32_T)((uint32_T)bit_fftLen >> 1);
        br_j ^= bit_fftLen;
      } while (!((br_j & bit_fftLen) != 0));
    }

    y[yIdx + br_j].re = x[uIdx];
    y[yIdx + br_j].im = x[uIdx + 1];
  }

  /* End of S-Function (sdspfft2): '<S30>/FFT' */
}

void MWDSPCG_R2DIT_TBLS_Z(creal_T y[], int32_T nChans, int32_T nRows, int32_T
  fftLen, int32_T offset, const real_T tablePtr[], int32_T twiddleStep,
  boolean_T isInverse)
{
  int32_T nHalf;
  real_T twidRe;
  real_T twidIm;
  int32_T nQtr;
  int32_T fwdInvFactor;
  int32_T iCh;
  int32_T offsetCh;
  int32_T idelta;
  int32_T ix;
  int32_T k;
  int32_T kratio;
  int32_T istart;
  int32_T i1;
  int32_T j;
  int32_T i2;
  real_T tmp_re;
  real_T tmp_im;

  /* S-Function (sdspfft2): '<S30>/FFT' */
  /* DSP System Toolbox Decimation in Time FFT  */
  /* Computation performed using table lookup  */
  /* Output type: complex real_T */
  nHalf = fftLen >> 1;
  nHalf *= twiddleStep;
  nQtr = nHalf >> 1;
  fwdInvFactor = isInverse ? -1 : 1;

  /* For each channel */
  offsetCh = offset;
  for (iCh = 0; iCh < nChans; iCh++) {
    /* Perform butterflies for the first stage, where no multiply is required. */
    for (ix = offsetCh; ix < (fftLen + offsetCh) - 1; ix += 2) {
      i2 = ix + 1;
      tmp_re = y[i2].re;
      tmp_im = y[i2].im;
      y[i2].re = y[ix].re - tmp_re;
      y[i2].im = y[ix].im - tmp_im;
      y[ix].re += tmp_re;
      y[ix].im += tmp_im;
    }

    idelta = 2;
    k = fftLen >> 2;
    kratio = k * twiddleStep;
    while (k > 0) {
      istart = offsetCh;
      i1 = istart;

      /* Perform the first butterfly in each remaining stage, where no multiply is required. */
      for (ix = 0; ix < k; ix++) {
        i2 = i1 + idelta;
        tmp_re = y[i2].re;
        tmp_im = y[i2].im;
        y[i2].re = y[i1].re - tmp_re;
        y[i2].im = y[i1].im - tmp_im;
        y[i1].re += tmp_re;
        y[i1].im += tmp_im;
        i1 += idelta << 1;
      }

      /* Perform remaining butterflies */
      for (j = kratio; j < nHalf; j += kratio) {
        i1 = istart + 1;
        twidRe = tablePtr[j];
        twidIm = tablePtr[j + nQtr] * (real_T)fwdInvFactor;
        for (ix = 0; ix < k; ix++) {
          i2 = i1 + idelta;
          tmp_re = y[i2].re * twidRe - y[i2].im * twidIm;
          tmp_im = y[i2].re * twidIm + y[i2].im * twidRe;
          y[i2].re = y[i1].re - tmp_re;
          y[i2].im = y[i1].im - tmp_im;
          y[i1].re += tmp_re;
          y[i1].im += tmp_im;
          i1 += idelta << 1;
        }

        istart++;
      }

      idelta <<= 1;
      k >>= 1;
      kratio >>= 1;
    }

    /* Point to next channel */
    offsetCh += nRows;
  }

  /* End of S-Function (sdspfft2): '<S30>/FFT' */
}

void MWDSPCG_FFT_DblLen_Z(creal_T y[], int32_T nChans, int32_T nRows, const
  real_T twiddleTable[], int32_T twiddleStep)
{
  real_T accRe;
  real_T tempOut0Im;
  real_T tempOut1Re;
  real_T tempOut1Im;
  real_T temp2Re;
  int32_T N2;
  int32_T N4;
  int32_T W4;
  int32_T yIdx;
  int32_T ix;
  int32_T k;
  real_T cTemp_im;

  /* S-Function (sdspfft2): '<S30>/FFT' */
  /* In-place "double-length" data recovery
     Table-based mem-optimized twiddle computation

     Used to recover linear-ordered length-N point complex FFT result
     from a linear-ordered complex length-N/2 point FFT, performed
     on N interleaved real values.
   */
  N2 = nRows >> 1;
  N4 = N2 >> 1;
  W4 = N4 * twiddleStep;
  yIdx = (nChans - 1) * nRows;
  if (nRows > 2) {
    temp2Re = y[N4 + yIdx].re;
    tempOut0Im = y[N4 + yIdx].im;
    y[(N2 + N4) + yIdx].re = temp2Re;
    y[(N2 + N4) + yIdx].im = tempOut0Im;
    y[N4 + yIdx].re = temp2Re;
    y[N4 + yIdx].im = -tempOut0Im;
  }

  if (nRows > 1) {
    accRe = y[yIdx].re;
    accRe -= y[yIdx].im;
    y[N2 + yIdx].re = accRe;
    y[N2 + yIdx].im = 0.0;
  }

  accRe = y[yIdx].re;
  accRe += y[yIdx].im;
  y[yIdx].re = accRe;
  y[yIdx].im = 0.0;
  k = twiddleStep;
  for (ix = 1; ix < N4; ix++) {
    accRe = y[ix + yIdx].re;
    accRe += y[(N2 - ix) + yIdx].re;
    accRe /= 2.0;
    temp2Re = accRe;
    accRe = y[ix + yIdx].im;
    accRe -= y[(N2 - ix) + yIdx].im;
    accRe /= 2.0;
    tempOut0Im = accRe;
    accRe = y[ix + yIdx].im;
    accRe += y[(N2 - ix) + yIdx].im;
    accRe /= 2.0;
    tempOut1Re = accRe;
    accRe = y[(N2 - ix) + yIdx].re;
    accRe -= y[ix + yIdx].re;
    accRe /= 2.0;
    y[ix + yIdx].re = tempOut1Re;
    y[ix + yIdx].im = accRe;
    accRe = y[ix + yIdx].re * twiddleTable[k] - -twiddleTable[W4 - k] * y[ix +
      yIdx].im;
    cTemp_im = y[ix + yIdx].im * twiddleTable[k] + -twiddleTable[W4 - k] * y[ix
      + yIdx].re;
    tempOut1Re = accRe;
    tempOut1Im = cTemp_im;
    accRe = temp2Re;
    cTemp_im = tempOut0Im;
    accRe += tempOut1Re;
    cTemp_im += tempOut1Im;
    y[ix + yIdx].re = accRe;
    y[ix + yIdx].im = cTemp_im;
    accRe = y[ix + yIdx].re;
    cTemp_im = -y[ix + yIdx].im;
    y[(nRows - ix) + yIdx].re = accRe;
    y[(nRows - ix) + yIdx].im = cTemp_im;
    accRe = temp2Re;
    cTemp_im = tempOut0Im;
    accRe -= tempOut1Re;
    cTemp_im -= tempOut1Im;
    y[(N2 + ix) + yIdx].re = accRe;
    y[(N2 + ix) + yIdx].im = cTemp_im;
    temp2Re = y[(N2 + ix) + yIdx].re;
    tempOut0Im = y[(N2 + ix) + yIdx].im;
    y[(N2 - ix) + yIdx].re = temp2Re;
    y[(N2 - ix) + yIdx].im = -tempOut0Im;
    k += twiddleStep;
  }

  /* End of S-Function (sdspfft2): '<S30>/FFT' */
}

real_T rt_roundd_snf(real_T u)
{
  real_T y;
  if (fabs(u) < 4.503599627370496E+15) {
    if (u >= 0.5) {
      y = floor(u + 0.5);
    } else if (u > -0.5) {
      y = u * 0.0;
    } else {
      y = ceil(u - 0.5);
    }
  } else {
    y = u;
  }

  return y;
}

/* Model output function for TID0 */
static void quadripulse_controller14_output0(void) /* Sample time: [0.001s, 0.0s] */
{
  uint32_T count;
  real_T tmp[2];
  real_T u0[2];
  ZCEventType zcEvent;
  dsp_HighpassFilter_quadripuls_T *obj;
  dsp_HighpassFilter_quadripuls_T *obj_0;
  int8_T inputSize[8];
  dspcodegen_FIRFilter_quadripu_T *obj_1;
  dspcodegen_FIRFilter_quadripu_T *obj_2;
  dspcodegen_FIRFilter_quadripu_T *obj_3;
  dsp_FIRFilter_0_quadripulse_c_T *obj_4;
  int32_T j;
  uint8_T tmp_0;
  int32_T yIdx;
  int32_T colIdx;
  int32_T ix;
  boolean_T isIEven;
  int32_T offset;
  real_T acc;
  real_T Tmp;
  real_T rTmpA;
  real_T rTmpA1;
  real_T tmp_1;
  int32_T i;
  boolean_T exitg1;

  {                                    /* Sample time: [0.001s, 0.0s] */
    rate_monotonic_scheduler();
  }

  /* Reset subsysRan breadcrumbs */
  srClearBC(quadripulse_controller14_DW.TriggerGenerator_SubsysRanBC);

  /* Level2 S-Function Block: '<S19>/Buffer Mngmt ' (xpcnb) */
  {
    SimStruct *rts = quadripulse_controller14_M->childSfunctions[0];
    sfcnOutputs(rts, 0);
  }

  /* Level2 S-Function Block: '<S19>/Ethernet Init ' (xpcetherinit) */
  {
    SimStruct *rts = quadripulse_controller14_M->childSfunctions[1];
    sfcnOutputs(rts, 0);
  }

  /* Level2 S-Function Block: '<S19>/ARP Init ' (xpcdebugarpinit) */
  {
    SimStruct *rts = quadripulse_controller14_M->childSfunctions[2];
    sfcnOutputs(rts, 0);
  }

  /* Level2 S-Function Block: '<S19>/IP Init ' (xpcdebugipinit) */
  {
    SimStruct *rts = quadripulse_controller14_M->childSfunctions[3];
    sfcnOutputs(rts, 0);
  }

  /* Level2 S-Function Block: '<S19>/UDP Init ' (xpcdebugudpinit) */
  {
    SimStruct *rts = quadripulse_controller14_M->childSfunctions[4];
    sfcnOutputs(rts, 0);
  }

  /* ok to acquire for <S1>/S-Function */
  quadripulse_controller14_DW.SFunction_IWORK.AcquireOK = 1;

  /* ok to acquire for <S2>/S-Function */
  quadripulse_controller14_DW.SFunction_IWORK_e.AcquireOK = 1;

  /* ok to acquire for <S11>/S-Function */
  quadripulse_controller14_DW.SFunction_IWORK_b.AcquireOK = 1;

  /* ok to acquire for <S12>/S-Function */
  quadripulse_controller14_DW.SFunction_IWORK_n.AcquireOK = 1;

  /* ok to acquire for <S13>/S-Function */
  quadripulse_controller14_DW.SFunction_IWORK_j.AcquireOK = 1;

  /* ok to acquire for <S14>/S-Function */
  quadripulse_controller14_DW.SFunction_IWORK_np.AcquireOK = 1;

  /* ok to acquire for <S15>/S-Function */
  quadripulse_controller14_DW.SFunction_IWORK_k.AcquireOK = 1;

  /* ok to acquire for <S18>/S-Function */
  quadripulse_controller14_DW.SFunction_IWORK_o.AcquireOK = 1;

  /* Reshape: '<Root>/Row1' incorporates:
   *  Constant: '<Root>/Constant1'
   */
  memcpy(&quadripulse_controller14_B.Row1[0],
         &quadripulse_controller14_P.spatial_filter[0], 65U * sizeof(real_T));

  /* Level2 S-Function Block: '<S50>/UDP Rx 1' (xpcudprx) */
  {
    SimStruct *rts = quadripulse_controller14_M->childSfunctions[5];
    sfcnOutputs(rts, 0);
  }

  /* Level2 S-Function Block: '<S50>/Buffer 1' (xpcnbbuffer) */
  {
    SimStruct *rts = quadripulse_controller14_M->childSfunctions[6];
    sfcnOutputs(rts, 0);
  }

  /* Level2 S-Function Block: '<S50>/UDP Consume 1' (xpcudpconsume) */
  {
    SimStruct *rts = quadripulse_controller14_M->childSfunctions[7];
    sfcnOutputs(rts, 0);
  }

  /* Level2 S-Function Block: '<S50>/Extract 1' (xpcnbextract) */
  {
    SimStruct *rts = quadripulse_controller14_M->childSfunctions[8];
    sfcnOutputs(rts, 0);
  }

  /* Reshape: '<S27>/Reshape' */
  memcpy(&quadripulse_controller14_B.Reshape_p[0],
         &quadripulse_controller14_B.Extract1_o1[28], 990U * sizeof(uint8_T));
  for (j = 0; j < 330; j++) {
    /* DSPFlip: '<S27>/Flip' */
    offset = 3 * j;
    ix = 2 + offset;
    tmp_0 = quadripulse_controller14_B.Reshape_p[offset];
    quadripulse_controller14_B.Flip_b[offset] =
      quadripulse_controller14_B.Reshape_p[ix];
    quadripulse_controller14_B.Flip_b[ix] = tmp_0;
    offset++;
    ix--;
    tmp_0 = quadripulse_controller14_B.Reshape_p[offset];
    quadripulse_controller14_B.Flip_b[offset] =
      quadripulse_controller14_B.Reshape_p[ix];
    quadripulse_controller14_B.Flip_b[ix] = tmp_0;

    /* Concatenate: '<S27>/Matrix Concatenate' incorporates:
     *  Constant: '<S27>/Constant'
     */
    quadripulse_controller14_B.MatrixConcatenate[j << 2] =
      quadripulse_controller14_P.Constant_Value_c[j];
    quadripulse_controller14_B.MatrixConcatenate[1 + (j << 2)] =
      quadripulse_controller14_B.Flip_b[3 * j];
    quadripulse_controller14_B.MatrixConcatenate[2 + (j << 2)] =
      quadripulse_controller14_B.Flip_b[3 * j + 1];
    quadripulse_controller14_B.MatrixConcatenate[3 + (j << 2)] =
      quadripulse_controller14_B.Flip_b[3 * j + 2];
  }

  /* Byte Unpacking: <S27>/Byte Unpacking  */
  (void)memcpy((uint8_T*)&quadripulse_controller14_B.ByteUnpacking[0], (uint8_T*)
               &quadripulse_controller14_B.MatrixConcatenate[0] + 0, 1320);
  for (i = 0; i < 330; i++) {
    /* DataTypeConversion: '<S27>/Data Type Conversion' */
    quadripulse_controller14_B.DataTypeConversion[i] =
      quadripulse_controller14_B.ByteUnpacking[i];

    /* Gain: '<S27>/Gain' */
    quadripulse_controller14_B.Gain[i] = quadripulse_controller14_P.Gain_Gain_p *
      quadripulse_controller14_B.DataTypeConversion[i];

    /* Reshape: '<S27>/Reshape2' */
    quadripulse_controller14_B.Reshape2[i] = quadripulse_controller14_B.Gain[i];
  }

  /* Math: '<S27>/Math Function' */
  for (yIdx = 0; yIdx < 66; yIdx++) {
    for (j = 0; j < 5; j++) {
      quadripulse_controller14_B.MathFunction[j + 5 * yIdx] =
        quadripulse_controller14_B.Reshape2[66 * j + yIdx];
    }
  }

  /* End of Math: '<S27>/Math Function' */
  /* Communications System Toolbox: Derepeat (scomdrpt2) - '<Root>/Derepeat' */
  {
    int32_T *counter = &quadripulse_controller14_DW.Derepeat_Count;
    int32_T c;
    const real_T *inSig = &quadripulse_controller14_B.MathFunction[0];
    real_T *outSig = &quadripulse_controller14_B.Derepeat[0];
    real_T *outBuf = (real_T *)quadripulse_controller14_DW.Derepeat_PWORK.OutBuf;
    int_T n;
    for (n = 0; n < 66; n++) {
      int_T i;
      c = *counter;
      for (i = 0; i< 5; i++) {
        if (c++ ==0)
          *outBuf = *inSig++;
        else
          *outBuf += *inSig++;
        if (c == 5) {
          c = 0;
          *outSig++ = *outBuf / 5;
        }
      }

      outBuf++;
    }

    *counter = c;

    {
      real_T *aBuf = &quadripulse_controller14_DW.Derepeat_Buffer[0];
      if (outBuf == aBuf + 66)
        outBuf = aBuf;
      quadripulse_controller14_DW.Derepeat_PWORK.OutBuf = outBuf;
    }
  }

  /* Reshape: '<Root>/Reshape1' */
  memcpy(&quadripulse_controller14_B.Reshape1[0],
         &quadripulse_controller14_B.Derepeat[0], 66U * sizeof(real_T));

  /* SignalConversion: '<S3>/TmpSignal ConversionAtMeanInport1' incorporates:
   *  Constant: '<S3>/Constant'
   */
  memcpy(&quadripulse_controller14_B.TmpSignalConversionAtMeanInport[0],
         &quadripulse_controller14_B.Reshape1[0], sizeof(real_T) << 6U);
  quadripulse_controller14_B.TmpSignalConversionAtMeanInport[64] =
    quadripulse_controller14_P.Constant_Value;

  /* S-Function (sdspstatfcns): '<S3>/Mean' */
  for (colIdx = 0; colIdx < 65; colIdx += 65) {
    for (j = colIdx; j < colIdx + 1; j++) {
      quadripulse_controller14_DW.Mean_AccVal =
        quadripulse_controller14_B.TmpSignalConversionAtMeanInport[j];
      ix = 65;
      offset = 1;
      while (ix - 1 > 0) {
        i = j + offset;
        quadripulse_controller14_DW.Mean_AccVal +=
          quadripulse_controller14_B.TmpSignalConversionAtMeanInport[i];
        offset++;
        ix--;
      }

      quadripulse_controller14_B.Mean = quadripulse_controller14_DW.Mean_AccVal /
        65.0;
    }
  }

  /* End of S-Function (sdspstatfcns): '<S3>/Mean' */

  /* Product: '<Root>/Product' */
  tmp_1 = 0.0;
  for (i = 0; i < 65; i++) {
    /* Sum: '<S3>/Subtract' */
    quadripulse_controller14_B.Subtract[i] =
      quadripulse_controller14_B.TmpSignalConversionAtMeanInport[i] -
      quadripulse_controller14_B.Mean;

    /* Reshape: '<Root>/Row' */
    quadripulse_controller14_B.Row[i] = quadripulse_controller14_B.Subtract[i];

    /* Product: '<Root>/Product' */
    acc = quadripulse_controller14_B.Row1[i];
    Tmp = quadripulse_controller14_B.Row[i];
    tmp_1 += acc * Tmp;
  }

  /* Product: '<Root>/Product' */
  quadripulse_controller14_B.Product = tmp_1;

  /* Buffer: '<Root>/Buffer' */
  j = 511 - quadripulse_controller14_DW.Buffer_CircBufIdx;
  ix = quadripulse_controller14_DW.Buffer_CircBufIdx;
  for (colIdx = 0; colIdx < j; colIdx++) {
    quadripulse_controller14_B.Buffer[colIdx] =
      quadripulse_controller14_DW.Buffer_CircBuff[ix + colIdx];
  }

  yIdx = j;
  for (colIdx = 0; colIdx < quadripulse_controller14_DW.Buffer_CircBufIdx;
       colIdx++) {
    quadripulse_controller14_B.Buffer[yIdx + colIdx] =
      quadripulse_controller14_DW.Buffer_CircBuff[colIdx];
  }

  yIdx -= j;
  quadripulse_controller14_B.Buffer[yIdx + 511] =
    quadripulse_controller14_B.Product;
  ix = quadripulse_controller14_DW.Buffer_CircBufIdx;
  quadripulse_controller14_DW.Buffer_CircBuff[ix] =
    quadripulse_controller14_B.Product;
  quadripulse_controller14_DW.Buffer_CircBufIdx++;
  if (quadripulse_controller14_DW.Buffer_CircBufIdx >= 511) {
    quadripulse_controller14_DW.Buffer_CircBufIdx -= 511;
  }

  /* End of Buffer: '<Root>/Buffer' */

  /* S-Function (sdspstatfcns): '<S9>/Mean' */
  for (colIdx = 0; colIdx < 512; colIdx += 512) {
    for (j = colIdx; j < colIdx + 1; j++) {
      quadripulse_controller14_DW.Mean_AccVal_d =
        quadripulse_controller14_B.Buffer[j];
      ix = 512;
      offset = 1;
      while (ix - 1 > 0) {
        i = j + offset;
        quadripulse_controller14_DW.Mean_AccVal_d +=
          quadripulse_controller14_B.Buffer[i];
        offset++;
        ix--;
      }

      quadripulse_controller14_B.Mean_d =
        quadripulse_controller14_DW.Mean_AccVal_d / 512.0;
    }
  }

  /* End of S-Function (sdspstatfcns): '<S9>/Mean' */

  /* Sum: '<S9>/Subtract' */
  for (i = 0; i < 512; i++) {
    quadripulse_controller14_B.Subtract_i[i] =
      quadripulse_controller14_B.Buffer[i] - quadripulse_controller14_B.Mean_d;
  }

  /* End of Sum: '<S9>/Subtract' */

  /* DiscreteFir: '<S17>/FIR Bandpass Filter Forward' */
  /* Consume delay line and beginning of input samples */
  for (colIdx = 0; colIdx < 128; colIdx++) {
    tmp_1 = 0.0;
    for (j = 0; j < colIdx + 1; j++) {
      acc = quadripulse_controller14_B.Subtract_i[colIdx - j] *
        quadripulse_controller14_P.fir_filter_coefficients[j];
      tmp_1 += acc;
    }

    for (j = 0; j < 128 - colIdx; j++) {
      acc = quadripulse_controller14_P.fir_filter_coefficients[(colIdx + j) + 1]
        * quadripulse_controller14_DW.FIRBandpassFilterForward_states[j];
      tmp_1 += acc;
    }

    quadripulse_controller14_B.FIRBandpassFilterForward[colIdx] = tmp_1;
  }

  /* Consume remaining input samples */
  while (colIdx < 512) {
    tmp_1 = 0.0;
    for (j = 0; j < 129; j++) {
      acc = quadripulse_controller14_B.Subtract_i[colIdx - j] *
        quadripulse_controller14_P.fir_filter_coefficients[j];
      tmp_1 += acc;
    }

    quadripulse_controller14_B.FIRBandpassFilterForward[colIdx] = tmp_1;
    colIdx++;
  }

  /* Update delay line for next frame */
  for (colIdx = 0; colIdx < 128; colIdx++) {
    quadripulse_controller14_DW.FIRBandpassFilterForward_states[127 - colIdx] =
      quadripulse_controller14_B.Subtract_i[colIdx + 384];
  }

  /* End of DiscreteFir: '<S17>/FIR Bandpass Filter Forward' */

  /* DSPFlip: '<S17>/Flip' */
  for (colIdx = 0; colIdx < 256; colIdx++) {
    offset = 511 - colIdx;
    tmp_1 = quadripulse_controller14_B.FIRBandpassFilterForward[colIdx];
    quadripulse_controller14_B.Flip[colIdx] =
      quadripulse_controller14_B.FIRBandpassFilterForward[offset];
    quadripulse_controller14_B.Flip[offset] = tmp_1;
  }

  /* End of DSPFlip: '<S17>/Flip' */

  /* DiscreteFir: '<S17>/FIR Bandpass Filter Backward' */
  /* Consume delay line and beginning of input samples */
  for (colIdx = 0; colIdx < 128; colIdx++) {
    tmp_1 = 0.0;
    for (j = 0; j < colIdx + 1; j++) {
      acc = quadripulse_controller14_B.Flip[colIdx - j] *
        quadripulse_controller14_P.fir_filter_coefficients[j];
      tmp_1 += acc;
    }

    for (j = 0; j < 128 - colIdx; j++) {
      acc = quadripulse_controller14_P.fir_filter_coefficients[(colIdx + j) + 1]
        * quadripulse_controller14_DW.FIRBandpassFilterBackward_state[j];
      tmp_1 += acc;
    }

    quadripulse_controller14_B.FIRBandpassFilterBackward[colIdx] = tmp_1;
  }

  /* Consume remaining input samples */
  while (colIdx < 512) {
    tmp_1 = 0.0;
    for (j = 0; j < 129; j++) {
      acc = quadripulse_controller14_B.Flip[colIdx - j] *
        quadripulse_controller14_P.fir_filter_coefficients[j];
      tmp_1 += acc;
    }

    quadripulse_controller14_B.FIRBandpassFilterBackward[colIdx] = tmp_1;
    colIdx++;
  }

  /* Update delay line for next frame */
  for (colIdx = 0; colIdx < 128; colIdx++) {
    quadripulse_controller14_DW.FIRBandpassFilterBackward_state[127 - colIdx] =
      quadripulse_controller14_B.Flip[colIdx + 384];
  }

  /* End of DiscreteFir: '<S17>/FIR Bandpass Filter Backward' */

  /* DSPFlip: '<S17>/Re-Flip' */
  for (colIdx = 0; colIdx < 256; colIdx++) {
    offset = 511 - colIdx;
    tmp_1 = quadripulse_controller14_B.FIRBandpassFilterBackward[colIdx];
    quadripulse_controller14_B.ReFlip[colIdx] =
      quadripulse_controller14_B.FIRBandpassFilterBackward[offset];
    quadripulse_controller14_B.ReFlip[offset] = tmp_1;
  }

  /* End of DSPFlip: '<S17>/Re-Flip' */

  /* S-Function (sdspsubmtrx): '<Root>/Remove Edges (first & last 64)' */
  memcpy(&quadripulse_controller14_B.RemoveEdgesfirstlast64[0],
         &quadripulse_controller14_B.ReFlip[64], 384U * sizeof(real_T));

  /* S-Function (sdspacf2): '<S42>/Autocorrelation' */
  j = 0;
  for (colIdx = 0; colIdx < 31; colIdx++) {
    Tmp = 0.0;
    offset = 0;
    ix = colIdx;
    i = 384 - colIdx;
    for (yIdx = 0; yIdx < i; yIdx++) {
      Tmp += quadripulse_controller14_B.RemoveEdgesfirstlast64[offset] *
        quadripulse_controller14_B.RemoveEdgesfirstlast64[ix];
      offset++;
      ix++;
    }

    quadripulse_controller14_B.Autocorrelation[j] = Tmp / 384.0;
    j++;
  }

  /* End of S-Function (sdspacf2): '<S42>/Autocorrelation' */

  /* S-Function (sdsplevdurb2): '<S42>/Levinson-Durbin' */
  j = 0;
  yIdx = 0;
  if (quadripulse_controller14_B.Autocorrelation[0] == 0.0) {
    quadripulse_controller14_B.LevinsonDurbin_o1[0] = 1.0;
    for (colIdx = 0; colIdx < 30; colIdx++) {
      quadripulse_controller14_B.LevinsonDurbin_o1[j + 1] = 0.0;
      j++;
    }

    quadripulse_controller14_B.LevinsonDurbin_o2 = 0.0;
  } else {
    isIEven = false;
    tmp_1 = quadripulse_controller14_B.Autocorrelation[0];
    for (colIdx = 0; colIdx < 30; colIdx++) {
      offset = colIdx + 1;
      acc = quadripulse_controller14_B.Autocorrelation[offset];
      i = 1;
      j = colIdx + 1;
      offset = 1;
      ix = colIdx + 1;
      ix--;
      while (i < j) {
        rTmpA1 = quadripulse_controller14_B.LevinsonDurbin_o1[offset] *
          quadripulse_controller14_B.Autocorrelation[ix];
        acc += rTmpA1;
        offset++;
        ix--;
        i++;
      }

      Tmp = 1.0 / tmp_1;
      Tmp = -Tmp;
      Tmp *= acc;
      acc = 1.0 - Tmp * Tmp;
      tmp_1 *= acc;
      i = 1;
      offset = 1;
      j = (j - 1) >> 1;
      ix = colIdx + 1;
      ix--;
      while (i <= j) {
        rTmpA = quadripulse_controller14_B.LevinsonDurbin_o1[offset];
        acc = quadripulse_controller14_B.LevinsonDurbin_o1[offset];
        rTmpA1 = quadripulse_controller14_B.LevinsonDurbin_o1[ix];
        rTmpA1 *= Tmp;
        acc += rTmpA1;
        quadripulse_controller14_B.LevinsonDurbin_o1[offset] = acc;
        acc = quadripulse_controller14_B.LevinsonDurbin_o1[ix];
        rTmpA1 = Tmp * rTmpA;
        acc += rTmpA1;
        quadripulse_controller14_B.LevinsonDurbin_o1[ix] = acc;
        offset++;
        ix--;
        i++;
      }

      if (isIEven) {
        offset = (colIdx + 1) >> 1;
        acc = quadripulse_controller14_B.LevinsonDurbin_o1[offset];
        rTmpA1 = quadripulse_controller14_B.LevinsonDurbin_o1[offset];
        rTmpA1 *= Tmp;
        acc += rTmpA1;
        quadripulse_controller14_B.LevinsonDurbin_o1[offset] = acc;
      }

      isIEven = !isIEven;
      offset = colIdx + 1;
      quadripulse_controller14_B.LevinsonDurbin_o1[offset] = Tmp;
    }

    quadripulse_controller14_B.LevinsonDurbin_o1[0] = 1.0;
    quadripulse_controller14_B.LevinsonDurbin_o2 = tmp_1;
  }

  /* End of S-Function (sdsplevdurb2): '<S42>/Levinson-Durbin' */

  /* Outputs for Iterator SubSystem: '<S41>/Forecast' incorporates:
   *  ForIterator: '<S43>/For Iterator'
   */
  for (j = 1; j <= quadripulse_controller14_P.ForIterator_IterationLimit; j++) {
    quadripulse_controller14_B.ForIterator = j;

    /* Sum: '<S43>/Add' */
    quadripulse_controller14_B.Add_d = ((real_T)
      quadripulse_controller14_B.ForIterator -
      quadripulse_controller14_B.NumberofCoefficients) +
      quadripulse_controller14_B.FrameLength;

    /* UnitDelay: '<S43>/Unit Delay' */
    quadripulse_controller14_B.UnitDelay =
      quadripulse_controller14_DW.UnitDelay_DSTATE;

    /* UnitDelay: '<S43>/Unit Delay1' */
    quadripulse_controller14_B.UnitDelay1 =
      quadripulse_controller14_DW.UnitDelay1_DSTATE;

    /* Saturate: '<S43>/Saturation' */
    colIdx = quadripulse_controller14_B.UnitDelay1;
    offset = quadripulse_controller14_P.Saturation_LowerSat;
    i = quadripulse_controller14_P.Forecastof128samples_num_iterat;
    if (colIdx > i) {
      quadripulse_controller14_B.Saturation = i;
    } else if (colIdx < offset) {
      quadripulse_controller14_B.Saturation = offset;
    } else {
      quadripulse_controller14_B.Saturation = colIdx;
    }

    /* End of Saturate: '<S43>/Saturation' */

    /* Assignment: '<S43>/Assignment' */
    quadripulse_controller14_B.Assignment[quadripulse_controller14_B.Saturation
      - 1] = quadripulse_controller14_B.UnitDelay;

    /* S-Function (sdspsubmtrx): '<S43>/Second to Last' */
    memcpy(&quadripulse_controller14_B.SecondtoLast[0],
           &quadripulse_controller14_B.LevinsonDurbin_o1[1], 30U * sizeof(real_T));

    /* DSPFlip: '<S43>/Flip' */
    for (colIdx = 0; colIdx < 15; colIdx++) {
      offset = 29 - colIdx;
      tmp_1 = quadripulse_controller14_B.SecondtoLast[colIdx];
      quadripulse_controller14_B.Flip_a[colIdx] =
        quadripulse_controller14_B.SecondtoLast[offset];
      quadripulse_controller14_B.Flip_a[offset] = tmp_1;
    }

    /* End of DSPFlip: '<S43>/Flip' */

    /* SignalConversion: '<S43>/TmpSignal ConversionAtVariable SelectorInport1' */
    memcpy(&quadripulse_controller14_B.TmpSignalConversionAtVariableSe[0],
           &quadripulse_controller14_B.RemoveEdgesfirstlast64[0], 384U * sizeof
           (real_T));
    memcpy(&quadripulse_controller14_B.TmpSignalConversionAtVariableSe[384],
           &quadripulse_controller14_B.Assignment[0], sizeof(real_T) << 7U);

    /* DotProduct: '<S43>/Dot Product' */
    tmp_1 = 0.0;
    for (i = 0; i < 30; i++) {
      /* Sum: '<S43>/Sum1' */
      quadripulse_controller14_B.Sum1_k[i] = quadripulse_controller14_B.Add_d +
        quadripulse_controller14_ConstB.ConstantRamp_i[i];

      /* S-Function (sdspperm2): '<S43>/Variable Selector' */
      offset = (int32_T)floor(quadripulse_controller14_B.Sum1_k[i]) - 1;
      if (offset < 0) {
        offset = 0;
      } else {
        if (offset >= 512) {
          offset = 511;
        }
      }

      quadripulse_controller14_B.VariableSelector[i] =
        quadripulse_controller14_B.TmpSignalConversionAtVariableSe[offset];

      /* End of S-Function (sdspperm2): '<S43>/Variable Selector' */

      /* DotProduct: '<S43>/Dot Product' */
      acc = quadripulse_controller14_B.VariableSelector[i];
      Tmp = quadripulse_controller14_B.Flip_a[i];
      tmp_1 += acc * Tmp;
    }

    /* DotProduct: '<S43>/Dot Product' */
    quadripulse_controller14_B.DotProduct_n = tmp_1;

    /* S-Function (sdspsubmtrx): '<S43>/First Element' */
    quadripulse_controller14_B.FirstElement =
      quadripulse_controller14_B.LevinsonDurbin_o1[0];

    /* Sum: '<S43>/Sum' */
    quadripulse_controller14_B.Sum_e = 0.0 -
      quadripulse_controller14_B.DotProduct_n;

    /* Update for UnitDelay: '<S43>/Unit Delay' */
    quadripulse_controller14_DW.UnitDelay_DSTATE =
      quadripulse_controller14_B.Sum_e;

    /* Update for UnitDelay: '<S43>/Unit Delay1' */
    quadripulse_controller14_DW.UnitDelay1_DSTATE =
      quadripulse_controller14_B.ForIterator;
  }

  /* End of Outputs for SubSystem: '<S41>/Forecast' */

  /* S-Function (sdspsubmtrx): '<Root>/Now' */
  quadripulse_controller14_B.Now = quadripulse_controller14_B.Assignment[64];

  /* UnitDelay: '<S46>/UD' */
  quadripulse_controller14_B.Uk1 = quadripulse_controller14_DW.UD_DSTATE;

  /* RateTransition: '<Root>/Rate Transition1' */
  quadripulse_controller14_B.RateTransition1 = quadripulse_controller14_B.Mean_l;

  /* UnitDelay: '<Root>/Unit Delay' */
  quadripulse_controller14_B.UnitDelay_b =
    quadripulse_controller14_DW.UnitDelay_DSTATE_m;

  /* UnitDelay: '<S39>/Unit Delay' */
  quadripulse_controller14_B.UnitDelay_n =
    quadripulse_controller14_DW.UnitDelay_DSTATE_b;

  /* Switch: '<S39>/Set Counter Switch' */
  if (quadripulse_controller14_B.UnitDelay_b) {
    /* SampleTimeMath: '<S39>/Weighted Sample Time'
     *
     * About '<S39>/Weighted Sample Time':
     *  y = K where K = 1 / ( w * Ts )
     */
    quadripulse_controller14_B.WeightedSampleTime =
      quadripulse_controller14_P.WeightedSampleTime_WtEt;

    /* Gain: '<S39>/Seconds' */
    quadripulse_controller14_B.Seconds = (uint32_T)
      quadripulse_controller14_P.Seconds_Gain *
      quadripulse_controller14_B.WeightedSampleTime;

    /* DataTypeConversion: '<S39>/Data Type Conversion' */
    quadripulse_controller14_B.DataTypeConversion_k = (int32_T)
      (quadripulse_controller14_B.Seconds >> 12);
    quadripulse_controller14_B.SetCounterSwitch =
      quadripulse_controller14_B.DataTypeConversion_k;
  } else {
    /* Sum: '<S39>/Sum' incorporates:
     *  Constant: '<S39>/One'
     */
    quadripulse_controller14_B.Sum_n = quadripulse_controller14_B.UnitDelay_n -
      quadripulse_controller14_P.One_Value;
    quadripulse_controller14_B.SetCounterSwitch =
      quadripulse_controller14_B.Sum_n;
  }

  /* End of Switch: '<S39>/Set Counter Switch' */

  /* Switch: '<S39>/Keep Postive Switch' incorporates:
   *  Constant: '<S39>/Zero'
   */
  if (quadripulse_controller14_B.SetCounterSwitch >=
      quadripulse_controller14_P.KeepPostiveSwitch_Threshold) {
    quadripulse_controller14_B.KeepPostiveSwitch =
      quadripulse_controller14_B.SetCounterSwitch;
  } else {
    quadripulse_controller14_B.KeepPostiveSwitch =
      quadripulse_controller14_P.Zero_Value_f;
  }

  /* End of Switch: '<S39>/Keep Postive Switch' */

  /* RelationalOperator: '<S40>/Compare' incorporates:
   *  Constant: '<S40>/Constant'
   */
  quadripulse_controller14_B.Compare =
    (quadripulse_controller14_B.KeepPostiveSwitch ==
     quadripulse_controller14_P.Constant_Value_j);

  /* RateTransition: '<S23>/Rate Transition' */
  if (quadripulse_controller14_M->Timing.RateInteraction.TID0_2) {
    quadripulse_controller14_B.RateTransition_j =
      quadripulse_controller14_B.Compare;
  }

  /* End of RateTransition: '<S23>/Rate Transition' */

  /* RateTransition: '<Root>/Rate Transition3' */
  quadripulse_controller14_B.RateTransition3[0] =
    quadripulse_controller14_B.Reshape1_a[0];

  /* ManualSwitch: '<Root>/Manual Switch' incorporates:
   *  Constant: '<Root>/Constant3'
   */
  if (quadripulse_controller14_P.ManualSwitch_CurrentSetting == 1) {
    quadripulse_controller14_B.ManualSwitch[0] =
      quadripulse_controller14_P.amplitudeinterval[0];
  } else {
    quadripulse_controller14_B.ManualSwitch[0] =
      quadripulse_controller14_B.RateTransition3[0];
  }

  /* RateTransition: '<Root>/Rate Transition3' */
  quadripulse_controller14_B.RateTransition3[1] =
    quadripulse_controller14_B.Reshape1_a[1];

  /* ManualSwitch: '<Root>/Manual Switch' incorporates:
   *  Constant: '<Root>/Constant3'
   */
  if (quadripulse_controller14_P.ManualSwitch_CurrentSetting == 1) {
    quadripulse_controller14_B.ManualSwitch[1] =
      quadripulse_controller14_P.amplitudeinterval[1];
  } else {
    quadripulse_controller14_B.ManualSwitch[1] =
      quadripulse_controller14_B.RateTransition3[1];
  }

  /* Switch: '<Root>/Switch' incorporates:
   *  Constant: '<Root>/Constant4'
   *  Constant: '<Root>/Reset1'
   */
  if (quadripulse_controller14_P.closedloopmode) {
    /* RelationalOperator: '<S25>/<= max' */
    quadripulse_controller14_B.max = (quadripulse_controller14_B.RateTransition1
      <= quadripulse_controller14_B.ManualSwitch[1]);

    /* RelationalOperator: '<S25>/>= min' */
    quadripulse_controller14_B.min = (quadripulse_controller14_B.RateTransition1
      >= quadripulse_controller14_B.ManualSwitch[0]);

    /* Logic: '<S25>/Within Range' */
    quadripulse_controller14_B.WithinRange = (quadripulse_controller14_B.min &&
      quadripulse_controller14_B.max);

    /* Sum: '<S46>/Diff' */
    quadripulse_controller14_B.Diff = quadripulse_controller14_B.Now -
      quadripulse_controller14_B.Uk1;

    /* HitCross: '<S45>/Hit  Crossing2' */
    zcEvent = rt_ZCFcn(RISING_ZERO_CROSSING,
                       &quadripulse_controller14_PrevZCX.HitCrossing2_Input_ZCE,
                       (quadripulse_controller14_B.Diff -
                        quadripulse_controller14_P.HitCrossing2_Offset));
    if (quadripulse_controller14_DW.HitCrossing2_MODE == 0) {
      if (zcEvent != NO_ZCEVENT) {
        quadripulse_controller14_B.HitCrossing2 =
          !quadripulse_controller14_B.HitCrossing2;
        quadripulse_controller14_DW.HitCrossing2_MODE = 1;
      } else {
        if (quadripulse_controller14_B.HitCrossing2 &&
            (quadripulse_controller14_B.Diff !=
             quadripulse_controller14_P.HitCrossing2_Offset)) {
          quadripulse_controller14_B.HitCrossing2 = false;
        }
      }
    } else {
      if (quadripulse_controller14_B.Diff !=
          quadripulse_controller14_P.HitCrossing2_Offset) {
        quadripulse_controller14_B.HitCrossing2 = false;
      }

      quadripulse_controller14_DW.HitCrossing2_MODE = 0;
    }

    /* End of HitCross: '<S45>/Hit  Crossing2' */

    /* HitCross: '<S45>/Hit  Crossing1' */
    zcEvent = rt_ZCFcn(FALLING_ZERO_CROSSING,
                       &quadripulse_controller14_PrevZCX.HitCrossing1_Input_ZCE,
                       (quadripulse_controller14_B.Now -
                        quadripulse_controller14_P.HitCrossing1_Offset));
    if (quadripulse_controller14_DW.HitCrossing1_MODE == 0) {
      if (zcEvent != NO_ZCEVENT) {
        quadripulse_controller14_B.HitCrossing1 =
          !quadripulse_controller14_B.HitCrossing1;
        quadripulse_controller14_DW.HitCrossing1_MODE = 1;
      } else {
        if (quadripulse_controller14_B.HitCrossing1 &&
            (quadripulse_controller14_B.Now !=
             quadripulse_controller14_P.HitCrossing1_Offset)) {
          quadripulse_controller14_B.HitCrossing1 = false;
        }
      }
    } else {
      if (quadripulse_controller14_B.Now !=
          quadripulse_controller14_P.HitCrossing1_Offset) {
        quadripulse_controller14_B.HitCrossing1 = false;
      }

      quadripulse_controller14_DW.HitCrossing1_MODE = 0;
    }

    /* End of HitCross: '<S45>/Hit  Crossing1' */

    /* HitCross: '<S45>/Hit  Crossing3' */
    zcEvent = rt_ZCFcn(FALLING_ZERO_CROSSING,
                       &quadripulse_controller14_PrevZCX.HitCrossing3_Input_ZCE,
                       (quadripulse_controller14_B.Diff -
                        quadripulse_controller14_P.HitCrossing3_Offset));
    if (quadripulse_controller14_DW.HitCrossing3_MODE == 0) {
      if (zcEvent != NO_ZCEVENT) {
        quadripulse_controller14_B.HitCrossing3 =
          !quadripulse_controller14_B.HitCrossing3;
        quadripulse_controller14_DW.HitCrossing3_MODE = 1;
      } else {
        if (quadripulse_controller14_B.HitCrossing3 &&
            (quadripulse_controller14_B.Diff !=
             quadripulse_controller14_P.HitCrossing3_Offset)) {
          quadripulse_controller14_B.HitCrossing3 = false;
        }
      }
    } else {
      if (quadripulse_controller14_B.Diff !=
          quadripulse_controller14_P.HitCrossing3_Offset) {
        quadripulse_controller14_B.HitCrossing3 = false;
      }

      quadripulse_controller14_DW.HitCrossing3_MODE = 0;
    }

    /* End of HitCross: '<S45>/Hit  Crossing3' */

    /* HitCross: '<S45>/Hit  Crossing' */
    zcEvent = rt_ZCFcn(RISING_ZERO_CROSSING,
                       &quadripulse_controller14_PrevZCX.HitCrossing_Input_ZCE_n,
                       (quadripulse_controller14_B.Now -
                        quadripulse_controller14_P.HitCrossing_Offset));
    if (quadripulse_controller14_DW.HitCrossing_MODE_m == 0) {
      if (zcEvent != NO_ZCEVENT) {
        quadripulse_controller14_B.HitCrossing_i =
          !quadripulse_controller14_B.HitCrossing_i;
        quadripulse_controller14_DW.HitCrossing_MODE_m = 1;
      } else {
        if (quadripulse_controller14_B.HitCrossing_i &&
            (quadripulse_controller14_B.Now !=
             quadripulse_controller14_P.HitCrossing_Offset)) {
          quadripulse_controller14_B.HitCrossing_i = false;
        }
      }
    } else {
      if (quadripulse_controller14_B.Now !=
          quadripulse_controller14_P.HitCrossing_Offset) {
        quadripulse_controller14_B.HitCrossing_i = false;
      }

      quadripulse_controller14_DW.HitCrossing_MODE_m = 0;
    }

    /* End of HitCross: '<S45>/Hit  Crossing' */

    /* MultiPortSwitch: '<S25>/Index Vector' incorporates:
     *  Constant: '<Root>/Constant2'
     *  Constant: '<S25>/Constant'
     */
    switch ((int32_T)quadripulse_controller14_P.phasecondition) {
     case 0:
      quadripulse_controller14_B.IndexVector =
        quadripulse_controller14_P.Constant_Value_l;
      break;

     case 1:
      quadripulse_controller14_B.IndexVector =
        quadripulse_controller14_B.HitCrossing_i;
      break;

     case 2:
      quadripulse_controller14_B.IndexVector =
        quadripulse_controller14_B.HitCrossing3;
      break;

     case 3:
      quadripulse_controller14_B.IndexVector =
        quadripulse_controller14_B.HitCrossing1;
      break;

     case 4:
      quadripulse_controller14_B.IndexVector =
        quadripulse_controller14_B.HitCrossing2;
      break;
    }

    /* End of MultiPortSwitch: '<S25>/Index Vector' */

    /* Logic: '<S25>/Trigger Condition Met' */
    quadripulse_controller14_B.TriggerConditionMet =
      (quadripulse_controller14_B.IndexVector &&
       quadripulse_controller14_B.WithinRange);
    quadripulse_controller14_B.Switch_g =
      quadripulse_controller14_B.TriggerConditionMet;
  } else {
    quadripulse_controller14_B.Switch_g =
      quadripulse_controller14_P.Constant4_Value;
  }

  /* End of Switch: '<Root>/Switch' */

  /* Memory: '<S20>/Memory' */
  quadripulse_controller14_B.Memory =
    quadripulse_controller14_DW.Memory_PreviousInput;

  /* CombinatorialLogic: '<S20>/Logic' incorporates:
   *  Constant: '<Root>/Reset'
   */
  isIEven = quadripulse_controller14_B.Switch_g;
  count = isIEven;
  isIEven = quadripulse_controller14_P.reset;
  count = (count << 1) + isIEven;
  isIEven = quadripulse_controller14_B.Memory;
  count = (count << 1) + isIEven;
  quadripulse_controller14_B.Logic[0U] =
    quadripulse_controller14_P.Logic_table[count];
  quadripulse_controller14_B.Logic[1U] =
    quadripulse_controller14_P.Logic_table[count + 8U];

  /* Outputs for Enabled SubSystem: '<Root>/Trigger Generator' incorporates:
   *  EnablePort: '<S26>/Enable'
   */
  if (quadripulse_controller14_B.Logic[0]) {
    if (!quadripulse_controller14_DW.TriggerGenerator_MODE) {
      /* InitializeConditions for Delay: '<S26>/Counter Delay' */
      quadripulse_controller14_DW.CounterDelay_DSTATE =
        quadripulse_controller14_P.CounterDelay_InitialCondition;

      /* InitializeConditions for UnitDelay: '<S47>/Output' */
      quadripulse_controller14_DW.Output_DSTATE =
        quadripulse_controller14_P.Output_InitialCondition;
      quadripulse_controller14_DW.TriggerGenerator_MODE = true;
    }

    /* Delay: '<S26>/Counter Delay' */
    quadripulse_controller14_B.CounterDelay =
      quadripulse_controller14_DW.CounterDelay_DSTATE;

    /* RelationalOperator: '<S26>/Bounds check' */
    quadripulse_controller14_B.Boundscheck =
      (quadripulse_controller14_B.CounterDelay <=
       quadripulse_controller14_ConstB.Width);

    /* Switch: '<S26>/Saturate' */
    if (quadripulse_controller14_B.Boundscheck) {
      quadripulse_controller14_B.Saturate =
        quadripulse_controller14_B.CounterDelay;
    } else {
      quadripulse_controller14_B.Saturate =
        quadripulse_controller14_ConstB.Width;
    }

    /* End of Switch: '<S26>/Saturate' */

    /* UnitDelay: '<S47>/Output' */
    quadripulse_controller14_B.Output =
      quadripulse_controller14_DW.Output_DSTATE;

    /* Sum: '<S48>/FixPt Sum1' incorporates:
     *  Constant: '<S48>/FixPt Constant'
     */
    quadripulse_controller14_B.FixPtSum1 = quadripulse_controller14_B.Output +
      quadripulse_controller14_P.FixPtConstant_Value;

    /* Switch: '<S49>/FixPt Switch' incorporates:
     *  Constant: '<S49>/Constant'
     */
    if (quadripulse_controller14_B.FixPtSum1 >
        quadripulse_controller14_P.WrapToZero_Threshold) {
      quadripulse_controller14_B.FixPtSwitch =
        quadripulse_controller14_P.Constant_Value_m;
    } else {
      quadripulse_controller14_B.FixPtSwitch =
        quadripulse_controller14_B.FixPtSum1;
    }

    /* End of Switch: '<S49>/FixPt Switch' */

    /* DataTypeConversion: '<S26>/Data Type Conversion1' */
    quadripulse_controller14_B.DataTypeConversion1_b =
      quadripulse_controller14_B.Output;

    /* Gain: '<S26>/Gain' */
    quadripulse_controller14_B.Gain_p = quadripulse_controller14_P.Gain_Gain *
      quadripulse_controller14_B.DataTypeConversion1_b;

    /* S-Function (sdspsubmtrx): '<S26>/Time Data' incorporates:
     *  Constant: '<Root>/Constant'
     */
    quadripulse_controller14_B.TimeData[0] =
      quadripulse_controller14_P.timeinsecondsandtriggerchannel[0];
    quadripulse_controller14_B.TimeData[1] =
      quadripulse_controller14_P.timeinsecondsandtriggerchannel[1];

    /* MultiPortSwitch: '<S26>/Time Index' */
    quadripulse_controller14_B.TimeIndex = quadripulse_controller14_B.TimeData
      [(int32_T)quadripulse_controller14_B.Saturate - 1];

    /* RelationalOperator: '<S26>/Relational Operator' */
    quadripulse_controller14_B.RelationalOperator =
      (quadripulse_controller14_B.Gain_p >= quadripulse_controller14_B.TimeIndex);

    /* DataTypeConversion: '<S26>/Data Type Conversion4' */
    quadripulse_controller14_B.DataTypeConversion4 =
      quadripulse_controller14_B.RelationalOperator;

    /* Logic: '<S26>/Logical Operator' */
    quadripulse_controller14_B.LogicalOperator =
      (quadripulse_controller14_B.Boundscheck &&
       quadripulse_controller14_B.RelationalOperator);

    /* Sum: '<S26>/Sum' */
    tmp_1 = floor(quadripulse_controller14_B.CounterDelay);
    if (rtIsNaN(tmp_1) || rtIsInf(tmp_1)) {
      tmp_1 = 0.0;
    } else {
      tmp_1 = fmod(tmp_1, 4.294967296E+9);
    }

    acc = floor(quadripulse_controller14_B.DataTypeConversion4);
    if (rtIsNaN(acc) || rtIsInf(acc)) {
      acc = 0.0;
    } else {
      acc = fmod(acc, 4.294967296E+9);
    }

    quadripulse_controller14_B.Sum = (tmp_1 < 0.0 ? (uint32_T)-(int32_T)
      (uint32_T)-tmp_1 : (uint32_T)tmp_1) + (acc < 0.0 ? (uint32_T)-(int32_T)
      (uint32_T)-acc : (uint32_T)acc);

    /* End of Sum: '<S26>/Sum' */

    /* Switch: '<S26>/Switch' incorporates:
     *  Constant: '<S26>/Zero'
     */
    if (quadripulse_controller14_B.LogicalOperator) {
      /* S-Function (sdspsubmtrx): '<S26>/Channel Data' incorporates:
       *  Constant: '<Root>/Constant'
       */
      quadripulse_controller14_B.ChannelData[0] =
        quadripulse_controller14_P.timeinsecondsandtriggerchannel[2];
      quadripulse_controller14_B.ChannelData[1] =
        quadripulse_controller14_P.timeinsecondsandtriggerchannel[3];

      /* MultiPortSwitch: '<S26>/Channel Index' */
      quadripulse_controller14_B.ChannelIndex =
        quadripulse_controller14_B.ChannelData[(int32_T)
        quadripulse_controller14_B.Saturate - 1];
      quadripulse_controller14_B.Switch =
        quadripulse_controller14_B.ChannelIndex;
    } else {
      quadripulse_controller14_B.Switch = quadripulse_controller14_P.Zero_Value;
    }

    /* End of Switch: '<S26>/Switch' */
    srUpdateBC(quadripulse_controller14_DW.TriggerGenerator_SubsysRanBC);
  } else {
    if (quadripulse_controller14_DW.TriggerGenerator_MODE) {
      quadripulse_controller14_DW.TriggerGenerator_MODE = false;
    }
  }

  /* End of Outputs for SubSystem: '<Root>/Trigger Generator' */

  /* RelationalOperator: '<S4>/Compare' incorporates:
   *  Constant: '<S4>/Constant'
   */
  quadripulse_controller14_B.Compare_l = (quadripulse_controller14_B.Switch ==
    quadripulse_controller14_P.CompareToConstant_const);

  /* DataTypeConversion: '<Root>/Data Type Conversion' */
  quadripulse_controller14_B.DataTypeConversion_l =
    quadripulse_controller14_B.Compare_l;

  /* RelationalOperator: '<S5>/Compare' incorporates:
   *  Constant: '<S5>/Constant'
   */
  quadripulse_controller14_B.Compare_h = (quadripulse_controller14_B.Switch ==
    quadripulse_controller14_P.CompareToConstant1_const);

  /* DataTypeConversion: '<Root>/Data Type Conversion1' */
  quadripulse_controller14_B.DataTypeConversion1 =
    quadripulse_controller14_B.Compare_h;

  /* RelationalOperator: '<S6>/Compare' incorporates:
   *  Constant: '<S6>/Constant'
   */
  quadripulse_controller14_B.Compare_ln = (quadripulse_controller14_B.Switch ==
    quadripulse_controller14_P.CompareToConstant2_const);

  /* DataTypeConversion: '<Root>/Data Type Conversion2' */
  quadripulse_controller14_B.DataTypeConversion2 =
    quadripulse_controller14_B.Compare_ln;

  /* RelationalOperator: '<S7>/Compare' incorporates:
   *  Constant: '<S7>/Constant'
   */
  quadripulse_controller14_B.Compare_n = (quadripulse_controller14_B.Switch ==
    quadripulse_controller14_P.CompareToConstant3_const);

  /* DataTypeConversion: '<Root>/Data Type Conversion3' */
  quadripulse_controller14_B.DataTypeConversion3 =
    quadripulse_controller14_B.Compare_n;

  /* Level2 S-Function Block: '<Root>/PD2-MF 12bit series' (doueipd2mfx) */
  {
    SimStruct *rts = quadripulse_controller14_M->childSfunctions[9];
    sfcnOutputs(rts, 0);
  }

  /* DataTypeConversion: '<Root>/Data Type Conversion5' */
  quadripulse_controller14_B.DataTypeConversion5 =
    quadripulse_controller14_B.Logic[0];

  /* HitCross: '<Root>/Hit  Crossing' */
  zcEvent = rt_ZCFcn(RISING_ZERO_CROSSING,
                     &quadripulse_controller14_PrevZCX.HitCrossing_Input_ZCE,
                     (quadripulse_controller14_B.DataTypeConversion5 -
                      quadripulse_controller14_P.HitCrossing_Offset_b));
  if (quadripulse_controller14_DW.HitCrossing_MODE == 0) {
    if (zcEvent != NO_ZCEVENT) {
      quadripulse_controller14_B.HitCrossing =
        !quadripulse_controller14_B.HitCrossing;
      quadripulse_controller14_DW.HitCrossing_MODE = 1;
    } else {
      if (quadripulse_controller14_B.HitCrossing &&
          (quadripulse_controller14_B.DataTypeConversion5 !=
           quadripulse_controller14_P.HitCrossing_Offset_b)) {
        quadripulse_controller14_B.HitCrossing = false;
      }
    }
  } else {
    if (quadripulse_controller14_B.DataTypeConversion5 !=
        quadripulse_controller14_P.HitCrossing_Offset_b) {
      quadripulse_controller14_B.HitCrossing = false;
    }

    quadripulse_controller14_DW.HitCrossing_MODE = 0;
  }

  /* End of HitCross: '<Root>/Hit  Crossing' */

  /* Switch: '<Root>/Switch1' incorporates:
   *  Constant: '<Root>/Triggetr ID'
   */
  if (quadripulse_controller14_B.HitCrossing) {
    quadripulse_controller14_B.Switch1 = quadripulse_controller14_P.marker_id;
  } else {
    /* DataTypeConversion: '<Root>/Data Type Conversion4' incorporates:
     *  Constant: '<Root>/Constant6'
     */
    quadripulse_controller14_B.DataTypeConversion4_k =
      quadripulse_controller14_P.Constant6_Value;
    quadripulse_controller14_B.Switch1 =
      quadripulse_controller14_B.DataTypeConversion4_k;
  }

  /* End of Switch: '<Root>/Switch1' */

  /* Level2 S-Function Block: '<Root>/Parallel Port DO ' (parallelportdio) */
  {
    SimStruct *rts = quadripulse_controller14_M->childSfunctions[10];
    sfcnOutputs(rts, 0);
  }

  /* S-Function (sdspsubmtrx): '<S21>/Times 2..end' incorporates:
   *  Constant: '<Root>/Constant'
   */
  colIdx = 0;
  quadripulse_controller14_B.Times2end =
    quadripulse_controller14_P.timeinsecondsandtriggerchannel[1];

  /* S-Function (sdspsubmtrx): '<S21>/Times 1..end-1' incorporates:
   *  Constant: '<Root>/Constant'
   */
  quadripulse_controller14_B.Times1end1 =
    quadripulse_controller14_P.timeinsecondsandtriggerchannel[0];

  /* Sum: '<S21>/Subtract' */
  quadripulse_controller14_B.Subtract_n = quadripulse_controller14_B.Times2end -
    quadripulse_controller14_B.Times1end1;

  /* MinMax: '<S21>/MinMax' */
  quadripulse_controller14_B.MinMax = quadripulse_controller14_B.Subtract_n;

  /* RelationalOperator: '<S37>/Compare' incorporates:
   *  Constant: '<S37>/Constant'
   */
  quadripulse_controller14_B.Compare_e = (quadripulse_controller14_B.MinMax <
    quadripulse_controller14_P.uinto1UnitLimit_const);

  /* Stop: '<S21>/Stop Simulation' */
  if (quadripulse_controller14_B.Compare_e) {
    rtmSetStopRequested(quadripulse_controller14_M, 1);
  }

  /* End of Stop: '<S21>/Stop Simulation' */
  /* ok to acquire for <S22>/S-Function */
  quadripulse_controller14_DW.SFunction_IWORK_g.AcquireOK = 1;

  /* Gain: '<Root>/AC Mode Scaling Factor' */
  for (i = 0; i < 66; i++) {
    quadripulse_controller14_B.ACModeScalingFactor[i] =
      quadripulse_controller14_P.ACModeScalingFactor_Gain *
      quadripulse_controller14_B.Reshape1[i];
  }

  /* End of Gain: '<Root>/AC Mode Scaling Factor' */

  /* RelationalOperator: '<S8>/Compare' incorporates:
   *  Constant: '<S8>/Constant'
   */
  quadripulse_controller14_B.Compare_d = (quadripulse_controller14_B.Switch >
    quadripulse_controller14_P.Constant_Value_i);
  for (i = 0; i < 512; i++) {
    /* SignalConversion: '<Root>/ConcatBufferAtVector ConcatenateIn1' */
    quadripulse_controller14_B.VectorConcatenate[i] =
      quadripulse_controller14_B.Subtract_i[i];

    /* SignalConversion: '<Root>/ConcatBufferAtVector ConcatenateIn2' */
    quadripulse_controller14_B.VectorConcatenate[i + 512] =
      quadripulse_controller14_B.ReFlip[i];
  }

  /* Delay: '<Root>/Delay1' */
  quadripulse_controller14_B.Delay1 = quadripulse_controller14_DW.Delay1_DSTATE
    [0];

  /* Delay: '<Root>/Delay2' */
  quadripulse_controller14_B.Delay2 = quadripulse_controller14_DW.Delay2_DSTATE
    [0];

  /* Unbuffer: '<S10>/Unbuffer' */
  i = quadripulse_controller14_DW.Unbuffer_outBufPtrIdx;
  if (i < 0) {
    i += 200;
  }

  j = 200 - i;
  offset = 1;
  if (j <= 1) {
    ix = i;
    while (colIdx < j) {
      quadripulse_controller14_B.Unbuffer[0] =
        quadripulse_controller14_DW.Unbuffer_CircBuf[ix];
      colIdx = 1;
    }

    yIdx = j;
    i = 0;
    offset = 1 - j;
  }

  ix = i;
  for (colIdx = 0; colIdx < offset; colIdx++) {
    quadripulse_controller14_B.Unbuffer[yIdx + colIdx] =
      quadripulse_controller14_DW.Unbuffer_CircBuf[ix + colIdx];
  }

  yIdx += offset;
  i = quadripulse_controller14_DW.Unbuffer_outBufPtrIdx;
  if (i < 0) {
    i += 200;
  }

  j = 200 - i;
  offset = 1;
  if (j <= 1) {
    ix = 200 + i;
    colIdx = 0;
    while (colIdx < j) {
      quadripulse_controller14_B.Unbuffer[yIdx] =
        quadripulse_controller14_DW.Unbuffer_CircBuf[ix];
      colIdx = 1;
    }

    yIdx += j;
    i = 0;
    offset = 1 - j;
  }

  ix = 200 + i;
  for (colIdx = 0; colIdx < offset; colIdx++) {
    quadripulse_controller14_B.Unbuffer[yIdx + colIdx] =
      quadripulse_controller14_DW.Unbuffer_CircBuf[ix + colIdx];
  }

  i += offset;
  quadripulse_controller14_DW.Unbuffer_outBufPtrIdx = i;

  /* End of Unbuffer: '<S10>/Unbuffer' */

  /* S-Function (sdspsubmtrx): '<S10>/Data' */
  quadripulse_controller14_B.Data = quadripulse_controller14_B.Unbuffer[1];

  /* S-Function (sdspsubmtrx): '<S10>/Trigger Signal' */
  quadripulse_controller14_B.TriggerSignal =
    quadripulse_controller14_B.Unbuffer[0];

  /* SignalConversion: '<S36>/TmpSignal ConversionAtDelayInport1' */
  quadripulse_controller14_B.TmpSignalConversionAtDelayInpor[0] =
    quadripulse_controller14_B.Subtract[4];
  quadripulse_controller14_B.TmpSignalConversionAtDelayInpor[1] =
    quadripulse_controller14_B.Subtract[20];
  quadripulse_controller14_B.TmpSignalConversionAtDelayInpor[2] =
    quadripulse_controller14_B.Subtract[22];
  quadripulse_controller14_B.TmpSignalConversionAtDelayInpor[3] =
    quadripulse_controller14_B.Subtract[24];
  quadripulse_controller14_B.TmpSignalConversionAtDelayInpor[4] =
    quadripulse_controller14_B.Subtract[26];

  /* Delay: '<S36>/Delay' */
  count = quadripulse_controller14_DW.CircBufIdx;

  /* Gain: '<S36>/Gain' */
  acc = quadripulse_controller14_P.RunningAverage_N;
  tmp_1 = 1.0 / acc;
  for (i = 0; i < 5; i++) {
    /* Delay: '<S36>/Delay1' */
    quadripulse_controller14_B.Delay1_b[i] =
      quadripulse_controller14_DW.Delay1_DSTATE_e[i];

    /* Delay: '<S36>/Delay' */
    quadripulse_controller14_B.Delay[i] =
      quadripulse_controller14_DW.Delay_DSTATE[500 * i + (int32_T)count];

    /* Sum: '<S36>/Add' */
    quadripulse_controller14_B.Add[i] = (quadripulse_controller14_B.Delay1_b[i]
      + quadripulse_controller14_B.TmpSignalConversionAtDelayInpor[i]) -
      quadripulse_controller14_B.Delay[i];

    /* Gain: '<S36>/Gain' */
    quadripulse_controller14_B.Gain_c[i] = tmp_1 *
      quadripulse_controller14_B.Add[i];
  }

  /* ZeroOrderHold: '<S16>/Zero-Order Hold' */
  if (quadripulse_controller14_M->Timing.RateInteraction.TID0_3) {
    for (i = 0; i < 5; i++) {
      quadripulse_controller14_B.ZeroOrderHold[i] =
        quadripulse_controller14_B.Gain_c[i];
    }
  }

  /* End of ZeroOrderHold: '<S16>/Zero-Order Hold' */
  for (i = 0; i < 5; i++) {
    /* RateTransition: '<S16>/Rate Transition' */
    quadripulse_controller14_B.RateTransition[i] =
      quadripulse_controller14_B.ZeroOrderHold[i];

    /* Sum: '<S16>/Add' */
    quadripulse_controller14_B.Add_o[i] =
      (quadripulse_controller14_ConstB.ConstantRamp[i] -
       quadripulse_controller14_B.RateTransition[i]) +
      quadripulse_controller14_B.TmpSignalConversionAtDelayInpor[i];
  }

  /* MATLABSystem: '<Root>/Highpass Filter' */
  tmp_1 = quadripulse_controller14_B.ACModeScalingFactor[64];
  u0[0] = tmp_1;
  tmp_1 = quadripulse_controller14_B.ACModeScalingFactor[65];
  u0[1] = tmp_1;

  /* Start for MATLABSystem: '<Root>/Highpass Filter' incorporates:
   *  MATLABSystem: '<Root>/Highpass Filter'
   */
  obj = &quadripulse_controller14_DW.obj;
  obj_0 = obj;
  inputSize[0] = 1;
  inputSize[1] = 2;
  for (yIdx = 0; yIdx < 6; yIdx++) {
    inputSize[yIdx + 2] = 1;
  }

  yIdx = 0;
  exitg1 = false;
  while ((exitg1 == false) && (yIdx < 8)) {
    tmp_1 = 1.0 + (real_T)yIdx;
    if (obj_0->inputVarSize1[(int32_T)tmp_1 - 1] != (uint32_T)inputSize[(int32_T)
        tmp_1 - 1]) {
      for (yIdx = 0; yIdx < 8; yIdx++) {
        obj_0->inputVarSize1[yIdx] = (uint32_T)inputSize[yIdx];
      }

      exitg1 = true;
    } else {
      yIdx++;
    }
  }

  obj_1 = obj->FilterObj;
  if (obj_1->isInitialized != 1) {
    obj_2 = obj_1;
    obj_3 = obj_2;
    obj_3->isInitialized = 1;
    obj_4 = &obj_2->cSFunObject;

    /* System object Initialization function: dsp.FIRFilter */
    tmp_1 = obj_4->P0_InitialStates;
    for (yIdx = 0; yIdx < 400; yIdx++) {
      obj_4->W0_states[yIdx] = tmp_1;
    }
  }

  obj_4 = &obj_1->cSFunObject;

  /* System object Outputs function: dsp.FIRFilter */
  for (yIdx = 0; yIdx < 2; yIdx++) {
    offset = yIdx * 200;
    i = yIdx;

    /* Consume delay line and beginning of input samples */
    colIdx = 0;
    while (colIdx < 1) {
      tmp_1 = 0.0;
      j = 0;
      while (j < 1) {
        acc = u0[i] * obj_4->P1_Coefficients[0];
        tmp_1 += acc;
        j = 1;
      }

      for (j = 0; j < 200; j++) {
        acc = obj_4->W0_states[offset + j] * obj_4->P1_Coefficients[j + 1];
        tmp_1 += acc;
      }

      tmp[i] = tmp_1;
      colIdx = 1;
    }

    /* Update delay line for next frame */
    for (colIdx = offset + 198; colIdx >= offset; colIdx--) {
      obj_4->W0_states[1 + colIdx] = obj_4->W0_states[colIdx];
    }

    colIdx = 0;
    while (colIdx < 1) {
      obj_4->W0_states[offset] = u0[i];
      colIdx = 1;
    }
  }

  /* End of Start for MATLABSystem: '<Root>/Highpass Filter' */

  /* MATLABSystem: '<Root>/Highpass Filter' */
  quadripulse_controller14_B.HighpassFilter[0] = tmp[0];

  /* S-Function (sdspsubmtrx): '<Root>/Single Row' */
  quadripulse_controller14_B.SingleRow[0] =
    quadripulse_controller14_B.VectorConcatenate[383];

  /* MATLABSystem: '<Root>/Highpass Filter' */
  quadripulse_controller14_B.HighpassFilter[1] = tmp[1];

  /* S-Function (sdspsubmtrx): '<Root>/Single Row' */
  quadripulse_controller14_B.SingleRow[1] =
    quadripulse_controller14_B.VectorConcatenate[895];
}

/* Model update function for TID0 */
static void quadripulse_controller14_update0(void) /* Sample time: [0.001s, 0.0s] */
{
  uint32_T currIdx;
  int32_T i;

  /* Update for UnitDelay: '<S46>/UD' */
  quadripulse_controller14_DW.UD_DSTATE = quadripulse_controller14_B.Now;

  /* Update for UnitDelay: '<Root>/Unit Delay' */
  quadripulse_controller14_DW.UnitDelay_DSTATE_m =
    quadripulse_controller14_B.Compare_d;

  /* Update for UnitDelay: '<S39>/Unit Delay' */
  quadripulse_controller14_DW.UnitDelay_DSTATE_b =
    quadripulse_controller14_B.KeepPostiveSwitch;

  /* Update for Memory: '<S20>/Memory' */
  quadripulse_controller14_DW.Memory_PreviousInput =
    quadripulse_controller14_B.Logic[0];

  /* Update for Enabled SubSystem: '<Root>/Trigger Generator' incorporates:
   *  Update for EnablePort: '<S26>/Enable'
   */
  if (quadripulse_controller14_DW.TriggerGenerator_MODE) {
    /* Update for Delay: '<S26>/Counter Delay' */
    quadripulse_controller14_DW.CounterDelay_DSTATE =
      quadripulse_controller14_B.Sum;

    /* Update for UnitDelay: '<S47>/Output' */
    quadripulse_controller14_DW.Output_DSTATE =
      quadripulse_controller14_B.FixPtSwitch;
  }

  /* End of Update for SubSystem: '<Root>/Trigger Generator' */
  for (i = 0; i < 127; i++) {
    /* Update for Delay: '<Root>/Delay1' */
    quadripulse_controller14_DW.Delay1_DSTATE[i] =
      quadripulse_controller14_DW.Delay1_DSTATE[i + 1];

    /* Update for Delay: '<Root>/Delay2' */
    quadripulse_controller14_DW.Delay2_DSTATE[i] =
      quadripulse_controller14_DW.Delay2_DSTATE[i + 1];
  }

  /* Update for Delay: '<Root>/Delay1' */
  quadripulse_controller14_DW.Delay1_DSTATE[127] =
    quadripulse_controller14_B.Now;

  /* Update for Delay: '<Root>/Delay2' */
  quadripulse_controller14_DW.Delay2_DSTATE[127] =
    quadripulse_controller14_B.RateTransition1;

  /* Update for Delay: '<S36>/Delay' */
  currIdx = quadripulse_controller14_DW.CircBufIdx;
  for (i = 0; i < 5; i++) {
    /* Update for Delay: '<S36>/Delay1' */
    quadripulse_controller14_DW.Delay1_DSTATE_e[i] =
      quadripulse_controller14_B.Add[i];

    /* Update for Delay: '<S36>/Delay' */
    quadripulse_controller14_DW.Delay_DSTATE[(int32_T)currIdx + 500 * i] =
      quadripulse_controller14_B.TmpSignalConversionAtDelayInpor[i];
  }

  /* Update for Delay: '<S36>/Delay' */
  if (quadripulse_controller14_DW.CircBufIdx < 499U) {
    quadripulse_controller14_DW.CircBufIdx++;
  } else {
    quadripulse_controller14_DW.CircBufIdx -= 499U;
  }

  /* Update absolute time */
  /* The "clockTick0" counts the number of times the code of this task has
   * been executed. The absolute time is the multiplication of "clockTick0"
   * and "Timing.stepSize0". Size of "clockTick0" ensures timer will not
   * overflow during the application lifespan selected.
   * Timer of this task consists of two 32 bit unsigned integers.
   * The two integers represent the low bits Timing.clockTick0 and the high bits
   * Timing.clockTickH0. When the low bit overflows to 0, the high bits increment.
   */
  if (!(++quadripulse_controller14_M->Timing.clockTick0)) {
    ++quadripulse_controller14_M->Timing.clockTickH0;
  }

  quadripulse_controller14_M->Timing.t[0] =
    quadripulse_controller14_M->Timing.clockTick0 *
    quadripulse_controller14_M->Timing.stepSize0 +
    quadripulse_controller14_M->Timing.clockTickH0 *
    quadripulse_controller14_M->Timing.stepSize0 * 4294967296.0;
}

/* Model output function for TID1 */
static void quadripulse_controller14_output1(void) /* Sample time: [0.01s, 0.0s] */
{
  int32_T idxW;
  int32_T outAddOffset;
  int32_T k;
  int32_T vector;
  int32_T offset;
  uint32_T count;
  int32_T col;
  int32_T tmp;
  int32_T i;
  int32_T tmp_data[1024];
  real_T tmp_0;
  real_T y;
  creal_T u;

  /* Reset subsysRan breadcrumbs */
  srClearBC(quadripulse_controller14_DW.IfActionSubsystem_SubsysRanBC);

  /* Reset subsysRan breadcrumbs */
  srClearBC(quadripulse_controller14_DW.IfActionSubsystem1_SubsysRanBC);

  /* DotProduct: '<S29>/Dot Product2' */
  y = 0.0;
  for (i = 0; i < 512; i++) {
    /* RateTransition: '<S10>/Rate Transition2' */
    quadripulse_controller14_B.RateTransition2[i] =
      quadripulse_controller14_B.Subtract_i[i];

    /* Reshape: '<S29>/Reshape' */
    quadripulse_controller14_B.Reshape[i] =
      quadripulse_controller14_B.RateTransition2[i];

    /* DotProduct: '<S29>/Dot Product2' */
    y += quadripulse_controller14_ConstB.ramp[i] *
      quadripulse_controller14_ConstB.ramp[i];
  }

  /* DotProduct: '<S29>/Dot Product2' */
  quadripulse_controller14_B.DotProduct2 = y;

  /* S-Function (sdspstatminmax): '<S29>/Maximum' */
  vector = 0;
  col = 0;
  while (col < 1) {
    quadripulse_controller14_B.Maximum =
      quadripulse_controller14_ConstB.ramp[vector];
    vector++;
    for (i = 1; i < 512; i++) {
      if (quadripulse_controller14_ConstB.ramp[vector] >
          quadripulse_controller14_B.Maximum) {
        quadripulse_controller14_B.Maximum =
          quadripulse_controller14_ConstB.ramp[vector];
      }

      vector++;
    }

    col = 1;
  }

  /* End of S-Function (sdspstatminmax): '<S29>/Maximum' */

  /* Product: '<S29>/linear term3' */
  quadripulse_controller14_B.linearterm3 =
    quadripulse_controller14_B.DotProduct2 * quadripulse_controller14_B.Maximum;

  /* Sum: '<S29>/Matrix Sum1' */
  idxW = 0;
  y = quadripulse_controller14_ConstB.ramp[0];
  for (outAddOffset = 0; outAddOffset < 511; outAddOffset++) {
    tmp = outAddOffset + 1;
    y += quadripulse_controller14_ConstB.ramp[tmp];
  }

  quadripulse_controller14_B.MatrixSum1 = y;

  /* End of Sum: '<S29>/Matrix Sum1' */

  /* Product: '<S29>/linear term2' */
  quadripulse_controller14_B.linearterm2 = quadripulse_controller14_B.MatrixSum1
    * quadripulse_controller14_B.MatrixSum1;

  /* Sum: '<S29>/Sum1' */
  quadripulse_controller14_B.Sum1 = quadripulse_controller14_B.linearterm3 -
    quadripulse_controller14_B.linearterm2;

  /* DotProduct: '<S29>/Dot Product' */
  y = 0.0;
  for (vector = 0; vector < 512; vector++) {
    tmp_0 = quadripulse_controller14_B.Reshape[vector];
    y += quadripulse_controller14_ConstB.ramp[vector] * tmp_0;
  }

  quadripulse_controller14_B.DotProduct = y;

  /* End of DotProduct: '<S29>/Dot Product' */

  /* Sum: '<S29>/Matrix Sum2' */
  y = quadripulse_controller14_B.Reshape[0];
  for (outAddOffset = 0; outAddOffset < 511; outAddOffset++) {
    tmp = outAddOffset + 1;
    y += quadripulse_controller14_B.Reshape[tmp];
  }

  quadripulse_controller14_B.MatrixSum2 = y;

  /* End of Sum: '<S29>/Matrix Sum2' */

  /* If: '<S29>/else' */
  if (quadripulse_controller14_B.Sum1 > 1.0) {
    /* Outputs for IfAction SubSystem: '<S29>/If Action Subsystem' incorporates:
     *  ActionPort: '<S33>/Action Port'
     */
    /* Product: '<S33>/linear term3' */
    quadripulse_controller14_B.linearterm3_j =
      quadripulse_controller14_B.DotProduct2 *
      quadripulse_controller14_B.MatrixSum2;

    /* Product: '<S33>/linear term4' */
    quadripulse_controller14_B.linearterm4 =
      quadripulse_controller14_B.MatrixSum1 *
      quadripulse_controller14_B.DotProduct;

    /* Sum: '<S33>/Sum1' */
    quadripulse_controller14_B.Sum1_m = quadripulse_controller14_B.linearterm3_j
      - quadripulse_controller14_B.linearterm4;

    /* Product: '<S33>/linear term1' */
    quadripulse_controller14_B.linearterm1_m =
      quadripulse_controller14_B.DotProduct * quadripulse_controller14_B.Maximum;

    /* Product: '<S33>/linear term2' */
    quadripulse_controller14_B.linearterm2_j =
      quadripulse_controller14_B.MatrixSum2 *
      quadripulse_controller14_B.MatrixSum1;

    /* Sum: '<S33>/Sum4' */
    quadripulse_controller14_B.Sum4_e = quadripulse_controller14_B.linearterm1_m
      - quadripulse_controller14_B.linearterm2_j;

    /* Product: '<S33>/linear term5' */
    quadripulse_controller14_B.a = quadripulse_controller14_B.Sum4_e /
      quadripulse_controller14_B.Sum1;

    /* Product: '<S33>/linear term6' */
    quadripulse_controller14_B.b = quadripulse_controller14_B.Sum1_m /
      quadripulse_controller14_B.Sum1;

    /* End of Outputs for SubSystem: '<S29>/If Action Subsystem' */

    /* Update for IfAction SubSystem: '<S29>/If Action Subsystem' incorporates:
     *  Update for ActionPort: '<S33>/Action Port'
     */
    /* Update for If: '<S29>/else' */
    srUpdateBC(quadripulse_controller14_DW.IfActionSubsystem_SubsysRanBC);

    /* End of Update for SubSystem: '<S29>/If Action Subsystem' */
  } else {
    /* Outputs for IfAction SubSystem: '<S29>/If Action Subsystem1' incorporates:
     *  ActionPort: '<S34>/Action Port'
     */
    /* S-Function (sdspihcplx2): '<S34>/Inherit Complexity' */
    quadripulse_controller14_B.InheritComplexity =
      quadripulse_controller14_B.Sum1;

    /* S-Function (sdspmultiportsel): '<S34>/Multiport Selector' */
    quadripulse_controller14_B.MultiportSelector =
      quadripulse_controller14_B.Reshape[0];

    /* SignalConversion: '<S34>/OutportBufferForOut1' */
    quadripulse_controller14_B.a = quadripulse_controller14_B.InheritComplexity;

    /* SignalConversion: '<S34>/OutportBufferForOut2' */
    quadripulse_controller14_B.b = quadripulse_controller14_B.MultiportSelector;

    /* End of Outputs for SubSystem: '<S29>/If Action Subsystem1' */

    /* Update for IfAction SubSystem: '<S29>/If Action Subsystem1' incorporates:
     *  Update for ActionPort: '<S34>/Action Port'
     */
    /* Update for If: '<S29>/else' */
    srUpdateBC(quadripulse_controller14_DW.IfActionSubsystem1_SubsysRanBC);

    /* End of Update for SubSystem: '<S29>/If Action Subsystem1' */
  }

  /* End of If: '<S29>/else' */
  for (i = 0; i < 512; i++) {
    /* Product: '<S29>/linear term1' */
    quadripulse_controller14_B.linearterm1[i] =
      quadripulse_controller14_ConstB.ramp[i] * quadripulse_controller14_B.a;

    /* Sum: '<S29>/Sum5' */
    quadripulse_controller14_B.Sum5[i] =
      quadripulse_controller14_B.linearterm1[i] + quadripulse_controller14_B.b;

    /* Sum: '<S29>/Sum4' */
    quadripulse_controller14_B.Sum4[i] = quadripulse_controller14_B.Reshape[i] -
      quadripulse_controller14_B.Sum5[i];
  }

  /* DSP System Toolbox Frame Status Conversion (sdspfrmconv) - <S35>/Inherit */
  memcpy( &quadripulse_controller14_B.Inherit[0],
         &quadripulse_controller14_B.Sum4[0], (512 * sizeof(real_T)) );

  /* S-Function (sdspwindow2): '<S10>/Window Function' */
  vector = 0;
  for (col = 0; col < 512; col++) {
    quadripulse_controller14_B.WindowFunction_o1[vector] =
      quadripulse_controller14_B.Inherit[vector] *
      quadripulse_controller14_ConstP.WindowFunction_WindowSamples[idxW];
    vector++;
    idxW++;
  }

  if (!quadripulse_controller14_DW.WindowFunction_FLAG) {
    quadripulse_controller14_DW.WindowFunction_FLAG = true;
    idxW = 0;
    for (col = 0; col < 512; col++) {
      quadripulse_controller14_B.WindowFunction_o2[idxW] =
        quadripulse_controller14_ConstP.WindowFunction_WindowSamples[idxW];
      idxW++;
    }
  }

  /* End of S-Function (sdspwindow2): '<S10>/Window Function' */

  /* S-Function (sdsppad): '<S10>/Pad' */
  /* Length of input columns to copy. Start with output column length and adjust. */
  vector = quadripulse_controller14_P.Pad_outDims[0];
  if (quadripulse_controller14_P.Pad_padBefore[0U] > 0) {
    vector -= quadripulse_controller14_P.Pad_padBefore[0];
  }

  if (quadripulse_controller14_P.Pad_padAfter[0U] > 0) {
    vector -= quadripulse_controller14_P.Pad_padAfter[0];
  }

  /* Compute initial column start addresses in both input and output arrays. */
  if (quadripulse_controller14_P.Pad_padBefore[0] < 0) {
    quadripulse_controller14_DW.Pad_inAdd[0] =
      -quadripulse_controller14_P.Pad_padBefore[0];
    quadripulse_controller14_DW.Pad_outAdd[0] = 0;
  } else {
    quadripulse_controller14_DW.Pad_inAdd[0] = 0;
    quadripulse_controller14_DW.Pad_outAdd[0] =
      quadripulse_controller14_P.Pad_padBefore[0];
  }

  if (quadripulse_controller14_P.Pad_padBefore[1] < 0) {
    quadripulse_controller14_DW.Pad_inAdd[1] =
      -quadripulse_controller14_P.Pad_padBefore[1];
    quadripulse_controller14_DW.Pad_outAdd[1] = 0;
  } else {
    quadripulse_controller14_DW.Pad_inAdd[1] = 0;
    quadripulse_controller14_DW.Pad_outAdd[1] =
      quadripulse_controller14_P.Pad_padBefore[1];
  }

  /* Copy all needed input columns to the output array. */
  /* Compute starting address of next column to copy. */
  idxW = quadripulse_controller14_DW.Pad_inAdd[0] *
    quadripulse_controller14_P.Pad_inWorkAdd[0];
  outAddOffset = quadripulse_controller14_DW.Pad_outAdd[0] *
    quadripulse_controller14_P.Pad_outWorkAdd[0];
  idxW += quadripulse_controller14_DW.Pad_inAdd[1] *
    quadripulse_controller14_P.Pad_inWorkAdd[1];
  outAddOffset += quadripulse_controller14_DW.Pad_outAdd[1] *
    quadripulse_controller14_P.Pad_outWorkAdd[1];

  /* Copy a column from input to output array. */
  for (i = 0; i < vector; i++) {
    quadripulse_controller14_B.Pad[outAddOffset + i] =
      quadripulse_controller14_B.WindowFunction_o1[idxW + i];
  }

  /* Increment the column starting address. */
  i = 1;
  while (i < 2) {
    quadripulse_controller14_DW.Pad_inAdd[1]++;
    quadripulse_controller14_DW.Pad_outAdd[1]++;
    if (((quadripulse_controller14_P.Pad_outDims[1] -
          quadripulse_controller14_P.Pad_padBefore[1]) -
         quadripulse_controller14_P.Pad_padAfter[1] ==
         quadripulse_controller14_DW.Pad_inAdd[1]) ||
        (quadripulse_controller14_DW.Pad_outAdd[1] ==
         quadripulse_controller14_P.Pad_outDims[1])) {
      /* Reset index of this dim and continue to the next dim. */
      if (quadripulse_controller14_P.Pad_padBefore[1] < 0) {
        quadripulse_controller14_DW.Pad_inAdd[1] =
          -quadripulse_controller14_P.Pad_padBefore[1];
        quadripulse_controller14_DW.Pad_outAdd[1] = 0;
      } else {
        quadripulse_controller14_DW.Pad_inAdd[1] = 0;
        quadripulse_controller14_DW.Pad_outAdd[1] =
          quadripulse_controller14_P.Pad_padBefore[1];
      }
    } else {
      /* Done incrementing address for this pass. */
      i = 2;
    }

    i++;
  }

  /* end CopyInToOut. */
  if ((quadripulse_controller14_P.Pad_padBefore[0] > 0) ||
      (quadripulse_controller14_P.Pad_padAfter[0] > 0)) {
    idxW = 0;
    outAddOffset = quadripulse_controller14_P.Pad_outDims[0];
    offset = quadripulse_controller14_P.Pad_outDims[1];
    if (quadripulse_controller14_P.Pad_padBefore[0] > 0) {
      outAddOffset -= quadripulse_controller14_P.Pad_padBefore[0];
    }

    if (quadripulse_controller14_P.Pad_padAfter[0] > 0) {
      outAddOffset -= quadripulse_controller14_P.Pad_padAfter[0];
    }

    col = 0;
    while (col < 1) {
      vector = idxW;
      for (i = 0; i < offset; i++) {
        for (k = 0; k < quadripulse_controller14_P.Pad_padBefore[0]; k++) {
          quadripulse_controller14_B.Pad[vector] =
            quadripulse_controller14_P.Pad_padVal;
          vector++;
        }

        vector += outAddOffset;
        for (k = 0; k < quadripulse_controller14_P.Pad_padAfter[0]; k++) {
          quadripulse_controller14_B.Pad[vector] =
            quadripulse_controller14_P.Pad_padVal;
          vector++;
        }
      }

      idxW++;
      col = 1;
    }
  }

  if ((quadripulse_controller14_P.Pad_padBefore[1] > 0) ||
      (quadripulse_controller14_P.Pad_padAfter[1] > 0)) {
    idxW = 0;
    outAddOffset = quadripulse_controller14_P.Pad_outDims[1];
    tmp = quadripulse_controller14_P.Pad_outDims[0];
    if (quadripulse_controller14_P.Pad_padBefore[1] > 0) {
      outAddOffset -= quadripulse_controller14_P.Pad_padBefore[1];
    }

    if (quadripulse_controller14_P.Pad_padAfter[1] > 0) {
      outAddOffset -= quadripulse_controller14_P.Pad_padAfter[1];
    }

    outAddOffset *= tmp;
    for (col = 0; col < tmp; col++) {
      vector = idxW;
      i = 0;
      while (i < 1) {
        for (k = 0; k < quadripulse_controller14_P.Pad_padBefore[1]; k++) {
          quadripulse_controller14_B.Pad[vector] =
            quadripulse_controller14_P.Pad_padVal;
          vector += tmp;
        }

        vector += outAddOffset;
        for (k = 0; k < quadripulse_controller14_P.Pad_padAfter[1]; k++) {
          quadripulse_controller14_B.Pad[vector] =
            quadripulse_controller14_P.Pad_padVal;
          vector += tmp;
        }

        i = 1;
      }

      idxW++;
    }
  }

  /* End of S-Function (sdsppad): '<S10>/Pad' */

  /* S-Function (sdspfft2): '<S30>/FFT' */
  MWDSPCG_FFT_Interleave_R2BR_D(&quadripulse_controller14_B.Pad[0U],
    &quadripulse_controller14_B.FFT[0U], 1, 1024);
  MWDSPCG_R2DIT_TBLS_Z(&quadripulse_controller14_B.FFT[0U], 1, 1024, 512, 0,
                       quadripulse_controller14_ConstP.FFT_TwiddleTable, 2,
                       false);
  MWDSPCG_FFT_DblLen_Z(&quadripulse_controller14_B.FFT[0U], 1, 1024,
                       quadripulse_controller14_ConstP.FFT_TwiddleTable, 1);

  /* Math: '<S30>/Magnitude Squared'
   *
   * About '<S30>/Magnitude Squared':
   *  Operator: magnitude^2
   */
  for (i = 0; i < 1024; i++) {
    u = quadripulse_controller14_B.FFT[i];
    y = u.re * u.re + u.im * u.im;
    quadripulse_controller14_B.MagnitudeSquared[i] = y;
  }

  /* End of Math: '<S30>/Magnitude Squared' */

  /* Sum: '<S10>/Sum of Elements' */
  y = quadripulse_controller14_B.WindowFunction_o2[0];
  for (outAddOffset = 0; outAddOffset < 511; outAddOffset++) {
    tmp = outAddOffset + 1;
    y += quadripulse_controller14_B.WindowFunction_o2[tmp];
  }

  quadripulse_controller14_B.SumofElements = y;

  /* End of Sum: '<S10>/Sum of Elements' */
  for (i = 0; i < 1024; i++) {
    /* Product: '<S10>/Divide' */
    quadripulse_controller14_B.Divide[i] =
      quadripulse_controller14_B.MagnitudeSquared[i] /
      quadripulse_controller14_B.SumofElements;

    /* Gain: '<S10>/scale to per Hz' */
    quadripulse_controller14_B.scaletoperHz[i] =
      quadripulse_controller14_P.scaletoperHz_Gain *
      quadripulse_controller14_B.Divide[i];
  }

  /* Selector: '<S10>/Selector' incorporates:
   *  Constant: '<S10>/Constant'
   */
  quadripulse_controller14_DW.Selector_DIMS1[0] = ((int32_T)
    quadripulse_controller14_P.fft_bin_indices_zero_based[1] - (int32_T)
    quadripulse_controller14_P.fft_bin_indices_zero_based[0]) + 1;
  quadripulse_controller14_DW.Selector_DIMS1[1] = 1;
  idxW = (int32_T)quadripulse_controller14_P.fft_bin_indices_zero_based[1] -
    (int32_T)quadripulse_controller14_P.fft_bin_indices_zero_based[0];
  for (vector = 0; vector <= idxW; vector++) {
    tmp_data[vector] = vector;
  }

  vector = (int32_T)quadripulse_controller14_P.fft_bin_indices_zero_based[0];
  idxW = ((int32_T)quadripulse_controller14_P.fft_bin_indices_zero_based[1] -
          (int32_T)quadripulse_controller14_P.fft_bin_indices_zero_based[0]) + 1;
  for (i = 0; i < idxW; i++) {
    quadripulse_controller14_B.Selector[i] =
      quadripulse_controller14_B.scaletoperHz[tmp_data[i] + vector];
  }

  /* End of Selector: '<S10>/Selector' */

  /* S-Function (sdspstatfcns): '<S10>/Mean' */
  vector = quadripulse_controller14_DW.Selector_DIMS1[0];
  vector *= quadripulse_controller14_DW.Selector_DIMS1[1];
  count = (uint32_T)vector;
  vector = quadripulse_controller14_DW.Selector_DIMS1[0];
  vector *= quadripulse_controller14_DW.Selector_DIMS1[1];
  for (col = 0; col < vector; col += outAddOffset) {
    for (i = col; i < col + 1; i++) {
      quadripulse_controller14_DW.Mean_AccVal_h =
        quadripulse_controller14_B.Selector[i];
      outAddOffset = quadripulse_controller14_DW.Selector_DIMS1[0];
      tmp = 1;
      for (outAddOffset = outAddOffset *
           quadripulse_controller14_DW.Selector_DIMS1[1] - 1; outAddOffset > 0;
           outAddOffset--) {
        offset = i + tmp;
        quadripulse_controller14_DW.Mean_AccVal_h +=
          quadripulse_controller14_B.Selector[offset];
        tmp++;
      }

      y = count;
      quadripulse_controller14_B.Mean_l =
        quadripulse_controller14_DW.Mean_AccVal_h / y;
    }

    outAddOffset = quadripulse_controller14_DW.Selector_DIMS1[0];
    outAddOffset *= quadripulse_controller14_DW.Selector_DIMS1[1];
  }

  /* End of S-Function (sdspstatfcns): '<S10>/Mean' */
}

/* Model update function for TID1 */
static void quadripulse_controller14_update1(void) /* Sample time: [0.01s, 0.0s] */
{
  /* Update absolute time */
  /* The "clockTick1" counts the number of times the code of this task has
   * been executed. The absolute time is the multiplication of "clockTick1"
   * and "Timing.stepSize1". Size of "clockTick1" ensures timer will not
   * overflow during the application lifespan selected.
   * Timer of this task consists of two 32 bit unsigned integers.
   * The two integers represent the low bits Timing.clockTick1 and the high bits
   * Timing.clockTickH1. When the low bit overflows to 0, the high bits increment.
   */
  if (!(++quadripulse_controller14_M->Timing.clockTick1)) {
    ++quadripulse_controller14_M->Timing.clockTickH1;
  }

  quadripulse_controller14_M->Timing.t[1] =
    quadripulse_controller14_M->Timing.clockTick1 *
    quadripulse_controller14_M->Timing.stepSize1 +
    quadripulse_controller14_M->Timing.clockTickH1 *
    quadripulse_controller14_M->Timing.stepSize1 * 4294967296.0;
}

/* Model output function for TID2 */
static void quadripulse_controller14_output2(void) /* Sample time: [0.1s, 0.0s] */
{
  int32_T i;
  int32_T offsetFromMemBase;
  int32_T nSamps;
  int32_T yIdx;
  int32_T loop;

  /* Reset subsysRan breadcrumbs */
  srClearBC(quadripulse_controller14_DW.EnabledSubsystem_SubsysRanBC);

  /* RateTransition: '<Root>/Rate Transition2' */
  quadripulse_controller14_B.RateTransition2_n =
    quadripulse_controller14_B.Mean_l;

  /* Outputs for Enabled SubSystem: '<S23>/Enabled Subsystem' incorporates:
   *  EnablePort: '<S38>/Enable'
   */
  if (quadripulse_controller14_B.RateTransition_j) {
    /* Buffer: '<S38>/Buffer' */
    loop = 599 - quadripulse_controller14_DW.Buffer_CircBufIdx_d;
    nSamps = quadripulse_controller14_DW.Buffer_CircBufIdx_d;
    for (i = 0; i < loop; i++) {
      quadripulse_controller14_B.Buffer_p[i] =
        quadripulse_controller14_DW.Buffer_CircBuff_a[nSamps + i];
    }

    yIdx = loop;
    for (i = 0; i < quadripulse_controller14_DW.Buffer_CircBufIdx_d; i++) {
      quadripulse_controller14_B.Buffer_p[yIdx + i] =
        quadripulse_controller14_DW.Buffer_CircBuff_a[i];
    }

    yIdx -= loop;
    quadripulse_controller14_B.Buffer_p[yIdx + 599] =
      quadripulse_controller14_B.RateTransition2_n;
    nSamps = quadripulse_controller14_DW.Buffer_CircBufIdx_d;
    quadripulse_controller14_DW.Buffer_CircBuff_a[nSamps] =
      quadripulse_controller14_B.RateTransition2_n;
    quadripulse_controller14_DW.Buffer_CircBufIdx_d++;
    if (quadripulse_controller14_DW.Buffer_CircBufIdx_d >= 599) {
      quadripulse_controller14_DW.Buffer_CircBufIdx_d -= 599;
    }

    /* End of Buffer: '<S38>/Buffer' */
    srUpdateBC(quadripulse_controller14_DW.EnabledSubsystem_SubsysRanBC);
  }

  /* End of Outputs for SubSystem: '<S23>/Enabled Subsystem' */
  /* DSP System Toolbox Sort (sdspsrt2) - '<S23>/Sort' */
  {
    const real_T *u = &quadripulse_controller14_B.Buffer_p[0];
    real_T *y = &quadripulse_controller14_B.Sort[0];
    memcpy(y, u, 600*sizeof(real_T));
    MWDSP_Sort_Qk_Val_D(y, 0, 599);
  }

  /* Sum: '<S23>/Subtract' incorporates:
   *  Constant: '<S23>/Constant'
   */
  quadripulse_controller14_B.Subtract_f = quadripulse_controller14_B.Probe[0] -
    quadripulse_controller14_P.Constant_Value_g;

  /* Product: '<S23>/Multiply' incorporates:
   *  Constant: '<Root>/Constant5'
   */
  quadripulse_controller14_B.Multiply[0] = quadripulse_controller14_B.Subtract_f
    * quadripulse_controller14_P.amplitudeinterval_percentiles[0];

  /* Rounding: '<S23>/Rounding Function' */
  quadripulse_controller14_B.RoundingFunction[0] = rt_roundd_snf
    (quadripulse_controller14_B.Multiply[0]);

  /* Product: '<S23>/Multiply' incorporates:
   *  Constant: '<Root>/Constant5'
   */
  quadripulse_controller14_B.Multiply[1] = quadripulse_controller14_B.Subtract_f
    * quadripulse_controller14_P.amplitudeinterval_percentiles[1];

  /* Rounding: '<S23>/Rounding Function' */
  quadripulse_controller14_B.RoundingFunction[1] = rt_roundd_snf
    (quadripulse_controller14_B.Multiply[1]);

  /* Selector: '<S23>/Selector' */
  quadripulse_controller14_B.Selector_m[0] = quadripulse_controller14_B.Sort
    [(int32_T)quadripulse_controller14_B.RoundingFunction[0]];

  /* Reshape: '<S23>/Reshape1' */
  quadripulse_controller14_B.Reshape1_a[0] =
    quadripulse_controller14_B.Selector_m[0];

  /* Selector: '<S23>/Selector' */
  quadripulse_controller14_B.Selector_m[1] = quadripulse_controller14_B.Sort
    [(int32_T)quadripulse_controller14_B.RoundingFunction[1]];

  /* Reshape: '<S23>/Reshape1' */
  quadripulse_controller14_B.Reshape1_a[1] =
    quadripulse_controller14_B.Selector_m[1];

  /* RateTransition: '<S10>/Rate Transition3' */
  memcpy(&quadripulse_controller14_B.RateTransition3_e[0],
         &quadripulse_controller14_B.scaletoperHz[0], sizeof(real_T) << 10U);
  for (loop = 0; loop < 100; loop++) {
    /* S-Function (sdspsubmtrx): '<S10>/Bins 2..51' */
    quadripulse_controller14_B.MatrixConcatenation[loop + 100] =
      quadripulse_controller14_B.RateTransition3_e[loop + 1];

    /* Constant: '<S28>/Constant' */
    quadripulse_controller14_B.MatrixConcatenation[loop] =
      quadripulse_controller14_P.Constant5_Value[loop];
  }

  /* Unbuffer: '<S10>/Unbuffer' */
  yIdx = 0;
  nSamps = 100;
  loop = 200 - quadripulse_controller14_DW.Unbuffer_inBufPtrIdx;
  offsetFromMemBase = quadripulse_controller14_DW.Unbuffer_inBufPtrIdx;
  if (loop <= 100) {
    for (i = 0; i < loop; i++) {
      quadripulse_controller14_DW.Unbuffer_CircBuf[offsetFromMemBase + i] =
        quadripulse_controller14_B.MatrixConcatenation[i];
    }

    yIdx = loop;
    offsetFromMemBase = 0;
    nSamps = 100 - loop;
  }

  for (i = 0; i < nSamps; i++) {
    quadripulse_controller14_DW.Unbuffer_CircBuf[offsetFromMemBase + i] =
      quadripulse_controller14_B.MatrixConcatenation[yIdx + i];
  }

  yIdx += nSamps;
  nSamps = 100;
  loop = 200 - quadripulse_controller14_DW.Unbuffer_inBufPtrIdx;
  offsetFromMemBase = quadripulse_controller14_DW.Unbuffer_inBufPtrIdx + 200;
  if (loop <= 100) {
    for (i = 0; i < loop; i++) {
      quadripulse_controller14_DW.Unbuffer_CircBuf[offsetFromMemBase + i] =
        quadripulse_controller14_B.MatrixConcatenation[yIdx + i];
    }

    yIdx += loop;
    offsetFromMemBase = 200;
    nSamps = 100 - loop;
  }

  for (i = 0; i < nSamps; i++) {
    quadripulse_controller14_DW.Unbuffer_CircBuf[offsetFromMemBase + i] =
      quadripulse_controller14_B.MatrixConcatenation[yIdx + i];
  }

  quadripulse_controller14_DW.Unbuffer_inBufPtrIdx += 100;
  if (quadripulse_controller14_DW.Unbuffer_inBufPtrIdx >= 200) {
    quadripulse_controller14_DW.Unbuffer_inBufPtrIdx -= 200;
  }

  /* End of Unbuffer: '<S10>/Unbuffer' */
}

/* Model update function for TID2 */
static void quadripulse_controller14_update2(void) /* Sample time: [0.1s, 0.0s] */
{
  /* Update absolute time */
  /* The "clockTick2" counts the number of times the code of this task has
   * been executed. The absolute time is the multiplication of "clockTick2"
   * and "Timing.stepSize2". Size of "clockTick2" ensures timer will not
   * overflow during the application lifespan selected.
   * Timer of this task consists of two 32 bit unsigned integers.
   * The two integers represent the low bits Timing.clockTick2 and the high bits
   * Timing.clockTickH2. When the low bit overflows to 0, the high bits increment.
   */
  if (!(++quadripulse_controller14_M->Timing.clockTick2)) {
    ++quadripulse_controller14_M->Timing.clockTickH2;
  }

  quadripulse_controller14_M->Timing.t[2] =
    quadripulse_controller14_M->Timing.clockTick2 *
    quadripulse_controller14_M->Timing.stepSize2 +
    quadripulse_controller14_M->Timing.clockTickH2 *
    quadripulse_controller14_M->Timing.stepSize2 * 4294967296.0;
}

/* Model output function for TID3 */
static void quadripulse_controller14_output3(void) /* Sample time: [0.5s, 0.0s] */
{
  /* (no output code required) */
}

/* Model update function for TID3 */
static void quadripulse_controller14_update3(void) /* Sample time: [0.5s, 0.0s] */
{
  /* Update absolute time */
  /* The "clockTick3" counts the number of times the code of this task has
   * been executed. The absolute time is the multiplication of "clockTick3"
   * and "Timing.stepSize3". Size of "clockTick3" ensures timer will not
   * overflow during the application lifespan selected.
   * Timer of this task consists of two 32 bit unsigned integers.
   * The two integers represent the low bits Timing.clockTick3 and the high bits
   * Timing.clockTickH3. When the low bit overflows to 0, the high bits increment.
   */
  if (!(++quadripulse_controller14_M->Timing.clockTick3)) {
    ++quadripulse_controller14_M->Timing.clockTickH3;
  }

  quadripulse_controller14_M->Timing.t[3] =
    quadripulse_controller14_M->Timing.clockTick3 *
    quadripulse_controller14_M->Timing.stepSize3 +
    quadripulse_controller14_M->Timing.clockTickH3 *
    quadripulse_controller14_M->Timing.stepSize3 * 4294967296.0;
}

/* Model output wrapper function for compatibility with a static main program */
static void quadripulse_controller14_output(int_T tid)
{
  switch (tid) {
   case 0 :
    quadripulse_controller14_output0();
    break;

   case 1 :
    quadripulse_controller14_output1();
    break;

   case 2 :
    quadripulse_controller14_output2();
    break;

   case 3 :
    quadripulse_controller14_output3();
    break;

   default :
    break;
  }
}

/* Model update wrapper function for compatibility with a static main program */
static void quadripulse_controller14_update(int_T tid)
{
  switch (tid) {
   case 0 :
    quadripulse_controller14_update0();
    break;

   case 1 :
    quadripulse_controller14_update1();
    break;

   case 2 :
    quadripulse_controller14_update2();
    break;

   case 3 :
    quadripulse_controller14_update3();
    break;

   default :
    break;
  }
}

/* Model initialize function */
static void quadripulse_controller14_initialize(void)
{
  {
    dsp_HighpassFilter_quadripuls_T *obj;
    dsp_HighpassFilter_quadripuls_T *obj_0;
    dspcodegen_FIRFilter_quadripu_T *FIR;
    dspcodegen_FIRFilter_quadripu_T *obj_1;
    dsp_FIRFilter_0_quadripulse_c_T *obj_2;
    real_T val[201];
    int32_T i;
    static const real_T tmp[201] = { 0.0023617195364993488,
      -0.00095361396970737393, -0.00082036991771363657, -0.00073192510790854248,
      -0.00067762446447440917, -0.00064950364757128734, -0.00064161159568770277,
      -0.00064950341668676425, -0.00066986079022773176, -0.00070020780548595929,
      -0.00073869823748666465, -0.00078395629087232063, -0.00083495736518492689,
      -0.000890938781305331, -0.00095133292746796142, -0.001015717193734848,
      -0.0010837764715576326, -0.0011552750585249985, -0.0012300356073810465,
      -0.0013079233467078362, -0.001388834250951971, -0.001472686167799215,
      -0.0015594121610024135, -0.0016489555140693248, -0.0017412659785808226,
      -0.0018362969569208751, -0.0019340033861991041, -0.00203434014961865,
      -0.0021372608848382706, -0.0022427170918928986, -0.002350657467815041,
      -0.0024610274132681451, -0.0025737686705449951, -0.0026888190622128411,
      -0.002806112307746448, -0.0029255779008694732, -0.0030471410349814849,
      -0.0031707225669138314, -0.003296239011984625, -0.0034236025647959079,
      -0.0035527211418504368, -0.0036834984427703433, -0.0038158340279070982,
      -0.003949623410424004, -0.0040847581615697714, -0.0042211260279419955,
      -0.0043586110599512151, -0.0044970937506738909, -0.0046364511845555451,
      -0.0047765571953570923, -0.00491728253292518, -0.0050584950382767573,
      -0.0052000598266295365, -0.0053418394779056006, -0.0054836942343543353,
      -0.0056254822048250564, -0.005767059575332377, -0.0059082808254303648,
      -0.0060489989500256656, -0.0061890656861266239, -0.00632833174413786,
      -0.0064666470431798883, -0.0066038609500200336, -0.0067398225210805185,
      -0.0068743807470838039, -0.007007384799795075, -0.0071386842803951274,
      -0.0072681294689439955, -0.0073955715744433576, -0.007520862984964404,
      -0.0076438575173270289, -0.007764410665809224, -0.0078823798493547828,
      -0.0079976246567737587, -0.0081100070893938853, -0.0082193918006745748,
      -0.0083256463322391224, -0.00842864134585736, -0.0085282508508390288,
      -0.0086243524263912748, -0.0087168274384154167, -0.0088055612503180631,
      -0.0088904434273337565, -0.00897136793395865, -0.0090482333240216924,
      -0.0091209429230177212, -0.00918940500226622, -0.0092535329445474525,
      -0.0093132454008205082, -0.0093684664377064759, -0.0094191256753872882,
      -0.0094651584156353677, -0.0095065057596762318, -0.0095431147156339879,
      -0.0095749382953142434, -0.0096019356001144831, -0.00962407189586954,
      -0.0096413186764648471, -0.0096536537160799227, -0.0096610611099401753,
      0.99033646869650571, -0.0096610611099401753, -0.0096536537160799227,
      -0.0096413186764648471, -0.00962407189586954, -0.0096019356001144831,
      -0.0095749382953142434, -0.0095431147156339879, -0.0095065057596762318,
      -0.0094651584156353677, -0.0094191256753872882, -0.0093684664377064759,
      -0.0093132454008205082, -0.0092535329445474525, -0.00918940500226622,
      -0.0091209429230177212, -0.0090482333240216924, -0.00897136793395865,
      -0.0088904434273337565, -0.0088055612503180631, -0.0087168274384154167,
      -0.0086243524263912748, -0.0085282508508390288, -0.00842864134585736,
      -0.0083256463322391224, -0.0082193918006745748, -0.0081100070893938853,
      -0.0079976246567737587, -0.0078823798493547828, -0.007764410665809224,
      -0.0076438575173270289, -0.007520862984964404, -0.0073955715744433576,
      -0.0072681294689439955, -0.0071386842803951274, -0.007007384799795075,
      -0.0068743807470838039, -0.0067398225210805185, -0.0066038609500200336,
      -0.0064666470431798883, -0.00632833174413786, -0.0061890656861266239,
      -0.0060489989500256656, -0.0059082808254303648, -0.005767059575332377,
      -0.0056254822048250564, -0.0054836942343543353, -0.0053418394779056006,
      -0.0052000598266295365, -0.0050584950382767573, -0.00491728253292518,
      -0.0047765571953570923, -0.0046364511845555451, -0.0044970937506738909,
      -0.0043586110599512151, -0.0042211260279419955, -0.0040847581615697714,
      -0.003949623410424004, -0.0038158340279070982, -0.0036834984427703433,
      -0.0035527211418504368, -0.0034236025647959079, -0.003296239011984625,
      -0.0031707225669138314, -0.0030471410349814849, -0.0029255779008694732,
      -0.002806112307746448, -0.0026888190622128411, -0.0025737686705449951,
      -0.0024610274132681451, -0.002350657467815041, -0.0022427170918928986,
      -0.0021372608848382706, -0.00203434014961865, -0.0019340033861991041,
      -0.0018362969569208751, -0.0017412659785808226, -0.0016489555140693248,
      -0.0015594121610024135, -0.001472686167799215, -0.001388834250951971,
      -0.0013079233467078362, -0.0012300356073810465, -0.0011552750585249985,
      -0.0010837764715576326, -0.001015717193734848, -0.00095133292746796142,
      -0.000890938781305331, -0.00083495736518492689, -0.00078395629087232063,
      -0.00073869823748666465, -0.00070020780548595929, -0.00066986079022773176,
      -0.00064950341668676425, -0.00064161159568770277, -0.00064950364757128734,
      -0.00067762446447440917, -0.00073192510790854248, -0.00082036991771363657,
      -0.00095361396970737393, 0.0023617195364993488 };

    static const real_T tmp_0[201] = { 0.0023617195364993488,
      -0.00095361396970737393, -0.00082036991771363657, -0.00073192510790854248,
      -0.00067762446447440917, -0.00064950364757128734, -0.00064161159568770277,
      -0.00064950341668676425, -0.00066986079022773176, -0.00070020780548595929,
      -0.00073869823748666465, -0.00078395629087232063, -0.00083495736518492689,
      -0.000890938781305331, -0.00095133292746796142, -0.001015717193734848,
      -0.0010837764715576326, -0.0011552750585249985, -0.0012300356073810465,
      -0.0013079233467078362, -0.001388834250951971, -0.001472686167799215,
      -0.0015594121610024135, -0.0016489555140693248, -0.0017412659785808226,
      -0.0018362969569208751, -0.0019340033861991041, -0.00203434014961865,
      -0.0021372608848382706, -0.0022427170918928986, -0.002350657467815041,
      -0.0024610274132681451, -0.0025737686705449951, -0.0026888190622128411,
      -0.002806112307746448, -0.0029255779008694732, -0.0030471410349814849,
      -0.0031707225669138314, -0.003296239011984625, -0.0034236025647959079,
      -0.0035527211418504368, -0.0036834984427703433, -0.0038158340279070982,
      -0.003949623410424004, -0.0040847581615697714, -0.0042211260279419955,
      -0.0043586110599512151, -0.0044970937506738909, -0.0046364511845555451,
      -0.0047765571953570923, -0.00491728253292518, -0.0050584950382767573,
      -0.0052000598266295365, -0.0053418394779056006, -0.0054836942343543353,
      -0.0056254822048250564, -0.005767059575332377, -0.0059082808254303648,
      -0.0060489989500256656, -0.0061890656861266239, -0.00632833174413786,
      -0.0064666470431798883, -0.0066038609500200336, -0.0067398225210805185,
      -0.0068743807470838039, -0.007007384799795075, -0.0071386842803951274,
      -0.0072681294689439955, -0.0073955715744433576, -0.007520862984964404,
      -0.0076438575173270289, -0.007764410665809224, -0.0078823798493547828,
      -0.0079976246567737587, -0.0081100070893938853, -0.0082193918006745748,
      -0.0083256463322391224, -0.00842864134585736, -0.0085282508508390288,
      -0.0086243524263912748, -0.0087168274384154167, -0.0088055612503180631,
      -0.0088904434273337565, -0.00897136793395865, -0.0090482333240216924,
      -0.0091209429230177212, -0.00918940500226622, -0.0092535329445474525,
      -0.0093132454008205082, -0.0093684664377064759, -0.0094191256753872882,
      -0.0094651584156353677, -0.0095065057596762318, -0.0095431147156339879,
      -0.0095749382953142434, -0.0096019356001144831, -0.00962407189586954,
      -0.0096413186764648471, -0.0096536537160799227, -0.0096610611099401753,
      0.99033646869650571, -0.0096610611099401753, -0.0096536537160799227,
      -0.0096413186764648471, -0.00962407189586954, -0.0096019356001144831,
      -0.0095749382953142434, -0.0095431147156339879, -0.0095065057596762318,
      -0.0094651584156353677, -0.0094191256753872882, -0.0093684664377064759,
      -0.0093132454008205082, -0.0092535329445474525, -0.00918940500226622,
      -0.0091209429230177212, -0.0090482333240216924, -0.00897136793395865,
      -0.0088904434273337565, -0.0088055612503180631, -0.0087168274384154167,
      -0.0086243524263912748, -0.0085282508508390288, -0.00842864134585736,
      -0.0083256463322391224, -0.0082193918006745748, -0.0081100070893938853,
      -0.0079976246567737587, -0.0078823798493547828, -0.007764410665809224,
      -0.0076438575173270289, -0.007520862984964404, -0.0073955715744433576,
      -0.0072681294689439955, -0.0071386842803951274, -0.007007384799795075,
      -0.0068743807470838039, -0.0067398225210805185, -0.0066038609500200336,
      -0.0064666470431798883, -0.00632833174413786, -0.0061890656861266239,
      -0.0060489989500256656, -0.0059082808254303648, -0.005767059575332377,
      -0.0056254822048250564, -0.0054836942343543353, -0.0053418394779056006,
      -0.0052000598266295365, -0.0050584950382767573, -0.00491728253292518,
      -0.0047765571953570923, -0.0046364511845555451, -0.0044970937506738909,
      -0.0043586110599512151, -0.0042211260279419955, -0.0040847581615697714,
      -0.003949623410424004, -0.0038158340279070982, -0.0036834984427703433,
      -0.0035527211418504368, -0.0034236025647959079, -0.003296239011984625,
      -0.0031707225669138314, -0.0030471410349814849, -0.0029255779008694732,
      -0.002806112307746448, -0.0026888190622128411, -0.0025737686705449951,
      -0.0024610274132681451, -0.002350657467815041, -0.0022427170918928986,
      -0.0021372608848382706, -0.00203434014961865, -0.0019340033861991041,
      -0.0018362969569208751, -0.0017412659785808226, -0.0016489555140693248,
      -0.0015594121610024135, -0.001472686167799215, -0.001388834250951971,
      -0.0013079233467078362, -0.0012300356073810465, -0.0011552750585249985,
      -0.0010837764715576326, -0.001015717193734848, -0.00095133292746796142,
      -0.000890938781305331, -0.00083495736518492689, -0.00078395629087232063,
      -0.00073869823748666465, -0.00070020780548595929, -0.00066986079022773176,
      -0.00064950341668676425, -0.00064161159568770277, -0.00064950364757128734,
      -0.00067762446447440917, -0.00073192510790854248, -0.00082036991771363657,
      -0.00095361396970737393, 0.0023617195364993488 };

    real_T val_0;

    /* Level2 S-Function Block: '<S19>/Buffer Mngmt ' (xpcnb) */
    {
      SimStruct *rts = quadripulse_controller14_M->childSfunctions[0];
      sfcnStart(rts);
      if (ssGetErrorStatus(rts) != (NULL))
        return;
    }

    /* Level2 S-Function Block: '<S19>/Ethernet Init ' (xpcetherinit) */
    {
      SimStruct *rts = quadripulse_controller14_M->childSfunctions[1];
      sfcnStart(rts);
      if (ssGetErrorStatus(rts) != (NULL))
        return;
    }

    /* Level2 S-Function Block: '<S19>/ARP Init ' (xpcdebugarpinit) */
    {
      SimStruct *rts = quadripulse_controller14_M->childSfunctions[2];
      sfcnStart(rts);
      if (ssGetErrorStatus(rts) != (NULL))
        return;
    }

    /* Level2 S-Function Block: '<S19>/IP Init ' (xpcdebugipinit) */
    {
      SimStruct *rts = quadripulse_controller14_M->childSfunctions[3];
      sfcnStart(rts);
      if (ssGetErrorStatus(rts) != (NULL))
        return;
    }

    /* Level2 S-Function Block: '<S19>/UDP Init ' (xpcdebugudpinit) */
    {
      SimStruct *rts = quadripulse_controller14_M->childSfunctions[4];
      sfcnStart(rts);
      if (ssGetErrorStatus(rts) != (NULL))
        return;
    }

    /* S-Function Block: <S1>/S-Function (scblock) */
    {
      int i;
      if ((i = rl32eScopeExists(3)) == 0) {
        if ((i = rl32eDefScope(3,2)) != 0) {
          printf("Error creating scope 3\n");
        } else {
          rl32eAddSignal(3, rl32eGetSignalNo("Rate Transition1"));
          rl32eAddSignal(3, rl32eGetSignalNo("Manual Switch/s1"));
          rl32eAddSignal(3, rl32eGetSignalNo("Manual Switch/s2"));
          rl32eSetScope(3, 4, 100);
          rl32eSetScope(3, 5, 0);
          rl32eSetScope(3, 6, 100);
          rl32eSetScope(3, 0, 0);
          rl32eSetScope(3, 3, rl32eGetSignalNo("Rate Transition1"));
          rl32eSetScope(3, 1, 0.5);
          rl32eSetScope(3, 2, 1);
          rl32eSetScope(3, 9, 0);
          rl32eSetTargetScope(3, 1, 2.0);
          rl32eSetTargetScope(3, 11, 0.0);
          rl32eSetTargetScope(3, 10, 0.0);
          xpceScopeAcqOK(3,
                         &quadripulse_controller14_DW.SFunction_IWORK.AcquireOK);
        }
      }

      if (i) {
        rl32eRestartAcquisition(3);
      }
    }

    /* S-Function Block: <S2>/S-Function (scblock) */
    {
      int i;
      if ((i = rl32eScopeExists(10)) == 0) {
        if ((i = rl32eDefScope(10,1)) != 0) {
          printf("Error creating scope 10\n");
        } else {
          rl32eAddSignal(10, rl32eGetSignalNo("Manual Switch/s1"));
          rl32eAddSignal(10, rl32eGetSignalNo("Manual Switch/s2"));
          rl32eSetScope(10, 4, 3);
          rl32eSetScope(10, 5, -2);
          rl32eSetScope(10, 6, 1);
          rl32eSetScope(10, 0, 2);
          rl32eSetScope(10, 3, rl32eGetSignalNo("S-R Flip-Flop/Logic/s1"));
          rl32eSetScope(10, 1, 0.5);
          rl32eSetScope(10, 2, 1);
          rl32eSetScope(10, 9, 0);
          xpceScopeAcqOK(10,
                         &quadripulse_controller14_DW.SFunction_IWORK_e.AcquireOK);
        }
      }

      if (i) {
        rl32eRestartAcquisition(10);
      }
    }

    /* S-Function Block: <S11>/S-Function (scblock) */
    {
      int i;
      if ((i = rl32eScopeExists(12)) == 0) {
        if ((i = rl32eDefScope(12,1)) != 0) {
          printf("Error creating scope 12\n");
        } else {
          rl32eAddSignal(12, rl32eGetSignalNo("Single Row/s1"));
          rl32eAddSignal(12, rl32eGetSignalNo("Single Row/s2"));
          rl32eAddSignal(12, rl32eGetSignalNo("Delay1"));
          rl32eAddSignal(12, rl32eGetSignalNo("Delay2"));
          rl32eSetScope(12, 4, 3000);
          rl32eSetScope(12, 5, -3000);
          rl32eSetScope(12, 6, 1);
          rl32eSetScope(12, 0, 2);
          rl32eSetScope(12, 3, rl32eGetSignalNo("S-R Flip-Flop/Logic/s1"));
          rl32eSetScope(12, 1, 0.5);
          rl32eSetScope(12, 2, 1);
          rl32eSetScope(12, 9, 0);
          xpceScopeAcqOK(12,
                         &quadripulse_controller14_DW.SFunction_IWORK_b.AcquireOK);
        }
      }

      if (i) {
        rl32eRestartAcquisition(12);
      }
    }

    /* S-Function Block: <S12>/S-Function (scblock) */
    {
      int i;
      if ((i = rl32eScopeExists(13)) == 0) {
        if ((i = rl32eDefScope(13,1)) != 0) {
          printf("Error creating scope 13\n");
        } else {
          rl32eAddSignal(13, rl32eGetSignalNo("Single Row/s1"));
          rl32eAddSignal(13, rl32eGetSignalNo("Single Row/s2"));
          rl32eAddSignal(13, rl32eGetSignalNo("Delay1"));
          rl32eAddSignal(13, rl32eGetSignalNo("Delay2"));
          rl32eSetScope(13, 4, 2000);
          rl32eSetScope(13, 5, -872);
          rl32eSetScope(13, 6, 1);
          rl32eSetScope(13, 0, 2);
          rl32eSetScope(13, 3, rl32eGetSignalNo("S-R Flip-Flop/Logic/s1"));
          rl32eSetScope(13, 1, 0.5);
          rl32eSetScope(13, 2, 1);
          rl32eSetScope(13, 9, 0);
          xpceScopeAcqOK(13,
                         &quadripulse_controller14_DW.SFunction_IWORK_n.AcquireOK);
        }
      }

      if (i) {
        rl32eRestartAcquisition(13);
      }
    }

    /* S-Function Block: <S13>/S-Function (scblock) */
    {
      int i;
      if ((i = rl32eScopeExists(14)) == 0) {
        if ((i = rl32eDefScope(14,1)) != 0) {
          printf("Error creating scope 14\n");
        } else {
          rl32eAddSignal(14, rl32eGetSignalNo("Reshape1/s1"));
          rl32eAddSignal(14, rl32eGetSignalNo("Reshape1/s2"));
          rl32eAddSignal(14, rl32eGetSignalNo("Reshape1/s3"));
          rl32eAddSignal(14, rl32eGetSignalNo("Reshape1/s4"));
          rl32eAddSignal(14, rl32eGetSignalNo("Reshape1/s5"));
          rl32eAddSignal(14, rl32eGetSignalNo("Reshape1/s6"));
          rl32eAddSignal(14, rl32eGetSignalNo("Reshape1/s7"));
          rl32eAddSignal(14, rl32eGetSignalNo("Reshape1/s8"));
          rl32eAddSignal(14, rl32eGetSignalNo("Reshape1/s9"));
          rl32eAddSignal(14, rl32eGetSignalNo("Reshape1/s10"));
          rl32eAddSignal(14, rl32eGetSignalNo("Reshape1/s11"));
          rl32eAddSignal(14, rl32eGetSignalNo("Reshape1/s12"));
          rl32eAddSignal(14, rl32eGetSignalNo("Reshape1/s13"));
          rl32eAddSignal(14, rl32eGetSignalNo("Reshape1/s14"));
          rl32eAddSignal(14, rl32eGetSignalNo("Reshape1/s15"));
          rl32eAddSignal(14, rl32eGetSignalNo("Reshape1/s16"));
          rl32eAddSignal(14, rl32eGetSignalNo("Reshape1/s17"));
          rl32eAddSignal(14, rl32eGetSignalNo("Reshape1/s18"));
          rl32eAddSignal(14, rl32eGetSignalNo("Reshape1/s19"));
          rl32eAddSignal(14, rl32eGetSignalNo("Reshape1/s20"));
          rl32eAddSignal(14, rl32eGetSignalNo("Reshape1/s21"));
          rl32eAddSignal(14, rl32eGetSignalNo("Reshape1/s22"));
          rl32eAddSignal(14, rl32eGetSignalNo("Reshape1/s23"));
          rl32eAddSignal(14, rl32eGetSignalNo("Reshape1/s24"));
          rl32eAddSignal(14, rl32eGetSignalNo("Reshape1/s25"));
          rl32eAddSignal(14, rl32eGetSignalNo("Reshape1/s26"));
          rl32eAddSignal(14, rl32eGetSignalNo("Reshape1/s27"));
          rl32eAddSignal(14, rl32eGetSignalNo("Reshape1/s28"));
          rl32eAddSignal(14, rl32eGetSignalNo("Reshape1/s29"));
          rl32eAddSignal(14, rl32eGetSignalNo("Reshape1/s30"));
          rl32eAddSignal(14, rl32eGetSignalNo("Reshape1/s31"));
          rl32eAddSignal(14, rl32eGetSignalNo("Reshape1/s32"));
          rl32eAddSignal(14, rl32eGetSignalNo("Reshape1/s33"));
          rl32eAddSignal(14, rl32eGetSignalNo("Reshape1/s34"));
          rl32eAddSignal(14, rl32eGetSignalNo("Reshape1/s35"));
          rl32eAddSignal(14, rl32eGetSignalNo("Reshape1/s36"));
          rl32eAddSignal(14, rl32eGetSignalNo("Reshape1/s37"));
          rl32eAddSignal(14, rl32eGetSignalNo("Reshape1/s38"));
          rl32eAddSignal(14, rl32eGetSignalNo("Reshape1/s39"));
          rl32eAddSignal(14, rl32eGetSignalNo("Reshape1/s40"));
          rl32eAddSignal(14, rl32eGetSignalNo("Reshape1/s41"));
          rl32eAddSignal(14, rl32eGetSignalNo("Reshape1/s42"));
          rl32eAddSignal(14, rl32eGetSignalNo("Reshape1/s43"));
          rl32eAddSignal(14, rl32eGetSignalNo("Reshape1/s44"));
          rl32eAddSignal(14, rl32eGetSignalNo("Reshape1/s45"));
          rl32eAddSignal(14, rl32eGetSignalNo("Reshape1/s46"));
          rl32eAddSignal(14, rl32eGetSignalNo("Reshape1/s47"));
          rl32eAddSignal(14, rl32eGetSignalNo("Reshape1/s48"));
          rl32eAddSignal(14, rl32eGetSignalNo("Reshape1/s49"));
          rl32eAddSignal(14, rl32eGetSignalNo("Reshape1/s50"));
          rl32eAddSignal(14, rl32eGetSignalNo("Reshape1/s51"));
          rl32eAddSignal(14, rl32eGetSignalNo("Reshape1/s52"));
          rl32eAddSignal(14, rl32eGetSignalNo("Reshape1/s53"));
          rl32eAddSignal(14, rl32eGetSignalNo("Reshape1/s54"));
          rl32eAddSignal(14, rl32eGetSignalNo("Reshape1/s55"));
          rl32eAddSignal(14, rl32eGetSignalNo("Reshape1/s56"));
          rl32eAddSignal(14, rl32eGetSignalNo("Reshape1/s57"));
          rl32eAddSignal(14, rl32eGetSignalNo("Reshape1/s58"));
          rl32eAddSignal(14, rl32eGetSignalNo("Reshape1/s59"));
          rl32eAddSignal(14, rl32eGetSignalNo("Reshape1/s60"));
          rl32eAddSignal(14, rl32eGetSignalNo("Reshape1/s61"));
          rl32eAddSignal(14, rl32eGetSignalNo("Reshape1/s62"));
          rl32eAddSignal(14, rl32eGetSignalNo("Reshape1/s63"));
          rl32eAddSignal(14, rl32eGetSignalNo("Reshape1/s64"));
          rl32eAddSignal(14, rl32eGetSignalNo("Reshape1/s65"));
          rl32eAddSignal(14, rl32eGetSignalNo("Reshape1/s66"));
          rl32eSetScope(14, 4, 2000);
          rl32eSetScope(14, 5, -1000);
          rl32eSetScope(14, 6, 1);
          rl32eSetScope(14, 0, 2);
          rl32eSetScope(14, 1, 0.5);
          rl32eSetScope(14, 2, 1);
          rl32eSetScope(14, 9, 0);
          xpceScopeAcqOK(14,
                         &quadripulse_controller14_DW.SFunction_IWORK_j.AcquireOK);
        }
      }

      if (i) {
        rl32eRestartAcquisition(14);
      }
    }

    /* S-Function Block: <S14>/S-Function (scblock) */
    {
      int i;
      if ((i = rl32eScopeExists(1)) == 0) {
        if ((i = rl32eDefScope(1,2)) != 0) {
          printf("Error creating scope 1\n");
        } else {
          rl32eAddSignal(1, rl32eGetSignalNo(
            "Fan Out with Offset for Scope Display /Add/s1"));
          rl32eAddSignal(1, rl32eGetSignalNo(
            "Fan Out with Offset for Scope Display /Add/s2"));
          rl32eAddSignal(1, rl32eGetSignalNo(
            "Fan Out with Offset for Scope Display /Add/s3"));
          rl32eAddSignal(1, rl32eGetSignalNo(
            "Fan Out with Offset for Scope Display /Add/s4"));
          rl32eAddSignal(1, rl32eGetSignalNo(
            "Fan Out with Offset for Scope Display /Add/s5"));
          rl32eSetScope(1, 4, 500);
          rl32eSetScope(1, 5, -250);
          rl32eSetScope(1, 6, 1);
          rl32eSetScope(1, 0, 0);
          rl32eSetScope(1, 3, rl32eGetSignalNo(
            "Fan Out with Offset for Scope Display /Add/s1"));
          rl32eSetScope(1, 1, 0.5);
          rl32eSetScope(1, 2, 1);
          rl32eSetScope(1, 9, 0);
          rl32eSetTargetScope(1, 11, 0.0);
          rl32eSetTargetScope(1, 10, 0.0);
          xpceScopeAcqOK(1,
                         &quadripulse_controller14_DW.SFunction_IWORK_np.AcquireOK);
        }
      }

      if (i) {
        rl32eRestartAcquisition(1);
      }
    }

    /* S-Function Block: <S15>/S-Function (scblock) */
    {
      int i;
      if ((i = rl32eScopeExists(11)) == 0) {
        if ((i = rl32eDefScope(11,1)) != 0) {
          printf("Error creating scope 11\n");
        } else {
          rl32eAddSignal(11, rl32eGetSignalNo("Highpass Filter/s1"));
          rl32eAddSignal(11, rl32eGetSignalNo("Highpass Filter/s2"));
          rl32eSetScope(11, 4, 150);
          rl32eSetScope(11, 5, 50);
          rl32eSetScope(11, 6, 1);
          rl32eSetScope(11, 0, 2);
          rl32eSetScope(11, 3, rl32eGetSignalNo("S-R Flip-Flop/Logic/s1"));
          rl32eSetScope(11, 1, 0.5);
          rl32eSetScope(11, 2, 1);
          rl32eSetScope(11, 9, 0);
          xpceScopeAcqOK(11,
                         &quadripulse_controller14_DW.SFunction_IWORK_k.AcquireOK);
        }
      }

      if (i) {
        rl32eRestartAcquisition(11);
      }
    }

    /* S-Function Block: <S18>/S-Function (scblock) */
    {
      int i;
      if ((i = rl32eScopeExists(2)) == 0) {
        if ((i = rl32eDefScope(2,2)) != 0) {
          printf("Error creating scope 2\n");
        } else {
          rl32eAddSignal(2, rl32eGetSignalNo("Single Row/s1"));
          rl32eAddSignal(2, rl32eGetSignalNo("Single Row/s2"));
          rl32eAddSignal(2, rl32eGetSignalNo("Delay1"));
          rl32eSetScope(2, 4, 500);
          rl32eSetScope(2, 5, -122);
          rl32eSetScope(2, 6, 1);
          rl32eSetScope(2, 0, 0);
          rl32eSetScope(2, 3, rl32eGetSignalNo("Single Row/s1"));
          rl32eSetScope(2, 1, 0.5);
          rl32eSetScope(2, 2, 1);
          rl32eSetScope(2, 9, 0);
          rl32eSetTargetScope(2, 11, -0.0);
          rl32eSetTargetScope(2, 10, 0.0);
          xpceScopeAcqOK(2,
                         &quadripulse_controller14_DW.SFunction_IWORK_o.AcquireOK);
        }
      }

      if (i) {
        rl32eRestartAcquisition(2);
      }
    }

    /* Level2 S-Function Block: '<S50>/UDP Rx 1' (xpcudprx) */
    {
      SimStruct *rts = quadripulse_controller14_M->childSfunctions[5];
      sfcnStart(rts);
      if (ssGetErrorStatus(rts) != (NULL))
        return;
    }

    /* Level2 S-Function Block: '<S50>/Buffer 1' (xpcnbbuffer) */
    {
      SimStruct *rts = quadripulse_controller14_M->childSfunctions[6];
      sfcnStart(rts);
      if (ssGetErrorStatus(rts) != (NULL))
        return;
    }

    /* Level2 S-Function Block: '<S50>/UDP Consume 1' (xpcudpconsume) */
    {
      SimStruct *rts = quadripulse_controller14_M->childSfunctions[7];
      sfcnStart(rts);
      if (ssGetErrorStatus(rts) != (NULL))
        return;
    }

    /* Start for Iterator SubSystem: '<S41>/Forecast' */
    /* Start for Probe: '<S43>/Number of Coefficients' */
    quadripulse_controller14_B.NumberofCoefficients = 30.0;

    /* Start for Probe: '<S43>/Frame Length' */
    quadripulse_controller14_B.FrameLength = 384.0;

    /* End of Start for SubSystem: '<S41>/Forecast' */

    /* Start for Probe: '<S23>/Probe' */
    quadripulse_controller14_B.Probe[0] = 600.0;
    quadripulse_controller14_B.Probe[1] = 1.0;

    /* Start for Enabled SubSystem: '<Root>/Trigger Generator' */
    quadripulse_controller14_DW.TriggerGenerator_MODE = false;

    /* End of Start for SubSystem: '<Root>/Trigger Generator' */
    /* Level2 S-Function Block: '<Root>/PD2-MF 12bit series' (doueipd2mfx) */
    {
      SimStruct *rts = quadripulse_controller14_M->childSfunctions[9];
      sfcnStart(rts);
      if (ssGetErrorStatus(rts) != (NULL))
        return;
    }

    /* Level2 S-Function Block: '<Root>/Parallel Port DO ' (parallelportdio) */
    {
      SimStruct *rts = quadripulse_controller14_M->childSfunctions[10];
      sfcnStart(rts);
      if (ssGetErrorStatus(rts) != (NULL))
        return;
    }

    /* S-Function Block: <S22>/S-Function (scblock) */
    {
      int i;
      if ((i = rl32eScopeExists(4)) == 0) {
        if ((i = rl32eDefScope(4,2)) != 0) {
          printf("Error creating scope 4\n");
        } else {
          rl32eAddSignal(4, rl32eGetSignalNo("Detrend and FFT/Data"));
          rl32eSetScope(4, 4, 100);
          rl32eSetScope(4, 5, 0);
          rl32eSetScope(4, 6, 1);
          rl32eSetScope(4, 0, 2);
          rl32eSetScope(4, 3, rl32eGetSignalNo("Detrend and FFT/Trigger Signal"));
          rl32eSetScope(4, 1, 0.5);
          rl32eSetScope(4, 2, 1);
          rl32eSetScope(4, 9, 0);
          rl32eSetTargetScope(4, 11, 0.0);
          rl32eSetTargetScope(4, 10, 0.0);
          xpceScopeAcqOK(4,
                         &quadripulse_controller14_DW.SFunction_IWORK_g.AcquireOK);
        }
      }

      if (i) {
        rl32eRestartAcquisition(4);
      }
    }

    /* Start for MATLABSystem: '<Root>/Highpass Filter' */
    obj = &quadripulse_controller14_DW.obj;
    obj_0 = obj;
    obj_0->isInitialized = 0;
    obj->NumChannels = -1.0;
    quadripulse_controller14_DW.objisempty = true;
    obj = &quadripulse_controller14_DW.obj;
    obj->pSampleRateDialog = quadripulse_controll_SampleRate;
    obj = &quadripulse_controller14_DW.obj;
    FIR = &quadripulse_controller14_DW.gobj_0;
    obj->isInitialized = 1;
    obj_0 = obj;
    obj_0->inputVarSize1[0] = 1U;
    obj_0->inputVarSize1[1] = 2U;
    for (i = 0; i < 6; i++) {
      obj_0->inputVarSize1[i + 2] = 1U;
    }

    obj_0 = obj;
    obj_1 = FIR;
    obj_1->isInitialized = 0;
    obj_2 = &FIR->cSFunObject;

    /* System object Constructor function: dsp.FIRFilter */
    obj_2->P0_InitialStates = 0.0;
    for (i = 0; i < 201; i++) {
      obj_2->P1_Coefficients[i] = tmp_0[i];
    }

    obj_1 = FIR;
    obj_2 = &obj_1->cSFunObject;
    for (i = 0; i < 201; i++) {
      val_0 = tmp[i];
      val[i] = val_0;
    }

    for (i = 0; i < 201; i++) {
      obj_2->P1_Coefficients[i] = val[i];
    }

    obj_0->FilterObj = FIR;
    obj->NumChannels = 2.0;

    /* End of Start for MATLABSystem: '<Root>/Highpass Filter' */
  }

  quadripulse_controller14_PrevZCX.HitCrossing_Input_ZCE = UNINITIALIZED_ZCSIG;
  quadripulse_controller14_PrevZCX.HitCrossing2_Input_ZCE = UNINITIALIZED_ZCSIG;
  quadripulse_controller14_PrevZCX.HitCrossing1_Input_ZCE = UNINITIALIZED_ZCSIG;
  quadripulse_controller14_PrevZCX.HitCrossing3_Input_ZCE = UNINITIALIZED_ZCSIG;
  quadripulse_controller14_PrevZCX.HitCrossing_Input_ZCE_n = UNINITIALIZED_ZCSIG;

  {
    boolean_T flag;
    dsp_HighpassFilter_quadripuls_T *obj;
    dspcodegen_FIRFilter_quadripu_T *obj_0;
    dsp_FIRFilter_0_quadripulse_c_T *obj_1;
    int32_T i;
    real_T obj_2;

    /* Communications System Toolbox Derepeat (scomdrpt2) - '<Root>/Derepeat' */
    {
      real_T *outBuf = &quadripulse_controller14_DW.Derepeat_Buffer[0];
      quadripulse_controller14_DW.Derepeat_PWORK.OutBuf = outBuf;

      /* Reset counter */
      quadripulse_controller14_DW.Derepeat_Count = 0;
    }

    /* InitializeConditions for Buffer: '<Root>/Buffer' */
    for (i = 0; i < 511; i++) {
      quadripulse_controller14_DW.Buffer_CircBuff[i] =
        quadripulse_controller14_P.Buffer_ic_n;
    }

    quadripulse_controller14_DW.Buffer_CircBufIdx = 0;

    /* End of InitializeConditions for Buffer: '<Root>/Buffer' */

    /* InitializeConditions for UnitDelay: '<S46>/UD' */
    quadripulse_controller14_DW.UD_DSTATE =
      quadripulse_controller14_P.Difference_ICPrevInput;

    /* InitializeConditions for S-Function (sdspwindow2): '<S10>/Window Function' */
    quadripulse_controller14_DW.WindowFunction_FLAG = false;

    /* InitializeConditions for UnitDelay: '<Root>/Unit Delay' */
    quadripulse_controller14_DW.UnitDelay_DSTATE_m =
      quadripulse_controller14_P.UnitDelay_InitialCondition_i;

    /* InitializeConditions for UnitDelay: '<S39>/Unit Delay' */
    quadripulse_controller14_DW.UnitDelay_DSTATE_b =
      quadripulse_controller14_P.UnitDelay_InitialCondition_m;

    /* InitializeConditions for Memory: '<S20>/Memory' */
    quadripulse_controller14_DW.Memory_PreviousInput =
      quadripulse_controller14_P.SRFlipFlop_initial_condition;
    for (i = 0; i < 128; i++) {
      /* InitializeConditions for DiscreteFir: '<S17>/FIR Bandpass Filter Forward' */
      quadripulse_controller14_DW.FIRBandpassFilterForward_states[i] =
        quadripulse_controller14_P.FIRBandpassFilterForward_Initia;

      /* InitializeConditions for DiscreteFir: '<S17>/FIR Bandpass Filter Backward' */
      quadripulse_controller14_DW.FIRBandpassFilterBackward_state[i] =
        quadripulse_controller14_P.FIRBandpassFilterBackward_Initi;

      /* InitializeConditions for Delay: '<Root>/Delay1' */
      quadripulse_controller14_DW.Delay1_DSTATE[i] =
        quadripulse_controller14_P.Delay1_InitialCondition;

      /* InitializeConditions for Delay: '<Root>/Delay2' */
      quadripulse_controller14_DW.Delay2_DSTATE[i] =
        quadripulse_controller14_P.Delay2_InitialCondition;
    }

    /* InitializeConditions for Unbuffer: '<S10>/Unbuffer' */
    for (i = 0; i < 400; i++) {
      quadripulse_controller14_DW.Unbuffer_CircBuf[i] =
        quadripulse_controller14_P.Unbuffer_ic;
    }

    quadripulse_controller14_DW.Unbuffer_inBufPtrIdx = 100;
    quadripulse_controller14_DW.Unbuffer_bufferLength = 100;
    quadripulse_controller14_DW.Unbuffer_outBufPtrIdx = 0;

    /* End of InitializeConditions for Unbuffer: '<S10>/Unbuffer' */

    /* InitializeConditions for Delay: '<S36>/Delay1' */
    for (i = 0; i < 5; i++) {
      quadripulse_controller14_DW.Delay1_DSTATE_e[i] =
        quadripulse_controller14_P.Delay1_InitialCondition_i;
    }

    /* End of InitializeConditions for Delay: '<S36>/Delay1' */

    /* InitializeConditions for Delay: '<S36>/Delay' */
    for (i = 0; i < 2500; i++) {
      quadripulse_controller14_DW.Delay_DSTATE[i] =
        quadripulse_controller14_P.Delay_InitialCondition;
    }

    quadripulse_controller14_DW.CircBufIdx = 0U;

    /* End of InitializeConditions for Delay: '<S36>/Delay' */

    /* SystemInitialize for Iterator SubSystem: '<S41>/Forecast' */
    /* InitializeConditions for UnitDelay: '<S43>/Unit Delay' */
    quadripulse_controller14_DW.UnitDelay_DSTATE =
      quadripulse_controller14_P.UnitDelay_InitialCondition;

    /* InitializeConditions for UnitDelay: '<S43>/Unit Delay1' */
    quadripulse_controller14_DW.UnitDelay1_DSTATE =
      quadripulse_controller14_P.UnitDelay1_InitialCondition;

    /* SystemInitialize for Outport: '<S43>/Forecast' */
    for (i = 0; i < 128; i++) {
      quadripulse_controller14_B.Assignment[i] =
        quadripulse_controller14_P.Forecast_Y0;
    }

    /* End of SystemInitialize for Outport: '<S43>/Forecast' */
    /* End of SystemInitialize for SubSystem: '<S41>/Forecast' */

    /* SystemInitialize for Enabled SubSystem: '<S23>/Enabled Subsystem' */
    /* InitializeConditions for Buffer: '<S38>/Buffer' */
    for (i = 0; i < 599; i++) {
      quadripulse_controller14_DW.Buffer_CircBuff_a[i] =
        quadripulse_controller14_P.Buffer_ic;
    }

    quadripulse_controller14_DW.Buffer_CircBufIdx_d = 0;

    /* End of InitializeConditions for Buffer: '<S38>/Buffer' */

    /* SystemInitialize for Outport: '<S38>/Out1' */
    for (i = 0; i < 600; i++) {
      quadripulse_controller14_B.Buffer_p[i] =
        quadripulse_controller14_P.Out1_Y0;
    }

    /* End of SystemInitialize for Outport: '<S38>/Out1' */
    /* End of SystemInitialize for SubSystem: '<S23>/Enabled Subsystem' */

    /* SystemInitialize for Enabled SubSystem: '<Root>/Trigger Generator' */
    /* InitializeConditions for Delay: '<S26>/Counter Delay' */
    quadripulse_controller14_DW.CounterDelay_DSTATE =
      quadripulse_controller14_P.CounterDelay_InitialCondition;

    /* InitializeConditions for UnitDelay: '<S47>/Output' */
    quadripulse_controller14_DW.Output_DSTATE =
      quadripulse_controller14_P.Output_InitialCondition;

    /* SystemInitialize for Outport: '<S26>/Channel' */
    quadripulse_controller14_B.Switch = quadripulse_controller14_P.Channel_Y0;

    /* End of SystemInitialize for SubSystem: '<Root>/Trigger Generator' */

    /* Start for MATLABSystem: '<Root>/Highpass Filter' incorporates:
     *  InitializeConditions for MATLABSystem: '<Root>/Highpass Filter'
     */
    obj = &quadripulse_controller14_DW.obj;
    flag = (obj->isInitialized == 1);
    if (flag) {
      obj = &quadripulse_controller14_DW.obj;
      if (obj->isInitialized == 1) {
        obj_0 = obj->FilterObj;
        if (obj_0->isInitialized == 1) {
          obj_1 = &obj_0->cSFunObject;

          /* System object Initialization function: dsp.FIRFilter */
          obj_2 = obj_1->P0_InitialStates;
          for (i = 0; i < 400; i++) {
            obj_1->W0_states[i] = obj_2;
          }
        }
      }
    }

    /* End of Start for MATLABSystem: '<Root>/Highpass Filter' */
  }
}

/* Model terminate function */
static void quadripulse_controller14_terminate(void)
{
  boolean_T flag;
  dsp_HighpassFilter_quadripuls_T *obj;
  dspcodegen_FIRFilter_quadripu_T *obj_0;

  /* Level2 S-Function Block: '<S19>/Buffer Mngmt ' (xpcnb) */
  {
    SimStruct *rts = quadripulse_controller14_M->childSfunctions[0];
    sfcnTerminate(rts);
  }

  /* Level2 S-Function Block: '<S19>/Ethernet Init ' (xpcetherinit) */
  {
    SimStruct *rts = quadripulse_controller14_M->childSfunctions[1];
    sfcnTerminate(rts);
  }

  /* Level2 S-Function Block: '<S19>/ARP Init ' (xpcdebugarpinit) */
  {
    SimStruct *rts = quadripulse_controller14_M->childSfunctions[2];
    sfcnTerminate(rts);
  }

  /* Level2 S-Function Block: '<S19>/IP Init ' (xpcdebugipinit) */
  {
    SimStruct *rts = quadripulse_controller14_M->childSfunctions[3];
    sfcnTerminate(rts);
  }

  /* Level2 S-Function Block: '<S19>/UDP Init ' (xpcdebugudpinit) */
  {
    SimStruct *rts = quadripulse_controller14_M->childSfunctions[4];
    sfcnTerminate(rts);
  }

  /* Level2 S-Function Block: '<S50>/UDP Rx 1' (xpcudprx) */
  {
    SimStruct *rts = quadripulse_controller14_M->childSfunctions[5];
    sfcnTerminate(rts);
  }

  /* Level2 S-Function Block: '<S50>/Buffer 1' (xpcnbbuffer) */
  {
    SimStruct *rts = quadripulse_controller14_M->childSfunctions[6];
    sfcnTerminate(rts);
  }

  /* Level2 S-Function Block: '<S50>/UDP Consume 1' (xpcudpconsume) */
  {
    SimStruct *rts = quadripulse_controller14_M->childSfunctions[7];
    sfcnTerminate(rts);
  }

  /* Level2 S-Function Block: '<S50>/Extract 1' (xpcnbextract) */
  {
    SimStruct *rts = quadripulse_controller14_M->childSfunctions[8];
    sfcnTerminate(rts);
  }

  /* Level2 S-Function Block: '<Root>/PD2-MF 12bit series' (doueipd2mfx) */
  {
    SimStruct *rts = quadripulse_controller14_M->childSfunctions[9];
    sfcnTerminate(rts);
  }

  /* Level2 S-Function Block: '<Root>/Parallel Port DO ' (parallelportdio) */
  {
    SimStruct *rts = quadripulse_controller14_M->childSfunctions[10];
    sfcnTerminate(rts);
  }

  /* Start for MATLABSystem: '<Root>/Highpass Filter' incorporates:
   *  Terminate for MATLABSystem: '<Root>/Highpass Filter'
   */
  obj = &quadripulse_controller14_DW.obj;
  flag = (obj->isInitialized == 1);
  if (flag) {
    obj = &quadripulse_controller14_DW.obj;
    if (obj->isInitialized == 1) {
      obj->isInitialized = 2;
      obj_0 = obj->FilterObj;
      if (obj_0->isInitialized == 1) {
        obj_0->isInitialized = 2;
      }

      obj->NumChannels = -1.0;
    }
  }

  /* End of Start for MATLABSystem: '<Root>/Highpass Filter' */
}

/*========================================================================*
 * Start of Classic call interface                                        *
 *========================================================================*/
void MdlOutputs(int_T tid)
{
  quadripulse_controller14_output(tid);
}

void MdlUpdate(int_T tid)
{
  quadripulse_controller14_update(tid);
}

void MdlInitializeSizes(void)
{
}

void MdlInitializeSampleTimes(void)
{
}

void MdlInitialize(void)
{
}

void MdlStart(void)
{
  quadripulse_controller14_initialize();
}

void MdlTerminate(void)
{
  quadripulse_controller14_terminate();
}

/* Registration function */
RT_MODEL_quadripulse_controller14_T *quadripulse_controller14(void)
{
  /* Registration code */

  /* initialize non-finites */
  rt_InitInfAndNaN(sizeof(real_T));

  /* initialize real-time model */
  (void) memset((void *)quadripulse_controller14_M, 0,
                sizeof(RT_MODEL_quadripulse_controller14_T));
  rtsiSetSolverName(&quadripulse_controller14_M->solverInfo,"FixedStepDiscrete");
  quadripulse_controller14_M->solverInfoPtr =
    (&quadripulse_controller14_M->solverInfo);

  /* Initialize timing info */
  {
    int_T *mdlTsMap = quadripulse_controller14_M->Timing.sampleTimeTaskIDArray;
    mdlTsMap[0] = 0;
    mdlTsMap[1] = 1;
    mdlTsMap[2] = 2;
    mdlTsMap[3] = 3;
    quadripulse_controller14_M->Timing.sampleTimeTaskIDPtr = (&mdlTsMap[0]);
    quadripulse_controller14_M->Timing.sampleTimes =
      (&quadripulse_controller14_M->Timing.sampleTimesArray[0]);
    quadripulse_controller14_M->Timing.offsetTimes =
      (&quadripulse_controller14_M->Timing.offsetTimesArray[0]);

    /* task periods */
    quadripulse_controller14_M->Timing.sampleTimes[0] = (0.001);
    quadripulse_controller14_M->Timing.sampleTimes[1] = (0.01);
    quadripulse_controller14_M->Timing.sampleTimes[2] = (0.1);
    quadripulse_controller14_M->Timing.sampleTimes[3] = (0.5);

    /* task offsets */
    quadripulse_controller14_M->Timing.offsetTimes[0] = (0.0);
    quadripulse_controller14_M->Timing.offsetTimes[1] = (0.0);
    quadripulse_controller14_M->Timing.offsetTimes[2] = (0.0);
    quadripulse_controller14_M->Timing.offsetTimes[3] = (0.0);
  }

  rtmSetTPtr(quadripulse_controller14_M,
             &quadripulse_controller14_M->Timing.tArray[0]);

  {
    int_T *mdlSampleHits = quadripulse_controller14_M->Timing.sampleHitArray;
    int_T *mdlPerTaskSampleHits =
      quadripulse_controller14_M->Timing.perTaskSampleHitsArray;
    quadripulse_controller14_M->Timing.perTaskSampleHits =
      (&mdlPerTaskSampleHits[0]);
    mdlSampleHits[0] = 1;
    quadripulse_controller14_M->Timing.sampleHits = (&mdlSampleHits[0]);
  }

  rtmSetTFinal(quadripulse_controller14_M, -1);
  quadripulse_controller14_M->Timing.stepSize0 = 0.001;
  quadripulse_controller14_M->Timing.stepSize1 = 0.01;
  quadripulse_controller14_M->Timing.stepSize2 = 0.1;
  quadripulse_controller14_M->Timing.stepSize3 = 0.5;

  /* Setup for data logging */
  {
    static RTWLogInfo rt_DataLoggingInfo;
    rt_DataLoggingInfo.loggingInterval = NULL;
    quadripulse_controller14_M->rtwLogInfo = &rt_DataLoggingInfo;
  }

  /* Setup for data logging */
  {
    rtliSetLogXSignalInfo(quadripulse_controller14_M->rtwLogInfo, (NULL));
    rtliSetLogXSignalPtrs(quadripulse_controller14_M->rtwLogInfo, (NULL));
    rtliSetLogT(quadripulse_controller14_M->rtwLogInfo, "");
    rtliSetLogX(quadripulse_controller14_M->rtwLogInfo, "");
    rtliSetLogXFinal(quadripulse_controller14_M->rtwLogInfo, "");
    rtliSetLogVarNameModifier(quadripulse_controller14_M->rtwLogInfo, "rt_");
    rtliSetLogFormat(quadripulse_controller14_M->rtwLogInfo, 2);
    rtliSetLogMaxRows(quadripulse_controller14_M->rtwLogInfo, 1000);
    rtliSetLogDecimation(quadripulse_controller14_M->rtwLogInfo, 1);
    rtliSetLogY(quadripulse_controller14_M->rtwLogInfo, "");
    rtliSetLogYSignalInfo(quadripulse_controller14_M->rtwLogInfo, (NULL));
    rtliSetLogYSignalPtrs(quadripulse_controller14_M->rtwLogInfo, (NULL));
  }

  quadripulse_controller14_M->solverInfoPtr =
    (&quadripulse_controller14_M->solverInfo);
  quadripulse_controller14_M->Timing.stepSize = (0.001);
  rtsiSetFixedStepSize(&quadripulse_controller14_M->solverInfo, 0.001);
  rtsiSetSolverMode(&quadripulse_controller14_M->solverInfo,
                    SOLVER_MODE_MULTITASKING);

  /* block I/O */
  quadripulse_controller14_M->ModelData.blockIO = ((void *)
    &quadripulse_controller14_B);
  (void) memset(((void *) &quadripulse_controller14_B), 0,
                sizeof(B_quadripulse_controller14_T));

  /* parameters */
  quadripulse_controller14_M->ModelData.defaultParam = ((real_T *)
    &quadripulse_controller14_P);

  /* states (dwork) */
  quadripulse_controller14_M->ModelData.dwork = ((void *)
    &quadripulse_controller14_DW);
  (void) memset((void *)&quadripulse_controller14_DW, 0,
                sizeof(DW_quadripulse_controller14_T));

  /* Initialize DataMapInfo substructure containing ModelMap for C API */
  quadripulse_controller14_InitializeDataMapInfo(quadripulse_controller14_M);

  /* child S-Function registration */
  {
    RTWSfcnInfo *sfcnInfo =
      &quadripulse_controller14_M->NonInlinedSFcns.sfcnInfo;
    quadripulse_controller14_M->sfcnInfo = (sfcnInfo);
    rtssSetErrorStatusPtr(sfcnInfo, (&rtmGetErrorStatus
      (quadripulse_controller14_M)));
    rtssSetNumRootSampTimesPtr(sfcnInfo,
      &quadripulse_controller14_M->Sizes.numSampTimes);
    quadripulse_controller14_M->NonInlinedSFcns.taskTimePtrs[0] = &(rtmGetTPtr
      (quadripulse_controller14_M)[0]);
    quadripulse_controller14_M->NonInlinedSFcns.taskTimePtrs[1] = &(rtmGetTPtr
      (quadripulse_controller14_M)[1]);
    quadripulse_controller14_M->NonInlinedSFcns.taskTimePtrs[2] = &(rtmGetTPtr
      (quadripulse_controller14_M)[2]);
    quadripulse_controller14_M->NonInlinedSFcns.taskTimePtrs[3] = &(rtmGetTPtr
      (quadripulse_controller14_M)[3]);
    rtssSetTPtrPtr(sfcnInfo,
                   quadripulse_controller14_M->NonInlinedSFcns.taskTimePtrs);
    rtssSetTStartPtr(sfcnInfo, &rtmGetTStart(quadripulse_controller14_M));
    rtssSetTFinalPtr(sfcnInfo, &rtmGetTFinal(quadripulse_controller14_M));
    rtssSetTimeOfLastOutputPtr(sfcnInfo, &rtmGetTimeOfLastOutput
      (quadripulse_controller14_M));
    rtssSetStepSizePtr(sfcnInfo, &quadripulse_controller14_M->Timing.stepSize);
    rtssSetStopRequestedPtr(sfcnInfo, &rtmGetStopRequested
      (quadripulse_controller14_M));
    rtssSetDerivCacheNeedsResetPtr(sfcnInfo,
      &quadripulse_controller14_M->ModelData.derivCacheNeedsReset);
    rtssSetZCCacheNeedsResetPtr(sfcnInfo,
      &quadripulse_controller14_M->ModelData.zCCacheNeedsReset);
    rtssSetBlkStateChangePtr(sfcnInfo,
      &quadripulse_controller14_M->ModelData.blkStateChange);
    rtssSetSampleHitsPtr(sfcnInfo,
                         &quadripulse_controller14_M->Timing.sampleHits);
    rtssSetPerTaskSampleHitsPtr(sfcnInfo,
      &quadripulse_controller14_M->Timing.perTaskSampleHits);
    rtssSetSimModePtr(sfcnInfo, &quadripulse_controller14_M->simMode);
    rtssSetSolverInfoPtr(sfcnInfo, &quadripulse_controller14_M->solverInfoPtr);
  }

  quadripulse_controller14_M->Sizes.numSFcns = (11);

  /* register each child */
  {
    (void) memset((void *)
                  &quadripulse_controller14_M->NonInlinedSFcns.childSFunctions[0],
                  0,
                  11*sizeof(SimStruct));
    quadripulse_controller14_M->childSfunctions =
      (&quadripulse_controller14_M->NonInlinedSFcns.childSFunctionPtrs[0]);

    {
      int_T i;
      for (i = 0; i < 11; i++) {
        quadripulse_controller14_M->childSfunctions[i] =
          (&quadripulse_controller14_M->NonInlinedSFcns.childSFunctions[i]);
      }
    }

    /* Level2 S-Function Block: quadripulse_controller14/<S19>/Buffer Mngmt  (xpcnb) */
    {
      SimStruct *rts = quadripulse_controller14_M->childSfunctions[0];

      /* timing info */
      time_T *sfcnPeriod =
        quadripulse_controller14_M->NonInlinedSFcns.Sfcn0.sfcnPeriod;
      time_T *sfcnOffset =
        quadripulse_controller14_M->NonInlinedSFcns.Sfcn0.sfcnOffset;
      int_T *sfcnTsMap =
        quadripulse_controller14_M->NonInlinedSFcns.Sfcn0.sfcnTsMap;
      (void) memset((void*)sfcnPeriod, 0,
                    sizeof(time_T)*1);
      (void) memset((void*)sfcnOffset, 0,
                    sizeof(time_T)*1);
      ssSetSampleTimePtr(rts, &sfcnPeriod[0]);
      ssSetOffsetTimePtr(rts, &sfcnOffset[0]);
      ssSetSampleTimeTaskIDPtr(rts, sfcnTsMap);

      /* Set up the mdlInfo pointer */
      {
        ssSetBlkInfo2Ptr(rts,
                         &quadripulse_controller14_M->NonInlinedSFcns.blkInfo2[0]);
      }

      ssSetRTWSfcnInfo(rts, quadripulse_controller14_M->sfcnInfo);

      /* Allocate memory of model methods 2 */
      {
        ssSetModelMethods2(rts,
                           &quadripulse_controller14_M->
                           NonInlinedSFcns.methods2[0]);
      }

      /* Allocate memory of model methods 3 */
      {
        ssSetModelMethods3(rts,
                           &quadripulse_controller14_M->
                           NonInlinedSFcns.methods3[0]);
      }

      /* Allocate memory for states auxilliary information */
      {
        ssSetStatesInfo2(rts,
                         &quadripulse_controller14_M->NonInlinedSFcns.statesInfo2
                         [0]);
        ssSetPeriodicStatesInfo(rts,
          &quadripulse_controller14_M->NonInlinedSFcns.periodicStatesInfo[0]);
      }

      /* path info */
      ssSetModelName(rts, "Buffer Mngmt ");
      ssSetPath(rts,
                "quadripulse_controller14/Real-time UDP  Configuration/Buffer Mngmt ");
      ssSetRTModel(rts,quadripulse_controller14_M);
      ssSetParentSS(rts, (NULL));
      ssSetRootSS(rts, rts);
      ssSetVersion(rts, SIMSTRUCT_VERSION_LEVEL2);

      /* parameters */
      {
        mxArray **sfcnParams = (mxArray **)
          &quadripulse_controller14_M->NonInlinedSFcns.Sfcn0.params;
        ssSetSFcnParamsCount(rts, 3);
        ssSetSFcnParamsPtr(rts, &sfcnParams[0]);
        ssSetSFcnParam(rts, 0, (mxArray*)
                       quadripulse_controller14_P.BufferMngmt_P1_Size);
        ssSetSFcnParam(rts, 1, (mxArray*)
                       quadripulse_controller14_P.BufferMngmt_P2_Size);
        ssSetSFcnParam(rts, 2, (mxArray*)
                       quadripulse_controller14_P.BufferMngmt_P3_Size);
      }

      /* registration */
      xpcnb(rts);
      sfcnInitializeSizes(rts);
      sfcnInitializeSampleTimes(rts);

      /* adjust sample time */
      ssSetSampleTime(rts, 0, 0.001);
      ssSetOffsetTime(rts, 0, 0.0);
      sfcnTsMap[0] = 0;

      /* set compiled values of dynamic vector attributes */
      ssSetNumNonsampledZCs(rts, 0);

      /* Update connectivity flags for each port */
      /* Update the BufferDstPort flags for each input port */
    }

    /* Level2 S-Function Block: quadripulse_controller14/<S19>/Ethernet Init  (xpcetherinit) */
    {
      SimStruct *rts = quadripulse_controller14_M->childSfunctions[1];

      /* timing info */
      time_T *sfcnPeriod =
        quadripulse_controller14_M->NonInlinedSFcns.Sfcn1.sfcnPeriod;
      time_T *sfcnOffset =
        quadripulse_controller14_M->NonInlinedSFcns.Sfcn1.sfcnOffset;
      int_T *sfcnTsMap =
        quadripulse_controller14_M->NonInlinedSFcns.Sfcn1.sfcnTsMap;
      (void) memset((void*)sfcnPeriod, 0,
                    sizeof(time_T)*1);
      (void) memset((void*)sfcnOffset, 0,
                    sizeof(time_T)*1);
      ssSetSampleTimePtr(rts, &sfcnPeriod[0]);
      ssSetOffsetTimePtr(rts, &sfcnOffset[0]);
      ssSetSampleTimeTaskIDPtr(rts, sfcnTsMap);

      /* Set up the mdlInfo pointer */
      {
        ssSetBlkInfo2Ptr(rts,
                         &quadripulse_controller14_M->NonInlinedSFcns.blkInfo2[1]);
      }

      ssSetRTWSfcnInfo(rts, quadripulse_controller14_M->sfcnInfo);

      /* Allocate memory of model methods 2 */
      {
        ssSetModelMethods2(rts,
                           &quadripulse_controller14_M->
                           NonInlinedSFcns.methods2[1]);
      }

      /* Allocate memory of model methods 3 */
      {
        ssSetModelMethods3(rts,
                           &quadripulse_controller14_M->
                           NonInlinedSFcns.methods3[1]);
      }

      /* Allocate memory for states auxilliary information */
      {
        ssSetStatesInfo2(rts,
                         &quadripulse_controller14_M->NonInlinedSFcns.statesInfo2
                         [1]);
        ssSetPeriodicStatesInfo(rts,
          &quadripulse_controller14_M->NonInlinedSFcns.periodicStatesInfo[1]);
      }

      /* path info */
      ssSetModelName(rts, "Ethernet Init ");
      ssSetPath(rts,
                "quadripulse_controller14/Real-time UDP  Configuration/Ethernet Init ");
      ssSetRTModel(rts,quadripulse_controller14_M);
      ssSetParentSS(rts, (NULL));
      ssSetRootSS(rts, rts);
      ssSetVersion(rts, SIMSTRUCT_VERSION_LEVEL2);

      /* parameters */
      {
        mxArray **sfcnParams = (mxArray **)
          &quadripulse_controller14_M->NonInlinedSFcns.Sfcn1.params;
        ssSetSFcnParamsCount(rts, 21);
        ssSetSFcnParamsPtr(rts, &sfcnParams[0]);
        ssSetSFcnParam(rts, 0, (mxArray*)
                       quadripulse_controller14_P.EthernetInit_P1_Size);
        ssSetSFcnParam(rts, 1, (mxArray*)
                       quadripulse_controller14_P.EthernetInit_P2_Size);
        ssSetSFcnParam(rts, 2, (mxArray*)
                       quadripulse_controller14_P.EthernetInit_P3_Size);
        ssSetSFcnParam(rts, 3, (mxArray*)
                       quadripulse_controller14_P.EthernetInit_P4_Size);
        ssSetSFcnParam(rts, 4, (mxArray*)
                       quadripulse_controller14_P.EthernetInit_P5_Size);
        ssSetSFcnParam(rts, 5, (mxArray*)
                       quadripulse_controller14_P.EthernetInit_P6_Size);
        ssSetSFcnParam(rts, 6, (mxArray*)
                       quadripulse_controller14_P.EthernetInit_P7_Size);
        ssSetSFcnParam(rts, 7, (mxArray*)
                       quadripulse_controller14_P.EthernetInit_P8_Size);
        ssSetSFcnParam(rts, 8, (mxArray*)
                       quadripulse_controller14_P.EthernetInit_P9_Size);
        ssSetSFcnParam(rts, 9, (mxArray*)
                       quadripulse_controller14_P.EthernetInit_P10_Size);
        ssSetSFcnParam(rts, 10, (mxArray*)
                       quadripulse_controller14_P.EthernetInit_P11_Size);
        ssSetSFcnParam(rts, 11, (mxArray*)
                       quadripulse_controller14_P.EthernetInit_P12_Size);
        ssSetSFcnParam(rts, 12, (mxArray*)
                       quadripulse_controller14_P.EthernetInit_P13_Size);
        ssSetSFcnParam(rts, 13, (mxArray*)
                       quadripulse_controller14_P.EthernetInit_P14_Size);
        ssSetSFcnParam(rts, 14, (mxArray*)
                       quadripulse_controller14_P.EthernetInit_P15_Size);
        ssSetSFcnParam(rts, 15, (mxArray*)
                       quadripulse_controller14_P.EthernetInit_P16_Size);
        ssSetSFcnParam(rts, 16, (mxArray*)
                       quadripulse_controller14_P.EthernetInit_P17_Size);
        ssSetSFcnParam(rts, 17, (mxArray*)
                       quadripulse_controller14_P.EthernetInit_P18_Size);
        ssSetSFcnParam(rts, 18, (mxArray*)
                       quadripulse_controller14_P.EthernetInit_P19_Size);
        ssSetSFcnParam(rts, 19, (mxArray*)
                       quadripulse_controller14_P.EthernetInit_P20_Size);
        ssSetSFcnParam(rts, 20, (mxArray*)
                       quadripulse_controller14_P.EthernetInit_P21_Size);
      }

      /* registration */
      xpcetherinit(rts);
      sfcnInitializeSizes(rts);
      sfcnInitializeSampleTimes(rts);

      /* adjust sample time */
      ssSetSampleTime(rts, 0, 0.001);
      ssSetOffsetTime(rts, 0, 0.0);
      sfcnTsMap[0] = 0;

      /* set compiled values of dynamic vector attributes */
      ssSetNumNonsampledZCs(rts, 0);

      /* Update connectivity flags for each port */
      /* Update the BufferDstPort flags for each input port */
    }

    /* Level2 S-Function Block: quadripulse_controller14/<S19>/ARP Init  (xpcdebugarpinit) */
    {
      SimStruct *rts = quadripulse_controller14_M->childSfunctions[2];

      /* timing info */
      time_T *sfcnPeriod =
        quadripulse_controller14_M->NonInlinedSFcns.Sfcn2.sfcnPeriod;
      time_T *sfcnOffset =
        quadripulse_controller14_M->NonInlinedSFcns.Sfcn2.sfcnOffset;
      int_T *sfcnTsMap =
        quadripulse_controller14_M->NonInlinedSFcns.Sfcn2.sfcnTsMap;
      (void) memset((void*)sfcnPeriod, 0,
                    sizeof(time_T)*1);
      (void) memset((void*)sfcnOffset, 0,
                    sizeof(time_T)*1);
      ssSetSampleTimePtr(rts, &sfcnPeriod[0]);
      ssSetOffsetTimePtr(rts, &sfcnOffset[0]);
      ssSetSampleTimeTaskIDPtr(rts, sfcnTsMap);

      /* Set up the mdlInfo pointer */
      {
        ssSetBlkInfo2Ptr(rts,
                         &quadripulse_controller14_M->NonInlinedSFcns.blkInfo2[2]);
      }

      ssSetRTWSfcnInfo(rts, quadripulse_controller14_M->sfcnInfo);

      /* Allocate memory of model methods 2 */
      {
        ssSetModelMethods2(rts,
                           &quadripulse_controller14_M->
                           NonInlinedSFcns.methods2[2]);
      }

      /* Allocate memory of model methods 3 */
      {
        ssSetModelMethods3(rts,
                           &quadripulse_controller14_M->
                           NonInlinedSFcns.methods3[2]);
      }

      /* Allocate memory for states auxilliary information */
      {
        ssSetStatesInfo2(rts,
                         &quadripulse_controller14_M->NonInlinedSFcns.statesInfo2
                         [2]);
        ssSetPeriodicStatesInfo(rts,
          &quadripulse_controller14_M->NonInlinedSFcns.periodicStatesInfo[2]);
      }

      /* path info */
      ssSetModelName(rts, "ARP Init ");
      ssSetPath(rts,
                "quadripulse_controller14/Real-time UDP  Configuration/ARP Init ");
      ssSetRTModel(rts,quadripulse_controller14_M);
      ssSetParentSS(rts, (NULL));
      ssSetRootSS(rts, rts);
      ssSetVersion(rts, SIMSTRUCT_VERSION_LEVEL2);

      /* parameters */
      {
        mxArray **sfcnParams = (mxArray **)
          &quadripulse_controller14_M->NonInlinedSFcns.Sfcn2.params;
        ssSetSFcnParamsCount(rts, 16);
        ssSetSFcnParamsPtr(rts, &sfcnParams[0]);
        ssSetSFcnParam(rts, 0, (mxArray*)
                       quadripulse_controller14_P.ARPInit_P1_Size);
        ssSetSFcnParam(rts, 1, (mxArray*)
                       quadripulse_controller14_P.ARPInit_P2_Size);
        ssSetSFcnParam(rts, 2, (mxArray*)
                       quadripulse_controller14_P.ARPInit_P3_Size);
        ssSetSFcnParam(rts, 3, (mxArray*)
                       quadripulse_controller14_P.ARPInit_P4_Size);
        ssSetSFcnParam(rts, 4, (mxArray*)
                       quadripulse_controller14_P.ARPInit_P5_Size);
        ssSetSFcnParam(rts, 5, (mxArray*)
                       quadripulse_controller14_P.ARPInit_P6_Size);
        ssSetSFcnParam(rts, 6, (mxArray*)
                       quadripulse_controller14_P.ARPInit_P7_Size);
        ssSetSFcnParam(rts, 7, (mxArray*)
                       quadripulse_controller14_P.ARPInit_P8_Size);
        ssSetSFcnParam(rts, 8, (mxArray*)
                       quadripulse_controller14_P.ARPInit_P9_Size);
        ssSetSFcnParam(rts, 9, (mxArray*)
                       quadripulse_controller14_P.ARPInit_P10_Size);
        ssSetSFcnParam(rts, 10, (mxArray*)
                       quadripulse_controller14_P.ARPInit_P11_Size);
        ssSetSFcnParam(rts, 11, (mxArray*)
                       quadripulse_controller14_P.ARPInit_P12_Size);
        ssSetSFcnParam(rts, 12, (mxArray*)
                       quadripulse_controller14_P.ARPInit_P13_Size);
        ssSetSFcnParam(rts, 13, (mxArray*)
                       quadripulse_controller14_P.ARPInit_P14_Size);
        ssSetSFcnParam(rts, 14, (mxArray*)
                       quadripulse_controller14_P.ARPInit_P15_Size);
        ssSetSFcnParam(rts, 15, (mxArray*)
                       quadripulse_controller14_P.ARPInit_P16_Size);
      }

      /* registration */
      xpcdebugarpinit(rts);
      sfcnInitializeSizes(rts);
      sfcnInitializeSampleTimes(rts);

      /* adjust sample time */
      ssSetSampleTime(rts, 0, 0.001);
      ssSetOffsetTime(rts, 0, 0.0);
      sfcnTsMap[0] = 0;

      /* set compiled values of dynamic vector attributes */
      ssSetNumNonsampledZCs(rts, 0);

      /* Update connectivity flags for each port */
      /* Update the BufferDstPort flags for each input port */
    }

    /* Level2 S-Function Block: quadripulse_controller14/<S19>/IP Init  (xpcdebugipinit) */
    {
      SimStruct *rts = quadripulse_controller14_M->childSfunctions[3];

      /* timing info */
      time_T *sfcnPeriod =
        quadripulse_controller14_M->NonInlinedSFcns.Sfcn3.sfcnPeriod;
      time_T *sfcnOffset =
        quadripulse_controller14_M->NonInlinedSFcns.Sfcn3.sfcnOffset;
      int_T *sfcnTsMap =
        quadripulse_controller14_M->NonInlinedSFcns.Sfcn3.sfcnTsMap;
      (void) memset((void*)sfcnPeriod, 0,
                    sizeof(time_T)*1);
      (void) memset((void*)sfcnOffset, 0,
                    sizeof(time_T)*1);
      ssSetSampleTimePtr(rts, &sfcnPeriod[0]);
      ssSetOffsetTimePtr(rts, &sfcnOffset[0]);
      ssSetSampleTimeTaskIDPtr(rts, sfcnTsMap);

      /* Set up the mdlInfo pointer */
      {
        ssSetBlkInfo2Ptr(rts,
                         &quadripulse_controller14_M->NonInlinedSFcns.blkInfo2[3]);
      }

      ssSetRTWSfcnInfo(rts, quadripulse_controller14_M->sfcnInfo);

      /* Allocate memory of model methods 2 */
      {
        ssSetModelMethods2(rts,
                           &quadripulse_controller14_M->
                           NonInlinedSFcns.methods2[3]);
      }

      /* Allocate memory of model methods 3 */
      {
        ssSetModelMethods3(rts,
                           &quadripulse_controller14_M->
                           NonInlinedSFcns.methods3[3]);
      }

      /* Allocate memory for states auxilliary information */
      {
        ssSetStatesInfo2(rts,
                         &quadripulse_controller14_M->NonInlinedSFcns.statesInfo2
                         [3]);
        ssSetPeriodicStatesInfo(rts,
          &quadripulse_controller14_M->NonInlinedSFcns.periodicStatesInfo[3]);
      }

      /* path info */
      ssSetModelName(rts, "IP Init ");
      ssSetPath(rts,
                "quadripulse_controller14/Real-time UDP  Configuration/IP Init ");
      ssSetRTModel(rts,quadripulse_controller14_M);
      ssSetParentSS(rts, (NULL));
      ssSetRootSS(rts, rts);
      ssSetVersion(rts, SIMSTRUCT_VERSION_LEVEL2);

      /* parameters */
      {
        mxArray **sfcnParams = (mxArray **)
          &quadripulse_controller14_M->NonInlinedSFcns.Sfcn3.params;
        ssSetSFcnParamsCount(rts, 12);
        ssSetSFcnParamsPtr(rts, &sfcnParams[0]);
        ssSetSFcnParam(rts, 0, (mxArray*)
                       quadripulse_controller14_P.IPInit_P1_Size);
        ssSetSFcnParam(rts, 1, (mxArray*)
                       quadripulse_controller14_P.IPInit_P2_Size);
        ssSetSFcnParam(rts, 2, (mxArray*)
                       quadripulse_controller14_P.IPInit_P3_Size);
        ssSetSFcnParam(rts, 3, (mxArray*)
                       quadripulse_controller14_P.IPInit_P4_Size);
        ssSetSFcnParam(rts, 4, (mxArray*)
                       quadripulse_controller14_P.IPInit_P5_Size);
        ssSetSFcnParam(rts, 5, (mxArray*)
                       quadripulse_controller14_P.IPInit_P6_Size);
        ssSetSFcnParam(rts, 6, (mxArray*)
                       quadripulse_controller14_P.IPInit_P7_Size);
        ssSetSFcnParam(rts, 7, (mxArray*)
                       quadripulse_controller14_P.IPInit_P8_Size);
        ssSetSFcnParam(rts, 8, (mxArray*)
                       quadripulse_controller14_P.IPInit_P9_Size);
        ssSetSFcnParam(rts, 9, (mxArray*)
                       quadripulse_controller14_P.IPInit_P10_Size);
        ssSetSFcnParam(rts, 10, (mxArray*)
                       quadripulse_controller14_P.IPInit_P11_Size);
        ssSetSFcnParam(rts, 11, (mxArray*)
                       quadripulse_controller14_P.IPInit_P12_Size);
      }

      /* registration */
      xpcdebugipinit(rts);
      sfcnInitializeSizes(rts);
      sfcnInitializeSampleTimes(rts);

      /* adjust sample time */
      ssSetSampleTime(rts, 0, 0.001);
      ssSetOffsetTime(rts, 0, 0.0);
      sfcnTsMap[0] = 0;

      /* set compiled values of dynamic vector attributes */
      ssSetNumNonsampledZCs(rts, 0);

      /* Update connectivity flags for each port */
      /* Update the BufferDstPort flags for each input port */
    }

    /* Level2 S-Function Block: quadripulse_controller14/<S19>/UDP Init  (xpcdebugudpinit) */
    {
      SimStruct *rts = quadripulse_controller14_M->childSfunctions[4];

      /* timing info */
      time_T *sfcnPeriod =
        quadripulse_controller14_M->NonInlinedSFcns.Sfcn4.sfcnPeriod;
      time_T *sfcnOffset =
        quadripulse_controller14_M->NonInlinedSFcns.Sfcn4.sfcnOffset;
      int_T *sfcnTsMap =
        quadripulse_controller14_M->NonInlinedSFcns.Sfcn4.sfcnTsMap;
      (void) memset((void*)sfcnPeriod, 0,
                    sizeof(time_T)*1);
      (void) memset((void*)sfcnOffset, 0,
                    sizeof(time_T)*1);
      ssSetSampleTimePtr(rts, &sfcnPeriod[0]);
      ssSetOffsetTimePtr(rts, &sfcnOffset[0]);
      ssSetSampleTimeTaskIDPtr(rts, sfcnTsMap);

      /* Set up the mdlInfo pointer */
      {
        ssSetBlkInfo2Ptr(rts,
                         &quadripulse_controller14_M->NonInlinedSFcns.blkInfo2[4]);
      }

      ssSetRTWSfcnInfo(rts, quadripulse_controller14_M->sfcnInfo);

      /* Allocate memory of model methods 2 */
      {
        ssSetModelMethods2(rts,
                           &quadripulse_controller14_M->
                           NonInlinedSFcns.methods2[4]);
      }

      /* Allocate memory of model methods 3 */
      {
        ssSetModelMethods3(rts,
                           &quadripulse_controller14_M->
                           NonInlinedSFcns.methods3[4]);
      }

      /* Allocate memory for states auxilliary information */
      {
        ssSetStatesInfo2(rts,
                         &quadripulse_controller14_M->NonInlinedSFcns.statesInfo2
                         [4]);
        ssSetPeriodicStatesInfo(rts,
          &quadripulse_controller14_M->NonInlinedSFcns.periodicStatesInfo[4]);
      }

      /* path info */
      ssSetModelName(rts, "UDP Init ");
      ssSetPath(rts,
                "quadripulse_controller14/Real-time UDP  Configuration/UDP Init ");
      ssSetRTModel(rts,quadripulse_controller14_M);
      ssSetParentSS(rts, (NULL));
      ssSetRootSS(rts, rts);
      ssSetVersion(rts, SIMSTRUCT_VERSION_LEVEL2);

      /* parameters */
      {
        mxArray **sfcnParams = (mxArray **)
          &quadripulse_controller14_M->NonInlinedSFcns.Sfcn4.params;
        ssSetSFcnParamsCount(rts, 5);
        ssSetSFcnParamsPtr(rts, &sfcnParams[0]);
        ssSetSFcnParam(rts, 0, (mxArray*)
                       quadripulse_controller14_P.UDPInit_P1_Size);
        ssSetSFcnParam(rts, 1, (mxArray*)
                       quadripulse_controller14_P.UDPInit_P2_Size);
        ssSetSFcnParam(rts, 2, (mxArray*)
                       quadripulse_controller14_P.UDPInit_P3_Size);
        ssSetSFcnParam(rts, 3, (mxArray*)
                       quadripulse_controller14_P.UDPInit_P4_Size);
        ssSetSFcnParam(rts, 4, (mxArray*)
                       quadripulse_controller14_P.UDPInit_P5_Size);
      }

      /* registration */
      xpcdebugudpinit(rts);
      sfcnInitializeSizes(rts);
      sfcnInitializeSampleTimes(rts);

      /* adjust sample time */
      ssSetSampleTime(rts, 0, 0.001);
      ssSetOffsetTime(rts, 0, 0.0);
      sfcnTsMap[0] = 0;

      /* set compiled values of dynamic vector attributes */
      ssSetNumNonsampledZCs(rts, 0);

      /* Update connectivity flags for each port */
      /* Update the BufferDstPort flags for each input port */
    }

    /* Level2 S-Function Block: quadripulse_controller14/<S50>/UDP Rx 1 (xpcudprx) */
    {
      SimStruct *rts = quadripulse_controller14_M->childSfunctions[5];

      /* timing info */
      time_T *sfcnPeriod =
        quadripulse_controller14_M->NonInlinedSFcns.Sfcn5.sfcnPeriod;
      time_T *sfcnOffset =
        quadripulse_controller14_M->NonInlinedSFcns.Sfcn5.sfcnOffset;
      int_T *sfcnTsMap =
        quadripulse_controller14_M->NonInlinedSFcns.Sfcn5.sfcnTsMap;
      (void) memset((void*)sfcnPeriod, 0,
                    sizeof(time_T)*1);
      (void) memset((void*)sfcnOffset, 0,
                    sizeof(time_T)*1);
      ssSetSampleTimePtr(rts, &sfcnPeriod[0]);
      ssSetOffsetTimePtr(rts, &sfcnOffset[0]);
      ssSetSampleTimeTaskIDPtr(rts, sfcnTsMap);

      /* Set up the mdlInfo pointer */
      {
        ssSetBlkInfo2Ptr(rts,
                         &quadripulse_controller14_M->NonInlinedSFcns.blkInfo2[5]);
      }

      ssSetRTWSfcnInfo(rts, quadripulse_controller14_M->sfcnInfo);

      /* Allocate memory of model methods 2 */
      {
        ssSetModelMethods2(rts,
                           &quadripulse_controller14_M->
                           NonInlinedSFcns.methods2[5]);
      }

      /* Allocate memory of model methods 3 */
      {
        ssSetModelMethods3(rts,
                           &quadripulse_controller14_M->
                           NonInlinedSFcns.methods3[5]);
      }

      /* Allocate memory for states auxilliary information */
      {
        ssSetStatesInfo2(rts,
                         &quadripulse_controller14_M->NonInlinedSFcns.statesInfo2
                         [5]);
        ssSetPeriodicStatesInfo(rts,
          &quadripulse_controller14_M->NonInlinedSFcns.periodicStatesInfo[5]);
      }

      /* outputs */
      {
        ssSetPortInfoForOutputs(rts,
          &quadripulse_controller14_M->NonInlinedSFcns.Sfcn5.outputPortInfo[0]);
        _ssSetNumOutputPorts(rts, 1);

        /* port 0 */
        {
          _ssSetOutputPortNumDimensions(rts, 0, 1);
          ssSetOutputPortWidth(rts, 0, 1);
          ssSetOutputPortSignal(rts, 0, ((uint32_T *)
            &quadripulse_controller14_B.UDPRx1));
        }
      }

      /* path info */
      ssSetModelName(rts, "UDP Rx 1");
      ssSetPath(rts, "quadripulse_controller14/UDP EEG Data/Receive 1/UDP Rx 1");
      ssSetRTModel(rts,quadripulse_controller14_M);
      ssSetParentSS(rts, (NULL));
      ssSetRootSS(rts, rts);
      ssSetVersion(rts, SIMSTRUCT_VERSION_LEVEL2);

      /* parameters */
      {
        mxArray **sfcnParams = (mxArray **)
          &quadripulse_controller14_M->NonInlinedSFcns.Sfcn5.params;
        ssSetSFcnParamsCount(rts, 6);
        ssSetSFcnParamsPtr(rts, &sfcnParams[0]);
        ssSetSFcnParam(rts, 0, (mxArray*)
                       quadripulse_controller14_P.UDPRx1_P1_Size);
        ssSetSFcnParam(rts, 1, (mxArray*)
                       quadripulse_controller14_P.UDPRx1_P2_Size);
        ssSetSFcnParam(rts, 2, (mxArray*)
                       quadripulse_controller14_P.UDPRx1_P3_Size);
        ssSetSFcnParam(rts, 3, (mxArray*)
                       quadripulse_controller14_P.UDPRx1_P4_Size);
        ssSetSFcnParam(rts, 4, (mxArray*)
                       quadripulse_controller14_P.UDPRx1_P5_Size);
        ssSetSFcnParam(rts, 5, (mxArray*)
                       quadripulse_controller14_P.UDPRx1_P6_Size);
      }

      /* work vectors */
      ssSetIWork(rts, (int_T *) &quadripulse_controller14_DW.UDPRx1_IWORK[0]);

      {
        struct _ssDWorkRecord *dWorkRecord = (struct _ssDWorkRecord *)
          &quadripulse_controller14_M->NonInlinedSFcns.Sfcn5.dWork;
        struct _ssDWorkAuxRecord *dWorkAuxRecord = (struct _ssDWorkAuxRecord *)
          &quadripulse_controller14_M->NonInlinedSFcns.Sfcn5.dWorkAux;
        ssSetSFcnDWork(rts, dWorkRecord);
        ssSetSFcnDWorkAux(rts, dWorkAuxRecord);
        _ssSetNumDWork(rts, 1);

        /* IWORK */
        ssSetDWorkWidth(rts, 0, 11);
        ssSetDWorkDataType(rts, 0,SS_INTEGER);
        ssSetDWorkComplexSignal(rts, 0, 0);
        ssSetDWork(rts, 0, &quadripulse_controller14_DW.UDPRx1_IWORK[0]);
      }

      /* registration */
      xpcudprx(rts);
      sfcnInitializeSizes(rts);
      sfcnInitializeSampleTimes(rts);

      /* adjust sample time */
      ssSetSampleTime(rts, 0, 0.001);
      ssSetOffsetTime(rts, 0, 0.0);
      sfcnTsMap[0] = 0;

      /* set compiled values of dynamic vector attributes */
      ssSetNumNonsampledZCs(rts, 0);

      /* Update connectivity flags for each port */
      _ssSetOutputPortConnected(rts, 0, 1);
      _ssSetOutputPortBeingMerged(rts, 0, 0);

      /* Update the BufferDstPort flags for each input port */
    }

    /* Level2 S-Function Block: quadripulse_controller14/<S50>/Buffer 1 (xpcnbbuffer) */
    {
      SimStruct *rts = quadripulse_controller14_M->childSfunctions[6];

      /* timing info */
      time_T *sfcnPeriod =
        quadripulse_controller14_M->NonInlinedSFcns.Sfcn6.sfcnPeriod;
      time_T *sfcnOffset =
        quadripulse_controller14_M->NonInlinedSFcns.Sfcn6.sfcnOffset;
      int_T *sfcnTsMap =
        quadripulse_controller14_M->NonInlinedSFcns.Sfcn6.sfcnTsMap;
      (void) memset((void*)sfcnPeriod, 0,
                    sizeof(time_T)*1);
      (void) memset((void*)sfcnOffset, 0,
                    sizeof(time_T)*1);
      ssSetSampleTimePtr(rts, &sfcnPeriod[0]);
      ssSetOffsetTimePtr(rts, &sfcnOffset[0]);
      ssSetSampleTimeTaskIDPtr(rts, sfcnTsMap);

      /* Set up the mdlInfo pointer */
      {
        ssSetBlkInfo2Ptr(rts,
                         &quadripulse_controller14_M->NonInlinedSFcns.blkInfo2[6]);
      }

      ssSetRTWSfcnInfo(rts, quadripulse_controller14_M->sfcnInfo);

      /* Allocate memory of model methods 2 */
      {
        ssSetModelMethods2(rts,
                           &quadripulse_controller14_M->
                           NonInlinedSFcns.methods2[6]);
      }

      /* Allocate memory of model methods 3 */
      {
        ssSetModelMethods3(rts,
                           &quadripulse_controller14_M->
                           NonInlinedSFcns.methods3[6]);
      }

      /* Allocate memory for states auxilliary information */
      {
        ssSetStatesInfo2(rts,
                         &quadripulse_controller14_M->NonInlinedSFcns.statesInfo2
                         [6]);
        ssSetPeriodicStatesInfo(rts,
          &quadripulse_controller14_M->NonInlinedSFcns.periodicStatesInfo[6]);
      }

      /* inputs */
      {
        _ssSetNumInputPorts(rts, 1);
        ssSetPortInfoForInputs(rts,
          &quadripulse_controller14_M->NonInlinedSFcns.Sfcn6.inputPortInfo[0]);

        /* port 0 */
        {
          ssSetInputPortRequiredContiguous(rts, 0, 1);
          ssSetInputPortSignal(rts, 0, &quadripulse_controller14_B.UDPRx1);
          _ssSetInputPortNumDimensions(rts, 0, 1);
          ssSetInputPortWidth(rts, 0, 1);
        }
      }

      /* outputs */
      {
        ssSetPortInfoForOutputs(rts,
          &quadripulse_controller14_M->NonInlinedSFcns.Sfcn6.outputPortInfo[0]);
        _ssSetNumOutputPorts(rts, 1);

        /* port 0 */
        {
          _ssSetOutputPortNumDimensions(rts, 0, 1);
          ssSetOutputPortWidth(rts, 0, 1);
          ssSetOutputPortSignal(rts, 0, ((uint32_T *)
            &quadripulse_controller14_B.Buffer1));
        }
      }

      /* path info */
      ssSetModelName(rts, "Buffer 1");
      ssSetPath(rts, "quadripulse_controller14/UDP EEG Data/Receive 1/Buffer 1");
      ssSetRTModel(rts,quadripulse_controller14_M);
      ssSetParentSS(rts, (NULL));
      ssSetRootSS(rts, rts);
      ssSetVersion(rts, SIMSTRUCT_VERSION_LEVEL2);

      /* parameters */
      {
        mxArray **sfcnParams = (mxArray **)
          &quadripulse_controller14_M->NonInlinedSFcns.Sfcn6.params;
        ssSetSFcnParamsCount(rts, 3);
        ssSetSFcnParamsPtr(rts, &sfcnParams[0]);
        ssSetSFcnParam(rts, 0, (mxArray*)
                       quadripulse_controller14_P.Buffer1_P1_Size);
        ssSetSFcnParam(rts, 1, (mxArray*)
                       quadripulse_controller14_P.Buffer1_P2_Size);
        ssSetSFcnParam(rts, 2, (mxArray*)
                       quadripulse_controller14_P.Buffer1_P3_Size);
      }

      /* work vectors */
      ssSetIWork(rts, (int_T *) &quadripulse_controller14_DW.Buffer1_IWORK[0]);
      ssSetPWork(rts, (void **) &quadripulse_controller14_DW.Buffer1_PWORK);

      {
        struct _ssDWorkRecord *dWorkRecord = (struct _ssDWorkRecord *)
          &quadripulse_controller14_M->NonInlinedSFcns.Sfcn6.dWork;
        struct _ssDWorkAuxRecord *dWorkAuxRecord = (struct _ssDWorkAuxRecord *)
          &quadripulse_controller14_M->NonInlinedSFcns.Sfcn6.dWorkAux;
        ssSetSFcnDWork(rts, dWorkRecord);
        ssSetSFcnDWorkAux(rts, dWorkAuxRecord);
        _ssSetNumDWork(rts, 2);

        /* IWORK */
        ssSetDWorkWidth(rts, 0, 2);
        ssSetDWorkDataType(rts, 0,SS_INTEGER);
        ssSetDWorkComplexSignal(rts, 0, 0);
        ssSetDWork(rts, 0, &quadripulse_controller14_DW.Buffer1_IWORK[0]);

        /* PWORK */
        ssSetDWorkWidth(rts, 1, 1);
        ssSetDWorkDataType(rts, 1,SS_POINTER);
        ssSetDWorkComplexSignal(rts, 1, 0);
        ssSetDWork(rts, 1, &quadripulse_controller14_DW.Buffer1_PWORK);
      }

      /* registration */
      xpcnbbuffer(rts);
      sfcnInitializeSizes(rts);
      sfcnInitializeSampleTimes(rts);

      /* adjust sample time */
      ssSetSampleTime(rts, 0, 0.001);
      ssSetOffsetTime(rts, 0, 0.0);
      sfcnTsMap[0] = 0;

      /* set compiled values of dynamic vector attributes */
      ssSetNumNonsampledZCs(rts, 0);

      /* Update connectivity flags for each port */
      _ssSetInputPortConnected(rts, 0, 1);
      _ssSetOutputPortConnected(rts, 0, 1);
      _ssSetOutputPortBeingMerged(rts, 0, 0);

      /* Update the BufferDstPort flags for each input port */
      ssSetInputPortBufferDstPort(rts, 0, -1);
    }

    /* Level2 S-Function Block: quadripulse_controller14/<S50>/UDP Consume 1 (xpcudpconsume) */
    {
      SimStruct *rts = quadripulse_controller14_M->childSfunctions[7];

      /* timing info */
      time_T *sfcnPeriod =
        quadripulse_controller14_M->NonInlinedSFcns.Sfcn7.sfcnPeriod;
      time_T *sfcnOffset =
        quadripulse_controller14_M->NonInlinedSFcns.Sfcn7.sfcnOffset;
      int_T *sfcnTsMap =
        quadripulse_controller14_M->NonInlinedSFcns.Sfcn7.sfcnTsMap;
      (void) memset((void*)sfcnPeriod, 0,
                    sizeof(time_T)*1);
      (void) memset((void*)sfcnOffset, 0,
                    sizeof(time_T)*1);
      ssSetSampleTimePtr(rts, &sfcnPeriod[0]);
      ssSetOffsetTimePtr(rts, &sfcnOffset[0]);
      ssSetSampleTimeTaskIDPtr(rts, sfcnTsMap);

      /* Set up the mdlInfo pointer */
      {
        ssSetBlkInfo2Ptr(rts,
                         &quadripulse_controller14_M->NonInlinedSFcns.blkInfo2[7]);
      }

      ssSetRTWSfcnInfo(rts, quadripulse_controller14_M->sfcnInfo);

      /* Allocate memory of model methods 2 */
      {
        ssSetModelMethods2(rts,
                           &quadripulse_controller14_M->
                           NonInlinedSFcns.methods2[7]);
      }

      /* Allocate memory of model methods 3 */
      {
        ssSetModelMethods3(rts,
                           &quadripulse_controller14_M->
                           NonInlinedSFcns.methods3[7]);
      }

      /* Allocate memory for states auxilliary information */
      {
        ssSetStatesInfo2(rts,
                         &quadripulse_controller14_M->NonInlinedSFcns.statesInfo2
                         [7]);
        ssSetPeriodicStatesInfo(rts,
          &quadripulse_controller14_M->NonInlinedSFcns.periodicStatesInfo[7]);
      }

      /* inputs */
      {
        _ssSetNumInputPorts(rts, 1);
        ssSetPortInfoForInputs(rts,
          &quadripulse_controller14_M->NonInlinedSFcns.Sfcn7.inputPortInfo[0]);

        /* port 0 */
        {
          ssSetInputPortRequiredContiguous(rts, 0, 1);
          ssSetInputPortSignal(rts, 0, &quadripulse_controller14_B.Buffer1);
          _ssSetInputPortNumDimensions(rts, 0, 1);
          ssSetInputPortWidth(rts, 0, 1);
        }
      }

      /* outputs */
      {
        ssSetPortInfoForOutputs(rts,
          &quadripulse_controller14_M->NonInlinedSFcns.Sfcn7.outputPortInfo[0]);
        _ssSetNumOutputPorts(rts, 2);

        /* port 0 */
        {
          _ssSetOutputPortNumDimensions(rts, 0, 1);
          ssSetOutputPortWidth(rts, 0, 1);
          ssSetOutputPortSignal(rts, 0, ((uint32_T *)
            &quadripulse_controller14_B.UDPConsume1_o1));
        }

        /* port 1 */
        {
          _ssSetOutputPortNumDimensions(rts, 1, 1);
          ssSetOutputPortWidth(rts, 1, 1);
          ssSetOutputPortSignal(rts, 1, ((uint32_T *)
            &quadripulse_controller14_B.UDPConsume1_o2));
        }
      }

      /* path info */
      ssSetModelName(rts, "UDP Consume 1");
      ssSetPath(rts,
                "quadripulse_controller14/UDP EEG Data/Receive 1/UDP Consume 1");
      ssSetRTModel(rts,quadripulse_controller14_M);
      ssSetParentSS(rts, (NULL));
      ssSetRootSS(rts, rts);
      ssSetVersion(rts, SIMSTRUCT_VERSION_LEVEL2);

      /* parameters */
      {
        mxArray **sfcnParams = (mxArray **)
          &quadripulse_controller14_M->NonInlinedSFcns.Sfcn7.params;
        ssSetSFcnParamsCount(rts, 3);
        ssSetSFcnParamsPtr(rts, &sfcnParams[0]);
        ssSetSFcnParam(rts, 0, (mxArray*)
                       quadripulse_controller14_P.UDPConsume1_P1_Size);
        ssSetSFcnParam(rts, 1, (mxArray*)
                       quadripulse_controller14_P.UDPConsume1_P2_Size);
        ssSetSFcnParam(rts, 2, (mxArray*)
                       quadripulse_controller14_P.UDPConsume1_P3_Size);
      }

      /* work vectors */
      ssSetIWork(rts, (int_T *) &quadripulse_controller14_DW.UDPConsume1_IWORK);

      {
        struct _ssDWorkRecord *dWorkRecord = (struct _ssDWorkRecord *)
          &quadripulse_controller14_M->NonInlinedSFcns.Sfcn7.dWork;
        struct _ssDWorkAuxRecord *dWorkAuxRecord = (struct _ssDWorkAuxRecord *)
          &quadripulse_controller14_M->NonInlinedSFcns.Sfcn7.dWorkAux;
        ssSetSFcnDWork(rts, dWorkRecord);
        ssSetSFcnDWorkAux(rts, dWorkAuxRecord);
        _ssSetNumDWork(rts, 1);

        /* IWORK */
        ssSetDWorkWidth(rts, 0, 1);
        ssSetDWorkDataType(rts, 0,SS_INTEGER);
        ssSetDWorkComplexSignal(rts, 0, 0);
        ssSetDWork(rts, 0, &quadripulse_controller14_DW.UDPConsume1_IWORK);
      }

      /* registration */
      xpcudpconsume(rts);
      sfcnInitializeSizes(rts);
      sfcnInitializeSampleTimes(rts);

      /* adjust sample time */
      ssSetSampleTime(rts, 0, 0.001);
      ssSetOffsetTime(rts, 0, 0.0);
      sfcnTsMap[0] = 0;

      /* set compiled values of dynamic vector attributes */
      ssSetNumNonsampledZCs(rts, 0);

      /* Update connectivity flags for each port */
      _ssSetInputPortConnected(rts, 0, 1);
      _ssSetOutputPortConnected(rts, 0, 1);
      _ssSetOutputPortConnected(rts, 1, 0);
      _ssSetOutputPortBeingMerged(rts, 0, 0);
      _ssSetOutputPortBeingMerged(rts, 1, 0);

      /* Update the BufferDstPort flags for each input port */
      ssSetInputPortBufferDstPort(rts, 0, -1);
    }

    /* Level2 S-Function Block: quadripulse_controller14/<S50>/Extract 1 (xpcnbextract) */
    {
      SimStruct *rts = quadripulse_controller14_M->childSfunctions[8];

      /* timing info */
      time_T *sfcnPeriod =
        quadripulse_controller14_M->NonInlinedSFcns.Sfcn8.sfcnPeriod;
      time_T *sfcnOffset =
        quadripulse_controller14_M->NonInlinedSFcns.Sfcn8.sfcnOffset;
      int_T *sfcnTsMap =
        quadripulse_controller14_M->NonInlinedSFcns.Sfcn8.sfcnTsMap;
      (void) memset((void*)sfcnPeriod, 0,
                    sizeof(time_T)*1);
      (void) memset((void*)sfcnOffset, 0,
                    sizeof(time_T)*1);
      ssSetSampleTimePtr(rts, &sfcnPeriod[0]);
      ssSetOffsetTimePtr(rts, &sfcnOffset[0]);
      ssSetSampleTimeTaskIDPtr(rts, sfcnTsMap);

      /* Set up the mdlInfo pointer */
      {
        ssSetBlkInfo2Ptr(rts,
                         &quadripulse_controller14_M->NonInlinedSFcns.blkInfo2[8]);
      }

      ssSetRTWSfcnInfo(rts, quadripulse_controller14_M->sfcnInfo);

      /* Allocate memory of model methods 2 */
      {
        ssSetModelMethods2(rts,
                           &quadripulse_controller14_M->
                           NonInlinedSFcns.methods2[8]);
      }

      /* Allocate memory of model methods 3 */
      {
        ssSetModelMethods3(rts,
                           &quadripulse_controller14_M->
                           NonInlinedSFcns.methods3[8]);
      }

      /* Allocate memory for states auxilliary information */
      {
        ssSetStatesInfo2(rts,
                         &quadripulse_controller14_M->NonInlinedSFcns.statesInfo2
                         [8]);
        ssSetPeriodicStatesInfo(rts,
          &quadripulse_controller14_M->NonInlinedSFcns.periodicStatesInfo[8]);
      }

      /* inputs */
      {
        _ssSetNumInputPorts(rts, 1);
        ssSetPortInfoForInputs(rts,
          &quadripulse_controller14_M->NonInlinedSFcns.Sfcn8.inputPortInfo[0]);

        /* port 0 */
        {
          ssSetInputPortRequiredContiguous(rts, 0, 1);
          ssSetInputPortSignal(rts, 0,
                               &quadripulse_controller14_B.UDPConsume1_o1);
          _ssSetInputPortNumDimensions(rts, 0, 1);
          ssSetInputPortWidth(rts, 0, 1);
        }
      }

      /* outputs */
      {
        ssSetPortInfoForOutputs(rts,
          &quadripulse_controller14_M->NonInlinedSFcns.Sfcn8.outputPortInfo[0]);
        _ssSetNumOutputPorts(rts, 2);

        /* port 0 */
        {
          _ssSetOutputPortNumDimensions(rts, 0, 1);
          ssSetOutputPortWidth(rts, 0, 1018);
          ssSetOutputPortSignal(rts, 0, ((uint8_T *)
            quadripulse_controller14_B.Extract1_o1));
        }

        /* port 1 */
        {
          _ssSetOutputPortNumDimensions(rts, 1, 1);
          ssSetOutputPortWidth(rts, 1, 1);
          ssSetOutputPortSignal(rts, 1, ((real_T *)
            &quadripulse_controller14_B.Extract1_o2));
        }
      }

      /* path info */
      ssSetModelName(rts, "Extract 1");
      ssSetPath(rts, "quadripulse_controller14/UDP EEG Data/Receive 1/Extract 1");
      ssSetRTModel(rts,quadripulse_controller14_M);
      ssSetParentSS(rts, (NULL));
      ssSetRootSS(rts, rts);
      ssSetVersion(rts, SIMSTRUCT_VERSION_LEVEL2);

      /* parameters */
      {
        mxArray **sfcnParams = (mxArray **)
          &quadripulse_controller14_M->NonInlinedSFcns.Sfcn8.params;
        ssSetSFcnParamsCount(rts, 1);
        ssSetSFcnParamsPtr(rts, &sfcnParams[0]);
        ssSetSFcnParam(rts, 0, (mxArray*)
                       quadripulse_controller14_P.Extract1_P1_Size);
      }

      /* registration */
      xpcnbextract(rts);
      sfcnInitializeSizes(rts);
      sfcnInitializeSampleTimes(rts);

      /* adjust sample time */
      ssSetSampleTime(rts, 0, 0.001);
      ssSetOffsetTime(rts, 0, 0.0);
      sfcnTsMap[0] = 0;

      /* set compiled values of dynamic vector attributes */
      ssSetNumNonsampledZCs(rts, 0);

      /* Update connectivity flags for each port */
      _ssSetInputPortConnected(rts, 0, 1);
      _ssSetOutputPortConnected(rts, 0, 1);
      _ssSetOutputPortConnected(rts, 1, 1);
      _ssSetOutputPortBeingMerged(rts, 0, 0);
      _ssSetOutputPortBeingMerged(rts, 1, 0);

      /* Update the BufferDstPort flags for each input port */
      ssSetInputPortBufferDstPort(rts, 0, -1);
    }

    /* Level2 S-Function Block: quadripulse_controller14/<Root>/PD2-MF 12bit series (doueipd2mfx) */
    {
      SimStruct *rts = quadripulse_controller14_M->childSfunctions[9];

      /* timing info */
      time_T *sfcnPeriod =
        quadripulse_controller14_M->NonInlinedSFcns.Sfcn9.sfcnPeriod;
      time_T *sfcnOffset =
        quadripulse_controller14_M->NonInlinedSFcns.Sfcn9.sfcnOffset;
      int_T *sfcnTsMap =
        quadripulse_controller14_M->NonInlinedSFcns.Sfcn9.sfcnTsMap;
      (void) memset((void*)sfcnPeriod, 0,
                    sizeof(time_T)*1);
      (void) memset((void*)sfcnOffset, 0,
                    sizeof(time_T)*1);
      ssSetSampleTimePtr(rts, &sfcnPeriod[0]);
      ssSetOffsetTimePtr(rts, &sfcnOffset[0]);
      ssSetSampleTimeTaskIDPtr(rts, sfcnTsMap);

      /* Set up the mdlInfo pointer */
      {
        ssSetBlkInfo2Ptr(rts,
                         &quadripulse_controller14_M->NonInlinedSFcns.blkInfo2[9]);
      }

      ssSetRTWSfcnInfo(rts, quadripulse_controller14_M->sfcnInfo);

      /* Allocate memory of model methods 2 */
      {
        ssSetModelMethods2(rts,
                           &quadripulse_controller14_M->
                           NonInlinedSFcns.methods2[9]);
      }

      /* Allocate memory of model methods 3 */
      {
        ssSetModelMethods3(rts,
                           &quadripulse_controller14_M->
                           NonInlinedSFcns.methods3[9]);
      }

      /* Allocate memory for states auxilliary information */
      {
        ssSetStatesInfo2(rts,
                         &quadripulse_controller14_M->NonInlinedSFcns.statesInfo2
                         [9]);
        ssSetPeriodicStatesInfo(rts,
          &quadripulse_controller14_M->NonInlinedSFcns.periodicStatesInfo[9]);
      }

      /* inputs */
      {
        _ssSetNumInputPorts(rts, 4);
        ssSetPortInfoForInputs(rts,
          &quadripulse_controller14_M->NonInlinedSFcns.Sfcn9.inputPortInfo[0]);

        /* port 0 */
        {
          real_T const **sfcnUPtrs = (real_T const **)
            &quadripulse_controller14_M->NonInlinedSFcns.Sfcn9.UPtrs0;
          sfcnUPtrs[0] = &quadripulse_controller14_B.DataTypeConversion_l;
          ssSetInputPortSignalPtrs(rts, 0, (InputPtrsType)&sfcnUPtrs[0]);
          _ssSetInputPortNumDimensions(rts, 0, 1);
          ssSetInputPortWidth(rts, 0, 1);
        }

        /* port 1 */
        {
          real_T const **sfcnUPtrs = (real_T const **)
            &quadripulse_controller14_M->NonInlinedSFcns.Sfcn9.UPtrs1;
          sfcnUPtrs[0] = &quadripulse_controller14_B.DataTypeConversion1;
          ssSetInputPortSignalPtrs(rts, 1, (InputPtrsType)&sfcnUPtrs[0]);
          _ssSetInputPortNumDimensions(rts, 1, 1);
          ssSetInputPortWidth(rts, 1, 1);
        }

        /* port 2 */
        {
          real_T const **sfcnUPtrs = (real_T const **)
            &quadripulse_controller14_M->NonInlinedSFcns.Sfcn9.UPtrs2;
          sfcnUPtrs[0] = &quadripulse_controller14_B.DataTypeConversion2;
          ssSetInputPortSignalPtrs(rts, 2, (InputPtrsType)&sfcnUPtrs[0]);
          _ssSetInputPortNumDimensions(rts, 2, 1);
          ssSetInputPortWidth(rts, 2, 1);
        }

        /* port 3 */
        {
          real_T const **sfcnUPtrs = (real_T const **)
            &quadripulse_controller14_M->NonInlinedSFcns.Sfcn9.UPtrs3;
          sfcnUPtrs[0] = &quadripulse_controller14_B.DataTypeConversion3;
          ssSetInputPortSignalPtrs(rts, 3, (InputPtrsType)&sfcnUPtrs[0]);
          _ssSetInputPortNumDimensions(rts, 3, 1);
          ssSetInputPortWidth(rts, 3, 1);
        }
      }

      /* path info */
      ssSetModelName(rts, "PD2-MF 12bit series");
      ssSetPath(rts, "quadripulse_controller14/PD2-MF 12bit series");
      ssSetRTModel(rts,quadripulse_controller14_M);
      ssSetParentSS(rts, (NULL));
      ssSetRootSS(rts, rts);
      ssSetVersion(rts, SIMSTRUCT_VERSION_LEVEL2);

      /* parameters */
      {
        mxArray **sfcnParams = (mxArray **)
          &quadripulse_controller14_M->NonInlinedSFcns.Sfcn9.params;
        ssSetSFcnParamsCount(rts, 8);
        ssSetSFcnParamsPtr(rts, &sfcnParams[0]);
        ssSetSFcnParam(rts, 0, (mxArray*)
                       quadripulse_controller14_P.PD2MF12bitseries_P1_Size);
        ssSetSFcnParam(rts, 1, (mxArray*)
                       quadripulse_controller14_P.PD2MF12bitseries_P2_Size);
        ssSetSFcnParam(rts, 2, (mxArray*)
                       quadripulse_controller14_P.PD2MF12bitseries_P3_Size);
        ssSetSFcnParam(rts, 3, (mxArray*)
                       quadripulse_controller14_P.PD2MF12bitseries_P4_Size);
        ssSetSFcnParam(rts, 4, (mxArray*)
                       quadripulse_controller14_P.PD2MF12bitseries_P5_Size);
        ssSetSFcnParam(rts, 5, (mxArray*)
                       quadripulse_controller14_P.PD2MF12bitseries_P6_Size);
        ssSetSFcnParam(rts, 6, (mxArray*)
                       quadripulse_controller14_P.PD2MF12bitseries_P7_Size);
        ssSetSFcnParam(rts, 7, (mxArray*)
                       quadripulse_controller14_P.PD2MF12bitseries_P8_Size);
      }

      /* work vectors */
      ssSetIWork(rts, (int_T *)
                 &quadripulse_controller14_DW.PD2MF12bitseries_IWORK[0]);

      {
        struct _ssDWorkRecord *dWorkRecord = (struct _ssDWorkRecord *)
          &quadripulse_controller14_M->NonInlinedSFcns.Sfcn9.dWork;
        struct _ssDWorkAuxRecord *dWorkAuxRecord = (struct _ssDWorkAuxRecord *)
          &quadripulse_controller14_M->NonInlinedSFcns.Sfcn9.dWorkAux;
        ssSetSFcnDWork(rts, dWorkRecord);
        ssSetSFcnDWorkAux(rts, dWorkAuxRecord);
        _ssSetNumDWork(rts, 1);

        /* IWORK */
        ssSetDWorkWidth(rts, 0, 2);
        ssSetDWorkDataType(rts, 0,SS_INTEGER);
        ssSetDWorkComplexSignal(rts, 0, 0);
        ssSetDWork(rts, 0, &quadripulse_controller14_DW.PD2MF12bitseries_IWORK[0]);
      }

      /* registration */
      doueipd2mfx(rts);
      sfcnInitializeSizes(rts);
      sfcnInitializeSampleTimes(rts);

      /* adjust sample time */
      ssSetSampleTime(rts, 0, 0.001);
      ssSetOffsetTime(rts, 0, 0.0);
      sfcnTsMap[0] = 0;

      /* set compiled values of dynamic vector attributes */
      ssSetNumNonsampledZCs(rts, 0);

      /* Update connectivity flags for each port */
      _ssSetInputPortConnected(rts, 0, 1);
      _ssSetInputPortConnected(rts, 1, 1);
      _ssSetInputPortConnected(rts, 2, 1);
      _ssSetInputPortConnected(rts, 3, 1);

      /* Update the BufferDstPort flags for each input port */
      ssSetInputPortBufferDstPort(rts, 0, -1);
      ssSetInputPortBufferDstPort(rts, 1, -1);
      ssSetInputPortBufferDstPort(rts, 2, -1);
      ssSetInputPortBufferDstPort(rts, 3, -1);
    }

    /* Level2 S-Function Block: quadripulse_controller14/<Root>/Parallel Port DO  (parallelportdio) */
    {
      SimStruct *rts = quadripulse_controller14_M->childSfunctions[10];

      /* timing info */
      time_T *sfcnPeriod =
        quadripulse_controller14_M->NonInlinedSFcns.Sfcn10.sfcnPeriod;
      time_T *sfcnOffset =
        quadripulse_controller14_M->NonInlinedSFcns.Sfcn10.sfcnOffset;
      int_T *sfcnTsMap =
        quadripulse_controller14_M->NonInlinedSFcns.Sfcn10.sfcnTsMap;
      (void) memset((void*)sfcnPeriod, 0,
                    sizeof(time_T)*1);
      (void) memset((void*)sfcnOffset, 0,
                    sizeof(time_T)*1);
      ssSetSampleTimePtr(rts, &sfcnPeriod[0]);
      ssSetOffsetTimePtr(rts, &sfcnOffset[0]);
      ssSetSampleTimeTaskIDPtr(rts, sfcnTsMap);

      /* Set up the mdlInfo pointer */
      {
        ssSetBlkInfo2Ptr(rts,
                         &quadripulse_controller14_M->NonInlinedSFcns.blkInfo2
                         [10]);
      }

      ssSetRTWSfcnInfo(rts, quadripulse_controller14_M->sfcnInfo);

      /* Allocate memory of model methods 2 */
      {
        ssSetModelMethods2(rts,
                           &quadripulse_controller14_M->
                           NonInlinedSFcns.methods2[10]);
      }

      /* Allocate memory of model methods 3 */
      {
        ssSetModelMethods3(rts,
                           &quadripulse_controller14_M->
                           NonInlinedSFcns.methods3[10]);
      }

      /* Allocate memory for states auxilliary information */
      {
        ssSetStatesInfo2(rts,
                         &quadripulse_controller14_M->NonInlinedSFcns.statesInfo2
                         [10]);
        ssSetPeriodicStatesInfo(rts,
          &quadripulse_controller14_M->NonInlinedSFcns.periodicStatesInfo[10]);
      }

      /* inputs */
      {
        _ssSetNumInputPorts(rts, 1);
        ssSetPortInfoForInputs(rts,
          &quadripulse_controller14_M->NonInlinedSFcns.Sfcn10.inputPortInfo[0]);

        /* port 0 */
        {
          ssSetInputPortRequiredContiguous(rts, 0, 1);
          ssSetInputPortSignal(rts, 0, &quadripulse_controller14_B.Switch1);
          _ssSetInputPortNumDimensions(rts, 0, 1);
          ssSetInputPortWidth(rts, 0, 1);
        }
      }

      /* path info */
      ssSetModelName(rts, "Parallel Port DO ");
      ssSetPath(rts, "quadripulse_controller14/Parallel Port DO ");
      ssSetRTModel(rts,quadripulse_controller14_M);
      ssSetParentSS(rts, (NULL));
      ssSetRootSS(rts, rts);
      ssSetVersion(rts, SIMSTRUCT_VERSION_LEVEL2);

      /* parameters */
      {
        mxArray **sfcnParams = (mxArray **)
          &quadripulse_controller14_M->NonInlinedSFcns.Sfcn10.params;
        ssSetSFcnParamsCount(rts, 9);
        ssSetSFcnParamsPtr(rts, &sfcnParams[0]);
        ssSetSFcnParam(rts, 0, (mxArray*)
                       quadripulse_controller14_P.ParallelPortDO_P1_Size);
        ssSetSFcnParam(rts, 1, (mxArray*)
                       quadripulse_controller14_P.ParallelPortDO_P2_Size);
        ssSetSFcnParam(rts, 2, (mxArray*)
                       quadripulse_controller14_P.ParallelPortDO_P3_Size);
        ssSetSFcnParam(rts, 3, (mxArray*)
                       quadripulse_controller14_P.ParallelPortDO_P4_Size);
        ssSetSFcnParam(rts, 4, (mxArray*)
                       quadripulse_controller14_P.ParallelPortDO_P5_Size);
        ssSetSFcnParam(rts, 5, (mxArray*)
                       quadripulse_controller14_P.ParallelPortDO_P6_Size);
        ssSetSFcnParam(rts, 6, (mxArray*)
                       quadripulse_controller14_P.ParallelPortDO_P7_Size);
        ssSetSFcnParam(rts, 7, (mxArray*)
                       quadripulse_controller14_P.ParallelPortDO_P8_Size);
        ssSetSFcnParam(rts, 8, (mxArray*)
                       quadripulse_controller14_P.ParallelPortDO_P9_Size);
      }

      /* registration */
      parallelportdio(rts);
      sfcnInitializeSizes(rts);
      sfcnInitializeSampleTimes(rts);

      /* adjust sample time */
      ssSetSampleTime(rts, 0, 0.001);
      ssSetOffsetTime(rts, 0, 0.0);
      sfcnTsMap[0] = 0;

      /* set compiled values of dynamic vector attributes */
      ssSetNumNonsampledZCs(rts, 0);

      /* Update connectivity flags for each port */
      _ssSetInputPortConnected(rts, 0, 1);

      /* Update the BufferDstPort flags for each input port */
      ssSetInputPortBufferDstPort(rts, 0, -1);
    }
  }

  /* Initialize Sizes */
  quadripulse_controller14_M->Sizes.numContStates = (0);/* Number of continuous states */
  quadripulse_controller14_M->Sizes.numY = (0);/* Number of model outputs */
  quadripulse_controller14_M->Sizes.numU = (0);/* Number of model inputs */
  quadripulse_controller14_M->Sizes.sysDirFeedThru = (0);/* The model is not direct feedthrough */
  quadripulse_controller14_M->Sizes.numSampTimes = (4);/* Number of sample times */
  quadripulse_controller14_M->Sizes.numBlocks = (249);/* Number of blocks */
  quadripulse_controller14_M->Sizes.numBlockIO = (174);/* Number of block outputs */
  quadripulse_controller14_M->Sizes.numBlockPrms = (1020);/* Sum of parameter "widths" */
  return quadripulse_controller14_M;
}

/*========================================================================*
 * End of Classic call interface                                          *
 *========================================================================*/
