;*************************************************
; WRF: creat basic x-y plots. Simple variations
;************************************************
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"   
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"   
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRF_contributed.ncl"   

begin
;************************************************
; open file and read in data
;************************************************
  f       = addfile ("wrfout_d01_000000.nc", "r")
;************************************************
; Read all the times. Convert to numeric units for plottin.
;************************************************
  Times = f->Times                       ; Times is of type character
  Time  = WRF_Times2Udunits_c(Times, 0)  ; convert to "hours since"

;************************************************
; Import time series of perturbation geopotential (PH)
; at a (arbitrarily) specified grid point
;************************************************
  y     = f->PH(:,8,50,5)                ; (Time, bottom_top, south_north, west_east)
;************************************************
; subtract the initial value to create anomalies
;************************************************
  yAnom             = y-y(0)             ; anomalies from init time
  yAnom@description = "Anomalies from initial Time" 
  yAnom@units       = y@units
;************************************************
; For plot label, read the lat/lon location     
;************************************************
  lat   = f->XLAT(0,50, 5)
  lon   = f->XLONG(0,50, 5)
;************************************************
; create plots: Three slight variations.  
;************************************************
  wks = gsn_open_wks("ps" ,"WRF_xy")          ; ps,pdf,x11,ncgm,eps

  res                       = True            ; plot mods desired
;;res@gsnMaximize           = True            ; uncomment to maximize size
  res@tiMainString          = lat+"N  "+fabs(lon)+"W"
 
  plot                      = gsn_csm_xy(wks,Time,y,res)

  res@tiXAxisString         = Time@units      ; label bottom axis with units
  res@xyLineThicknessF      = 3.0             ; make a bit thicker           
  res@gsnYRefLine           = 0.0             ; draw a reference line
  plot                      = gsn_csm_xy(wks,Time,yAnom,res)

  res@gsnAboveYRefLineColor = "red"           ; above ref line fill red
  res@gsnBelowYRefLineColor = "blue"          ; below ref line fill blue
  plot                      = gsn_csm_xy(wks,Time,yAnom,res)
end
