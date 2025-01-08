" Vim syntax file
" Language: Aerobasic G-Code
" Maintainer: Riccardo Albiero <albr.riccardo@gmail.com>
" Last Change: 2021 July
"
" Rework of https://github.com/vim-scripts/nc.vim--Eno to be compatible with Aerotech GCODE used for femtosecond laser micromachining.

" Quit when a (custom syntax file was already loaded
if exists("b:current_syntax")
    finish
endif

syntax case ignore

" Match M- and G-codes {{{
syntax match gcGCode "\vG\d+"

" Match M-codes
syntax match gcMCode "\vM\d+"
" }}}

" Match functions {{{
" " Keywords {{{
syntax keyword gcFunction $AI
syntax keyword gcFunction $BI
syntax keyword gcFunction $BO
syntax keyword gcFunction $DI
syntax keyword gcFunction $DO
syntax keyword gcFunction $ECI
syntax keyword gcFunction $EDI
syntax keyword gcFunction $EDO
syntax keyword gcFunction $EPO
syntax keyword gcFunction $EPOD
syntax keyword gcFunction $EPOF
syntax keyword gcFunction $EPOS
syntax keyword gcFunction $ERI
syntax keyword gcFunction $ERID
syntax keyword gcFunction $ERIF
syntax keyword gcFunction $ERIS
syntax keyword gcFunction $ERO
syntax keyword gcFunction $EROD
syntax keyword gcFunction $EROF
syntax keyword gcFunction $EROS
syntax keyword gcFunction $PORT
syntax keyword gcFunction $RI
syntax keyword gcFunction $RO
syntax keyword gcFunction $WI
syntax keyword gcFunction $WO
syntax keyword gcFunction ABORT
syntax keyword gcFunction ABSOLUTE
syntax keyword gcFunction ANALOG
syntax keyword gcFunction ARRAY
syntax keyword gcFunction AUTOFOCUS
syntax keyword gcFunction AXCALPARM
syntax keyword gcFunction BAND
syntax keyword gcFunction BRAKE
syntax keyword gcFunction CALL
syntax keyword gcFunction CALLDLL
syntax keyword gcFunction CCW
syntax keyword gcFunction CFGMASTER
syntax keyword gcFunction COMMINIT
syntax keyword gcFunction COMMSETTIMEOUT
syntax keyword gcFunction CONTROL
syntax keyword gcFunction CW
syntax keyword gcFunction DATAACQ
syntax keyword gcFunction DATACW
syntax keyword gcFunction DATASTART
syntax keyword gcFunction DATASTOP
syntax keyword gcFunction DBLTOSTR
syntax keyword gcFunction DISABLE
syntax keyword gcFunction DISPLAY
syntax keyword gcFunction DRIVEINFO
syntax keyword gcFunction DVAR
syntax keyword gcFunction DWELL
syntax keyword gcFunction ENABLE
syntax keyword gcFunction ENGLISH
syntax keyword gcFunction EXE
syntax keyword gcFunction EXECANNEDFUNCTION
syntax keyword gcFunction EXEMODAL
syntax keyword gcFunction FARCALL
syntax keyword gcFunction FAULTACK
syntax keyword gcFunction FIBER
syntax keyword gcFunction FILECLOSE
syntax keyword gcFunction FILEEXISTS
syntax keyword gcFunction FILEOPEN
syntax keyword gcFunction FILEREAD
syntax keyword gcFunction FILEREADINI
syntax keyword gcFunction FILEWRITE
syntax keyword gcFunction FILEWRITEINI
syntax keyword gcFunction FILEWRITENOTERM
syntax keyword gcFunction FRAC
syntax keyword gcFunction FREECAN
syntax keyword gcFunction FREERUN
syntax keyword gcFunction HALT
syntax keyword gcFunction HANDWEEL
syntax keyword gcFunction HOME
syntax keyword gcFunction HOMEASYNC
syntax keyword gcFunction INCREMENTAL
syntax keyword gcFunction INT
syntax keyword gcFunction ISDONE
syntax keyword gcFunction LINEAR
syntax keyword gcFunction LOADCAMTABLE
syntax keyword gcFunction LOADCAMVAR
syntax keyword gcFunction LOADTOOLTABLE
syntax keyword gcFunction MAKESTRING
syntax keyword gcFunction MASKTODOUBLE
syntax keyword gcFunction MC
syntax keyword gcFunction METRIC
syntax keyword gcFunction MINUTES
syntax keyword gcFunction MOVEABS
syntax keyword gcFunction MOVEINC
syntax keyword gcFunction MOVEOUTLIM
syntax keyword gcFunction MSET
syntax keyword gcFunction MSGBOX
syntax keyword gcFunction MSGCLEAR
syntax keyword gcFunction MSGDISPLAY
syntax keyword gcFunction MSGHIDE
syntax keyword gcFunction MSGINPUT
syntax keyword gcFunction MSGLAMP
syntax keyword gcFunction MSGMENU
syntax keyword gcFunction MSGSHOW
syntax keyword gcFunction MSGTASK
syntax keyword gcFunction NSCOPEMANUALXYSCALE
syntax keyword gcFunction NSCOPESTART
syntax keyword gcFunction NSCOPETRIG
syntax keyword gcFunction NVISION
syntax keyword gcFunction ONGOSUB
syntax keyword gcFunction OSC
syntax keyword gcFunction PCI
syntax keyword gcFunction PGM
syntax keyword gcFunction POPMODES
syntax keyword gcFunction PORT
syntax keyword gcFunction PRG
syntax keyword gcFunction PROBE
syntax keyword gcFunction PROGRAMDOWNLOADFILE
syntax keyword gcFunction PROGRAMEXECUTE
syntax keyword gcFunction PROGRAMEXECUTEFILE
syntax keyword gcFunction PROGRAMTASKRESET
syntax keyword gcFunction PROGRAMUNLOAD
syntax keyword gcFunction PSOCONTROL
syntax keyword gcFunction PSODISTANCE
syntax keyword gcFunction PSOHALT
syntax keyword gcFunction PSOOUTPUT
syntax keyword gcFunction PSOPULSE
syntax keyword gcFunction PSOTRACK
syntax keyword gcFunction PSOWINDOW
syntax keyword gcFunction PULSE
syntax keyword gcFunction PUSHMODES
syntax keyword gcFunction PVT
syntax keyword gcFunction QCOMMAND
syntax keyword gcFunction RAND
syntax keyword gcFunction RAPID
syntax keyword gcFunction READ
syntax keyword gcFunction REF
syntax keyword gcFunction RETURN
syntax keyword gcFunction SECONDS
syntax keyword gcFunction SETCANNEDFUNCTION
syntax keyword gcFunction SETPARM
syntax keyword gcFunction SETPOSCMD
syntax keyword gcFunction SLICE
syntax keyword gcFunction SLW
syntax keyword gcFunction STRCHAR
syntax keyword gcFunction STRCMP
syntax keyword gcFunction STRFIND
syntax keyword gcFunction STRLEN
syntax keyword gcFunction STRLWR
syntax keyword gcFunction STRMID
syntax keyword gcFunction STRTOASCII
syntax keyword gcFunction STRTODBL
syntax keyword gcFunction STRUPR
syntax keyword gcFunction SUB
syntax keyword gcFunction SYNCH
syntax keyword gcFunction UNITS
syntax keyword gcFunction VELOCITY
syntax keyword gcFunction WORD
syntax match gcFunction "\<ANALOG TRACK\>"
syntax match gcFunction "\<.DEFINED\>"
syntax match gcFunction "\<ENCODER OUT\>"
syntax match gcFunction "\<RAMP MODE RATE\>"
syntax match gcFunction "\<RAMP MODE TIME\>"
syntax match gcFunction "\<RAMP RATE\>"
syntax match gcFunction "\<RAMP TIME\>"
syntax match gcFunction "\<VME READ\>"
syntax match gcFunction "\<VME WRITE\>"
syntax match gcFunction "\<WAIT MODE\>"
" }}}

" Match math operators
syntax match gcOperator "[\+|\-|\*|\/|=|>|<|>=|<=|&|\||%|!|\^|\(|\)\[\]\{\}]"
syntax keyword gcMath ABS ACOS ASIN ATAN COS EXP SIN SQRT TAN
syntax keyword gcIter DFS ELSE ELSEIF END ENDDFS ENDIF ENDREPEAT ENDRPT ENDW FARGOTO FARJUMP FOR GOTO IF JUMP NEXT PROGRAM REPEAT RPT STEP THEN TO WHILE
syntax keyword gcStatus INPOS INPUT MODE NOWAIT OFF ON RESET TRIGGER WAIT
syntax keyword gcError ERROR TASKERROR
" }}}

" Match #CMD {{{
syntax match gcHashtag "#\<AXISNAMES\>"
syntax match gcHashtag "#\<DEFINE\>"
syntax match gcHashtag "#\<ELSE\>"
syntax match gcHashtag "#\<ENDIF\>"
syntax match gcHashtag "#\<IFDEF\>"
syntax match gcHashtag "#\<IFNDEF\>"
syntax match gcHashtag "#\<INCLUDE\>"
syntax match gcHashtag "#\<MAKENCODESLABELS\>"
syntax match gcHashtag "#\<NOSUBST\>"
syntax match gcHashtag "#\<SUBST\>"
syntax match gcHashtag "#\<UNDEF\>"
" }}}

" Match axis and motion parameters {{{
syntax match gcAxis "\<[XYZU]\>"
syntax match gcAxis "\<[XYZU]-\?\d\+\>"
syntax match gcAxis "\<[XYZU]-\?\.\d\+\>"
syntax match gcAxis "\<[XYZU]-\?\d\+\."
syntax match gcAxis "\<[XYZU]-\?\d\+\.\d\+\>"
syntax match gcAxis "\<[XYZU]\ze\(\s*\d\+\)*\>"

syntax match gcFeed "\<[EFS]\>"
syntax match gcFeed "\<[EFS]-\?\d\+\>"
syntax match gcFeed "\<[EFS]-\?\.\d\+\>"
syntax match gcFeed "\<[EFS]-\?\d\+\."
syntax match gcFeed "\<[EFS]-\?\d\+\.\d\+\>"
syntax match gcFeed "\<[EFS]\ze\(\s*\d\+\)*\>"

syntax match gcUserParam "\<[LO]\>"
syntax match gcUserParam "\<[LO]-\?\d\+\>"
syntax match gcUserParam "\<[LO]-\?\.\d\+\>"
syntax match gcUserParam "\<[LO]-\?\d\+\."
syntax match gcUserParam "\<[LO]-\?\d\+\.\d\+\>"
syntax match gcUserParam "\<[LO]\ze\(\s*\d\+\)*\>"

syntax match gcRotationParam "\<[IJKPQR]\>"
syntax match gcRotationParam "\<[IJKPQR]-\?\d\+\>"
syntax match gcRotationParam "\<[IJKPQR]-\?\.\d\+\>"
syntax match gcRotationParam "\<[IJKPQR]-\?\d\+\."
syntax match gcRotationParam "\<[IJKPQR]-\?\d\+\.\d\+\>"
syntax match gcRotationParam "\<[IJKPQR]\ze\(\s*\d\+\)*\>"
" }}}

" Math variables {{{
syntax match gcDollar "\$\ze\(\w*\)"
syntax match gcVariable "\$\(\w*\)"hs=s+1,ms=s+1
" }}}

" Match strings {{{
syntax match gcString "\v\"([^"]*)\""
" }}}

" Match comments {{{
syntax  match gcComment "'.*$" contains=gcTodo
syntax  match gcComment "\/\/.*$" contains=gcTodo
syntax  match gcComment ";.*$" contains=gcTodo
" }}}

" highlight gcFunction cterm=NONE gui=NONE guifg=#9aae6b
highlight  gcFunction  cterm=NONE  gui=NONE  guifg=#b0d0f0
highlight  gcGCode     cterm=bold  gui=bold  guifg=#b0d0f0
highlight  gcAxis      cterm=bold  gui=bold  guifg=#9aae6b
highlight  gcOperator  cterm=NONE  gui=NONE  guifg=#7c9081
highlight  gcStatus    cterm=bold  gui=bold  guifg=#9aae6b

highlight  def  link  gcComment        Comment
highlight  def  link  gcDollar         gcGCode
highlight  def  link  gcError          Error
highlight  def  link  gcFeed           gcAxis
highlight  def  link  gcHashtag        Include
highlight  def  link  gcIter           gcGCode
highlight  def  link  gcMCode          gcGCode
highlight  def  link  gcMath           gcOperator
highlight  def  link  gcRotationParam  gcAxis
highlight  def  link  gcString         String
highlight  def  link  gcUserParam      Parameter
highlight  def  link  gcVariable       Keyword

let b:current_syntax = "gcode"
