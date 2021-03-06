;----------------------------------------------------------------------
; colormap_2a.ncl
;
; Concepts illustrated:
;   - Drawing color maps using draw_color_palette
;   - Creating a color map using named colors
;   - Creating a color map using RGB triplets
;----------------------------------------------------------------------
; Note: you must have NCL V6.3.0 or later to
; run this example.
;----------------------------------------------------------------------
;
; This file is loaded by default in NCL V6.2.0 and newer
; load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"

begin
  wks = gsn_open_wks("png","colormap")              ; send graphics to PNG file

;---Draw a predefined color map
  draw_color_palette(wks,"WhViBlGrYeOrReWh",False)

;---Create and draw color map using named colors
  colors = (/"firebrick","peachpuff","orangered","navyblue","peru",\
             "yellow","wheat1","gray55","thistle","coral","dodgerblue", \
             "seagreen","maroon","gold","turquoise","mediumorchid"/)

  draw_color_palette(wks,colors,False)

;---Create and draw color map using RGB values.
  cmap = (/(/0.00,0.00,0.00/), (/0.20,0.00,0.00/), (/0.40,0.00,0.00/), \
           (/0.60,0.00,0.00/), (/0.80,0.00,0.00/), (/1.00,0.00,0.00/), \
           (/0.00,0.00,0.20/), (/0.20,0.00,0.20/), (/0.40,0.00,0.20/), \
           (/0.60,0.00,0.20/), (/0.80,0.00,0.20/), (/1.00,0.00,0.20/), \
           (/0.00,0.00,0.40/), (/0.20,0.00,0.40/), (/0.40,0.00,0.40/), \
           (/0.60,0.00,0.40/), (/0.80,0.00,0.40/), (/1.00,0.00,0.40/), \
           (/0.00,0.00,0.60/), (/0.20,0.00,0.60/), (/0.40,0.00,0.60/), \
           (/0.60,0.00,0.60/), (/0.80,0.00,0.60/), (/1.00,0.00,0.60/), \
           (/0.00,0.00,0.80/), (/0.20,0.00,0.80/), (/0.40,0.00,0.80/), \
           (/0.60,0.00,0.80/), (/0.80,0.00,0.80/), (/1.00,0.00,0.80/), \
           (/0.00,0.00,1.00/), (/0.20,0.00,1.00/), (/0.40,0.00,1.00/), \
           (/0.60,0.00,1.00/), (/0.80,0.00,1.00/), (/1.00,0.00,1.00/), \
           (/0.00,0.20,0.00/), (/0.20,0.20,0.00/), (/0.40,0.20,0.00/), \
           (/0.60,0.20,0.00/), (/0.80,0.20,0.00/), (/1.00,0.20,0.00/), \
           (/0.00,0.20,0.20/), (/0.20,0.20,0.20/), (/0.40,0.20,0.20/), \
           (/0.60,0.20,0.20/), (/0.80,0.20,0.20/), (/1.00,0.20,0.20/), \
           (/0.00,0.20,0.40/), (/0.20,0.20,0.40/), (/0.40,0.20,0.40/), \
           (/0.60,0.20,0.40/), (/0.80,0.20,0.40/), (/1.00,0.20,0.40/), \
           (/0.00,0.20,0.60/), (/0.20,0.20,0.60/), (/0.40,0.20,0.60/), \
           (/0.60,0.20,0.60/), (/0.80,0.20,0.60/), (/1.00,0.20,0.60/), \
           (/0.00,0.20,0.80/), (/0.20,0.20,0.80/), (/0.40,0.20,0.80/), \
           (/0.60,0.20,0.80/), (/0.80,0.20,0.80/), (/1.00,0.20,0.80/), \
           (/0.00,0.20,1.00/), (/0.20,0.20,1.00/), (/0.40,0.20,1.00/), \
           (/0.60,0.20,1.00/), (/0.80,0.20,1.00/), (/1.00,0.20,1.00/), \
           (/0.00,0.40,0.00/), (/0.20,0.40,0.00/), (/0.40,0.40,0.00/), \
           (/0.60,0.40,0.00/), (/0.80,0.40,0.00/), (/1.00,0.40,0.00/), \
           (/0.00,0.40,0.20/), (/0.20,0.40,0.20/), (/0.40,0.40,0.20/), \
           (/0.60,0.40,0.20/), (/0.80,0.40,0.20/), (/1.00,0.40,0.20/), \
           (/0.00,0.40,0.40/), (/0.20,0.40,0.40/), (/0.40,0.40,0.40/), \
           (/0.60,0.40,0.40/), (/0.80,0.40,0.40/), (/1.00,0.40,0.40/), \
           (/0.00,0.40,0.60/), (/0.20,0.40,0.60/), (/0.40,0.40,0.60/), \
           (/0.60,0.40,0.60/), (/0.80,0.40,0.60/), (/1.00,0.40,0.60/), \
           (/0.00,0.40,0.80/), (/0.20,0.40,0.80/), (/0.40,0.40,0.80/), \
           (/0.60,0.40,0.80/), (/0.80,0.40,0.80/), (/1.00,0.40,0.80/), \
           (/0.00,0.40,1.00/), (/0.20,0.40,1.00/), (/0.40,0.40,1.00/), \
           (/0.60,0.40,1.00/), (/0.80,0.40,1.00/), (/1.00,0.40,1.00/), \
           (/0.00,0.60,0.00/), (/0.20,0.60,0.00/), (/0.40,0.60,0.00/), \
           (/0.60,0.60,0.00/), (/0.80,0.60,0.00/), (/1.00,0.60,0.00/), \
           (/0.00,0.60,0.20/), (/0.20,0.60,0.20/), (/0.40,0.60,0.20/), \
           (/0.60,0.60,0.20/), (/0.80,0.60,0.20/), (/1.00,0.60,0.20/), \
           (/0.00,0.60,0.40/), (/0.20,0.60,0.40/), (/0.40,0.60,0.40/), \
           (/0.60,0.60,0.40/), (/0.80,0.60,0.40/), (/1.00,0.60,0.40/), \
           (/0.00,0.60,0.60/), (/0.20,0.60,0.60/), (/0.40,0.60,0.60/), \
           (/0.60,0.60,0.60/), (/0.80,0.60,0.60/), (/1.00,0.60,0.60/), \
           (/0.00,0.60,0.80/), (/0.20,0.60,0.80/), (/0.40,0.60,0.80/), \
           (/0.60,0.60,0.80/), (/0.80,0.60,0.80/), (/1.00,0.60,0.80/), \
           (/0.00,0.60,1.00/), (/0.20,0.60,1.00/), (/0.40,0.60,1.00/), \
           (/0.60,0.60,1.00/), (/0.80,0.60,1.00/), (/1.00,0.60,1.00/), \
           (/0.00,0.80,0.00/), (/0.20,0.80,0.00/), (/0.40,0.80,0.00/), \
           (/0.60,0.80,0.00/), (/0.80,0.80,0.00/), (/1.00,0.80,0.00/), \
           (/0.00,0.80,0.20/), (/0.20,0.80,0.20/), (/0.40,0.80,0.20/), \
           (/0.60,0.80,0.20/), (/0.80,0.80,0.20/), (/1.00,0.80,0.20/), \
           (/0.00,0.80,0.40/), (/0.20,0.80,0.40/), (/0.40,0.80,0.40/), \
           (/0.60,0.80,0.40/), (/0.80,0.80,0.40/), (/1.00,0.80,0.40/), \
           (/0.00,0.80,0.60/), (/0.20,0.80,0.60/), (/0.40,0.80,0.60/), \
           (/0.60,0.80,0.60/), (/0.80,0.80,0.60/), (/1.00,0.80,0.60/), \
           (/0.00,0.80,0.80/), (/0.20,0.80,0.80/), (/0.40,0.80,0.80/), \
           (/0.60,0.80,0.80/), (/0.80,0.80,0.80/), (/1.00,0.80,0.80/), \
           (/0.00,0.80,1.00/), (/0.20,0.80,1.00/), (/0.40,0.80,1.00/), \
           (/0.60,0.80,1.00/), (/0.80,0.80,1.00/), (/1.00,0.80,1.00/), \
           (/0.00,1.00,0.00/), (/0.20,1.00,0.00/), (/0.40,1.00,0.00/), \
           (/0.60,1.00,0.00/), (/0.80,1.00,0.00/), (/1.00,1.00,0.00/), \
           (/0.00,1.00,0.20/), (/0.20,1.00,0.20/), (/0.40,1.00,0.20/), \
           (/0.60,1.00,0.20/), (/0.80,1.00,0.20/), (/1.00,1.00,0.20/), \
           (/0.00,1.00,0.40/), (/0.20,1.00,0.40/), (/0.40,1.00,0.40/), \
           (/0.60,1.00,0.40/), (/0.80,1.00,0.40/), (/1.00,1.00,0.40/), \
           (/0.00,1.00,0.60/), (/0.20,1.00,0.60/), (/0.40,1.00,0.60/), \
           (/0.60,1.00,0.60/), (/0.80,1.00,0.60/), (/1.00,1.00,0.60/), \
           (/0.00,1.00,0.80/), (/0.20,1.00,0.80/), (/0.40,1.00,0.80/), \
           (/0.60,1.00,0.80/), (/0.80,1.00,0.80/), (/1.00,1.00,0.80/), \
           (/0.00,1.00,1.00/), (/0.20,1.00,1.00/), (/0.40,1.00,1.00/), \
           (/0.60,1.00,1.00/), (/0.80,1.00,1.00/), (/1.00,1.00,1.00/)/)

  draw_color_palette(wks,cmap,False)
end

           
