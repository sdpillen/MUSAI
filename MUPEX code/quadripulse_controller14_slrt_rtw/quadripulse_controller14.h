/*
 * quadripulse_controller14.h
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

#ifndef RTW_HEADER_quadripulse_controller14_h_
#define RTW_HEADER_quadripulse_controller14_h_
#include <stddef.h>
#include <string.h>
#include <math.h>
#include "rtw_modelmap.h"
#ifndef quadripulse_controller14_COMMON_INCLUDES_
# define quadripulse_controller14_COMMON_INCLUDES_
#include <xpcimports.h>
#include <xpcdatatypes.h>
#include "rtwtypes.h"
#include "zero_crossing_types.h"
#include "simstruc.h"
#include "fixedpoint.h"
#include "rt_logging.h"
#endif                                 /* quadripulse_controller14_COMMON_INCLUDES_ */

#include "quadripulse_controller14_types.h"

/* Shared type includes */
#include "multiword_types.h"
#include "rt_zcfcn.h"
#include "rt_nonfinite.h"
#include "rt_defines.h"

/* Macros for accessing real-time model data structure */
#ifndef rtmGetBlkStateChangeFlag
# define rtmGetBlkStateChangeFlag(rtm) ((rtm)->ModelData.blkStateChange)
#endif

#ifndef rtmSetBlkStateChangeFlag
# define rtmSetBlkStateChangeFlag(rtm, val) ((rtm)->ModelData.blkStateChange = (val))
#endif

#ifndef rtmGetBlockIO
# define rtmGetBlockIO(rtm)            ((rtm)->ModelData.blockIO)
#endif

#ifndef rtmSetBlockIO
# define rtmSetBlockIO(rtm, val)       ((rtm)->ModelData.blockIO = (val))
#endif

#ifndef rtmGetChecksums
# define rtmGetChecksums(rtm)          ((rtm)->Sizes.checksums)
#endif

#ifndef rtmSetChecksums
# define rtmSetChecksums(rtm, val)     ((rtm)->Sizes.checksums = (val))
#endif

#ifndef rtmGetConstBlockIO
# define rtmGetConstBlockIO(rtm)       ((rtm)->ModelData.constBlockIO)
#endif

#ifndef rtmSetConstBlockIO
# define rtmSetConstBlockIO(rtm, val)  ((rtm)->ModelData.constBlockIO = (val))
#endif

#ifndef rtmGetContStateDisabled
# define rtmGetContStateDisabled(rtm)  ((rtm)->ModelData.contStateDisabled)
#endif

#ifndef rtmSetContStateDisabled
# define rtmSetContStateDisabled(rtm, val) ((rtm)->ModelData.contStateDisabled = (val))
#endif

#ifndef rtmGetContStates
# define rtmGetContStates(rtm)         ((rtm)->ModelData.contStates)
#endif

#ifndef rtmSetContStates
# define rtmSetContStates(rtm, val)    ((rtm)->ModelData.contStates = (val))
#endif

#ifndef rtmGetDataMapInfo
# define rtmGetDataMapInfo(rtm)        ((rtm)->DataMapInfo)
#endif

#ifndef rtmSetDataMapInfo
# define rtmSetDataMapInfo(rtm, val)   ((rtm)->DataMapInfo = (val))
#endif

#ifndef rtmGetDefaultParam
# define rtmGetDefaultParam(rtm)       ((rtm)->ModelData.defaultParam)
#endif

#ifndef rtmSetDefaultParam
# define rtmSetDefaultParam(rtm, val)  ((rtm)->ModelData.defaultParam = (val))
#endif

#ifndef rtmGetDerivCacheNeedsReset
# define rtmGetDerivCacheNeedsReset(rtm) ((rtm)->ModelData.derivCacheNeedsReset)
#endif

#ifndef rtmSetDerivCacheNeedsReset
# define rtmSetDerivCacheNeedsReset(rtm, val) ((rtm)->ModelData.derivCacheNeedsReset = (val))
#endif

#ifndef rtmGetDirectFeedThrough
# define rtmGetDirectFeedThrough(rtm)  ((rtm)->Sizes.sysDirFeedThru)
#endif

#ifndef rtmSetDirectFeedThrough
# define rtmSetDirectFeedThrough(rtm, val) ((rtm)->Sizes.sysDirFeedThru = (val))
#endif

#ifndef rtmGetErrorStatusFlag
# define rtmGetErrorStatusFlag(rtm)    ((rtm)->errorStatus)
#endif

#ifndef rtmSetErrorStatusFlag
# define rtmSetErrorStatusFlag(rtm, val) ((rtm)->errorStatus = (val))
#endif

#ifndef rtmGetFinalTime
# define rtmGetFinalTime(rtm)          ((rtm)->Timing.tFinal)
#endif

#ifndef rtmSetFinalTime
# define rtmSetFinalTime(rtm, val)     ((rtm)->Timing.tFinal = (val))
#endif

#ifndef rtmGetFirstInitCondFlag
# define rtmGetFirstInitCondFlag(rtm)  ()
#endif

#ifndef rtmSetFirstInitCondFlag
# define rtmSetFirstInitCondFlag(rtm, val) ()
#endif

#ifndef rtmGetIntgData
# define rtmGetIntgData(rtm)           ()
#endif

#ifndef rtmSetIntgData
# define rtmSetIntgData(rtm, val)      ()
#endif

#ifndef rtmGetMdlRefGlobalTID
# define rtmGetMdlRefGlobalTID(rtm)    ()
#endif

#ifndef rtmSetMdlRefGlobalTID
# define rtmSetMdlRefGlobalTID(rtm, val) ()
#endif

#ifndef rtmGetMdlRefTriggerTID
# define rtmGetMdlRefTriggerTID(rtm)   ()
#endif

#ifndef rtmSetMdlRefTriggerTID
# define rtmSetMdlRefTriggerTID(rtm, val) ()
#endif

#ifndef rtmGetModelMappingInfo
# define rtmGetModelMappingInfo(rtm)   ((rtm)->SpecialInfo.mappingInfo)
#endif

#ifndef rtmSetModelMappingInfo
# define rtmSetModelMappingInfo(rtm, val) ((rtm)->SpecialInfo.mappingInfo = (val))
#endif

#ifndef rtmGetModelName
# define rtmGetModelName(rtm)          ((rtm)->modelName)
#endif

#ifndef rtmSetModelName
# define rtmSetModelName(rtm, val)     ((rtm)->modelName = (val))
#endif

#ifndef rtmGetNonInlinedSFcns
# define rtmGetNonInlinedSFcns(rtm)    ((rtm)->NonInlinedSFcns)
#endif

#ifndef rtmSetNonInlinedSFcns
# define rtmSetNonInlinedSFcns(rtm, val) ((rtm)->NonInlinedSFcns = (val))
#endif

#ifndef rtmGetNumBlockIO
# define rtmGetNumBlockIO(rtm)         ((rtm)->Sizes.numBlockIO)
#endif

#ifndef rtmSetNumBlockIO
# define rtmSetNumBlockIO(rtm, val)    ((rtm)->Sizes.numBlockIO = (val))
#endif

#ifndef rtmGetNumBlockParams
# define rtmGetNumBlockParams(rtm)     ((rtm)->Sizes.numBlockPrms)
#endif

#ifndef rtmSetNumBlockParams
# define rtmSetNumBlockParams(rtm, val) ((rtm)->Sizes.numBlockPrms = (val))
#endif

#ifndef rtmGetNumBlocks
# define rtmGetNumBlocks(rtm)          ((rtm)->Sizes.numBlocks)
#endif

#ifndef rtmSetNumBlocks
# define rtmSetNumBlocks(rtm, val)     ((rtm)->Sizes.numBlocks = (val))
#endif

#ifndef rtmGetNumContStates
# define rtmGetNumContStates(rtm)      ((rtm)->Sizes.numContStates)
#endif

#ifndef rtmSetNumContStates
# define rtmSetNumContStates(rtm, val) ((rtm)->Sizes.numContStates = (val))
#endif

#ifndef rtmGetNumDWork
# define rtmGetNumDWork(rtm)           ((rtm)->Sizes.numDwork)
#endif

#ifndef rtmSetNumDWork
# define rtmSetNumDWork(rtm, val)      ((rtm)->Sizes.numDwork = (val))
#endif

#ifndef rtmGetNumInputPorts
# define rtmGetNumInputPorts(rtm)      ((rtm)->Sizes.numIports)
#endif

#ifndef rtmSetNumInputPorts
# define rtmSetNumInputPorts(rtm, val) ((rtm)->Sizes.numIports = (val))
#endif

#ifndef rtmGetNumNonSampledZCs
# define rtmGetNumNonSampledZCs(rtm)   ((rtm)->Sizes.numNonSampZCs)
#endif

#ifndef rtmSetNumNonSampledZCs
# define rtmSetNumNonSampledZCs(rtm, val) ((rtm)->Sizes.numNonSampZCs = (val))
#endif

#ifndef rtmGetNumOutputPorts
# define rtmGetNumOutputPorts(rtm)     ((rtm)->Sizes.numOports)
#endif

#ifndef rtmSetNumOutputPorts
# define rtmSetNumOutputPorts(rtm, val) ((rtm)->Sizes.numOports = (val))
#endif

#ifndef rtmGetNumPeriodicContStates
# define rtmGetNumPeriodicContStates(rtm) ((rtm)->Sizes.numPeriodicContStates)
#endif

#ifndef rtmSetNumPeriodicContStates
# define rtmSetNumPeriodicContStates(rtm, val) ((rtm)->Sizes.numPeriodicContStates = (val))
#endif

#ifndef rtmGetNumSFcnParams
# define rtmGetNumSFcnParams(rtm)      ((rtm)->Sizes.numSFcnPrms)
#endif

#ifndef rtmSetNumSFcnParams
# define rtmSetNumSFcnParams(rtm, val) ((rtm)->Sizes.numSFcnPrms = (val))
#endif

#ifndef rtmGetNumSFunctions
# define rtmGetNumSFunctions(rtm)      ((rtm)->Sizes.numSFcns)
#endif

#ifndef rtmSetNumSFunctions
# define rtmSetNumSFunctions(rtm, val) ((rtm)->Sizes.numSFcns = (val))
#endif

#ifndef rtmGetNumSampleTimes
# define rtmGetNumSampleTimes(rtm)     ((rtm)->Sizes.numSampTimes)
#endif

#ifndef rtmSetNumSampleTimes
# define rtmSetNumSampleTimes(rtm, val) ((rtm)->Sizes.numSampTimes = (val))
#endif

#ifndef rtmGetNumU
# define rtmGetNumU(rtm)               ((rtm)->Sizes.numU)
#endif

#ifndef rtmSetNumU
# define rtmSetNumU(rtm, val)          ((rtm)->Sizes.numU = (val))
#endif

#ifndef rtmGetNumY
# define rtmGetNumY(rtm)               ((rtm)->Sizes.numY)
#endif

#ifndef rtmSetNumY
# define rtmSetNumY(rtm, val)          ((rtm)->Sizes.numY = (val))
#endif

#ifndef rtmGetOdeF
# define rtmGetOdeF(rtm)               ()
#endif

#ifndef rtmSetOdeF
# define rtmSetOdeF(rtm, val)          ()
#endif

#ifndef rtmGetOdeY
# define rtmGetOdeY(rtm)               ()
#endif

#ifndef rtmSetOdeY
# define rtmSetOdeY(rtm, val)          ()
#endif

#ifndef rtmGetOffsetTimeArray
# define rtmGetOffsetTimeArray(rtm)    ((rtm)->Timing.offsetTimesArray)
#endif

#ifndef rtmSetOffsetTimeArray
# define rtmSetOffsetTimeArray(rtm, val) ((rtm)->Timing.offsetTimesArray = (val))
#endif

#ifndef rtmGetOffsetTimePtr
# define rtmGetOffsetTimePtr(rtm)      ((rtm)->Timing.offsetTimes)
#endif

#ifndef rtmSetOffsetTimePtr
# define rtmSetOffsetTimePtr(rtm, val) ((rtm)->Timing.offsetTimes = (val))
#endif

#ifndef rtmGetOptions
# define rtmGetOptions(rtm)            ((rtm)->Sizes.options)
#endif

#ifndef rtmSetOptions
# define rtmSetOptions(rtm, val)       ((rtm)->Sizes.options = (val))
#endif

#ifndef rtmGetParamIsMalloced
# define rtmGetParamIsMalloced(rtm)    ()
#endif

#ifndef rtmSetParamIsMalloced
# define rtmSetParamIsMalloced(rtm, val) ()
#endif

#ifndef rtmGetPath
# define rtmGetPath(rtm)               ((rtm)->path)
#endif

#ifndef rtmSetPath
# define rtmSetPath(rtm, val)          ((rtm)->path = (val))
#endif

#ifndef rtmGetPerTaskSampleHits
# define rtmGetPerTaskSampleHits(rtm)  ((rtm)->Timing.RateInteraction)
#endif

#ifndef rtmSetPerTaskSampleHits
# define rtmSetPerTaskSampleHits(rtm, val) ((rtm)->Timing.RateInteraction = (val))
#endif

#ifndef rtmGetPerTaskSampleHitsArray
# define rtmGetPerTaskSampleHitsArray(rtm) ((rtm)->Timing.perTaskSampleHitsArray)
#endif

#ifndef rtmSetPerTaskSampleHitsArray
# define rtmSetPerTaskSampleHitsArray(rtm, val) ((rtm)->Timing.perTaskSampleHitsArray = (val))
#endif

#ifndef rtmGetPerTaskSampleHitsPtr
# define rtmGetPerTaskSampleHitsPtr(rtm) ((rtm)->Timing.perTaskSampleHits)
#endif

#ifndef rtmSetPerTaskSampleHitsPtr
# define rtmSetPerTaskSampleHitsPtr(rtm, val) ((rtm)->Timing.perTaskSampleHits = (val))
#endif

#ifndef rtmGetPeriodicContStateIndices
# define rtmGetPeriodicContStateIndices(rtm) ((rtm)->ModelData.periodicContStateIndices)
#endif

#ifndef rtmSetPeriodicContStateIndices
# define rtmSetPeriodicContStateIndices(rtm, val) ((rtm)->ModelData.periodicContStateIndices = (val))
#endif

#ifndef rtmGetPeriodicContStateRanges
# define rtmGetPeriodicContStateRanges(rtm) ((rtm)->ModelData.periodicContStateRanges)
#endif

#ifndef rtmSetPeriodicContStateRanges
# define rtmSetPeriodicContStateRanges(rtm, val) ((rtm)->ModelData.periodicContStateRanges = (val))
#endif

#ifndef rtmGetPrevZCSigState
# define rtmGetPrevZCSigState(rtm)     ((rtm)->ModelData.prevZCSigState)
#endif

#ifndef rtmSetPrevZCSigState
# define rtmSetPrevZCSigState(rtm, val) ((rtm)->ModelData.prevZCSigState = (val))
#endif

#ifndef rtmGetRTWExtModeInfo
# define rtmGetRTWExtModeInfo(rtm)     ((rtm)->extModeInfo)
#endif

#ifndef rtmSetRTWExtModeInfo
# define rtmSetRTWExtModeInfo(rtm, val) ((rtm)->extModeInfo = (val))
#endif

#ifndef rtmGetRTWGeneratedSFcn
# define rtmGetRTWGeneratedSFcn(rtm)   ((rtm)->Sizes.rtwGenSfcn)
#endif

#ifndef rtmSetRTWGeneratedSFcn
# define rtmSetRTWGeneratedSFcn(rtm, val) ((rtm)->Sizes.rtwGenSfcn = (val))
#endif

#ifndef rtmGetRTWLogInfo
# define rtmGetRTWLogInfo(rtm)         ((rtm)->rtwLogInfo)
#endif

#ifndef rtmSetRTWLogInfo
# define rtmSetRTWLogInfo(rtm, val)    ((rtm)->rtwLogInfo = (val))
#endif

#ifndef rtmGetRTWRTModelMethodsInfo
# define rtmGetRTWRTModelMethodsInfo(rtm) ()
#endif

#ifndef rtmSetRTWRTModelMethodsInfo
# define rtmSetRTWRTModelMethodsInfo(rtm, val) ()
#endif

#ifndef rtmGetRTWSfcnInfo
# define rtmGetRTWSfcnInfo(rtm)        ((rtm)->sfcnInfo)
#endif

#ifndef rtmSetRTWSfcnInfo
# define rtmSetRTWSfcnInfo(rtm, val)   ((rtm)->sfcnInfo = (val))
#endif

#ifndef rtmGetRTWSolverInfo
# define rtmGetRTWSolverInfo(rtm)      ((rtm)->solverInfo)
#endif

#ifndef rtmSetRTWSolverInfo
# define rtmSetRTWSolverInfo(rtm, val) ((rtm)->solverInfo = (val))
#endif

#ifndef rtmGetRTWSolverInfoPtr
# define rtmGetRTWSolverInfoPtr(rtm)   ((rtm)->solverInfoPtr)
#endif

#ifndef rtmSetRTWSolverInfoPtr
# define rtmSetRTWSolverInfoPtr(rtm, val) ((rtm)->solverInfoPtr = (val))
#endif

#ifndef rtmGetReservedForXPC
# define rtmGetReservedForXPC(rtm)     ((rtm)->SpecialInfo.xpcData)
#endif

#ifndef rtmSetReservedForXPC
# define rtmSetReservedForXPC(rtm, val) ((rtm)->SpecialInfo.xpcData = (val))
#endif

#ifndef rtmGetRootDWork
# define rtmGetRootDWork(rtm)          ((rtm)->ModelData.dwork)
#endif

#ifndef rtmSetRootDWork
# define rtmSetRootDWork(rtm, val)     ((rtm)->ModelData.dwork = (val))
#endif

#ifndef rtmGetSFunctions
# define rtmGetSFunctions(rtm)         ((rtm)->childSfunctions)
#endif

#ifndef rtmSetSFunctions
# define rtmSetSFunctions(rtm, val)    ((rtm)->childSfunctions = (val))
#endif

#ifndef rtmGetSampleHitArray
# define rtmGetSampleHitArray(rtm)     ((rtm)->Timing.sampleHitArray)
#endif

#ifndef rtmSetSampleHitArray
# define rtmSetSampleHitArray(rtm, val) ((rtm)->Timing.sampleHitArray = (val))
#endif

#ifndef rtmGetSampleHitPtr
# define rtmGetSampleHitPtr(rtm)       ((rtm)->Timing.sampleHits)
#endif

#ifndef rtmSetSampleHitPtr
# define rtmSetSampleHitPtr(rtm, val)  ((rtm)->Timing.sampleHits = (val))
#endif

#ifndef rtmGetSampleTimeArray
# define rtmGetSampleTimeArray(rtm)    ((rtm)->Timing.sampleTimesArray)
#endif

#ifndef rtmSetSampleTimeArray
# define rtmSetSampleTimeArray(rtm, val) ((rtm)->Timing.sampleTimesArray = (val))
#endif

#ifndef rtmGetSampleTimePtr
# define rtmGetSampleTimePtr(rtm)      ((rtm)->Timing.sampleTimes)
#endif

#ifndef rtmSetSampleTimePtr
# define rtmSetSampleTimePtr(rtm, val) ((rtm)->Timing.sampleTimes = (val))
#endif

#ifndef rtmGetSampleTimeTaskIDArray
# define rtmGetSampleTimeTaskIDArray(rtm) ((rtm)->Timing.sampleTimeTaskIDArray)
#endif

#ifndef rtmSetSampleTimeTaskIDArray
# define rtmSetSampleTimeTaskIDArray(rtm, val) ((rtm)->Timing.sampleTimeTaskIDArray = (val))
#endif

#ifndef rtmGetSampleTimeTaskIDPtr
# define rtmGetSampleTimeTaskIDPtr(rtm) ((rtm)->Timing.sampleTimeTaskIDPtr)
#endif

#ifndef rtmSetSampleTimeTaskIDPtr
# define rtmSetSampleTimeTaskIDPtr(rtm, val) ((rtm)->Timing.sampleTimeTaskIDPtr = (val))
#endif

#ifndef rtmGetSimMode
# define rtmGetSimMode(rtm)            ((rtm)->simMode)
#endif

#ifndef rtmSetSimMode
# define rtmSetSimMode(rtm, val)       ((rtm)->simMode = (val))
#endif

#ifndef rtmGetSimTimeStep
# define rtmGetSimTimeStep(rtm)        ((rtm)->Timing.simTimeStep)
#endif

#ifndef rtmSetSimTimeStep
# define rtmSetSimTimeStep(rtm, val)   ((rtm)->Timing.simTimeStep = (val))
#endif

#ifndef rtmGetStartTime
# define rtmGetStartTime(rtm)          ((rtm)->Timing.tStart)
#endif

#ifndef rtmSetStartTime
# define rtmSetStartTime(rtm, val)     ((rtm)->Timing.tStart = (val))
#endif

#ifndef rtmGetStepSize
# define rtmGetStepSize(rtm)           ((rtm)->Timing.stepSize)
#endif

#ifndef rtmSetStepSize
# define rtmSetStepSize(rtm, val)      ((rtm)->Timing.stepSize = (val))
#endif

#ifndef rtmGetStopRequestedFlag
# define rtmGetStopRequestedFlag(rtm)  ((rtm)->Timing.stopRequestedFlag)
#endif

#ifndef rtmSetStopRequestedFlag
# define rtmSetStopRequestedFlag(rtm, val) ((rtm)->Timing.stopRequestedFlag = (val))
#endif

#ifndef rtmGetTaskCounters
# define rtmGetTaskCounters(rtm)       ((rtm)->Timing.TaskCounters)
#endif

#ifndef rtmSetTaskCounters
# define rtmSetTaskCounters(rtm, val)  ((rtm)->Timing.TaskCounters = (val))
#endif

#ifndef rtmGetTaskTimeArray
# define rtmGetTaskTimeArray(rtm)      ((rtm)->Timing.tArray)
#endif

#ifndef rtmSetTaskTimeArray
# define rtmSetTaskTimeArray(rtm, val) ((rtm)->Timing.tArray = (val))
#endif

#ifndef rtmGetTimePtr
# define rtmGetTimePtr(rtm)            ((rtm)->Timing.t)
#endif

#ifndef rtmSetTimePtr
# define rtmSetTimePtr(rtm, val)       ((rtm)->Timing.t = (val))
#endif

#ifndef rtmGetTimingData
# define rtmGetTimingData(rtm)         ((rtm)->Timing.timingData)
#endif

#ifndef rtmSetTimingData
# define rtmSetTimingData(rtm, val)    ((rtm)->Timing.timingData = (val))
#endif

#ifndef rtmGetU
# define rtmGetU(rtm)                  ((rtm)->ModelData.inputs)
#endif

#ifndef rtmSetU
# define rtmSetU(rtm, val)             ((rtm)->ModelData.inputs = (val))
#endif

#ifndef rtmGetVarNextHitTimesListPtr
# define rtmGetVarNextHitTimesListPtr(rtm) ((rtm)->Timing.varNextHitTimesList)
#endif

#ifndef rtmSetVarNextHitTimesListPtr
# define rtmSetVarNextHitTimesListPtr(rtm, val) ((rtm)->Timing.varNextHitTimesList = (val))
#endif

#ifndef rtmGetY
# define rtmGetY(rtm)                  ((rtm)->ModelData.outputs)
#endif

#ifndef rtmSetY
# define rtmSetY(rtm, val)             ((rtm)->ModelData.outputs = (val))
#endif

#ifndef rtmGetZCCacheNeedsReset
# define rtmGetZCCacheNeedsReset(rtm)  ((rtm)->ModelData.zCCacheNeedsReset)
#endif

#ifndef rtmSetZCCacheNeedsReset
# define rtmSetZCCacheNeedsReset(rtm, val) ((rtm)->ModelData.zCCacheNeedsReset = (val))
#endif

#ifndef rtmGetZCSignalValues
# define rtmGetZCSignalValues(rtm)     ((rtm)->ModelData.zcSignalValues)
#endif

#ifndef rtmSetZCSignalValues
# define rtmSetZCSignalValues(rtm, val) ((rtm)->ModelData.zcSignalValues = (val))
#endif

#ifndef rtmGet_TimeOfLastOutput
# define rtmGet_TimeOfLastOutput(rtm)  ((rtm)->Timing.timeOfLastOutput)
#endif

#ifndef rtmSet_TimeOfLastOutput
# define rtmSet_TimeOfLastOutput(rtm, val) ((rtm)->Timing.timeOfLastOutput = (val))
#endif

#ifndef rtmGetdX
# define rtmGetdX(rtm)                 ((rtm)->ModelData.derivs)
#endif

#ifndef rtmSetdX
# define rtmSetdX(rtm, val)            ((rtm)->ModelData.derivs = (val))
#endif

#ifndef rtmGetChecksumVal
# define rtmGetChecksumVal(rtm, idx)   ((rtm)->Sizes.checksums[idx])
#endif

#ifndef rtmSetChecksumVal
# define rtmSetChecksumVal(rtm, idx, val) ((rtm)->Sizes.checksums[idx] = (val))
#endif

#ifndef rtmGetDWork
# define rtmGetDWork(rtm, idx)         ((rtm)->ModelData.dwork[idx])
#endif

#ifndef rtmSetDWork
# define rtmSetDWork(rtm, idx, val)    ((rtm)->ModelData.dwork[idx] = (val))
#endif

#ifndef rtmGetOffsetTime
# define rtmGetOffsetTime(rtm, idx)    ((rtm)->Timing.offsetTimes[idx])
#endif

#ifndef rtmSetOffsetTime
# define rtmSetOffsetTime(rtm, idx, val) ((rtm)->Timing.offsetTimes[idx] = (val))
#endif

#ifndef rtmGetSFunction
# define rtmGetSFunction(rtm, idx)     ((rtm)->childSfunctions[idx])
#endif

#ifndef rtmSetSFunction
# define rtmSetSFunction(rtm, idx, val) ((rtm)->childSfunctions[idx] = (val))
#endif

#ifndef rtmGetSampleTime
# define rtmGetSampleTime(rtm, idx)    ((rtm)->Timing.sampleTimes[idx])
#endif

#ifndef rtmSetSampleTime
# define rtmSetSampleTime(rtm, idx, val) ((rtm)->Timing.sampleTimes[idx] = (val))
#endif

#ifndef rtmGetSampleTimeTaskID
# define rtmGetSampleTimeTaskID(rtm, idx) ((rtm)->Timing.sampleTimeTaskIDPtr[idx])
#endif

#ifndef rtmSetSampleTimeTaskID
# define rtmSetSampleTimeTaskID(rtm, idx, val) ((rtm)->Timing.sampleTimeTaskIDPtr[idx] = (val))
#endif

#ifndef rtmGetVarNextHitTimeList
# define rtmGetVarNextHitTimeList(rtm, idx) ((rtm)->Timing.varNextHitTimesList[idx])
#endif

#ifndef rtmSetVarNextHitTimeList
# define rtmSetVarNextHitTimeList(rtm, idx, val) ((rtm)->Timing.varNextHitTimesList[idx] = (val))
#endif

#ifndef rtmIsContinuousTask
# define rtmIsContinuousTask(rtm, tid) 0
#endif

#ifndef rtmGetErrorStatus
# define rtmGetErrorStatus(rtm)        ((rtm)->errorStatus)
#endif

#ifndef rtmSetErrorStatus
# define rtmSetErrorStatus(rtm, val)   ((rtm)->errorStatus = (val))
#endif

#ifndef rtmIsSampleHit
# define rtmIsSampleHit(rtm, sti, tid) (((rtm)->Timing.sampleTimeTaskIDPtr[sti] == (tid)))
#endif

#ifndef rtmStepTask
# define rtmStepTask(rtm, idx)         ((rtm)->Timing.TaskCounters.TID[(idx)] == 0)
#endif

#ifndef rtmGetStopRequested
# define rtmGetStopRequested(rtm)      ((rtm)->Timing.stopRequestedFlag)
#endif

#ifndef rtmSetStopRequested
# define rtmSetStopRequested(rtm, val) ((rtm)->Timing.stopRequestedFlag = (val))
#endif

#ifndef rtmGetStopRequestedPtr
# define rtmGetStopRequestedPtr(rtm)   (&((rtm)->Timing.stopRequestedFlag))
#endif

#ifndef rtmGetT
# define rtmGetT(rtm)                  (rtmGetTPtr((rtm))[0])
#endif

#ifndef rtmSetT
# define rtmSetT(rtm, val)                                       /* Do Nothing */
#endif

#ifndef rtmGetTFinal
# define rtmGetTFinal(rtm)             ((rtm)->Timing.tFinal)
#endif

#ifndef rtmSetTFinal
# define rtmSetTFinal(rtm, val)        ((rtm)->Timing.tFinal = (val))
#endif

#ifndef rtmGetTPtr
# define rtmGetTPtr(rtm)               ((rtm)->Timing.t)
#endif

#ifndef rtmSetTPtr
# define rtmSetTPtr(rtm, val)          ((rtm)->Timing.t = (val))
#endif

#ifndef rtmGetTStart
# define rtmGetTStart(rtm)             ((rtm)->Timing.tStart)
#endif

#ifndef rtmSetTStart
# define rtmSetTStart(rtm, val)        ((rtm)->Timing.tStart = (val))
#endif

#ifndef rtmTaskCounter
# define rtmTaskCounter(rtm, idx)      ((rtm)->Timing.TaskCounters.TID[(idx)])
#endif

#ifndef rtmGetTaskTime
# define rtmGetTaskTime(rtm, sti)      (rtmGetTPtr((rtm))[(rtm)->Timing.sampleTimeTaskIDPtr[sti]])
#endif

#ifndef rtmSetTaskTime
# define rtmSetTaskTime(rtm, sti, val) (rtmGetTPtr((rtm))[sti] = (val))
#endif

#ifndef rtmGetTimeOfLastOutput
# define rtmGetTimeOfLastOutput(rtm)   ((rtm)->Timing.timeOfLastOutput)
#endif

#ifdef rtmGetRTWSolverInfo
#undef rtmGetRTWSolverInfo
#endif

#define rtmGetRTWSolverInfo(rtm)       &((rtm)->solverInfo)
#define rtModel_quadripulse_controller14 RT_MODEL_quadripulse_controller14_T

/* Definition for use in the target main file */
#define quadripulse_controller14_rtModel RT_MODEL_quadripulse_controller14_T

/* user code (top of export header file) */
#include "xpcdatatypes.h"

/* Block signals (auto storage) */
typedef struct {
  creal_T FFT[1024];                   /* '<S30>/FFT' */
  real_T Row1[65];                     /* '<Root>/Row1' */
  real_T Extract1_o2;                  /* '<S50>/Extract 1' */
  real_T DataTypeConversion[330];      /* '<S27>/Data Type Conversion' */
  real_T Gain[330];                    /* '<S27>/Gain' */
  real_T Reshape2[330];                /* '<S27>/Reshape2' */
  real_T MathFunction[330];            /* '<S27>/Math Function' */
  real_T Derepeat[66];                 /* '<Root>/Derepeat' */
  real_T Reshape1[66];                 /* '<Root>/Reshape1' */
  real_T TmpSignalConversionAtMeanInport[65];
  real_T Mean;                         /* '<S3>/Mean' */
  real_T Subtract[65];                 /* '<S3>/Subtract' */
  real_T Row[65];                      /* '<Root>/Row' */
  real_T Product;                      /* '<Root>/Product' */
  real_T Buffer[512];                  /* '<Root>/Buffer' */
  real_T Mean_d;                       /* '<S9>/Mean' */
  real_T Subtract_i[512];              /* '<S9>/Subtract' */
  real_T FIRBandpassFilterForward[512];/* '<S17>/FIR Bandpass Filter Forward' */
  real_T Flip[512];                    /* '<S17>/Flip' */
  real_T FIRBandpassFilterBackward[512];/* '<S17>/FIR Bandpass Filter Backward' */
  real_T ReFlip[512];                  /* '<S17>/Re-Flip' */
  real_T RemoveEdgesfirstlast64[384];  /* '<Root>/Remove Edges (first & last 64)' */
  real_T Autocorrelation[31];          /* '<S42>/Autocorrelation' */
  real_T LevinsonDurbin_o1[31];        /* '<S42>/Levinson-Durbin' */
  real_T LevinsonDurbin_o2;            /* '<S42>/Levinson-Durbin' */
  real_T Now;                          /* '<Root>/Now' */
  real_T Uk1;                          /* '<S46>/UD' */
  real_T RateTransition2[512];         /* '<S10>/Rate Transition2' */
  real_T Reshape[512];                 /* '<S29>/Reshape' */
  real_T DotProduct2;                  /* '<S29>/Dot Product2' */
  real_T Maximum;                      /* '<S29>/Maximum' */
  real_T linearterm3;                  /* '<S29>/linear term3' */
  real_T MatrixSum1;                   /* '<S29>/Matrix Sum1' */
  real_T linearterm2;                  /* '<S29>/linear term2' */
  real_T Sum1;                         /* '<S29>/Sum1' */
  real_T DotProduct;                   /* '<S29>/Dot Product' */
  real_T MatrixSum2;                   /* '<S29>/Matrix Sum2' */
  real_T a;                            /* '<S29>/Merge' */
  real_T linearterm1[512];             /* '<S29>/linear term1' */
  real_T b;                            /* '<S29>/Merge1' */
  real_T Sum5[512];                    /* '<S29>/Sum5' */
  real_T Sum4[512];                    /* '<S29>/Sum4' */
  real_T Inherit[512];                 /* '<S35>/Inherit' */
  real_T WindowFunction_o1[512];       /* '<S10>/Window Function' */
  real_T WindowFunction_o2[512];       /* '<S10>/Window Function' */
  real_T Pad[1024];                    /* '<S10>/Pad' */
  real_T MagnitudeSquared[1024];       /* '<S30>/Magnitude Squared' */
  real_T SumofElements;                /* '<S10>/Sum of Elements' */
  real_T Divide[1024];                 /* '<S10>/Divide' */
  real_T scaletoperHz[1024];           /* '<S10>/scale to per Hz' */
  real_T Selector[1024];               /* '<S10>/Selector' */
  real_T Mean_l;                       /* '<S10>/Mean' */
  real_T RateTransition1;              /* '<Root>/Rate Transition1' */
  real_T RateTransition2_n;            /* '<Root>/Rate Transition2' */
  real_T Sort[600];                    /* '<S23>/Sort' */
  real_T Probe[2];                     /* '<S23>/Probe' */
  real_T Subtract_f;                   /* '<S23>/Subtract' */
  real_T Multiply[2];                  /* '<S23>/Multiply' */
  real_T RoundingFunction[2];          /* '<S23>/Rounding Function' */
  real_T Selector_m[2];                /* '<S23>/Selector' */
  real_T Reshape1_a[2];                /* '<S23>/Reshape1' */
  real_T RateTransition3[2];           /* '<Root>/Rate Transition3' */
  real_T ManualSwitch[2];              /* '<Root>/Manual Switch' */
  real_T DataTypeConversion_l;         /* '<Root>/Data Type Conversion' */
  real_T DataTypeConversion1;          /* '<Root>/Data Type Conversion1' */
  real_T DataTypeConversion2;          /* '<Root>/Data Type Conversion2' */
  real_T DataTypeConversion3;          /* '<Root>/Data Type Conversion3' */
  real_T DataTypeConversion5;          /* '<Root>/Data Type Conversion5' */
  real_T Times2end;                    /* '<S21>/Times 2..end' */
  real_T Times1end1;                   /* '<S21>/Times 1..end-1' */
  real_T Subtract_n;                   /* '<S21>/Subtract' */
  real_T MinMax;                       /* '<S21>/MinMax' */
  real_T ACModeScalingFactor[66];      /* '<Root>/AC Mode Scaling Factor' */
  real_T Delay1;                       /* '<Root>/Delay1' */
  real_T Delay2;                       /* '<Root>/Delay2' */
  real_T RateTransition3_e[1024];      /* '<S10>/Rate Transition3' */
  real_T MatrixConcatenation[200];     /* '<S10>/Matrix Concatenation' */
  real_T Unbuffer[2];                  /* '<S10>/Unbuffer' */
  real_T Data;                         /* '<S10>/Data' */
  real_T TriggerSignal;                /* '<S10>/Trigger Signal' */
  real_T Delay1_b[5];                  /* '<S36>/Delay1' */
  real_T TmpSignalConversionAtDelayInpor[5];
  real_T Delay[5];                     /* '<S36>/Delay' */
  real_T Add[5];                       /* '<S36>/Add' */
  real_T Gain_c[5];                    /* '<S36>/Gain' */
  real_T ZeroOrderHold[5];             /* '<S16>/Zero-Order Hold' */
  real_T RateTransition[5];            /* '<S16>/Rate Transition' */
  real_T Add_o[5];                     /* '<S16>/Add' */
  real_T VectorConcatenate[1024];      /* '<Root>/Vector Concatenate' */
  real_T SingleRow[2];                 /* '<Root>/Single Row' */
  real_T CounterDelay;                 /* '<S26>/Counter Delay' */
  real_T Saturate;                     /* '<S26>/Saturate' */
  real_T DataTypeConversion1_b;        /* '<S26>/Data Type Conversion1' */
  real_T Gain_p;                       /* '<S26>/Gain' */
  real_T TimeData[2];                  /* '<S26>/Time Data' */
  real_T TimeIndex;                    /* '<S26>/Time Index' */
  real_T DataTypeConversion4;          /* '<S26>/Data Type Conversion4' */
  real_T Sum;                          /* '<S26>/Sum' */
  real_T Switch;                       /* '<S26>/Switch' */
  real_T ChannelData[2];               /* '<S26>/Channel Data' */
  real_T ChannelIndex;                 /* '<S26>/Channel Index' */
  real_T NumberofCoefficients;         /* '<S43>/Number of Coefficients' */
  real_T FrameLength;                  /* '<S43>/Frame Length' */
  real_T Add_d;                        /* '<S43>/Add' */
  real_T UnitDelay;                    /* '<S43>/Unit Delay' */
  real_T Assignment[128];              /* '<S43>/Assignment' */
  real_T SecondtoLast[30];             /* '<S43>/Second to Last' */
  real_T Flip_a[30];                   /* '<S43>/Flip' */
  real_T TmpSignalConversionAtVariableSe[512];
  real_T Sum1_k[30];                   /* '<S43>/Sum1' */
  real_T VariableSelector[30];         /* '<S43>/Variable Selector' */
  real_T DotProduct_n;                 /* '<S43>/Dot Product' */
  real_T FirstElement;                 /* '<S43>/First Element' */
  real_T Sum_e;                        /* '<S43>/Sum' */
  real_T Buffer_p[600];                /* '<S38>/Buffer' */
  real_T InheritComplexity;            /* '<S34>/Inherit Complexity' */
  real_T MultiportSelector;            /* '<S34>/Multiport Selector' */
  real_T linearterm3_j;                /* '<S33>/linear term3' */
  real_T linearterm4;                  /* '<S33>/linear term4' */
  real_T Sum1_m;                       /* '<S33>/Sum1' */
  real_T linearterm1_m;                /* '<S33>/linear term1' */
  real_T linearterm2_j;                /* '<S33>/linear term2' */
  real_T Sum4_e;                       /* '<S33>/Sum4' */
  real_T HighpassFilter[2];            /* '<Root>/Highpass Filter' */
  real_T Diff;                         /* '<S46>/Diff' */
  int32_T ByteUnpacking[330];          /* '<S27>/Byte Unpacking ' */
  int32_T UnitDelay_n;                 /* '<S39>/Unit Delay' */
  int32_T SetCounterSwitch;            /* '<S39>/Set Counter Switch' */
  int32_T KeepPostiveSwitch;           /* '<S39>/Keep Postive Switch' */
  int32_T ForIterator;                 /* '<S43>/For Iterator' */
  int32_T UnitDelay1;                  /* '<S43>/Unit Delay1' */
  int32_T Saturation;                  /* '<S43>/Saturation' */
  int32_T DataTypeConversion_k;        /* '<S39>/Data Type Conversion' */
  int32_T Sum_n;                       /* '<S39>/Sum' */
  uint32_T UDPRx1;                     /* '<S50>/UDP Rx 1' */
  uint32_T Buffer1;                    /* '<S50>/Buffer 1' */
  uint32_T UDPConsume1_o1;             /* '<S50>/UDP Consume 1' */
  uint32_T UDPConsume1_o2;             /* '<S50>/UDP Consume 1' */
  uint32_T Output;                     /* '<S47>/Output' */
  uint32_T FixPtSum1;                  /* '<S48>/FixPt Sum1' */
  uint32_T FixPtSwitch;                /* '<S49>/FixPt Switch' */
  uint32_T Seconds;                    /* '<S39>/Seconds' */
  uint16_T WeightedSampleTime;         /* '<S39>/Weighted Sample Time' */
  uint8_T Extract1_o1[1018];           /* '<S50>/Extract 1' */
  uint8_T Reshape_p[990];              /* '<S27>/Reshape' */
  uint8_T Flip_b[990];                 /* '<S27>/Flip' */
  uint8_T MatrixConcatenate[1320];     /* '<S27>/Matrix Concatenate' */
  uint8_T Switch1;                     /* '<Root>/Switch1' */
  uint8_T DataTypeConversion4_k;       /* '<Root>/Data Type Conversion4' */
  boolean_T UnitDelay_b;               /* '<Root>/Unit Delay' */
  boolean_T Compare;                   /* '<S40>/Compare' */
  boolean_T RateTransition_j;          /* '<S23>/Rate Transition' */
  boolean_T Switch_g;                  /* '<Root>/Switch' */
  boolean_T Memory;                    /* '<S20>/Memory' */
  boolean_T Logic[2];                  /* '<S20>/Logic' */
  boolean_T Compare_l;                 /* '<S4>/Compare' */
  boolean_T Compare_h;                 /* '<S5>/Compare' */
  boolean_T Compare_ln;                /* '<S6>/Compare' */
  boolean_T Compare_n;                 /* '<S7>/Compare' */
  boolean_T HitCrossing;               /* '<Root>/Hit  Crossing' */
  boolean_T Compare_e;                 /* '<S37>/Compare' */
  boolean_T Compare_d;                 /* '<S8>/Compare' */
  boolean_T Boundscheck;               /* '<S26>/Bounds check' */
  boolean_T RelationalOperator;        /* '<S26>/Relational Operator' */
  boolean_T LogicalOperator;           /* '<S26>/Logical Operator' */
  boolean_T max;                       /* '<S25>/<= max' */
  boolean_T min;                       /* '<S25>/>= min' */
  boolean_T WithinRange;               /* '<S25>/Within Range' */
  boolean_T HitCrossing2;              /* '<S45>/Hit  Crossing2' */
  boolean_T HitCrossing1;              /* '<S45>/Hit  Crossing1' */
  boolean_T HitCrossing3;              /* '<S45>/Hit  Crossing3' */
  boolean_T HitCrossing_i;             /* '<S45>/Hit  Crossing' */
  boolean_T IndexVector;               /* '<S25>/Index Vector' */
  boolean_T TriggerConditionMet;       /* '<S25>/Trigger Condition Met' */
} B_quadripulse_controller14_T;

/* Block states (auto storage) for system '<Root>' */
typedef struct {
  dspcodegen_FIRFilter_quadripu_T gobj_0;/* '<Root>/Highpass Filter' */
  dspcodegen_FIRFilter_quadripu_T gobj_1;/* '<Root>/Highpass Filter' */
  dsp_HighpassFilter_quadripuls_T obj; /* '<Root>/Highpass Filter' */
  real_T Derepeat_Buffer[66];          /* '<Root>/Derepeat' */
  real_T Buffer_CircBuff[511];         /* '<Root>/Buffer' */
  real_T FIRBandpassFilterForward_states[128];/* '<S17>/FIR Bandpass Filter Forward' */
  real_T FIRBandpassFilterBackward_state[128];/* '<S17>/FIR Bandpass Filter Backward' */
  real_T UD_DSTATE;                    /* '<S46>/UD' */
  real_T Delay1_DSTATE[128];           /* '<Root>/Delay1' */
  real_T Delay2_DSTATE[128];           /* '<Root>/Delay2' */
  real_T Unbuffer_CircBuf[400];        /* '<S10>/Unbuffer' */
  real_T Delay1_DSTATE_e[5];           /* '<S36>/Delay1' */
  real_T Delay_DSTATE[2500];           /* '<S36>/Delay' */
  real_T CounterDelay_DSTATE;          /* '<S26>/Counter Delay' */
  real_T UnitDelay_DSTATE;             /* '<S43>/Unit Delay' */
  real_T Buffer_CircBuff_a[599];       /* '<S38>/Buffer' */
  real_T Mean_AccVal;                  /* '<S3>/Mean' */
  real_T Mean_AccVal_d;                /* '<S9>/Mean' */
  real_T Mean_AccVal_h;                /* '<S10>/Mean' */
  real_T Add_DWORK1;                   /* '<S43>/Add' */
  void *Buffer1_PWORK;                 /* '<S50>/Buffer 1' */
  struct {
    void *OutBuf;
    void *InBuf;
  } Derepeat_PWORK;                    /* '<Root>/Derepeat' */

  void *HighpassFilter_PWORK;          /* '<Root>/Highpass Filter' */
  int32_T Derepeat_Count;              /* '<Root>/Derepeat' */
  int32_T Buffer_CircBufIdx;           /* '<Root>/Buffer' */
  int32_T UnitDelay_DSTATE_b;          /* '<S39>/Unit Delay' */
  int32_T Unbuffer_inBufPtrIdx;        /* '<S10>/Unbuffer' */
  int32_T Unbuffer_outBufPtrIdx;       /* '<S10>/Unbuffer' */
  int32_T Unbuffer_bufferLength;       /* '<S10>/Unbuffer' */
  int32_T UnitDelay1_DSTATE;           /* '<S43>/Unit Delay1' */
  int32_T Buffer_CircBufIdx_d;         /* '<S38>/Buffer' */
  uint32_T Output_DSTATE;              /* '<S47>/Output' */
  int32_T Pad_inAdd[2];                /* '<S10>/Pad' */
  int32_T Pad_outAdd[2];               /* '<S10>/Pad' */
  int32_T Selector_DIMS1[2];           /* '<S10>/Selector' */
  int32_T Sum_DWORK1;                  /* '<S39>/Sum' */
  uint32_T CircBufIdx;                 /* '<S36>/Delay' */
  uint32_T Sum_DWORK1_p;               /* '<S26>/Sum' */
  struct {
    int_T AcquireOK;
  } SFunction_IWORK;                   /* '<S1>/S-Function' */

  struct {
    int_T AcquireOK;
  } SFunction_IWORK_e;                 /* '<S2>/S-Function' */

  struct {
    int_T AcquireOK;
  } SFunction_IWORK_b;                 /* '<S11>/S-Function' */

  struct {
    int_T AcquireOK;
  } SFunction_IWORK_n;                 /* '<S12>/S-Function' */

  struct {
    int_T AcquireOK;
  } SFunction_IWORK_j;                 /* '<S13>/S-Function' */

  struct {
    int_T AcquireOK;
  } SFunction_IWORK_np;                /* '<S14>/S-Function' */

  struct {
    int_T AcquireOK;
  } SFunction_IWORK_k;                 /* '<S15>/S-Function' */

  struct {
    int_T AcquireOK;
  } SFunction_IWORK_o;                 /* '<S18>/S-Function' */

  int_T UDPRx1_IWORK[11];              /* '<S50>/UDP Rx 1' */
  int_T Buffer1_IWORK[2];              /* '<S50>/Buffer 1' */
  int_T UDPConsume1_IWORK;             /* '<S50>/UDP Consume 1' */
  int_T ByteUnpacking_IWORK[2];        /* '<S27>/Byte Unpacking ' */
  int_T PD2MF12bitseries_IWORK[2];     /* '<Root>/PD2-MF 12bit series' */
  struct {
    int_T AcquireOK;
  } SFunction_IWORK_g;                 /* '<S22>/S-Function' */

  int_T HitCrossing_MODE;              /* '<Root>/Hit  Crossing' */
  int_T HitCrossing2_MODE;             /* '<S45>/Hit  Crossing2' */
  int_T HitCrossing1_MODE;             /* '<S45>/Hit  Crossing1' */
  int_T HitCrossing3_MODE;             /* '<S45>/Hit  Crossing3' */
  int_T HitCrossing_MODE_m;            /* '<S45>/Hit  Crossing' */
  boolean_T UnitDelay_DSTATE_m;        /* '<Root>/Unit Delay' */
  int8_T IfActionSubsystem_SubsysRanBC;/* '<S29>/If Action Subsystem' */
  int8_T IfActionSubsystem1_SubsysRanBC;/* '<S29>/If Action Subsystem1' */
  int8_T EnabledSubsystem_SubsysRanBC; /* '<S23>/Enabled Subsystem' */
  int8_T TriggerGenerator_SubsysRanBC; /* '<Root>/Trigger Generator' */
  boolean_T WindowFunction_FLAG;       /* '<S10>/Window Function' */
  boolean_T Memory_PreviousInput;      /* '<S20>/Memory' */
  boolean_T objisempty;                /* '<Root>/Highpass Filter' */
  boolean_T isInitialized;             /* '<Root>/Highpass Filter' */
  boolean_T TriggerGenerator_MODE;     /* '<Root>/Trigger Generator' */
} DW_quadripulse_controller14_T;

/* Zero-crossing (trigger) state */
typedef struct {
  ZCSigState HitCrossing_Input_ZCE;    /* '<Root>/Hit  Crossing' */
  ZCSigState HitCrossing2_Input_ZCE;   /* '<S45>/Hit  Crossing2' */
  ZCSigState HitCrossing1_Input_ZCE;   /* '<S45>/Hit  Crossing1' */
  ZCSigState HitCrossing3_Input_ZCE;   /* '<S45>/Hit  Crossing3' */
  ZCSigState HitCrossing_Input_ZCE_n;  /* '<S45>/Hit  Crossing' */
} PrevZCX_quadripulse_controller14_T;

/* Invariant block signals (auto storage) */
typedef struct {
  const real_T ramp[512];              /* '<S29>/Constant Ramp' */
  const real_T TmpSignalConversionAtConsta[5];
  const real_T ConstantRamp[5];        /* '<S16>/Constant Ramp' */
  const real_T Width;                  /* '<S26>/Width' */
  const real_T ConstantRamp_i[30];     /* '<S43>/Constant Ramp' */
} ConstB_quadripulse_controller14_T;

/* Constant parameters (auto storage) */
typedef struct {
  /* Computed Parameter: WindowFunction_WindowSamples
   * Referenced by: '<S10>/Window Function'
   */
  real_T WindowFunction_WindowSamples[512];

  /* Computed Parameter: FFT_TwiddleTable
   * Referenced by: '<S30>/FFT'
   */
  real_T FFT_TwiddleTable[768];
} ConstP_quadripulse_controller14_T;

/* Backward compatible GRT Identifiers */
#define rtB                            quadripulse_controller14_B
#define BlockIO                        B_quadripulse_controller14_T
#define rtP                            quadripulse_controller14_P
#define Parameters                     P_quadripulse_controller14_T
#define rtDWork                        quadripulse_controller14_DW
#define D_Work                         DW_quadripulse_controller14_T
#define tConstBlockIOType              ConstB_quadripulse_controller14_T
#define rtC                            quadripulse_controller14_ConstB
#define ConstParam                     ConstP_quadripulse_controller14_T
#define rtcP                           quadripulse_controller14_ConstP
#define rtPrevZCSigState               quadripulse_controller14_PrevZCX
#define PrevZCSigStates                PrevZCX_quadripulse_controller14_T

/* Parameters (auto storage) */
struct P_quadripulse_controller14_T_ {
  real_T amplitudeinterval[2];         /* Variable: amplitudeinterval
                                        * Referenced by: '<Root>/Constant3'
                                        */
  real_T amplitudeinterval_percentiles[2];/* Variable: amplitudeinterval_percentiles
                                           * Referenced by: '<Root>/Constant5'
                                           */
  real_T fft_bin_indices_zero_based[2];/* Variable: fft_bin_indices_zero_based
                                        * Referenced by: '<S10>/Constant'
                                        */
  real_T fir_filter_coefficients[129]; /* Variable: fir_filter_coefficients
                                        * Referenced by:
                                        *   '<S17>/FIR Bandpass Filter Backward'
                                        *   '<S17>/FIR Bandpass Filter Forward'
                                        */
  real_T phasecondition;               /* Variable: phasecondition
                                        * Referenced by: '<Root>/Constant2'
                                        */
  real_T spatial_filter[65];           /* Variable: spatial_filter
                                        * Referenced by: '<Root>/Constant1'
                                        */
  real_T timeinsecondsandtriggerchannel[4];/* Variable: timeinsecondsandtriggerchannel
                                            * Referenced by: '<Root>/Constant'
                                            */
  uint8_T marker_id;                   /* Variable: marker_id
                                        * Referenced by: '<Root>/Triggetr ID'
                                        */
  boolean_T closedloopmode;            /* Variable: closedloopmode
                                        * Referenced by: '<Root>/Reset1'
                                        */
  boolean_T reset;                     /* Variable: reset
                                        * Referenced by: '<Root>/Reset'
                                        */
  real_T Difference_ICPrevInput;       /* Mask Parameter: Difference_ICPrevInput
                                        * Referenced by: '<S46>/UD'
                                        */
  real_T RunningAverage_N;             /* Mask Parameter: RunningAverage_N
                                        * Referenced by: '<S36>/Gain'
                                        */
  real_T Constant5_Value[100];         /* Mask Parameter: Constant5_Value
                                        * Referenced by: '<S28>/Constant'
                                        */
  real_T CompareToConstant_const;      /* Mask Parameter: CompareToConstant_const
                                        * Referenced by: '<S4>/Constant'
                                        */
  real_T CompareToConstant1_const;     /* Mask Parameter: CompareToConstant1_const
                                        * Referenced by: '<S5>/Constant'
                                        */
  real_T CompareToConstant2_const;     /* Mask Parameter: CompareToConstant2_const
                                        * Referenced by: '<S6>/Constant'
                                        */
  real_T CompareToConstant3_const;     /* Mask Parameter: CompareToConstant3_const
                                        * Referenced by: '<S7>/Constant'
                                        */
  real_T uinto1UnitLimit_const;        /* Mask Parameter: uinto1UnitLimit_const
                                        * Referenced by: '<S37>/Constant'
                                        */
  real_T Pad_padVal;                   /* Mask Parameter: Pad_padVal
                                        * Referenced by: '<S10>/Pad'
                                        */
  int32_T Forecastof128samples_num_iterat;/* Mask Parameter: Forecastof128samples_num_iterat
                                           * Referenced by: '<S43>/Saturation'
                                           */
  uint32_T WrapToZero_Threshold;       /* Mask Parameter: WrapToZero_Threshold
                                        * Referenced by: '<S49>/FixPt Switch'
                                        */
  boolean_T SRFlipFlop_initial_condition;/* Mask Parameter: SRFlipFlop_initial_condition
                                          * Referenced by: '<S20>/Memory'
                                          */
  real_T HitCrossing2_Offset;          /* Expression: 0
                                        * Referenced by: '<S45>/Hit  Crossing2'
                                        */
  real_T HitCrossing1_Offset;          /* Expression: 0
                                        * Referenced by: '<S45>/Hit  Crossing1'
                                        */
  real_T HitCrossing3_Offset;          /* Expression: 0
                                        * Referenced by: '<S45>/Hit  Crossing3'
                                        */
  real_T HitCrossing_Offset;           /* Expression: 0
                                        * Referenced by: '<S45>/Hit  Crossing'
                                        */
  real_T Out1_Y0;                      /* Computed Parameter: Out1_Y0
                                        * Referenced by: '<S38>/Out1'
                                        */
  real_T Buffer_ic;                    /* Expression: 0
                                        * Referenced by: '<S38>/Buffer'
                                        */
  real_T Forecast_Y0;                  /* Computed Parameter: Forecast_Y0
                                        * Referenced by: '<S43>/Forecast'
                                        */
  real_T UnitDelay_InitialCondition;   /* Expression: 0
                                        * Referenced by: '<S43>/Unit Delay'
                                        */
  real_T Zero_Value;                   /* Expression: 0
                                        * Referenced by: '<S26>/Zero'
                                        */
  real_T Channel_Y0;                   /* Computed Parameter: Channel_Y0
                                        * Referenced by: '<S26>/Channel'
                                        */
  real_T CounterDelay_InitialCondition;/* Expression: 1
                                        * Referenced by: '<S26>/Counter Delay'
                                        */
  real_T Gain_Gain;                    /* Expression: 0.001
                                        * Referenced by: '<S26>/Gain'
                                        */
  real_T BufferMngmt_P1_Size[2];       /* Computed Parameter: BufferMngmt_P1_Size
                                        * Referenced by: '<S19>/Buffer Mngmt '
                                        */
  real_T BufferMngmt_P1[4];            /* Expression: pool_sizes
                                        * Referenced by: '<S19>/Buffer Mngmt '
                                        */
  real_T BufferMngmt_P2_Size[2];       /* Computed Parameter: BufferMngmt_P2_Size
                                        * Referenced by: '<S19>/Buffer Mngmt '
                                        */
  real_T BufferMngmt_P2;               /* Expression: SampleTime
                                        * Referenced by: '<S19>/Buffer Mngmt '
                                        */
  real_T BufferMngmt_P3_Size[2];       /* Computed Parameter: BufferMngmt_P3_Size
                                        * Referenced by: '<S19>/Buffer Mngmt '
                                        */
  real_T BufferMngmt_P3;               /* Expression: ShowTune
                                        * Referenced by: '<S19>/Buffer Mngmt '
                                        */
  real_T EthernetInit_P1_Size[2];      /* Computed Parameter: EthernetInit_P1_Size
                                        * Referenced by: '<S19>/Ethernet Init '
                                        */
  real_T EthernetInit_P1;              /* Expression: ID
                                        * Referenced by: '<S19>/Ethernet Init '
                                        */
  real_T EthernetInit_P2_Size[2];      /* Computed Parameter: EthernetInit_P2_Size
                                        * Referenced by: '<S19>/Ethernet Init '
                                        */
  real_T EthernetInit_P2;              /* Expression: Driver
                                        * Referenced by: '<S19>/Ethernet Init '
                                        */
  real_T EthernetInit_P3_Size[2];      /* Computed Parameter: EthernetInit_P3_Size
                                        * Referenced by: '<S19>/Ethernet Init '
                                        */
  real_T EthernetInit_P3;              /* Expression: Bus
                                        * Referenced by: '<S19>/Ethernet Init '
                                        */
  real_T EthernetInit_P4_Size[2];      /* Computed Parameter: EthernetInit_P4_Size
                                        * Referenced by: '<S19>/Ethernet Init '
                                        */
  real_T EthernetInit_P4;              /* Expression: Slot
                                        * Referenced by: '<S19>/Ethernet Init '
                                        */
  real_T EthernetInit_P5_Size[2];      /* Computed Parameter: EthernetInit_P5_Size
                                        * Referenced by: '<S19>/Ethernet Init '
                                        */
  real_T EthernetInit_P5;              /* Expression: VendorID
                                        * Referenced by: '<S19>/Ethernet Init '
                                        */
  real_T EthernetInit_P6_Size[2];      /* Computed Parameter: EthernetInit_P6_Size
                                        * Referenced by: '<S19>/Ethernet Init '
                                        */
  real_T EthernetInit_P6;              /* Expression: DeviceID
                                        * Referenced by: '<S19>/Ethernet Init '
                                        */
  real_T EthernetInit_P7_Size[2];      /* Computed Parameter: EthernetInit_P7_Size
                                        * Referenced by: '<S19>/Ethernet Init '
                                        */
  real_T EthernetInit_P7;              /* Expression: AddressSource
                                        * Referenced by: '<S19>/Ethernet Init '
                                        */
  real_T EthernetInit_P8_Size[2];      /* Computed Parameter: EthernetInit_P8_Size
                                        * Referenced by: '<S19>/Ethernet Init '
                                        */
  real_T EthernetInit_P8[6];           /* Expression: mac
                                        * Referenced by: '<S19>/Ethernet Init '
                                        */
  real_T EthernetInit_P9_Size[2];      /* Computed Parameter: EthernetInit_P9_Size
                                        * Referenced by: '<S19>/Ethernet Init '
                                        */
  real_T EthernetInit_P9;              /* Expression: TxSA
                                        * Referenced by: '<S19>/Ethernet Init '
                                        */
  real_T EthernetInit_P10_Size[2];     /* Computed Parameter: EthernetInit_P10_Size
                                        * Referenced by: '<S19>/Ethernet Init '
                                        */
  real_T EthernetInit_P10;             /* Expression: RxPromiscuous
                                        * Referenced by: '<S19>/Ethernet Init '
                                        */
  real_T EthernetInit_P11_Size[2];     /* Computed Parameter: EthernetInit_P11_Size
                                        * Referenced by: '<S19>/Ethernet Init '
                                        */
  real_T EthernetInit_P11;             /* Expression: RxBad
                                        * Referenced by: '<S19>/Ethernet Init '
                                        */
  real_T EthernetInit_P12_Size[2];     /* Computed Parameter: EthernetInit_P12_Size
                                        * Referenced by: '<S19>/Ethernet Init '
                                        */
  real_T EthernetInit_P12;             /* Expression: RxShort
                                        * Referenced by: '<S19>/Ethernet Init '
                                        */
  real_T EthernetInit_P13_Size[2];     /* Computed Parameter: EthernetInit_P13_Size
                                        * Referenced by: '<S19>/Ethernet Init '
                                        */
  real_T EthernetInit_P13;             /* Expression: MaxMTU
                                        * Referenced by: '<S19>/Ethernet Init '
                                        */
  real_T EthernetInit_P14_Size[2];     /* Computed Parameter: EthernetInit_P14_Size
                                        * Referenced by: '<S19>/Ethernet Init '
                                        */
  real_T EthernetInit_P14;             /* Expression: TxThreshold
                                        * Referenced by: '<S19>/Ethernet Init '
                                        */
  real_T EthernetInit_P15_Size[2];     /* Computed Parameter: EthernetInit_P15_Size
                                        * Referenced by: '<S19>/Ethernet Init '
                                        */
  real_T EthernetInit_P15;             /* Expression: TxBuffers
                                        * Referenced by: '<S19>/Ethernet Init '
                                        */
  real_T EthernetInit_P16_Size[2];     /* Computed Parameter: EthernetInit_P16_Size
                                        * Referenced by: '<S19>/Ethernet Init '
                                        */
  real_T EthernetInit_P16;             /* Expression: RxBuffers
                                        * Referenced by: '<S19>/Ethernet Init '
                                        */
  real_T EthernetInit_P17_Size[2];     /* Computed Parameter: EthernetInit_P17_Size
                                        * Referenced by: '<S19>/Ethernet Init '
                                        */
  real_T EthernetInit_P17;             /* Expression: ShowTune
                                        * Referenced by: '<S19>/Ethernet Init '
                                        */
  real_T EthernetInit_P18_Size[2];     /* Computed Parameter: EthernetInit_P18_Size
                                        * Referenced by: '<S19>/Ethernet Init '
                                        */
  real_T EthernetInit_P18;             /* Expression: numMulti
                                        * Referenced by: '<S19>/Ethernet Init '
                                        */
  real_T EthernetInit_P19_Size[2];     /* Computed Parameter: EthernetInit_P19_Size
                                        * Referenced by: '<S19>/Ethernet Init '
                                        */
  real_T EthernetInit_P20_Size[2];     /* Computed Parameter: EthernetInit_P20_Size
                                        * Referenced by: '<S19>/Ethernet Init '
                                        */
  real_T EthernetInit_P20;             /* Expression: NumRxBlks
                                        * Referenced by: '<S19>/Ethernet Init '
                                        */
  real_T EthernetInit_P21_Size[2];     /* Computed Parameter: EthernetInit_P21_Size
                                        * Referenced by: '<S19>/Ethernet Init '
                                        */
  real_T EthernetInit_P21;             /* Expression: SampleTime
                                        * Referenced by: '<S19>/Ethernet Init '
                                        */
  real_T ARPInit_P1_Size[2];           /* Computed Parameter: ARPInit_P1_Size
                                        * Referenced by: '<S19>/ARP Init '
                                        */
  real_T ARPInit_P1;                   /* Expression: Stats
                                        * Referenced by: '<S19>/ARP Init '
                                        */
  real_T ARPInit_P2_Size[2];           /* Computed Parameter: ARPInit_P2_Size
                                        * Referenced by: '<S19>/ARP Init '
                                        */
  real_T ARPInit_P2;                   /* Expression: Interface
                                        * Referenced by: '<S19>/ARP Init '
                                        */
  real_T ARPInit_P3_Size[2];           /* Computed Parameter: ARPInit_P3_Size
                                        * Referenced by: '<S19>/ARP Init '
                                        */
  real_T ARPInit_P3;                   /* Expression: IpAddress
                                        * Referenced by: '<S19>/ARP Init '
                                        */
  real_T ARPInit_P4_Size[2];           /* Computed Parameter: ARPInit_P4_Size
                                        * Referenced by: '<S19>/ARP Init '
                                        */
  real_T ARPInit_P4;                   /* Expression: SubnetMask
                                        * Referenced by: '<S19>/ARP Init '
                                        */
  real_T ARPInit_P5_Size[2];           /* Computed Parameter: ARPInit_P5_Size
                                        * Referenced by: '<S19>/ARP Init '
                                        */
  real_T ARPInit_P5;                   /* Expression: Gateway
                                        * Referenced by: '<S19>/ARP Init '
                                        */
  real_T ARPInit_P6_Size[2];           /* Computed Parameter: ARPInit_P6_Size
                                        * Referenced by: '<S19>/ARP Init '
                                        */
  real_T ARPInit_P6;                   /* Expression: EthernetId
                                        * Referenced by: '<S19>/ARP Init '
                                        */
  real_T ARPInit_P7_Size[2];           /* Computed Parameter: ARPInit_P7_Size
                                        * Referenced by: '<S19>/ARP Init '
                                        */
  real_T ARPInit_P7;                   /* Expression: Flags
                                        * Referenced by: '<S19>/ARP Init '
                                        */
  real_T ARPInit_P8_Size[2];           /* Computed Parameter: ARPInit_P8_Size
                                        * Referenced by: '<S19>/ARP Init '
                                        */
  real_T ARPInit_P8;                   /* Expression: BlockId
                                        * Referenced by: '<S19>/ARP Init '
                                        */
  real_T ARPInit_P9_Size[2];           /* Computed Parameter: ARPInit_P9_Size
                                        * Referenced by: '<S19>/ARP Init '
                                        */
  real_T ARPInit_P9;                   /* Expression: Retry
                                        * Referenced by: '<S19>/ARP Init '
                                        */
  real_T ARPInit_P10_Size[2];          /* Computed Parameter: ARPInit_P10_Size
                                        * Referenced by: '<S19>/ARP Init '
                                        */
  real_T ARPInit_P10;                  /* Expression: Timeout
                                        * Referenced by: '<S19>/ARP Init '
                                        */
  real_T ARPInit_P11_Size[2];          /* Computed Parameter: ARPInit_P11_Size
                                        * Referenced by: '<S19>/ARP Init '
                                        */
  real_T ARPInit_P11;                  /* Expression: Expiration
                                        * Referenced by: '<S19>/ARP Init '
                                        */
  real_T ARPInit_P12_Size[2];          /* Computed Parameter: ARPInit_P12_Size
                                        * Referenced by: '<S19>/ARP Init '
                                        */
  real_T ARPInit_P13_Size[2];          /* Computed Parameter: ARPInit_P13_Size
                                        * Referenced by: '<S19>/ARP Init '
                                        */
  real_T ARPInit_P14_Size[2];          /* Computed Parameter: ARPInit_P14_Size
                                        * Referenced by: '<S19>/ARP Init '
                                        */
  real_T ARPInit_P15_Size[2];          /* Computed Parameter: ARPInit_P15_Size
                                        * Referenced by: '<S19>/ARP Init '
                                        */
  real_T ARPInit_P16_Size[2];          /* Computed Parameter: ARPInit_P16_Size
                                        * Referenced by: '<S19>/ARP Init '
                                        */
  real_T ARPInit_P16;                  /* Expression: SampleTime
                                        * Referenced by: '<S19>/ARP Init '
                                        */
  real_T IPInit_P1_Size[2];            /* Computed Parameter: IPInit_P1_Size
                                        * Referenced by: '<S19>/IP Init '
                                        */
  real_T IPInit_P1;                    /* Expression: Stats
                                        * Referenced by: '<S19>/IP Init '
                                        */
  real_T IPInit_P2_Size[2];            /* Computed Parameter: IPInit_P2_Size
                                        * Referenced by: '<S19>/IP Init '
                                        */
  real_T IPInit_P2;                    /* Expression: Group
                                        * Referenced by: '<S19>/IP Init '
                                        */
  real_T IPInit_P3_Size[2];            /* Computed Parameter: IPInit_P3_Size
                                        * Referenced by: '<S19>/IP Init '
                                        */
  real_T IPInit_P3;                    /* Expression: ArpId
                                        * Referenced by: '<S19>/IP Init '
                                        */
  real_T IPInit_P4_Size[2];            /* Computed Parameter: IPInit_P4_Size
                                        * Referenced by: '<S19>/IP Init '
                                        */
  real_T IPInit_P4;                    /* Expression: IpAddress
                                        * Referenced by: '<S19>/IP Init '
                                        */
  real_T IPInit_P5_Size[2];            /* Computed Parameter: IPInit_P5_Size
                                        * Referenced by: '<S19>/IP Init '
                                        */
  real_T IPInit_P5;                    /* Expression: SubnetMask
                                        * Referenced by: '<S19>/IP Init '
                                        */
  real_T IPInit_P6_Size[2];            /* Computed Parameter: IPInit_P6_Size
                                        * Referenced by: '<S19>/IP Init '
                                        */
  real_T IPInit_P6;                    /* Expression: DefaultGateway
                                        * Referenced by: '<S19>/IP Init '
                                        */
  real_T IPInit_P7_Size[2];            /* Computed Parameter: IPInit_P7_Size
                                        * Referenced by: '<S19>/IP Init '
                                        */
  real_T IPInit_P7;                    /* Expression: DefaultInterface
                                        * Referenced by: '<S19>/IP Init '
                                        */
  real_T IPInit_P8_Size[2];            /* Computed Parameter: IPInit_P8_Size
                                        * Referenced by: '<S19>/IP Init '
                                        */
  real_T IPInit_P8;                    /* Expression: Flags
                                        * Referenced by: '<S19>/IP Init '
                                        */
  real_T IPInit_P9_Size[2];            /* Computed Parameter: IPInit_P9_Size
                                        * Referenced by: '<S19>/IP Init '
                                        */
  real_T IPInit_P9;                    /* Expression: ToS
                                        * Referenced by: '<S19>/IP Init '
                                        */
  real_T IPInit_P10_Size[2];           /* Computed Parameter: IPInit_P10_Size
                                        * Referenced by: '<S19>/IP Init '
                                        */
  real_T IPInit_P10;                   /* Expression: StartingId
                                        * Referenced by: '<S19>/IP Init '
                                        */
  real_T IPInit_P11_Size[2];           /* Computed Parameter: IPInit_P11_Size
                                        * Referenced by: '<S19>/IP Init '
                                        */
  real_T IPInit_P11;                   /* Expression: TTL
                                        * Referenced by: '<S19>/IP Init '
                                        */
  real_T IPInit_P12_Size[2];           /* Computed Parameter: IPInit_P12_Size
                                        * Referenced by: '<S19>/IP Init '
                                        */
  real_T IPInit_P12;                   /* Expression: SampleTime
                                        * Referenced by: '<S19>/IP Init '
                                        */
  real_T UDPInit_P1_Size[2];           /* Computed Parameter: UDPInit_P1_Size
                                        * Referenced by: '<S19>/UDP Init '
                                        */
  real_T UDPInit_P1;                   /* Expression: Stats
                                        * Referenced by: '<S19>/UDP Init '
                                        */
  real_T UDPInit_P2_Size[2];           /* Computed Parameter: UDPInit_P2_Size
                                        * Referenced by: '<S19>/UDP Init '
                                        */
  real_T UDPInit_P2;                   /* Expression: Group
                                        * Referenced by: '<S19>/UDP Init '
                                        */
  real_T UDPInit_P3_Size[2];           /* Computed Parameter: UDPInit_P3_Size
                                        * Referenced by: '<S19>/UDP Init '
                                        */
  real_T UDPInit_P3;                   /* Expression: StartingPort
                                        * Referenced by: '<S19>/UDP Init '
                                        */
  real_T UDPInit_P4_Size[2];           /* Computed Parameter: UDPInit_P4_Size
                                        * Referenced by: '<S19>/UDP Init '
                                        */
  real_T UDPInit_P4;                   /* Expression: Flags
                                        * Referenced by: '<S19>/UDP Init '
                                        */
  real_T UDPInit_P5_Size[2];           /* Computed Parameter: UDPInit_P5_Size
                                        * Referenced by: '<S19>/UDP Init '
                                        */
  real_T UDPInit_P5;                   /* Expression: SampleTime
                                        * Referenced by: '<S19>/UDP Init '
                                        */
  real_T UDPRx1_P1_Size[2];            /* Computed Parameter: UDPRx1_P1_Size
                                        * Referenced by: '<S50>/UDP Rx 1'
                                        */
  real_T UDPRx1_P1;                    /* Expression: Group
                                        * Referenced by: '<S50>/UDP Rx 1'
                                        */
  real_T UDPRx1_P2_Size[2];            /* Computed Parameter: UDPRx1_P2_Size
                                        * Referenced by: '<S50>/UDP Rx 1'
                                        */
  real_T UDPRx1_P2;                    /* Expression: SourceAddress
                                        * Referenced by: '<S50>/UDP Rx 1'
                                        */
  real_T UDPRx1_P3_Size[2];            /* Computed Parameter: UDPRx1_P3_Size
                                        * Referenced by: '<S50>/UDP Rx 1'
                                        */
  real_T UDPRx1_P3;                    /* Expression: sip
                                        * Referenced by: '<S50>/UDP Rx 1'
                                        */
  real_T UDPRx1_P4_Size[2];            /* Computed Parameter: UDPRx1_P4_Size
                                        * Referenced by: '<S50>/UDP Rx 1'
                                        */
  real_T UDPRx1_P4;                    /* Expression: LocalPort
                                        * Referenced by: '<S50>/UDP Rx 1'
                                        */
  real_T UDPRx1_P5_Size[2];            /* Computed Parameter: UDPRx1_P5_Size
                                        * Referenced by: '<S50>/UDP Rx 1'
                                        */
  real_T UDPRx1_P5;                    /* Expression: lup
                                        * Referenced by: '<S50>/UDP Rx 1'
                                        */
  real_T UDPRx1_P6_Size[2];            /* Computed Parameter: UDPRx1_P6_Size
                                        * Referenced by: '<S50>/UDP Rx 1'
                                        */
  real_T UDPRx1_P6;                    /* Expression: SampleTime
                                        * Referenced by: '<S50>/UDP Rx 1'
                                        */
  real_T Buffer1_P1_Size[2];           /* Computed Parameter: Buffer1_P1_Size
                                        * Referenced by: '<S50>/Buffer 1'
                                        */
  real_T Buffer1_P1;                   /* Expression: chainSize
                                        * Referenced by: '<S50>/Buffer 1'
                                        */
  real_T Buffer1_P2_Size[2];           /* Computed Parameter: Buffer1_P2_Size
                                        * Referenced by: '<S50>/Buffer 1'
                                        */
  real_T Buffer1_P2;                   /* Expression: bufferSize
                                        * Referenced by: '<S50>/Buffer 1'
                                        */
  real_T Buffer1_P3_Size[2];           /* Computed Parameter: Buffer1_P3_Size
                                        * Referenced by: '<S50>/Buffer 1'
                                        */
  real_T Buffer1_P3;                   /* Expression: Threshold
                                        * Referenced by: '<S50>/Buffer 1'
                                        */
  real_T UDPConsume1_P1_Size[2];       /* Computed Parameter: UDPConsume1_P1_Size
                                        * Referenced by: '<S50>/UDP Consume 1'
                                        */
  real_T UDPConsume1_P1;               /* Expression: Group
                                        * Referenced by: '<S50>/UDP Consume 1'
                                        */
  real_T UDPConsume1_P2_Size[2];       /* Computed Parameter: UDPConsume1_P2_Size
                                        * Referenced by: '<S50>/UDP Consume 1'
                                        */
  real_T UDPConsume1_P2;               /* Expression: VectorSize
                                        * Referenced by: '<S50>/UDP Consume 1'
                                        */
  real_T UDPConsume1_P3_Size[2];       /* Computed Parameter: UDPConsume1_P3_Size
                                        * Referenced by: '<S50>/UDP Consume 1'
                                        */
  real_T UDPConsume1_P3;               /* Expression: SampleTime
                                        * Referenced by: '<S50>/UDP Consume 1'
                                        */
  real_T Extract1_P1_Size[2];          /* Computed Parameter: Extract1_P1_Size
                                        * Referenced by: '<S50>/Extract 1'
                                        */
  real_T Extract1_P1;                  /* Expression: packetSize
                                        * Referenced by: '<S50>/Extract 1'
                                        */
  real_T Gain_Gain_p;                  /* Expression: 1/(256*scalingFactor)
                                        * Referenced by: '<S27>/Gain'
                                        */
  real_T Constant_Value;               /* Expression: 0
                                        * Referenced by: '<S3>/Constant'
                                        */
  real_T Buffer_ic_n;                  /* Expression: 0
                                        * Referenced by: '<Root>/Buffer'
                                        */
  real_T FIRBandpassFilterForward_Initia;/* Expression: 0
                                          * Referenced by: '<S17>/FIR Bandpass Filter Forward'
                                          */
  real_T FIRBandpassFilterBackward_Initi;/* Expression: 0
                                          * Referenced by: '<S17>/FIR Bandpass Filter Backward'
                                          */
  real_T scaletoperHz_Gain;            /* Expression: 1024/1000
                                        * Referenced by: '<S10>/scale to per Hz'
                                        */
  real_T Constant_Value_g;             /* Expression: 1
                                        * Referenced by: '<S23>/Constant'
                                        */
  real_T PD2MF12bitseries_P1_Size[2];  /* Computed Parameter: PD2MF12bitseries_P1_Size
                                        * Referenced by: '<Root>/PD2-MF 12bit series'
                                        */
  real_T PD2MF12bitseries_P1[4];       /* Expression: channel
                                        * Referenced by: '<Root>/PD2-MF 12bit series'
                                        */
  real_T PD2MF12bitseries_P2_Size[2];  /* Computed Parameter: PD2MF12bitseries_P2_Size
                                        * Referenced by: '<Root>/PD2-MF 12bit series'
                                        */
  real_T PD2MF12bitseries_P2[4];       /* Expression: reset
                                        * Referenced by: '<Root>/PD2-MF 12bit series'
                                        */
  real_T PD2MF12bitseries_P3_Size[2];  /* Computed Parameter: PD2MF12bitseries_P3_Size
                                        * Referenced by: '<Root>/PD2-MF 12bit series'
                                        */
  real_T PD2MF12bitseries_P3[4];       /* Expression: initValue
                                        * Referenced by: '<Root>/PD2-MF 12bit series'
                                        */
  real_T PD2MF12bitseries_P4_Size[2];  /* Computed Parameter: PD2MF12bitseries_P4_Size
                                        * Referenced by: '<Root>/PD2-MF 12bit series'
                                        */
  real_T PD2MF12bitseries_P4;          /* Expression: sampletime
                                        * Referenced by: '<Root>/PD2-MF 12bit series'
                                        */
  real_T PD2MF12bitseries_P5_Size[2];  /* Computed Parameter: PD2MF12bitseries_P5_Size
                                        * Referenced by: '<Root>/PD2-MF 12bit series'
                                        */
  real_T PD2MF12bitseries_P5;          /* Expression: pcislot
                                        * Referenced by: '<Root>/PD2-MF 12bit series'
                                        */
  real_T PD2MF12bitseries_P6_Size[2];  /* Computed Parameter: PD2MF12bitseries_P6_Size
                                        * Referenced by: '<Root>/PD2-MF 12bit series'
                                        */
  real_T PD2MF12bitseries_P6;          /* Expression: boardType
                                        * Referenced by: '<Root>/PD2-MF 12bit series'
                                        */
  real_T PD2MF12bitseries_P7_Size[2];  /* Computed Parameter: PD2MF12bitseries_P7_Size
                                        * Referenced by: '<Root>/PD2-MF 12bit series'
                                        */
  real_T PD2MF12bitseries_P7;          /* Expression: board
                                        * Referenced by: '<Root>/PD2-MF 12bit series'
                                        */
  real_T PD2MF12bitseries_P8_Size[2];  /* Computed Parameter: PD2MF12bitseries_P8_Size
                                        * Referenced by: '<Root>/PD2-MF 12bit series'
                                        */
  real_T PD2MF12bitseries_P8[23];      /* Computed Parameter: PD2MF12bitseries_P8
                                        * Referenced by: '<Root>/PD2-MF 12bit series'
                                        */
  real_T HitCrossing_Offset_b;         /* Expression: 0.5
                                        * Referenced by: '<Root>/Hit  Crossing'
                                        */
  real_T ParallelPortDO_P1_Size[2];    /* Computed Parameter: ParallelPortDO_P1_Size
                                        * Referenced by: '<Root>/Parallel Port DO '
                                        */
  real_T ParallelPortDO_P1;            /* Expression: BaseAddress
                                        * Referenced by: '<Root>/Parallel Port DO '
                                        */
  real_T ParallelPortDO_P2_Size[2];    /* Computed Parameter: ParallelPortDO_P2_Size
                                        * Referenced by: '<Root>/Parallel Port DO '
                                        */
  real_T ParallelPortDO_P2;            /* Expression: Mode
                                        * Referenced by: '<Root>/Parallel Port DO '
                                        */
  real_T ParallelPortDO_P3_Size[2];    /* Computed Parameter: ParallelPortDO_P3_Size
                                        * Referenced by: '<Root>/Parallel Port DO '
                                        */
  real_T ParallelPortDO_P3;            /* Expression: Format
                                        * Referenced by: '<Root>/Parallel Port DO '
                                        */
  real_T ParallelPortDO_P4_Size[2];    /* Computed Parameter: ParallelPortDO_P4_Size
                                        * Referenced by: '<Root>/Parallel Port DO '
                                        */
  real_T ParallelPortDO_P4;            /* Expression: Channels
                                        * Referenced by: '<Root>/Parallel Port DO '
                                        */
  real_T ParallelPortDO_P5_Size[2];    /* Computed Parameter: ParallelPortDO_P5_Size
                                        * Referenced by: '<Root>/Parallel Port DO '
                                        */
  real_T ParallelPortDO_P5;            /* Expression: InitialValues
                                        * Referenced by: '<Root>/Parallel Port DO '
                                        */
  real_T ParallelPortDO_P6_Size[2];    /* Computed Parameter: ParallelPortDO_P6_Size
                                        * Referenced by: '<Root>/Parallel Port DO '
                                        */
  real_T ParallelPortDO_P6;            /* Expression: FinalActions
                                        * Referenced by: '<Root>/Parallel Port DO '
                                        */
  real_T ParallelPortDO_P7_Size[2];    /* Computed Parameter: ParallelPortDO_P7_Size
                                        * Referenced by: '<Root>/Parallel Port DO '
                                        */
  real_T ParallelPortDO_P7;            /* Expression: FinalValues
                                        * Referenced by: '<Root>/Parallel Port DO '
                                        */
  real_T ParallelPortDO_P8_Size[2];    /* Computed Parameter: ParallelPortDO_P8_Size
                                        * Referenced by: '<Root>/Parallel Port DO '
                                        */
  real_T ParallelPortDO_P8;            /* Expression: SampleTime
                                        * Referenced by: '<Root>/Parallel Port DO '
                                        */
  real_T ParallelPortDO_P9_Size[2];    /* Computed Parameter: ParallelPortDO_P9_Size
                                        * Referenced by: '<Root>/Parallel Port DO '
                                        */
  real_T ParallelPortDO_P9;            /* Expression: 0
                                        * Referenced by: '<Root>/Parallel Port DO '
                                        */
  real_T ACModeScalingFactor_Gain;     /* Expression: 0.2
                                        * Referenced by: '<Root>/AC Mode Scaling Factor'
                                        */
  real_T Constant_Value_i;             /* Expression: 0
                                        * Referenced by: '<S8>/Constant'
                                        */
  real_T Delay1_InitialCondition;      /* Expression: 0
                                        * Referenced by: '<Root>/Delay1'
                                        */
  real_T Delay2_InitialCondition;      /* Expression: 0
                                        * Referenced by: '<Root>/Delay2'
                                        */
  real_T Unbuffer_ic;                  /* Expression: 0
                                        * Referenced by: '<S10>/Unbuffer'
                                        */
  real_T Delay1_InitialCondition_i;    /* Expression: 0
                                        * Referenced by: '<S36>/Delay1'
                                        */
  real_T Delay_InitialCondition;       /* Expression: 0
                                        * Referenced by: '<S36>/Delay'
                                        */
  int32_T One_Value;                   /* Computed Parameter: One_Value
                                        * Referenced by: '<S39>/One'
                                        */
  int32_T Zero_Value_f;                /* Computed Parameter: Zero_Value_f
                                        * Referenced by: '<S39>/Zero'
                                        */
  int32_T ForIterator_IterationLimit;  /* Computed Parameter: ForIterator_IterationLimit
                                        * Referenced by: '<S43>/For Iterator'
                                        */
  int32_T UnitDelay1_InitialCondition; /* Computed Parameter: UnitDelay1_InitialCondition
                                        * Referenced by: '<S43>/Unit Delay1'
                                        */
  int32_T Saturation_LowerSat;         /* Computed Parameter: Saturation_LowerSat
                                        * Referenced by: '<S43>/Saturation'
                                        */
  int32_T Pad_outDims[2];              /* Computed Parameter: Pad_outDims
                                        * Referenced by: '<S10>/Pad'
                                        */
  int32_T Pad_padBefore[2];            /* Computed Parameter: Pad_padBefore
                                        * Referenced by: '<S10>/Pad'
                                        */
  int32_T Pad_padAfter[2];             /* Computed Parameter: Pad_padAfter
                                        * Referenced by: '<S10>/Pad'
                                        */
  int32_T Pad_inWorkAdd[2];            /* Computed Parameter: Pad_inWorkAdd
                                        * Referenced by: '<S10>/Pad'
                                        */
  int32_T Pad_outWorkAdd[2];           /* Computed Parameter: Pad_outWorkAdd
                                        * Referenced by: '<S10>/Pad'
                                        */
  int32_T UnitDelay_InitialCondition_m;/* Computed Parameter: UnitDelay_InitialCondition_m
                                        * Referenced by: '<S39>/Unit Delay'
                                        */
  int32_T KeepPostiveSwitch_Threshold; /* Computed Parameter: KeepPostiveSwitch_Threshold
                                        * Referenced by: '<S39>/Keep Postive Switch'
                                        */
  int32_T Constant_Value_j;            /* Computed Parameter: Constant_Value_j
                                        * Referenced by: '<S40>/Constant'
                                        */
  uint32_T CounterDelay_DelayLength;   /* Computed Parameter: CounterDelay_DelayLength
                                        * Referenced by: '<S26>/Counter Delay'
                                        */
  uint32_T FixPtConstant_Value;        /* Computed Parameter: FixPtConstant_Value
                                        * Referenced by: '<S48>/FixPt Constant'
                                        */
  uint32_T Output_InitialCondition;    /* Computed Parameter: Output_InitialCondition
                                        * Referenced by: '<S47>/Output'
                                        */
  uint32_T Constant_Value_m;           /* Computed Parameter: Constant_Value_m
                                        * Referenced by: '<S49>/Constant'
                                        */
  uint32_T Delay1_DelayLength;         /* Computed Parameter: Delay1_DelayLength
                                        * Referenced by: '<Root>/Delay1'
                                        */
  uint32_T Delay2_DelayLength;         /* Computed Parameter: Delay2_DelayLength
                                        * Referenced by: '<Root>/Delay2'
                                        */
  uint32_T Delay1_DelayLength_h;       /* Computed Parameter: Delay1_DelayLength_h
                                        * Referenced by: '<S36>/Delay1'
                                        */
  uint32_T Delay_DelayLength;          /* Computed Parameter: Delay_DelayLength
                                        * Referenced by: '<S36>/Delay'
                                        */
  uint16_T WeightedSampleTime_WtEt;    /* Computed Parameter: WeightedSampleTime_WtEt
                                        * Referenced by: '<S39>/Weighted Sample Time'
                                        */
  uint16_T Seconds_Gain;               /* Computed Parameter: Seconds_Gain
                                        * Referenced by: '<S39>/Seconds'
                                        */
  uint8_T Constant_Value_c[330];       /* Computed Parameter: Constant_Value_c
                                        * Referenced by: '<S27>/Constant'
                                        */
  uint8_T ManualSwitch_CurrentSetting; /* Computed Parameter: ManualSwitch_CurrentSetting
                                        * Referenced by: '<Root>/Manual Switch'
                                        */
  boolean_T Constant6_Value;           /* Computed Parameter: Constant6_Value
                                        * Referenced by: '<Root>/Constant6'
                                        */
  boolean_T Constant4_Value;           /* Computed Parameter: Constant4_Value
                                        * Referenced by: '<Root>/Constant4'
                                        */
  boolean_T Constant_Value_l;          /* Expression: true
                                        * Referenced by: '<S25>/Constant'
                                        */
  boolean_T UnitDelay_InitialCondition_i;/* Computed Parameter: UnitDelay_InitialCondition_i
                                          * Referenced by: '<Root>/Unit Delay'
                                          */
  boolean_T Logic_table[16];           /* Computed Parameter: Logic_table
                                        * Referenced by: '<S20>/Logic'
                                        */
};

/* Real-time Model Data Structure */
struct tag_RTM_quadripulse_controller14_T {
  const char_T *path;
  const char_T *modelName;
  struct SimStruct_tag * *childSfunctions;
  const char_T *errorStatus;
  SS_SimMode simMode;
  RTWLogInfo *rtwLogInfo;
  RTWExtModeInfo *extModeInfo;
  RTWSolverInfo solverInfo;
  RTWSolverInfo *solverInfoPtr;
  void *sfcnInfo;

  /*
   * NonInlinedSFcns:
   * The following substructure contains information regarding
   * non-inlined s-functions used in the model.
   */
  struct {
    RTWSfcnInfo sfcnInfo;
    time_T *taskTimePtrs[4];
    SimStruct childSFunctions[11];
    SimStruct *childSFunctionPtrs[11];
    struct _ssBlkInfo2 blkInfo2[11];
    struct _ssSFcnModelMethods2 methods2[11];
    struct _ssSFcnModelMethods3 methods3[11];
    struct _ssStatesInfo2 statesInfo2[11];
    ssPeriodicStatesInfo periodicStatesInfo[11];
    struct {
      time_T sfcnPeriod[1];
      time_T sfcnOffset[1];
      int_T sfcnTsMap[1];
      uint_T attribs[3];
      mxArray *params[3];
    } Sfcn0;

    struct {
      time_T sfcnPeriod[1];
      time_T sfcnOffset[1];
      int_T sfcnTsMap[1];
      uint_T attribs[21];
      mxArray *params[21];
    } Sfcn1;

    struct {
      time_T sfcnPeriod[1];
      time_T sfcnOffset[1];
      int_T sfcnTsMap[1];
      uint_T attribs[16];
      mxArray *params[16];
    } Sfcn2;

    struct {
      time_T sfcnPeriod[1];
      time_T sfcnOffset[1];
      int_T sfcnTsMap[1];
      uint_T attribs[12];
      mxArray *params[12];
    } Sfcn3;

    struct {
      time_T sfcnPeriod[1];
      time_T sfcnOffset[1];
      int_T sfcnTsMap[1];
      uint_T attribs[5];
      mxArray *params[5];
    } Sfcn4;

    struct {
      time_T sfcnPeriod[1];
      time_T sfcnOffset[1];
      int_T sfcnTsMap[1];
      struct _ssPortOutputs outputPortInfo[1];
      uint_T attribs[6];
      mxArray *params[6];
      struct _ssDWorkRecord dWork[1];
      struct _ssDWorkAuxRecord dWorkAux[1];
    } Sfcn5;

    struct {
      time_T sfcnPeriod[1];
      time_T sfcnOffset[1];
      int_T sfcnTsMap[1];
      struct _ssPortInputs inputPortInfo[1];
      struct _ssPortOutputs outputPortInfo[1];
      uint_T attribs[3];
      mxArray *params[3];
      struct _ssDWorkRecord dWork[2];
      struct _ssDWorkAuxRecord dWorkAux[2];
    } Sfcn6;

    struct {
      time_T sfcnPeriod[1];
      time_T sfcnOffset[1];
      int_T sfcnTsMap[1];
      struct _ssPortInputs inputPortInfo[1];
      struct _ssPortOutputs outputPortInfo[2];
      uint_T attribs[3];
      mxArray *params[3];
      struct _ssDWorkRecord dWork[1];
      struct _ssDWorkAuxRecord dWorkAux[1];
    } Sfcn7;

    struct {
      time_T sfcnPeriod[1];
      time_T sfcnOffset[1];
      int_T sfcnTsMap[1];
      struct _ssPortInputs inputPortInfo[1];
      struct _ssPortOutputs outputPortInfo[2];
      uint_T attribs[1];
      mxArray *params[1];
    } Sfcn8;

    struct {
      time_T sfcnPeriod[1];
      time_T sfcnOffset[1];
      int_T sfcnTsMap[1];
      struct _ssPortInputs inputPortInfo[4];
      real_T const *UPtrs0[1];
      real_T const *UPtrs1[1];
      real_T const *UPtrs2[1];
      real_T const *UPtrs3[1];
      uint_T attribs[8];
      mxArray *params[8];
      struct _ssDWorkRecord dWork[1];
      struct _ssDWorkAuxRecord dWorkAux[1];
    } Sfcn9;

    struct {
      time_T sfcnPeriod[1];
      time_T sfcnOffset[1];
      int_T sfcnTsMap[1];
      struct _ssPortInputs inputPortInfo[1];
      uint_T attribs[9];
      mxArray *params[9];
    } Sfcn10;
  } NonInlinedSFcns;

  /*
   * DataMapInfo:
   * The following substructure contains information regarding
   * structures generated in the model's C API.
   */
  struct {
    rtwCAPI_ModelMappingInfo mmi;
  } DataMapInfo;

  /*
   * ModelData:
   * The following substructure contains information regarding
   * the data used in the model.
   */
  struct {
    void *blockIO;
    const void *constBlockIO;
    void *defaultParam;
    ZCSigState *prevZCSigState;
    real_T *contStates;
    int_T *periodicContStateIndices;
    real_T *periodicContStateRanges;
    real_T *derivs;
    void *zcSignalValues;
    void *inputs;
    void *outputs;
    boolean_T *contStateDisabled;
    boolean_T zCCacheNeedsReset;
    boolean_T derivCacheNeedsReset;
    boolean_T blkStateChange;
    void *dwork;
  } ModelData;

  /*
   * Sizes:
   * The following substructure contains sizes information
   * for many of the model attributes such as inputs, outputs,
   * dwork, sample times, etc.
   */
  struct {
    uint32_T checksums[4];
    uint32_T options;
    int_T numContStates;
    int_T numPeriodicContStates;
    int_T numU;
    int_T numY;
    int_T numSampTimes;
    int_T numBlocks;
    int_T numBlockIO;
    int_T numBlockPrms;
    int_T numDwork;
    int_T numSFcnPrms;
    int_T numSFcns;
    int_T numIports;
    int_T numOports;
    int_T numNonSampZCs;
    int_T sysDirFeedThru;
    int_T rtwGenSfcn;
  } Sizes;

  /*
   * SpecialInfo:
   * The following substructure contains special information
   * related to other components that are dependent on RTW.
   */
  struct {
    const void *mappingInfo;
    void *xpcData;
  } SpecialInfo;

  /*
   * Timing:
   * The following substructure contains information regarding
   * the timing information for the model.
   */
  struct {
    time_T stepSize;
    uint32_T clockTick0;
    uint32_T clockTickH0;
    time_T stepSize0;
    uint32_T clockTick1;
    uint32_T clockTickH1;
    time_T stepSize1;
    uint32_T clockTick2;
    uint32_T clockTickH2;
    time_T stepSize2;
    uint32_T clockTick3;
    uint32_T clockTickH3;
    time_T stepSize3;
    struct {
      uint16_T TID[4];
    } TaskCounters;

    struct {
      boolean_T TID0_2;
      boolean_T TID0_3;
    } RateInteraction;

    time_T tStart;
    time_T tFinal;
    time_T timeOfLastOutput;
    void *timingData;
    real_T *varNextHitTimesList;
    SimTimeStep simTimeStep;
    boolean_T stopRequestedFlag;
    time_T *sampleTimes;
    time_T *offsetTimes;
    int_T *sampleTimeTaskIDPtr;
    int_T *sampleHits;
    int_T *perTaskSampleHits;
    time_T *t;
    time_T sampleTimesArray[4];
    time_T offsetTimesArray[4];
    int_T sampleTimeTaskIDArray[4];
    int_T sampleHitArray[4];
    int_T perTaskSampleHitsArray[16];
    time_T tArray[4];
  } Timing;
};

/* Block parameters (auto storage) */
extern P_quadripulse_controller14_T quadripulse_controller14_P;

/* Block signals (auto storage) */
extern B_quadripulse_controller14_T quadripulse_controller14_B;

/* Block states (auto storage) */
extern DW_quadripulse_controller14_T quadripulse_controller14_DW;

/* External data declarations for dependent source files */

/* Zero-crossing (trigger) state */
extern PrevZCX_quadripulse_controller14_T quadripulse_controller14_PrevZCX;
extern const ConstB_quadripulse_controller14_T quadripulse_controller14_ConstB;/* constant block i/o */

/* Constant parameters (auto storage) */
extern const ConstP_quadripulse_controller14_T quadripulse_controller14_ConstP;

/* External function called from main */
extern time_T rt_SimUpdateDiscreteEvents(
  int_T rtmNumSampTimes, void *rtmTimingData, int_T *rtmSampleHitPtr, int_T
  *rtmPerTaskSampleHits )
  ;

/*====================*
 * External functions *
 *====================*/
extern quadripulse_controller14_rtModel *quadripulse_controller14(void);
extern void MdlInitializeSizes(void);
extern void MdlInitializeSampleTimes(void);
extern void MdlInitialize(void);
extern void MdlStart(void);
extern void MdlOutputs(int_T tid);
extern void MdlUpdate(int_T tid);
extern void MdlTerminate(void);

/* Function to get C API Model Mapping Static Info */
extern const rtwCAPI_ModelMappingStaticInfo*
  quadripulse_controller14_GetCAPIStaticMap(void);

/* Real-time Model object */
extern RT_MODEL_quadripulse_controller14_T *const quadripulse_controller14_M;

/*-
 * The generated code includes comments that allow you to trace directly
 * back to the appropriate location in the model.  The basic format
 * is <system>/block_name, where system is the system number (uniquely
 * assigned by Simulink) and block_name is the name of the block.
 *
 * Use the MATLAB hilite_system command to trace the generated code back
 * to the model.  For example,
 *
 * hilite_system('<S3>')    - opens system 3
 * hilite_system('<S3>/Kp') - opens and selects block Kp which resides in S3
 *
 * Here is the system hierarchy for this model
 *
 * '<Root>' : 'quadripulse_controller14'
 * '<S1>'   : 'quadripulse_controller14/ Amplitude'
 * '<S2>'   : 'quadripulse_controller14/Amplitude Interval Scope'
 * '<S3>'   : 'quadripulse_controller14/Average Refernce'
 * '<S4>'   : 'quadripulse_controller14/Compare To Constant'
 * '<S5>'   : 'quadripulse_controller14/Compare To Constant1'
 * '<S6>'   : 'quadripulse_controller14/Compare To Constant2'
 * '<S7>'   : 'quadripulse_controller14/Compare To Constant3'
 * '<S8>'   : 'quadripulse_controller14/Compare To Zero'
 * '<S9>'   : 'quadripulse_controller14/De-Mean'
 * '<S10>'  : 'quadripulse_controller14/Detrend and FFT'
 * '<S11>'  : 'quadripulse_controller14/EEG Host'
 * '<S12>'  : 'quadripulse_controller14/EEG Host1'
 * '<S13>'  : 'quadripulse_controller14/EEG Host3'
 * '<S14>'  : 'quadripulse_controller14/EEG Raw'
 * '<S15>'  : 'quadripulse_controller14/EMG Host '
 * '<S16>'  : 'quadripulse_controller14/Fan Out with Offset for Scope Display '
 * '<S17>'  : 'quadripulse_controller14/Forward and Backward Band Pass Filter'
 * '<S18>'  : 'quadripulse_controller14/Hjorth & Hjorth Filtered & Now'
 * '<S19>'  : 'quadripulse_controller14/Real-time UDP  Configuration'
 * '<S20>'  : 'quadripulse_controller14/S-R Flip-Flop'
 * '<S21>'  : 'quadripulse_controller14/Safety Check'
 * '<S22>'  : 'quadripulse_controller14/Spectrum Scope '
 * '<S23>'  : 'quadripulse_controller14/Subsystem'
 * '<S24>'  : 'quadripulse_controller14/Time Series Forecast'
 * '<S25>'  : 'quadripulse_controller14/Trigger Condition'
 * '<S26>'  : 'quadripulse_controller14/Trigger Generator'
 * '<S27>'  : 'quadripulse_controller14/UDP EEG Data'
 * '<S28>'  : 'quadripulse_controller14/Detrend and FFT/Constant5'
 * '<S29>'  : 'quadripulse_controller14/Detrend and FFT/Detrend'
 * '<S30>'  : 'quadripulse_controller14/Detrend and FFT/Magnitude FFT'
 * '<S31>'  : 'quadripulse_controller14/Detrend and FFT/Detrend/Check Signal Attributes'
 * '<S32>'  : 'quadripulse_controller14/Detrend and FFT/Detrend/Error If Not Floating-Point'
 * '<S33>'  : 'quadripulse_controller14/Detrend and FFT/Detrend/If Action Subsystem'
 * '<S34>'  : 'quadripulse_controller14/Detrend and FFT/Detrend/If Action Subsystem1'
 * '<S35>'  : 'quadripulse_controller14/Detrend and FFT/Detrend/Inherit Frame Status'
 * '<S36>'  : 'quadripulse_controller14/Fan Out with Offset for Scope Display /Running Average'
 * '<S37>'  : 'quadripulse_controller14/Safety Check/4-into-1 Unit Limit'
 * '<S38>'  : 'quadripulse_controller14/Subsystem/Enabled Subsystem'
 * '<S39>'  : 'quadripulse_controller14/Subsystem/Prolonged Disable'
 * '<S40>'  : 'quadripulse_controller14/Subsystem/Prolonged Disable/Compare To Zero'
 * '<S41>'  : 'quadripulse_controller14/Time Series Forecast/Forecast of 128 samples'
 * '<S42>'  : 'quadripulse_controller14/Time Series Forecast/Yule-Walker AR Estimator'
 * '<S43>'  : 'quadripulse_controller14/Time Series Forecast/Forecast of 128 samples/Forecast'
 * '<S44>'  : 'quadripulse_controller14/Time Series Forecast/Yule-Walker AR Estimator/Error If Not Floating-Point'
 * '<S45>'  : 'quadripulse_controller14/Trigger Condition/Crossing Detector'
 * '<S46>'  : 'quadripulse_controller14/Trigger Condition/Crossing Detector/Difference'
 * '<S47>'  : 'quadripulse_controller14/Trigger Generator/Counter Free-Running'
 * '<S48>'  : 'quadripulse_controller14/Trigger Generator/Counter Free-Running/Increment Real World'
 * '<S49>'  : 'quadripulse_controller14/Trigger Generator/Counter Free-Running/Wrap To Zero'
 * '<S50>'  : 'quadripulse_controller14/UDP EEG Data/Receive 1'
 */
#endif                                 /* RTW_HEADER_quadripulse_controller14_h_ */
