;----------------------------------------------------------------------
; write_asc_2.ncl
;
; Concepts illustrated: 
;   - Writing formatted string, float, and integer data to an ASCII file
;----------------------------------------------------------------------
; This script uses "write_table" which is much faster than using 
; "sprintf" and "sprinti".
;----------------------------------------------------------------------

load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"

begin
;---Generate some dummy integer and float data.
   npts = 100
   i    = ispan(1,npts,1)
   j    = generate_unique_indices(npts)
   k    = generate_unique_indices(npts)
   x    = random_uniform(-10,10,npts)
   y    = random_uniform(0,1000.,npts)

  write_table("file2.txt","w",[/j,x,i,y,k/], \
              "string_%03i %8.2f %4.0i %8.1f     string_%03i")
end
