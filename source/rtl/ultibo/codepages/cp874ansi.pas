{
Ultibo CP874 (ANSI) interface unit.

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


CP874 ANSI (Thai)
=================

 Note: CP874 is used as both the ANSI and OEM code pages when selected

}

{$mode delphi} {Default to Delphi compatible syntax}
{$H+}          {Default to AnsiString}
{$inline on}   {Allow use of Inline procedures}

unit CP874ANSI;

interface

uses GlobalConfig,GlobalConst,GlobalTypes,Locale;

{==============================================================================}
{Global definitions}
{$INCLUDE ..\core\GlobalDefines.inc}
        
{==============================================================================}
{const}
 {CP874ANSI specific constants}

{==============================================================================}
{type}
 {CP874ANSI specific types}

{==============================================================================}
{var}
 {CP874ANSI specific variables}

{==============================================================================}
{Initialization Functions}
procedure CP874ANSIInit;
 
{==============================================================================}
{CP874ANSI Functions}
 
{==============================================================================}
{CP874ANSI Helper Functions}
 
{==============================================================================}
{==============================================================================}

implementation

{==============================================================================}
{==============================================================================}
var
 {CP874ANSI specific variables}
 CP874ANSIInitialized:Boolean;

 CPANSI874:TCodeTable = (
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
  $20AC,$0081,$0082,$0083,$0084,$2026,$0086,$0087,
  $0088,$0089,$008A,$008B,$008C,$008D,$008E,$008F,
  $0090,$2018,$2019,$201C,$201D,$2022,$2013,$2014,
  $0098,$0099,$009A,$009B,$009C,$009D,$009E,$009F,
  $00A0,$0E01,$0E02,$0E03,$0E04,$0E05,$0E06,$0E07,
  $0E08,$0E09,$0E0A,$0E0B,$0E0C,$0E0D,$0E0E,$0E0F,
  $0E10,$0E11,$0E12,$0E13,$0E14,$0E15,$0E16,$0E17,
  $0E18,$0E19,$0E1A,$0E1B,$0E1C,$0E1D,$0E1E,$0E1F,
  $0E20,$0E21,$0E22,$0E23,$0E24,$0E25,$0E26,$0E27,
  $0E28,$0E29,$0E2A,$0E2B,$0E2C,$0E2D,$0E2E,$0E2F,
  $0E30,$0E31,$0E32,$0E33,$0E34,$0E35,$0E36,$0E37,
  $0E38,$0E39,$0E3A,$F8C1,$F8C2,$F8C3,$F8C4,$0E3F,
  $0E40,$0E41,$0E42,$0E43,$0E44,$0E45,$0E46,$0E47,
  $0E48,$0E49,$0E4A,$0E4B,$0E4C,$0E4D,$0E4E,$0E4F,
  $0E50,$0E51,$0E52,$0E53,$0E54,$0E55,$0E56,$0E57,
  $0E58,$0E59,$0E5A,$0E5B,$F8C5,$F8C6,$F8C7,$F8C8)
 );
 
 CP874Lower:TLowerTable = (
  LowerID:874;
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
  $A0,$A1,$A2,$A3,$A4,$A5,$A6,$A7,$A8,$A9,$AA,$AB,$AC,$AD,$AE,$AF,
  $B0,$B1,$B2,$B3,$B4,$B5,$B6,$B7,$B8,$B9,$BA,$BB,$BC,$BD,$BE,$BF,
  $C0,$C1,$C2,$C3,$C4,$C5,$C6,$C7,$C8,$C9,$CA,$CB,$CC,$CD,$CE,$CF,
  $D0,$D1,$D2,$D3,$D4,$D5,$D6,$D7,$D8,$D9,$DA,$DB,$DC,$DD,$DE,$DF,
  $E0,$E1,$E2,$E3,$E4,$E5,$E6,$E7,$E8,$E9,$EA,$EB,$EC,$ED,$EE,$EF,
  $F0,$F1,$F2,$F3,$F4,$F5,$F6,$F7,$F8,$F9,$FA,$FB,$FC,$FD,$FE,$FF)
 );
 
 CP874Upper:TUpperTable = (
  UpperID:874;
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
  $D0,$D1,$D2,$D3,$D4,$D5,$D6,$D7,$D8,$D9,$DA,$DB,$DC,$DD,$DE,$DF,
  $E0,$E1,$E2,$E3,$E4,$E5,$E6,$E7,$E8,$E9,$EA,$EB,$EC,$ED,$EE,$EF,
  $F0,$F1,$F2,$F3,$F4,$F5,$F6,$F7,$F8,$F9,$FA,$FB,$FC,$FD,$FE,$FF)
 );
 
{==============================================================================}
{==============================================================================}
{Initialization Functions}
procedure CP874ANSIInit;
begin
 {}
 {Check Initialized}
 if CP874ANSIInitialized then Exit;

 {Load Default Code Pages}
 LoadPage(CP_ANSI_874,@CPANSI874,@CP874Lower,@CP874Upper);
 DefaultTrans(CP_ANSI_874,CP_OEM_874);
 
 CP874ANSIInitialized:=True;
end;

{==============================================================================}
{==============================================================================}
{CP874ANSI Functions}

{==============================================================================}
{==============================================================================}
{CP874ANSI Helper Functions}

{==============================================================================}
{==============================================================================}

initialization
 CP874ANSIInit;
 
{==============================================================================}
 
finalization
 {Nothing}

{==============================================================================}
{==============================================================================}

end.
