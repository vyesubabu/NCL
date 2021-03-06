; ===============================================
; h_time_5.ncl              
; ===============================================
;
; These files are loaded by default in NCL V6.2.0 and newer
; load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
; load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"

begin
;================================================
; get data
;================================================
  f     = addfile ("ts.nc", "r")
  v     = f->V    
;================================================
; smooth data
;================================================
  wgt   = (/ 1., 3., 4., 3., 1./)                  ; wgts for temporal smooth
  wgt   = wgt/sum(wgt)                             ; normalize

  slice   = v(lev|:,time|:,lat|0)                  ; trick to copy meta data
  slice   = wgt_runave(v(lat|30,lev|:,time|:), wgt, 0) 
;================================================
; plot
;================================================
  wks   = gsn_open_wks ("png", "h_time")           ; send graphics to PNG file
  res                      = True                  ; plot mods desired
  
  res@cnFillOn             = True                  ; turn on color
  res@cnFillPalette        = "BlWhRe"              ; set color map
  res@cnLinesOn            = False                 ; no contour lines
  
  res@cnLevelSelectionMode = "ManualLevels"       ; set manual contour levels
  res@cnMinLevelValF       = -4.                  ; set min contour level
  res@cnMaxLevelValF       =  4.                  ; set max contour level
  res@cnLevelSpacingF      = 0.5                  ; set contour spacing


; to remove the "height" label on the right, we have to go through several
; steps. The label is not an axis string but extra text placed there by
; the plot template
  res@gsnDraw              = False                 ; don't draw yet
  res@gsnFrame             = False                 ; don't advance frame yet
  

  plot = gsn_csm_pres_hgt (wks,slice,res) 

  getvalues plot@contour                                                     
  "pmAnnoManagers" : am_ids                                                
  end getvalues                                                              
  
  index = ind(NhlName(am_ids).eq."right_axis")  
  if(.not.ismissing(index)) then                                             
    NhlRemoveAnnotation(plot@contour,am_ids(index))                          
  end if                                                                     
  
  draw(plot)                                                                 
  frame(wks)   
  
end
