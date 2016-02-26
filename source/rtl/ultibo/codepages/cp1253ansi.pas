{
Ultibo CP1253 (ANSI) interface unit.

Copyright (C) 2016 - SoftOz Pty Ltd.

Arch
====

 <All>

Boards
======

 <All>

Licence
=======

 LGPLv2.1 with static linking exception (See COPYING.modifiedLGPL.txt)
 
Credits
=======

 Information for this unit was obtained from:

 
References
==========


CP1253 ANSI (Greek)
===================

 Note: This unit automatically includes CP737OEM as the matching OEM code page.

}

{$mode delphi} {Default to Delphi compatible syntax}
{$H+}          {Default to AnsiString}
{$inline on}   {Allow use of Inline procedures}

unit CP1253ANSI;

interface

uses GlobalConfig,GlobalConst,GlobalTypes,Locale;

{==============================================================================}
{Global definitions}
{$INCLUDE ..\core\GlobalDefines.inc}
        
{==============================================================================}
{const}
 {CP1253ANSI specific constants}

{==============================================================================}
{type}
 {CP1253ANSI specific types}

{==============================================================================}
{var}
 {CP1253ANSI specific variables}

{==============================================================================}
{Initialization Functions}
procedure CP1253ANSIInit;
 
{==============================================================================}
{CP1253ANSI Functions}
 
{==============================================================================}
{CP1253ANSI Helper Functions}
 
{==============================================================================}
{==============================================================================}

implementation

uses CP737OEM;

{==============================================================================}
{==============================================================================}
var
 {CP1253ANSI specific variables}
 CP1253ANSIInitialized:Boolean;

 CPANSI1253:TCodeTable = (
  MaxCharSize:1;
  DefaultChar:(
  $3F,$00);
  LeadByte:(
  $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00);
  Values:(
  $0000,$0001,$0002,$0003,$0004,$0005,$0006,$0007,
  $0008,$0009,$000A,$000B,$000C,$000D,$000E,$000F,
  $0010,$0011,$0012,$0013,$0014,$0015,$0016,$0017,
  $0018,$0019,$001A,$001B,$001C,$001D,$001E,$001F,
  $0020,$0021,$0022,$0023,$0024,$0025,$0026,$0027,
  $0028,$0029,$002A,$002B,$002C,$002D,$002E,$002F,
  $0030,$0031,$0032,$0033,$0034,$0035,$0036,$0037,
  $0038,$0039,$003A,$003B,$003C,$003D,$003E,$003F,
  $0040,$0041,$0042,$0043,$0044,$0045,$0046,$0047,
  $0048,$0049,$004A,$004B,$004C,$004D,$004E,$004F,
  $0050,$0051,$0052,$0053,$0054,$0055,$0056,$0057,
  $0058,$0059,$005A,$005B,$005C,$005D,$005E,$005F,
  $0060,$0061,$0062,$0063,$0064,$0065,$0066,$0067,
  $0068,$0069,$006A,$006B,$006C,$006D,$006E,$006F,
  $0070,$0071,$0072,$0073,$0074,$0075,$0076,$0077,
  $0078,$0079,$007A,$007B,$007C,$007D,$007E,$007F,
  $20AC,$0081,$201A,$0192,$201E,$2026,$2020,$2021,
  $0088,$2030,$008A,$2039,$008C,$008D,$008E,$008F,
  $0090,$2018,$2019,$201C,$201D,$2022,$2013,$2014,
  $0098,$2122,$009A,$203A,$009C,$009D,$009E,$009F,
  $00A0,$0385,$0386,$00A3,$00A4,$00A5,$00A6,$00A7,
  $00A8,$00A9,$F8F9,$00AB,$00AC,$00AD,$00AE,$2015,
  $00B0,$00B1,$00B2,$00B3,$0384,$00B5,$00B6,$00B7,
  $0388,$0389,$038A,$00BB,$038C,$00BD,$038E,$038F,
  $0390,$0391,$0392,$0393,$0394,$0395,$0396,$0397,
  $0398,$0399,$039A,$039B,$039C,$039D,$039E,$039F,
  $03A0,$03A1,$F8FA,$03A3,$03A4,$03A5,$03A6,$03A7,
  $03A8,$03A9,$03AA,$03AB,$03AC,$03AD,$03AE,$03AF,
  $03B0,$03B1,$03B2,$03B3,$03B4,$03B5,$03B6,$03B7,
  $03B8,$03B9,$03BA,$03BB,$03BC,$03BD,$03BE,$03BF,
  $03C0,$03C1,$03C2,$03C3,$03C4,$03C5,$03C6,$03C7,
  $03C8,$03C9,$03CA,$03CB,$03CC,$03CD,$03CE,$F8FB)
 );
 
 CP1253Lower:TLowerTable = (
  LowerID:1253;
  Values:(
  $00,$01,$02,$03,$04,$05,$06,$07,$08,$09,$0A,$0B,$0C,$0D,$0E,$0F,
  $10,$11,$12,$13,$14,$15,$16,$17,$18,$19,$1A,$1B,$1C,$1D,$1E,$1F,
  $20,$21,$22,$23,$24,$25,$26,$27,$28,$29,$2A,$2B,$2C,$2D,$2E,$2F,
  $30,$31,$32,$33,$34,$35,$36,$37,$38,$39,$3A,$3B,$3C,$3D,$3E,$3F,
  $40,$61,$62,$63,$64,$65,$66,$67,$68,$69,$6A,$6B,$6C,$6D,$6E,$6F,
  $70,$71,$72,$73,$74,$75,$76,$77,$78,$79,$7A,$5B,$5C,$5D,$5E,$5F,
  $60,$61,$62,$63,$64,$65,$66,$67,$68,$69,$6A,$6B,$6C,$6D,$6E,$6F,
  $70,$71,$72,$73,$74,$75,$76,$77,$78,$79,$7A,$7B,$7C,$7D,$7E,$7F,
  $80,$81,$82,$83,$84,$85,$86,$87,$88,$89,$8A,$8B,$8C,$8D,$8E,$8F,
  $90,$91,$92,$93,$94,$95,$96,$97,$98,$99,$9A,$9B,$9C,$9D,$9E,$9F,
  $A0,$A1,$DC,$A3,$A4,$A5,$A6,$A7,$A8,$A9,$AA,$AB,$AC,$AD,$AE,$AF,
  $B0,$B1,$B2,$B3,$B4,$B5,$B6,$B7,$DD,$DE,$DF,$BB,$FC,$BD,$FD,$FE,
  $C0,$E1,$E2,$E3,$E4,$E5,$E6,$E7,$E8,$E9,$EA,$EB,$EC,$ED,$EE,$EF,
  $F0,$F1,$D2,$F3,$F4,$F5,$F6,$F7,$F8,$F9,$FA,$FB,$DC,$DD,$DE,$DF,
  $E0,$E1,$E2,$E3,$E4,$E5,$E6,$E7,$E8,$E9,$EA,$EB,$EC,$ED,$EE,$EF,
  $F0,$F1,$F2,$F3,$F4,$F5,$F6,$F7,$F8,$F9,$FA,$FB,$FC,$FD,$FE,$FF)
 );
 
 CP1253Upper:TUpperTable = (
  UpperID:1253;
  Values:(
  $00,$01,$02,$03,$04,$05,$06,$07,$08,$09,$0A,$0B,$0C,$0D,$0E,$0F,
  $10,$11,$12,$13,$14,$15,$16,$17,$18,$19,$1A,$1B,$1C,$1D,$1E,$1F,
  $20,$21,$22,$23,$24,$25,$26,$27,$28,$29,$2A,$2B,$2C,$2D,$2E,$2F,
  $30,$31,$32,$33,$34,$35,$36,$37,$38,$39,$3A,$3B,$3C,$3D,$3E,$3F,
  $40,$41,$42,$43,$44,$45,$46,$47,$48,$49,$4A,$4B,$4C,$4D,$4E,$4F,
  $50,$51,$52,$53,$54,$55,$56,$57,$58,$59,$5A,$5B,$5C,$5D,$5E,$5F,
  $60,$41,$42,$43,$44,$45,$46,$47,$48,$49,$4A,$4B,$4C,$4D,$4E,$4F,
  $50,$51,$52,$53,$54,$55,$56,$57,$58,$59,$5A,$7B,$7C,$7D,$7E,$7F,
  $80,$81,$82,$83,$84,$85,$86,$87,$88,$89,$8A,$8B,$8C,$8D,$8E,$8F,
  $90,$91,$92,$93,$94,$95,$96,$97,$98,$99,$9A,$9B,$9C,$9D,$9E,$9F,
  $A0,$A1,$A2,$A3,$A4,$A5,$A6,$A7,$A8,$A9,$AA,$AB,$AC,$AD,$AE,$AF,
  $B0,$B1,$B2,$B3,$B4,$B5,$B6,$B7,$B8,$B9,$BA,$BB,$BC,$BD,$BE,$BF,
  $C0,$C1,$C2,$C3,$C4,$C5,$C6,$C7,$C8,$C9,$CA,$CB,$CC,$CD,$CE,$CF,
  $D0,$D1,$D2,$D3,$D4,$D5,$D6,$D7,$D8,$D9,$DA,$DB,$A2,$B8,$B9,$BA,
  $E0,$C1,$C2,$C3,$C4,$C5,$C6,$C7,$C8,$C9,$CA,$CB,$CC,$CD,$CE,$CF,
  $D0,$D1,$F2,$D3,$D4,$D5,$D6,$D7,$D8,$D9,$DA,$DB,$BC,$BE,$BF,$FF)
 );
 
 CP1253TO737:TTransTable = (
  TransID:737;
  Values:(
  $00,$01,$02,$03,$04,$05,$06,$07,$08,$09,$0A,$0B,$0C,$0D,$0E,$0F,
  $10,$11,$12,$13,$14,$15,$16,$17,$18,$19,$1A,$1B,$1C,$1D,$1E,$1F,
  $20,$21,$22,$23,$24,$25,$26,$27,$28,$29,$2A,$2B,$2C,$2D,$2E,$2F,
  $30,$31,$32,$33,$34,$35,$36,$37,$38,$39,$3A,$3B,$3C,$3D,$3E,$3F,
  $40,$41,$42,$43,$44,$45,$46,$47,$48,$49,$4A,$4B,$4C,$4D,$4E,$4F,
  $50,$51,$52,$53,$54,$55,$56,$57,$58,$59,$5A,$5B,$5C,$5D,$5E,$5F,
  $60,$61,$62,$63,$64,$65,$66,$67,$68,$69,$6A,$6B,$6C,$6D,$6E,$6F,
  $70,$71,$72,$73,$74,$75,$76,$77,$78,$79,$7A,$7B,$7C,$7D,$7E,$7F,
  $5F,$5F,$5F,$5F,$5F,$5F,$5F,$5F,$5F,$5F,$5F,$5F,$5F,$5F,$5F,$5F,
  $5F,$5F,$5F,$5F,$5F,$07,$5F,$5F,$5F,$5F,$5F,$5F,$5F,$5F,$5F,$5F,
  $FF,$5F,$EA,$5F,$5F,$5F,$5F,$15,$5F,$5F,$5F,$5F,$5F,$5F,$5F,$5F,
  $F8,$F1,$FD,$5F,$5F,$5F,$14,$FA,$EB,$EC,$ED,$5F,$EE,$5F,$EF,$F0,
  $5F,$80,$81,$82,$83,$84,$85,$86,$87,$88,$89,$8A,$8B,$8C,$8D,$8E,
  $8F,$90,$5F,$91,$92,$93,$94,$95,$96,$97,$F4,$F5,$E1,$E2,$E3,$E5,
  $5F,$98,$99,$9A,$9B,$9C,$9D,$9E,$9F,$A0,$A1,$A2,$A3,$A4,$A5,$A6,
  $A7,$A8,$AA,$A9,$AB,$AC,$AD,$AE,$AF,$E0,$E4,$E8,$E6,$E7,$E9,$5F)
 );
 
{==============================================================================}
{==============================================================================}
{Initialization Functions}
procedure CP1253ANSIInit;
begin
 {}
 {Check Initialized}
 if CP1253ANSIInitialized then Exit;

 {Load Default Code Pages}
 LoadPage(CP_ANSI_1253,@CPANSI1253,@CP1253Lower,@CP1253Upper);
 InstallTrans(CP_ANSI_1253,@CP1253TO737);

 CP1253ANSIInitialized:=True;
end;

{==============================================================================}
{==============================================================================}
{CP1253ANSI Functions}

{==============================================================================}
{==============================================================================}
{CP1253ANSI Helper Functions}

{==============================================================================}
{==============================================================================}

initialization
 CP1253ANSIInit;
 
{==============================================================================}
 
finalization
 {Nothing}

{==============================================================================}
{==============================================================================}

end.
