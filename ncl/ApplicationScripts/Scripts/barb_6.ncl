;***********************************************
; barb_6.ncl
;***********************************************
;
; These files are loaded by default in NCL V6.2.0 and newer
; load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
; load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
; load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
;***********************************************
begin
  ymin = 2300.            ; min height to be plotted
  ymax = 5500.            ; max height to be plotted
  ncol = 7                ; number of columns of data (Each ascii file has the same number of columns)
  wbcrit = 97.            ; minimum distance in meters between wind barbs 

  fils = systemfunc("ls barb*.txt")
  nfiles = dimsizes(fils)
  
  wks = gsn_open_wks("png","barb")     ; send graphics to PNG file
  gsn_define_colormap(wks,"WhBlGrYeRe")
  do gg = 0,nfiles-1
     t = asciiread(fils(gg) ,(/-1/), "float")
     nlvl = dimsizes(t)/ncol           ; figure out number of levels in the ascii file
     delete(t)
     TestData = asciiread(fils(gg) ,(/nlvl,ncol/), "float")
     z    = TestData (:,2)
     wspd = TestData (:,6)
     wdir = TestData (:,5)
     delete(TestData)

     rad = 4.0*atan(1.0)/180.
     u = -wspd*sin(rad*wdir)
     v = -wspd*cos(rad*wdir)
        
     if (gg.eq.0) then
        res = True
        res@gsnDraw = False
        res@gsnFrame = False
        res@vpWidthF = 0.7
        res@vpHeightF = 0.5
        res@vpXF = 0.15
        res@vpYF = 0.9
        res@trYMinF = ymin
        res@trYMaxF = ymax
        res@tmXBMode = "Explicit"
        res@tmXBValues = ispan(0,nfiles-1,1)
        res@tmXBLabels = (/"00Z 1 Jan","12Z 1 Jan","00Z 2 Jan"/)
        res@tiYAxisString = "height (m)"
        res@tiXAxisString = "time"
        res@tiMainString = "Wind Profile"
        xc = (/-0.5,nfiles-0.5,nfiles-0.5,-0.5,-0.5/)
        yc = (/ymin,ymin,ymax,ymax,ymin/)
     
        plot = gsn_csm_xy(wks,xc,yc,res)                          ; draw blank xy plot by outlining min/max of X/Y axes
        contours = ispan(5,65,5)*1.                               ; set contours used to define barb color 
        colors = (/20,30,40,45,50,55,60,65,70,75,80,85,90,95/)    ; set colors
     end if
   
     wmsetp ("wdf", 1)                 ; meteorological dir
     wmsetp("wbs",0.025)
     wmsetp ("blw",2.0)    ; increase line thickness of wind barbs
     do hh = 0,dimsizes(z)-1
        wmsetp("col", GetFillColorIndex(contours,colors,wspd(hh)))    
        if (z(hh).lt.ymax) then
           if (hh.eq.0) then                                   ; always draw the first wind barb 
              wmbarb(wks, gg*1., z(hh), u(hh), v(hh)) 
              iFlag = True                                     ; iFlag = True denotes that a barb has been drawn
           else
              if (z(hh)-zsave.ge.wbcrit) then                  ; if the current height is beyond wbcrit from 
                 wmbarb(wks, gg*1., z(hh), u(hh), v(hh))       ; previous barb height, draw barb
                 iFlag = True
              else
                 if (.not.iFlag) then                          ; if the previous barb has not been drawn,
                    if (z(hh)-zsave.ge.wbcrit) then            ; and if the last drawn barb was more than wbcrit away,
                       wmbarb(wks, gg*1., z(hh), u(hh), v(hh)) ; draw a barb
                       iFlag = True
                    else
                       iFlag = False                           ; set iFlag to False, denoting the barb wasn't drawn
                    end if
                 else   
                    iFlag = False
                 end if
              end if
           end if
        else  
           iFlag = False
        end if
        if (iFlag) then
           zsave = z(hh)                                        ; save the height of the drawn wind barb
        end if
     end do
     delete([/z,wspd,wdir,u,v/])
  end do

;--------------------------------------------------------------------------
;    Draw Labelbar
;-------------------------------------------------------------------------- 
  lbres                      = True
  lbres@lbPerimOn            = False               ; no label bar box
  lbres@lbOrientation        = "Horizontal"        ; orientation
  lbres@vpWidthF             = 0.5                 ; size
  lbres@vpHeightF            = 0.075
  lbres@lbLabelFontHeightF   = 0.015               ; label font height
  lbres@lbLabelAlignment     = "InteriorEdges"     ; where to label
  lbres@lbMonoFillPattern    = True                ; fill sold
  lbres@lbFillColors         = colors
  gsn_labelbar_ndc (wks,dimsizes(contours)+1,sprintf("%3.0f",contours),0.25,0.28,lbres)
  
  draw(plot)                      ; draw the plot
  frame(wks)                        ; advance the frame
end
