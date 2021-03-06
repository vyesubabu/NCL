;*****************************************************
; trimesh_1.ncl
;
; Concepts illustrated:
;   - Contouring one-dimensional X, Y, Z data
;   - Selecting a "rainbow" color map that also contains "gray"
;   - Spanning part of a color map for contour fill
;   - Drawing a map using the high resolution map outlines

;*****************************************************

load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"

begin
;
;  This data is from the Chesapeake Community Model Program Quoddy
;  model:
;
;    http://ccmp.chesapeake.org
;
;  using the NOAA/NOS standardized hydrodynamic model NetCDF format:
;
;    https://sourceforge.net/projects/oceanmodelfiles
;
  f = addfile("$NCARG_ROOT/lib/ncarg/data/cdf/ctcbay.nc","r")

  wtype = "png"
  wtype@wkWidth = 1000
  wtype@wkHeight = 1000
  wks = gsn_open_wks(wtype,"trimesh")                 ; create plot
  gsn_define_colormap(wks,"rainbow+gray")

  res                     = True
  res@gsnMaximize         = True
  res@gsnSpreadColors     = True
  res@gsnSpreadColorStart = 15         ; Start with lighter purple
  res@gsnSpreadColorEnd   = -2         ; Make sure not to include gray

  res@sfXArray            = f->lon
  res@sfYArray            = f->lat
  res@sfElementNodes      = f->ele
  res@sfFirstNodeIndex    = 1

  res@cnFillOn            = True        ; Turn on contour fill.
  res@cnLinesOn           = False       ; Turn off contour lines

  res@lbOrientation       = "Vertical"  ; Change location of labelbar.
  res@lbLabelAutoStride   = True

;
; First create just a contour plot so we can later retrieve
; the start/end limits of the actual location of the  data.
; Don't draw the contour plot or advance the frame.
;

  res@gsnDraw  = False
  res@gsnFrame = False

  contour = gsn_csm_contour(wks,f->depth,res)

;
; Make sure gsnDraw and gsnFrame are on for the next plot.
;
  res@gsnDraw  = True
  res@gsnFrame = True

;
; Get ready to overlay on a cylindrical equidistant map.
;
; Retrieve the actual start and end limits of the data
;
  getvalues contour@data
    "sfXCActualStartF" : xs
    "sfXCActualEndF"   : xe
    "sfYCActualStartF" : ys
    "sfYCActualEndF"   : ye
  end getvalues
;
; Note: in order to use the high-resolution coastal database
; (mpDataBaseVersion = "HighRes"), you must download and install RANGS
; (Regionally Accessible Nested Global Shorelines), the multi-resolution
; coastline database, developed by Rainer Feistel from Wessel and
; Smith's GSHHS (Global Self-consistent Hierarchical High-resolution
; Shoreline) database. For more information, visit:
;
;    http://www.ncl.ucar.edu/Document/Graphics/rangs.shtml
;
; If you don't have this database, or don't want to install it, 
; change this resource value to "MediumRes".
;
  res@mpDataBaseVersion     = "HighRes"     ; "MediumRes" will run faster.
  res@mpLimitMode           = "LatLon"
  res@mpMinLonF             = xs
  res@mpMaxLonF             = xe
  res@mpMinLatF             = ys
  res@mpMaxLatF             = ye

  res@pmTickMarkDisplayMode = "Always"        ; Turn on map tickmarks.

  res@gsnRightStringOrthogonalPosF = 0.02     ; Move the subtitles down
  res@gsnLeftStringOrthogonalPosF  = 0.02     ; a little bit.
  map = gsn_csm_contour_map(wks,f->depth,res)
end
