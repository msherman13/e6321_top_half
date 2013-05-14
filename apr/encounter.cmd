#######################################################
#                                                     #
#  Encounter Command Logging File                     #
#  Created on Tue May 14 04:20:11 2013                #
#                                                     #
#######################################################

#@(#)CDS: First Encounter v08.10-s273_1 (64bit) 06/16/2009 02:26 (Linux 2.6)
#@(#)CDS: NanoRoute v08.10-s155 NR090610-1622/USR60-UB (database version 2.30, 78.1.1) {superthreading v1.11}
#@(#)CDS: CeltIC v08.12-s254_1 (64bit) 06/11/2009 13:50:30 (Linux 2.6.9-67.0.10.ELsmp)
#@(#)CDS: CTE v08.10-s204_1 (64bit) Jun 10 2009 13:59:07 (Linux 2.6.9-67.0.10.ELsmp)
#@(#)CDS: CPE v08.12-s010

loadConfig ./top_level.conf
floorPlan -s 5000 2000 10 10 10 10
redraw
fit
globalNetConnect VDD -type tiehi
globalNetConnect VSS -type tielo
applyGlobalNets
addRing -nets {VDD VSS } -type core_rings -layer_top M1 -layer_bottom M1 -layer_right M2 -layer_left M2 -width_top 3 -width_bottom 3 -width_left 3 -width_right 3 -spacing_top 1 -spacing_bottom 1 -spacing_right 1 -spacing_left 1
redraw
sroute -nets {VDD VSS} -noBlockPins -noPadRings -stopBlockPin boundaryWithPin
redraw
saveFPlan top_level.fp
loadTimingCon top_level.sdc
setPlaceMode -timingdriven -congLowEffort -doCongOpt -modulePlan -maxRouteLayer 5
setOptMode -fixFanoutLoad -lowEffort -moveInst -reclaimArea true
placeDesign -inplaceOpt
redraw
saveDesign top_level.placed.enc
checkPlace
buildTimingGraph
redraw
setCTSMode -nameSingleDelim FALSE
specifyClockTree -file top_level.cts.manual
ckSynthesis -clk clk -rguide cts.rguide -report report.ctsrpt -macromodel report.ctsmdl -forceReconvergent
globalNetConnect VDD -type tiehi
globalNetConnect VSS -type tielo
applyGlobalNets
saveDesign top_level.opted.enc
savePlace top_level.place
loadTimingCon {top_level.sdc .interactive.constr.sdc}
setAttribute -net clk -weight 5 -avoid_detour true -bottom_preferred_routing_layer 2 -top_preferred_routing_layer 3 -preferred_extra_space 3
selectNet clk
setNanoRouteMode -quiet routeWithTimingDriven true
setNanoRouteMode -quiet route_selected_net_only true
setNanoRouteMode -quiet routeTopRoutingLayer 3
setNanoRouteMode -quiet routeBottomRoutingLayer 1
globalDetailRoute
redraw
setNanoRouteMode -quiet route_selected_net_only false
setNanoRouteMode -quiet routeWithTimingDriven true
setNanoRouteMode -quiet routeTdrEffort 10
setNanoRouteMode -quiet drouteFixAntenna true
setNanoRouteMode -quiet routeWithSiDriven true
setNanoRouteMode -quiet routeSiLengthLimit 200
setNanoRouteMode -quiet routeSiEffort high
setNanoRouteMode -quiet routeWithViaInPin true
setNanoRouteMode -quiet routeWithViaOnlyForStandardCellPin false
setNanoRouteMode -quiet droutePostRouteSwapVia multiCut
setNanoRouteMode -quiet drouteUseMultiCutViaEffort high
setNanoRouteMode routeTopRoutingLayer 3
setNanoRouteMode routeBottomRoutingLayer 1
globalDetailRoute
deleteAllRouteBlks
redraw
setExtractRCMode -detail
extractRC
setOptMode -yieldEffort none
setOptMode -highEffort
setOptMode -drcMargin 0.0
setOptMode -holdTargetSlack 0.0 -setupTargetSlack 0.0
setOptMode -noSimplifyNetlist
setOptMode -noUsefulSkew
setOptMode -moveInst
setOptMode -reclaimArea true
setOptMode -fixDRC
setOptMode -noFixCap
optDesign -postRoute -hold
globalNetConnect VDD -type pgpin -pin {VDD } -override
globalNetConnect VSS -type pgpin -pin {VSS } -override
globalNetConnect VDD -type tiehi
globalNetConnect VSS -type tielo
verifyGeometry -allowDiffCellViols
verifyConnectivity -type regular -error 1000 -warning 50
saveDesign top_level.routed.enc
verifyGeometry
addFiller -cell FILL16TS FILL1TS FILL2TS FILL32TS FILL4TS FILL64TS FILL8TS -prefix IBM13RFLPVT_FILLER -fillBoundary
verifyGeometry
redraw
globalNetConnect VDD -type pgpin -pin {VDD } -inst * -module {}
globalNetConnect VSS -type pgpin -pin {VSS } -inst * -module {}
globalNetConnect VDD -type tiehi
globalNetConnect VSS -type tielo
applyGlobalNets
clearDrc
verifyGeometry
verifyConnectivity -type regular -error 1000 -warning 50
verifyProcessAntenna
reportLeakagePower
reportGateCount
saveDesign top_level.opted.enc
lefOut top_level.lef -5.5 -PGpinLayers 4 -specifyTopLayer 4 -stripePin
defOut -floorplan -netlist -routing top_level.final.def
streamOut top_level.gds -mapFile /tools2/courses/ee6321/share/ibm13rflpvt/mapfiles/enc2gds.map -libName ibm13rflpvt -structureName top_level -stripes 1 -units 1000 -mode ALL
saveNetlist top_level.nophycell.v
extractRC -outfile top_level.cap
rcOut -spef top_level.spef
delayCal -sdf top_level.sdf -mergeSetupHold
setAnalysisMode -hold -useDetailRC
reportViolation -outfile final_hold.tarpt
setAnalysisMode -setup -useDetailRC
reportViolation -outfile final_setup.tarpt
reportCapViolation -outfile final_cap.tarpt
verifyGeometry
verifyConnectivity -type all
reportCritNet -outfile top_level.critnet.rpt
