unit uMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls, ImgList, ActnList, XPStyleActnCtrls, ActnMan,
  ExtCtrls, ComCtrls, Gauges, Mask, Spin;

type
  TSubTitles = class
  private
    FText: TStringList;
    FTSH, FTSM, FTSS, FTSMs: Integer;
    FTEH, FTEM, FTES, FTEMs: Integer;
    FSPosition, FEPosition: Integer;
  public
    property Text: TStringList read FText write FText;
    property TSH: Integer read FTSH write FTSH;
    property TSM: Integer read FTSM write FTSM;
    property TSS: Integer read FTSS write FTSS;
    property TSMs: Integer read FTSMs write FTSMs;
    property TEH: Integer read FTEH write FTEH;
    property TEM: Integer read FTEM write FTEM;
    property TES: Integer read FTES write FTES;
    property TEMs: Integer read FTEMs write FTEMs;
    property SPosition: Integer read FSPosition write FSPosition;
    property EPosition: Integer read FEPosition write FEPosition;

    constructor Create;
    destructor Destroy;
  end;


  TfmMain = class(TForm)
    ActionManager1: TActionManager;
    acExit: TAction;
    ImageList1: TImageList;
    acOpenSubtitles: TAction;
    acPlayStop: TAction;
    odOpenSubTitles: TOpenDialog;
    lvAllSubTitles: TListView;
    lbSubTit: TLabel;
    Panel1: TPanel;
    sbOpen: TSpeedButton;
    sbPlayStop: TSpeedButton;
    edTime: TEdit;
    sbExit: TSpeedButton;
    pbProgress: TProgressBar;
    Tim: TTimer;
    meNewPos: TMaskEdit;
    Label1: TLabel;
    Label2: TLabel;
    seSec: TSpinEdit;
    Label3: TLabel;
    sbChange: TSpeedButton;
    procedure acExitExecute(Sender: TObject);
    procedure acOpenSubtitlesExecute(Sender: TObject);
    procedure TimTimer(Sender: TObject);
    procedure acPlayStopExecute(Sender: TObject);
    procedure bbChangeClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure seSecChange(Sender: TObject);
    procedure sbChangeClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Dw: Boolean;
    Dx, Dy: Integer;
    CurrInd, CurrTime: Integer;
    Hn, Mn, Sn: Integer;
    dS: Integer;

    procedure WriteTime;
    procedure DoHMSNow(HMS: Integer);
  end;

var
  fmMain: TfmMain;

implementation

{$R *.dfm}

procedure TfmMain.acExitExecute(Sender: TObject);
begin
  close;
end;

procedure TfmMain.acOpenSubtitlesExecute(Sender: TObject);
var
  SubIn: TStringList;
  SubTitle: TSubTitles;
  i, j, OldI: Integer;
  Text, TextStart, TextEnd: string;
begin
  if not odOpenSubTitles.Execute then
    begin
      Screen.Cursor := crDefault;
      Self.Tag := 0;

      exit;
    end;

  Self.Tag := 1;
  Screen.Cursor := crHourGlass;

  lvAllSubTitles.Clear;
  pbProgress.Visible := True;

  SubIn := TStringList.Create;

  OldI := 0;

  SubIn.LoadFromFile(odOpenSubTitles.FileName);

 // fmMain.Repaint;

  for i := 0 to SubIn.Count - 1 do
    if SubIn[i] = '' then
    begin
      SubTitle := TSubTitles.Create;

      Text := SubIn[OldI + 1];
      SubTitle.TSH := StrToInt(Copy(Text, 1, Pos(':', Text) - 1));
      Delete(Text, 1, Pos(':', Text));
      SubTitle.TSM := StrToInt(Copy(Text, 1, Pos(':', Text) - 1));
      Delete(Text, 1, Pos(':', Text));
      SubTitle.TSS := StrToInt(Copy(Text, 1, Pos(',', Text) - 1));
      Delete(Text, 1, Pos(',', Text));
      SubTitle.TSMs := StrToInt(Copy(Text, 1, Pos(' ', Text) - 1));
      Delete(Text, 1, Pos(' ', Text));
      Delete(Text, 1, Pos(' ', Text));

      SubTitle.TEH := StrToInt(Copy(Text, 1, Pos(':', Text) - 1));
      Delete(Text, 1, Pos(':', Text));
      SubTitle.TEM := StrToInt(Copy(Text, 1, Pos(':', Text) - 1));
      Delete(Text, 1, Pos(':', Text));
      SubTitle.TES := StrToInt(Copy(Text, 1, Pos(',', Text) - 1));
      Delete(Text, 1, Pos(',', Text));
      if Text[Length(Text)] = ' ' then
        Delete(Text, Length(Text), 1);
      SubTitle.TEMs := StrToInt(Text);

      with SubTitle do
      begin
        SPosition := TSH * 60*60*1000 + TSM * 60*1000 + TSS * 1000 + TSMs;
        EPosition := TEH * 60*60*1000 + TEM * 60*1000 + TES * 1000 + TEMs;
      end;

      for j := OldI + 2 to i - 1 do
        SubTitle.Text.Add(SubIn[j]);

      Text := SubIn[OldI + 1];
      TextStart := Copy(Text, 1, Pos(' ', Text) - 1);
      Delete(Text, 1, Pos(' ', Text));
      Delete(Text, 1, Pos(' ', Text));
      TextEnd := Text;

      with lvAllSubTitles.Items.Add do
      begin
        Caption := SubTitle.Text[0];
        SubItems.Add(TextStart);
        SubItems.Add(TextEnd);
        Data := SubTitle;
      end;

      OldI := i + 1;

      pbProgress.Position := i * 100 div SubIn.Count;

      if OldI = SubIn.Count then
        break;
    end;

  Screen.Cursor := crDefault;
  pbProgress.Visible := False;

  CurrInd := 0;
  SubTitle := TSubTitles(lvAllSubTitles.Items[CurrInd].Data);
  CurrTime := SubTitle.SPosition;
end;

constructor TSubTitles.Create;
begin
  inherited;

  FText := TStringList.Create;
end;

destructor TSubTitles.Destroy;
begin
  FText.Destroy;

  inherited;
end;

procedure TfmMain.TimTimer(Sender: TObject);
var
  nms: Integer;
  i: Integer;
  SubTitle: TSubTitles;
begin
  WriteTime;

  for i := CurrInd to lvAllSubTitles.Items.Count - 1 do
    begin
      SubTitle := TSubTitles(lvAllSubTitles.Items[i].Data);
      if (CurrTime > SubTitle.SPosition) and
         (CurrTime < SubTitle.EPosition) then
           begin
             lbSubTit.Caption := SubTitle.Text.Text;
             CurrInd := i;
             break;
           end
      else
        lbSubTit.Caption := '';
    end;
  CurrTime := CurrTime + Tim.Interval + dS;
end;

procedure TfmMain.acPlayStopExecute(Sender: TObject);
begin
  if Self.Tag = 0  then exit;

  edTime.Visible := True;
  meNewPos.Visible := True;
  sbChange.Visible := True;
  Label1.Visible := True;
  Label2.Visible := True;
  Label3.Visible := True;
  seSec.Visible := True;
  sbPlaystop.Visible := True;
  pbProgress.Visible := False;
  Tim.Enabled := True;
end;

procedure TfmMain.WriteTime;
//запсывает текущее время в едит
var
  i: Integer;
  sM, sS: string;
begin
  DoHMSNow(CurrTime);

  if Mn < 10 then
    sM := '0' + IntToStr(Mn)
  else
    sM := IntToStr(Mn);

  if Sn < 10 then
    sS := '0' + IntToStr(Sn)
  else
    sS := IntToStr(Sn);

  edTime.Text := IntToStr(Hn) + ':' + sM + ':' + sS;
end;

procedure TfmMain.DoHMSNow(HMS: Integer);
begin
  Hn := HMS div 3600000;

  HMS := HMS - Hn * 3600000;
  Mn := HMS div 60000;

  HMS := HMS - Mn * 60000;
  Sn := HMS div 1000;
end;

procedure TfmMain.bbChangeClick(Sender: TObject);
var
  Text: string;
  h, m, s: Integer;
begin

  Text := meNewPos.Text;

  h := StrToInt(Copy(Text, 1, Pos(':', Text) - 1));
  Delete(Text, 1, Pos(':', Text));
  m := StrToInt(Copy(Text, 1, Pos(':', Text) - 1));
  Delete(Text, 1, Pos(':', Text));
  s := StrToInt(Text);

  CurrTime := h * 60*60*1000 + m * 60*1000 + s * 1000;
end;

procedure TfmMain.FormKeyPress(Sender: TObject; var Key: Char);
var
  SubTitle: TSubTitles;
begin
  if Key = ' ' then
    Tim.Enabled := not Tim.Enabled;
  if Key = 'l' then
    Self.Left := Self.Left - 1;
  if Key = 'r' then
    Self.Left := Self.Left + 1;
  if Key = 't' then
    Self.Top := Self.Top - 1;
  if Key = 'b' then
    Self.Top := Self.Top + 1;
  if Key = 'n' then
    begin
      Inc(CurrInd);
      SubTitle := TSubTitles(lvAllSubTitles.Items[CurrInd].Data);
      CurrTime := SubTitle.SPosition;
    end;
  if Key = 'p' then
    begin
      Dec(CurrInd);
      SubTitle := TSubTitles(lvAllSubTitles.Items[CurrInd].Data);
      CurrTime := SubTitle.SPosition;
    end;
  if (Key = 'u')and(seSec.Value < 99) then
    seSec.Value := seSec.Value + 1;
  if (Key = 'd')and(seSec.Value > -99) then
    seSec.Value := seSec.Value - 1;
end;

procedure TfmMain.FormCreate(Sender: TObject);
begin
  seSec.Value := 0;
  CurrInd := 0;
end;

procedure TfmMain.seSecChange(Sender: TObject);
begin
  Ds := seSec.Value;
end;

procedure TfmMain.sbChangeClick(Sender: TObject);
var
  Text: string;
  h, m, s: Integer;
begin

  Text := meNewPos.Text;

  h := StrToInt(Copy(Text, 1, Pos(':', Text) - 1));
  Delete(Text, 1, Pos(':', Text));
  m := StrToInt(Copy(Text, 1, Pos(':', Text) - 1));
  Delete(Text, 1, Pos(':', Text));
  s := StrToInt(Text);

  CurrTime := h * 60*60*1000 + m * 60*1000 + s * 1000;
end;

end.
