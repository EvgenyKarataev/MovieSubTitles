unit uMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ActnList,  ToolWin, ActnMan, ActnCtrls, ActnMenus,
  XPStyleActnCtrls, ExtCtrls, StdCtrls, MPlayer, Buttons, XPMan, IniFiles,
  ComCtrls, Mask, ImgList, MMSystem;

const
  Wid = 2;
  App_Name = 'SubTitles';

type
  TVolume = record
    vVolume: LongWord;
    vPosition: Integer;
  end;

  TVideo = class
    Path: string;
  end;

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

  TMark = class;


  TMarks = class(TObject)
  private
    FMarks: TList;

    function GetCount: Integer;
    function GetMark(Index: Integer): TMark;
  public
    function AddMark: TMark;
    function IndexOf(Mark: TMark): Integer;
    procedure Clear;
    procedure Delete(Index: Integer);

    property Marks[Index: Integer]: TMark read GetMark; default;
    property Count: Integer read GetCount;

    constructor Create;
  end;

  TMark = class(TObject)
  private
    FShape: TShape;
    FTime: TLabel;

    function GetParent: TWinControl;
    procedure SetParent(const Value: TWinControl);
  public
    property Shape: TShape read FShape;
    property Time: TLabel read FTime;
    property Parent: TWinControl read GetParent write SetParent;

    constructor Create(Marks: TMarks);
    destructor Destroy;
  end;

  TfmMain = class(TForm)
    acHead: TActionManager;
    ammbHead: TActionMainMenuBar;
    acExit: TAction;
    acAbout: TAction;
    gbVideo: TGroupBox;
    pVideoOut: TPanel;
    odAddVideo: TOpenDialog;
    odOpenSubTitles: TOpenDialog;
    sdSaveSubTitle: TSaveDialog;
    pListOfVideos: TPanel;
    pFButToVideo: TPanel;
    sbAddVideo: TSpeedButton;
    sbDelVideo: TSpeedButton;
    acAddVideo: TAction;
    sbPlayFromList: TSpeedButton;
    acPlayFromList: TAction;
    mpPlayer: TMediaPlayer;
    pMarks: TPanel;
    sbOpenVideo: TSpeedButton;
    sbStopVideo: TSpeedButton;
    sGoing: TShape;
    sLength: TShape;
    XPManifest1: TXPManifest;
    edTime: TEdit;
    acDelFromList: TAction;
    TimerPlay: TTimer;
    sBackGround: TShape;
    GroupBox1: TGroupBox;
    bbAddSubTitle: TBitBtn;
    gbAddSubTitle: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    mmSubTitle: TMemo;
    lbListOfVideo: TListBox;
    lvAllSubTitles: TListView;
    bbSetStart: TBitBtn;
    bbSetEnd: TBitBtn;
    bbDelSubTitle: TBitBtn;
    acAddSubTitle: TAction;
    acSetTimeStart: TAction;
    acSetTimeEnd: TAction;
    acDelSubTitle: TAction;
    meStart: TMaskEdit;
    meEnd: TMaskEdit;
    acDelAllSubTitles: TAction;
    bbDelAllSubTitles: TBitBtn;
    bbSaveSubTitles: TBitBtn;
    acSaveSubTitles: TAction;
    bbReplace: TBitBtn;
    acReplaceSubTitle: TAction;
    bbNewSubTitle: TBitBtn;
    acNewSubTitle: TAction;
    bbOpenSubTitles: TBitBtn;
    acOpenSubTitles: TAction;
    acSaveSubTitlesAs: TAction;
    sbClearListOfVideos: TSpeedButton;
    odOpenVideo: TOpenDialog;
    acOpenVideo: TAction;
    acClearListOfVideo: TAction;
    acNewSubTitles: TAction;
    pbProgress: TProgressBar;
    ImageList1: TImageList;
    acPlay: TAction;
    sbPlay: TSpeedButton;
    acPause: TAction;
    acStepLeft: TAction;
    acStepRight: TAction;
    sLengthBotom: TShape;
    sLengthTop: TShape;
    tbVolume: TTrackBar;
    sbVolume: TSpeedButton;
    acVolume: TAction;
    SpeedButton2: TSpeedButton;
    lbSubTit: TLabel;
    procedure acAddVideoExecute(Sender: TObject);
    procedure acPlayFromListExecute(Sender: TObject);
    procedure lbListOfVideoDblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure sLengthMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure sLengthMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure sLengthMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure sGoingMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure sGoingMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormResize(Sender: TObject);
    procedure acDelFromListExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure TimerPlayTimer(Sender: TObject);
    procedure pVideoOutClick(Sender: TObject);
    procedure acExitExecute(Sender: TObject);
    procedure acSetTimeStartExecute(Sender: TObject);
    procedure acSetTimeEndExecute(Sender: TObject);
    procedure acAddSubTitleExecute(Sender: TObject);
    procedure acDelSubTitleExecute(Sender: TObject);
    procedure acSaveSubTitlesExecute(Sender: TObject);
    procedure acNewSubTitleExecute(Sender: TObject);
    procedure lvAllSubTitlesClick(Sender: TObject);
    procedure acReplaceSubTitleExecute(Sender: TObject);
    procedure acOpenSubTitlesExecute(Sender: TObject);
    procedure acReplaceSubTitleUpdate(Sender: TObject);
    procedure acAddSubTitleUpdate(Sender: TObject);
    procedure acSetTimeStartUpdate(Sender: TObject);
    procedure acSetTimeEndUpdate(Sender: TObject);
    procedure acNewSubTitleUpdate(Sender: TObject);
    procedure acDelSubTitleUpdate(Sender: TObject);
    procedure acDelAllSubTitlesExecute(Sender: TObject);
    procedure acDelAllSubTitlesUpdate(Sender: TObject);
    procedure acSaveSubTitlesUpdate(Sender: TObject);
    procedure acOpenSubTitlesUpdate(Sender: TObject);
    procedure acSaveSubTitlesAsExecute(Sender: TObject);
    procedure acOpenVideoExecute(Sender: TObject);
    procedure acClearListOfVideoExecute(Sender: TObject);
    procedure acClearListOfVideoUpdate(Sender: TObject);
    procedure acDelFromListUpdate(Sender: TObject);
    procedure acPlayFromListUpdate(Sender: TObject);
    procedure acNewSubTitlesExecute(Sender: TObject);
    procedure acAboutExecute(Sender: TObject);
    procedure acPlayExecute(Sender: TObject);
    procedure acPauseExecute(Sender: TObject);
    procedure acSaveSubTitlesAsUpdate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure acStepLeftExecute(Sender: TObject);
    procedure acStepRightExecute(Sender: TObject);
    procedure tbVolumeChange(Sender: TObject);
    procedure acVolumeExecute(Sender: TObject);
    procedure mmSubTitleChange(Sender: TObject);
    procedure lvAllSubTitlesDblClick(Sender: TObject);
  private
    { Private declarations }
    TitleNow: string;
    PlayerOpened: Boolean;
    Down, DownGo, Started: Boolean;

    DownX, dX, H, M, S, Hn, Mn, Sn: Integer;
    HnToSet, MnToSet, SnToSet, MsnToSet: Integer;
    StartPos, EndPos, StepLR: Integer;
    Volume: TVolume;

    LenOfVideo, VideosName, SavedSubName, OldSavedSubName: string;

    Marks: TMarks;

    procedure PlayerOpen;

    procedure SetMarks(H, M, S: Integer);
    procedure SetTime(H, M, S: Integer);
    procedure DoHMS(HMS: Integer);
    procedure DoHMSNow(HMS: Integer);
    procedure DoHMSMsNow(HMS: Integer);
    procedure Play;
    procedure WriteTime;
    procedure WriteSubTit;
    procedure Sort;

    function GetName(S: string): string;
    function MakeTimeHMSMs: string;
    function CheckPlace(var Index:Integer): boolean;
  public
    { Public declarations }
  end;

var
  fmMain: TfmMain;

implementation

uses uAbout;

{$R *.dfm}

function TfmMain.GetName(S: string): string;
var
  i: Integer;
begin
  Result := S;

  Delete(S, Pos('.', S), Length(S) - Pos('.', S) + 1);

  for i := Length(S) downto 1 do
    if S[i] = '\' then
    begin
      Delete(S, 1, i);

      break;
    end;

  Result := S;
end;

procedure TfmMain.acAddVideoExecute(Sender: TObject);
var
  i: Integer;
  Video: TVideo;
  Playing: Boolean;
begin
  Playing := False;
  if Started then
  case mpPlayer.Mode of
    mpPlaying:
              begin
                mpPlayer.Pause;
                Playing := True;
              end;
  end;

  if not odAddVideo.Execute then
    begin
      if Playing then
        mpPlayer.Play;
      Exit;
    end;

  for i := 0 to odAddVideo.Files.Count - 1 do
  begin
    Video := TVideo.Create;

    Video.Path := odAddVideo.Files[i];

    lbListOfVideo.AddItem(GetName(odAddVideo.Files[i]), Video);
  end;

  lbListOfVideo.ItemIndex := 0;

  if Playing then
    mpPlayer.Play
end;

procedure TfmMain.acPlayFromListExecute(Sender: TObject);
var
  Video: TVideo;
  Bol: Boolean;
begin
  Screen.Cursor := crHourGlass;
  try
  if lbListOfVideo.ItemIndex > - 1 then
  begin
    Video := TVideo(lbListOfVideo.Items.Objects[lbListOfVideo.ItemIndex]);

    TitleNow := Video.Path;
    VideosName := lbListOfVideo.Items.Strings[lbListOfVideo.ItemIndex];

    mpPlayer.FileName := Video.Path;

    PlayerOpen;   //Открывает файл и наносит делители

    Play;
  end
  else
    sbStopVideo.Down := True;

  except
    Screen.Cursor := crDefault;
    Beep;
    Application.MessageBox('Выбранный файл не найден!!!', 'Внимание!!!', MB_ICONWARNING + mb_Ok);
  end;
  Screen.Cursor := crDefault;
end;

procedure TfmMain.Play;
begin
  mpPlayer.Play;
  Started := True;
  TimerPlay.Enabled := True;
end;

procedure TfmMain.lbListOfVideoDblClick(Sender: TObject);
begin
  acPlayFromList.OnExecute(Sender);
end;

procedure TfmMain.DoHMS(HMS: Integer);
begin
  H := HMS div 3600000;

  HMS := HMS - H * 3600000;
  M := HMS div 60000;

  HMS := HMS - M * 60000;
  S := HMS div 1000;
end;

procedure TfmMain.DoHMSNow(HMS: Integer);
begin
  Hn := HMS div 3600000;

  HMS := HMS - Hn * 3600000;
  Mn := HMS div 60000;

  HMS := HMS - Mn * 60000;
  Sn := HMS div 1000;
end;

procedure TfmMain.DoHMSMsNow(HMS: Integer);
begin
  HnToSet := HMS div 3600000;

  HMS := HMS - HnToSet * 3600000;
  MnToSet := HMS div 60000;

  HMS := HMS - MnToSet * 60000;
  SnToSet := HMS div 1000;

  MsnToSet := HMS - MnToSet * 60000;
end;

procedure TfmMain.PlayerOpen;
var
sdf: LongInt;
begin
  try
    mpPlayer.Open;
    mpPlayer.DisplayRect :=  Rect(0, 0, pVideoOut.Width, pVideoOut.Height);

    PlayerOpened :=True;

    mpPlayer.TimeFormat := tfMilliseconds;

    DoHMS(mpPlayer.Length);

    SetTime(H, M, S);
    SetMarks(H, M, S);
  except
    Screen.Cursor := crDefault;
  end;

end;

procedure TfmMain.FormCreate(Sender: TObject);
var
  Path: string;
  i, Count: Integer;
  Ini: TIniFile;
  Video: TVideo;
begin
  fmMain.Caption := App_Name;
  lbSubTit.Caption := '';

  StepLR := 10000;

  PlayerOpened := False;

  Marks := TMarks.Create;

  Path := Application.ExeName;

  for i := Length(Path) downto 0 do
    if Path[i] = '\' then
      begin
        Delete(Path, i + 1, Length(Path) - i);
        break;
      end;
  Path := Path + 'Films.ini';

   try
     Ini := TIniFile.Create(Path);
     Count := Ini.ReadInteger('Head', 'Count', 0);
     tbVolume.Position := Ini.ReadInteger('Head', 'Volume', 7);

     for i := 0 to Count - 1 do
       begin
         Video := TVideo.Create;
         Video.Path := Ini.ReadString('Titles', IntToStr(i), '');

         lbListOfVideo.AddItem(GetName(Ini.ReadString('Titles', IntToStr(i), '')), Video);
       end;
   finally
     Ini.Destroy;
   end;

  Volume.vPosition := tbVolume.Position;
  Volume.vVolume := 6500 * Volume.vPosition;
  Volume.vVolume := Volume.vVolume + (Volume.vVolume shl 16);
  WaveOutSetVolume(WAVE_MAPPER, Volume.vVolume);

  if lbListOfVideo.Count > 0 then
    lbListOfVideo.ItemIndex := 0;
end;

procedure TfmMain.SetMarks(H, M, S: Integer);
var
  Min, i: Integer;
  Mark: TMark;
begin
  Marks.Clear;
  sLength.Width := pMarks.Width - sLength.Left - 3;
  sLengthBotom.Width := sLength.Width;
  sLengthTop.Width := sLength.Width;

  Min := H * 60 + M;

  dX := sLength.Width div Min;

  for i := 0 to Min do
  begin
    Mark := Marks.AddMark;

    if Min < 120 then
      if i mod 5 = 0 then
        begin
          Mark.Shape.Height := 8;
          Mark.Shape.Top := sLength.Top - Mark.Shape.Height div 2 + 1;

          Mark.Shape.Left := i * dX + sLength.Left;
          Mark.Parent := pMarks;
          Mark.Shape.SendToBack;

          if i mod 10 = 0 then
          begin
            if i - (i div 60) * 60 = 0 then
              Mark.Time.Caption := IntToStr(i div 60) + ':' + IntToStr(i - (i div 60) * 60) + '0' + ':' + '00'
            else
              Mark.Time.Caption := IntToStr(i div 60) + ':' + IntToStr(i - (i div 60) * 60) + ':' + '00';

            Mark.Time.Top := Mark.Shape.Top - Mark.Time.Height;
            Mark.Time.Left := i * dX + sLength.Left - Mark.Time.Width div 2;
          end;   //  if i mod 10 = 0
        end
      else // if i mod 5 = 0
        begin
          Mark.Shape.Height := 1;
          Mark.Shape.Top := sLength.Top - Mark.Shape.Height;

          Mark.Shape.Left := i * dX + sLength.Left;
          Mark.Parent := pMarks;
          Mark.Shape.SendToBack;
        end
    else // if Min < 120
      begin
        if i mod 10 = 0 then
          begin
            Mark.Shape.Height := 8;
            Mark.Shape.Top := sLength.Top - Mark.Shape.Height div 2 + 1;

            Mark.Shape.Left := i * dX + sLength.Left;
            Mark.Parent := pMarks;
            Mark.Shape.SendToBack;

            if i mod 20 = 0 then
            begin
              if i - (i div 60) * 60 = 0 then
                Mark.Time.Caption := IntToStr(i div 60) + ':' + IntToStr(i - (i div 60) * 60) + '0' + ':' + '00'
              else
                Mark.Time.Caption := IntToStr(i div 60) + ':' + IntToStr(i - (i div 60) * 60) + ':' + '00';

              Mark.Time.Top := Mark.Shape.Top - Mark.Time.Height;
              Mark.Time.Left := i * dX + sLength.Left - Mark.Time.Width div 2;
            end;   //  if i mod 20 = 0
          end  //if i mod 10 = 0
        else if i mod 2 = 0 then
               begin
                 Mark.Shape.Height := 1;
                 Mark.Shape.Top := sLength.Top - Mark.Shape.Height;

                 Mark.Shape.Left := i * dX + sLength.Left;
                 Mark.Parent := pMarks;
                 Mark.Shape.SendToBack;
               end  //else if i mod 10 = 0
      end; // else if Min < 120
  end; // for i := 0 to Min do

  sLength.Width := dX * Min + 2 * Wid;
  sLengthBotom.Width := sLength.Width;
  sLengthTop.Width := sLength.Width;
  sGoing.Visible := True;
end;

procedure TfmMain.SetTime(H, M, S: Integer);
var
  sH, sM, sS: string;
begin
  sH := IntToStr(H);

  if M < 10 then
    sM := '0' + IntToStr(M)
  else
    sM := IntToStr(M);

  if S < 10 then
    sS := '0' + IntToStr(S)
  else
    sS := IntToStr(S);

  LenOfVideo := sH + ':' + sM + ':' + sS;

  edTime.Text := '0:00:00>' + sH + ':' + sM + ':' + sS;
end;

{ TMarks }

function TMarks.AddMark: TMark;
begin
  Result := TMark.Create(Self);         //Вызывает конструктор
  FMarks.Add(Result);
end;

procedure TMarks.Clear;
var
  i: Integer;
begin
  for i := Count - 1 downto 0 do
    Delete(i);
end;

constructor TMarks.Create;
begin
  inherited;

  FMarks := TList.Create;
end;

procedure TMarks.Delete(Index: Integer);
begin
  if Index > -1 then
  begin
    Marks[Index].Shape.Free;  //Убивает прямоуг
    Marks[Index].Time.Free;  //Убивает прямоуг
    FMarks.Delete(Index);
  end;
end;

function TMarks.GetCount: Integer;
begin
  Result := FMarks.Count;
end;

function TMarks.GetMark(Index: Integer): TMark;
begin
  Result := FMarks[Index];
end;

function TMarks.IndexOf(Mark: TMark): Integer;
begin
  Result := FMarks.IndexOf(Mark)
end;

{ TMark }

constructor TMark.Create(Marks: TMarks);
begin
  inherited Create;

  FShape := TShape.Create(nil);      //Создает прямоуг
  FShape.Tag := Integer(Self);
  FShape.Shape := stRectangle;
  FShape.Brush.Color := clActiveCaption;
  FShape.Pen.Color := clActiveCaption;
  FShape.Width := Wid;

  FTime := TLabel.Create(nil);
  FTime.AutoSize := True;
  FTime.Font.Size := 4;
  FTime.Font.Color := clActiveCaption;
  FTime.Tag := Integer(Self);
  FTime.Transparent := True;
end;

destructor TMark.Destroy;
begin
  FShape.Free;                       //Уничтожает прямоугольник
  FTime.Free;

  inherited;
end;

function TMark.GetParent: TWinControl;
begin
  Result := FShape.Parent;
end;

procedure TMark.SetParent(const Value: TWinControl);
begin
  FShape.Parent := Value;
  FTime.Parent := Value;
end;

procedure TfmMain.sLengthMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  Playing: Boolean;
begin
  if not Started then exit;

  if DownGo then
    sGoing.Left := DownX + sLength.Left - sGoing.Width div 2
  else
    sGoing.Left := X + sLength.Left - sGoing.Width div 2;
    
  Down := True;

  Playing := False;
  case mpPlayer.Mode of
    mpPlaying: Playing := True;
  end; //case

  mpPlayer.Position := Round(X * 60000 / dX);
  WriteTime;

  if Playing then
    mpPlayer.Play;
end;

procedure TfmMain.sLengthMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if not Started then exit;

  Down := False;
end;

procedure TfmMain.sLengthMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var
  Playing: Boolean;
begin
  if not Started then exit;

  if Down then
    begin
      Playing := False;
      case mpPlayer.Mode of
        mpPlaying: Playing := True;
      end; //case

      sGoing.Left := X + sLength.Left - sGoing.Width div 2;
      mpPlayer.Position := Round(X * 60000 / dX);
      WriteTime;

      if Playing then
        mpPlayer.Play;
    end;
end;

procedure TfmMain.sGoingMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  DownGo := True;
  DownX := sGoing.Left;
end;

procedure TfmMain.sGoingMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  DownGo := False;
end;

procedure TfmMain.FormResize(Sender: TObject);
var
  Playing: Boolean;
begin
  Playing := False;
  if Started then
  case mpPlayer.Mode of
    mpPlaying:
              begin
                mpPlayer.Pause;
                Playing := True;
              end;
  end;

  if PlayerOpened then
    SetMarks(H, M, S);
  pVideoOut.Left := (gbVideo.Width - pListOfVideos.Width - pVideoOut.Width)div 2;

  if Playing then
    mpPlayer.Play
end;

procedure TfmMain.acDelFromListExecute(Sender: TObject);
var
  Index: Integer;
begin
  Index := lbListOfVideo.ItemIndex;

  lbListOfVideo.DeleteSelected;
  if lbListOfVideo.Count > 0 then
    begin
      if Index <= lbListOfVideo.Count - 1 then
        lbListOfVideo.Selected[Index] := True
      else
        lbListOfVideo.Selected[lbListOfVideo.Count - 1] := True
    end;
end;

procedure TfmMain.FormClose(Sender: TObject; var Action: TCloseAction);
var
  Ini: TIniFile;
  Path: string;
  i: Integer;
  Video: TVideo;
begin
  if Started then
    mpPlayer.Stop;

  Path := Application.ExeName;

  for i := Length(Path) downto 0 do
    if Path[i] = '\' then
      begin
        Delete(Path, i + 1, Length(Path) - i);
        break;
      end;
  Path := Path + 'Films';

  try
    Ini := TIniFile.Create(ChangeFileExt(Path, '.ini'));
    Ini.WriteInteger('Head', 'Count', lbListOfVideo.Count);
    Ini.WriteInteger('Head', 'Volume', Volume.vPosition);

    for i := 0 to lbListOfVideo.Count - 1 do
      begin
        Video := TVideo(lbListOfVideo.Items.Objects[i]);
        Ini.WriteString('Titles', IntToStr(i), Video.Path);
      end
  finally
    Ini.Destroy;
  end;

  Volume.vPosition := 10;
  Volume.vVolume := 6500 * Volume.vPosition;
  Volume.vVolume := Volume.vVolume + (Volume.vVolume shl 16);
  WaveOutSetVolume(WAVE_MAPPER, Volume.vVolume);
end;

procedure TfmMain.WriteTime;
//запсывает текущее время в едит
var
  i: Integer;
  sM, sS: string;
begin
  DoHMSNow(mpPlayer.Position);

  if Mn < 10 then
    sM := '0' + IntToStr(Mn)
  else
    sM := IntToStr(Mn);

  if Sn < 10 then
    sS := '0' + IntToStr(Sn)
  else
    sS := IntToStr(Sn);

  edTime.Text := IntToStr(Hn) + ':' + sM + ':' + sS + '>' + LenOfVideo;
end;

procedure TfmMain.WriteSubTit;
var
  nms: Integer;
  i: Integer;
  SubTitle: TSubTitles;
begin
  for i := 0 to lvAllSubTitles.Items.Count - 1 do
    begin
      SubTitle := TSubTitles(lvAllSubTitles.Items[i].Data);
      if (mpPlayer.Position > SubTitle.SPosition) and
         (mpPlayer.Position < SubTitle.EPosition) then
           begin
             lbSubTit.Caption := SubTitle.Text.Text;
             break;
           end
      else
        lbSubTit.Caption := '';
    end;
end;

procedure TfmMain.TimerPlayTimer(Sender: TObject);
begin
  WriteTime; //запсывает текущее время в едит
  WriteSubTit;

  sGoing.Left := sLength.Left + Round(mpPlayer.Position * dX / 60000) - sGoing.Width div 2;
end;

procedure TfmMain.pVideoOutClick(Sender: TObject);
begin
  sbStopVideo.OnClick(Sender);
end;

procedure TfmMain.acExitExecute(Sender: TObject);
begin
  close;
end;

procedure TfmMain.acSetTimeStartExecute(Sender: TObject);
begin
  StartPos := mpPlayer.Position;
  meStart.Text := MakeTimeHMSMs;
end;

function TfmMain.MakeTimeHMSMs: string;
begin
  DoHMSMsNow(mpPlayer.Position);

  Result := IntToStr(HnToSet) + ':';

  if MnToSet < 10 then
    Result := Result + '0' + IntToStr(MnToSet) + ':'
  else
    Result := Result + IntToStr(MnToSet) + ':';

  if SnToSet < 10 then
    Result := Result + '0' + IntToStr(SnToSet) + ','
  else
    Result := Result + IntToStr(SnToSet) + ',';

  if MsnToSet < 10 then
    Result := Result + '00' + IntToStr(MsnToSet)
  else if MsnToSet < 100 then
         Result := Result + '0' + IntToStr(MsnToSet)
       else
         Result := Result + IntToStr(MsnToSet);
end;

procedure TfmMain.acSetTimeEndExecute(Sender: TObject);
begin
  if mpPlayer.Position > StartPos then
    begin
      EndPos := mpPlayer.Position;
      meEnd.Text := MakeTimeHMSMs;
    end
  else
    Application.MessageBox('Время окончания субтитра не может быть меньше времени начала!', 'Внимание!!!', mrNone);
end;

function TfmMain.CheckPlace(var Index:Integer): boolean;
//Проверяет можно ли суда вставить субтитр
var
  i: Integer;
  SubTitle: TSubTitles;
begin
  Result := True;
  for i := 0 to lvAllSubTitles.Items.Count - 1 do
    begin
      SubTitle := TSubTitles(lvAllSubTitles.Items[i].Data);
      if (StartPos <= SubTitle.SPosition)and(EndPos >= SubTitle.SPosition) then
        begin
          Result := False;
          Index := i;
          break;
        end
      else
        if (StartPos >= SubTitle.SPosition)and(EndPos <= SubTitle.EPosition) then
        begin
          Result := False;
          Index := i;
          break;
        end
        else
          if (StartPos <= SubTitle.EPosition)and(EndPos >= SubTitle.EPosition) then
          begin
            Result := False;
            Index := i;
            break;
          end
          else
            if (StartPos <= SubTitle.SPosition)and(EndPos >= SubTitle.EPosition) then
            begin
              Result := False;
              Index := i;
              break;
            end
    end;
end;

procedure TfmMain.acAddSubTitleExecute(Sender: TObject);
var
  SubTitle: TSubTitles;
  Index: Integer;
begin
 if StartPos > EndPos then
  begin
    Application.MessageBox('Время начала субтитра не может быть больше времени конца!', 'Внимание!!!', mrNone);
    exit;
  end;

  SubTitle := TSubTitles.Create;
  SubTitle.Text.AddStrings(mmSubTitle.Lines);

  SubTitle.TSH := StrToInt(meStart.Text[1]);
  SubTitle.TSM := StrToInt(meStart.Text[3] + meStart.Text[4]);
  SubTitle.TSS := StrToInt(meStart.Text[6] + meStart.Text[7]);
  SubTitle.TSMs := StrToInt(meStart.Text[9] + meStart.Text[10] + meStart.Text[11]);

  SubTitle.TEH := StrToInt(meEnd.Text[1]);
  SubTitle.TEM := StrToInt(meEnd.Text[3] + meEnd.Text[4]);
  SubTitle.TES := StrToInt(meEnd.Text[6] + meEnd.Text[7]);
  SubTitle.TEMs := StrToInt(meEnd.Text[9] + meEnd.Text[10] + meEnd.Text[11]);

  with SubTitle do
      begin
        SPosition := TSH * 60 * 60 * 1000 + TSM * 60 * 1000 + TSS * 1000 + TSMs;
        StartPos := SPosition;
        EPosition := TEH * 60 * 60 * 1000 + TEM * 60 * 1000 + TES * 1000 + TEMs;
        EndPos := EPosition;
      end;

  if not CheckPlace(Index) then
  begin
    lvAllSubTitles.Items[Index].Selected := True;
    Application.MessageBox('В этом временном промежутке уже имеется субтитр!', 'Внимание!!!', mrNone);
    SubTitle.Destroy;
    exit;
  end;

  with lvAllSubTitles.Items.Add do
    begin
      Caption := SubTitle.Text[0];
      SubItems.Add(meStart.Text);
      SubItems.Add(meEnd.Text);
      Data := SubTitle;
    end;

  mmSubTitle.Clear;
  Sort;
end;

procedure TfmMain.Sort;
var
  i, j: Integer;
  SubTitleI, SubTitleJ, SubTitle: TSubTitles;
  Item: TListItem;
  TextStart, TextEnd: string;
begin
  for i := 0 to lvAllSubTitles.Items.Count - 2 do
    for j := i + 1 to lvAllSubTitles.Items.Count - 1 do
      begin
        SubTitleI := TSubTitles.Create;
        SubTitleJ := TSubTitles.Create;

        SubTitleI := TSubTitles(lvAllSubTitles.Items[i].Data);
        SubTitleJ := TSubTitles(lvAllSubTitles.Items[j].Data);
        if SubTitleI.SPosition > SubTitleJ.SPosition then
          begin
            lvAllSubTitles.Items[i].Data := SubTitleJ;
            lvAllSubTitles.Items[j].Data := SubTitleI;
          end;
      end;
  for i := 0 to lvAllSubTitles.Items.Count - 1 do
  begin
    SubTitle := TSubTitles.Create;
    SubTitle := TSubTitles(lvAllSubTitles.Items[i].Data);

    TextStart := IntToStr(SubTitle.TSH) + ':';
    if SubTitle.TSM < 10 then
      TextStart := TextStart + '0' + IntToStr(SubTitle.TSM) + ':'
    else
      TextStart := TextStart + IntToStr(SubTitle.TSM) + ':';
    if SubTitle.TSS < 10 then
        TextStart := TextStart + '0' + IntToStr(SubTitle.TSS) + ','
      else
        TextStart := TextStart + IntToStr(SubTitle.TSS) + ',';
      if SubTitle.TSMs < 10 then
        TextStart := TextStart + '00' + IntToStr(SubTitle.TSMs)
      else if SubTitle.TSMs < 100 then
             TextStart := TextStart + '0' + IntToStr(SubTitle.TSMs)
           else
             TextStart := TextStart + IntToStr(SubTitle.TSMs);

    TextEnd := IntToStr(SubTitle.TEH) + ':';
    if SubTitle.TEM < 10 then
      TextEnd := TextEnd + '0' + IntToStr(SubTitle.TEM) + ':'
    else
      TextEnd := TextEnd + IntToStr(SubTitle.TEM) + ':';
    if SubTitle.TES < 10 then
        TextEnd := TextEnd + '0' + IntToStr(SubTitle.TES) + ','
      else
        TextEnd := TextEnd + IntToStr(SubTitle.TES) + ',';
      if SubTitle.TEMs < 10 then
        TextEnd := TextEnd + '00' + IntToStr(SubTitle.TEMs)
      else if SubTitle.TEMs < 100 then
             TextEnd := TextEnd + '0' + IntToStr(SubTitle.TEMs)
           else
             TextEnd := TextEnd + IntToStr(SubTitle.TEMs);

    with lvAllSubTitles.Items[i] do
    begin
      Caption := SubTitle.Text[0];
      SubItems.Text := TextStart;
      SubItems.Add(TextEnd);
      Data := SubTitle;
    end;

  end;
end;

procedure TfmMain.acDelSubTitleExecute(Sender: TObject);
begin
  lvAllSubTitles.DeleteSelected;
end;

procedure TfmMain.acSaveSubTitlesExecute(Sender: TObject);
var
  SubOut: TStringList;
  SubTitle: TSubTitles;
  i: Integer;
  Text: string;
  Playing: Boolean;
begin
  Playing := False;
  if Started then
  case mpPlayer.Mode of
    mpPlaying:
              begin
                mpPlayer.Pause;
                Playing := True;
              end;
  end;

  sdSaveSubTitle.FileName := VideosName;
  sdSaveSubTitle.InitialDir := TitleNow;

  if SavedSubName = '' then
    if not sdSaveSubTitle.Execute then
      begin
        SavedSubName := OldSavedSubName;
        Screen.Cursor := crDefault;

        if Playing then
          mpPlayer.Play;

        exit;
      end;

  fmMain.Repaint;

  Screen.Cursor := crHourGlass;

  SavedSubName := sdSaveSubTitle.FileName;
  OldSavedSubName := SavedSubName;
  fmMain.Caption := App_Name + ' - ' + SavedSubName;

  pbProgress.Visible := True;

  SubOut := TStringList.Create;
  for i := 0 to lvAllSubTitles.Items.Count - 1 do
    begin
      SubTitle := TSubTitles(lvAllSubTitles.Items[i].Data);
      SubOut.Add(IntToStr(i + 1));
      Text := '0' + IntToStr(SubTitle.TSH) + ':';
      if SubTitle.TSM < 10 then
        Text := Text + '0' + IntToStr(SubTitle.TSM) + ':'
      else
        Text := Text + IntToStr(SubTitle.TSM) + ':';
      if SubTitle.TSS < 10 then
        Text := Text + '0' + IntToStr(SubTitle.TSS) + ','
      else
        Text := Text + IntToStr(SubTitle.TSS) + ',';
      if SubTitle.TSMs < 10 then
        Text := Text + '00' + IntToStr(SubTitle.TSMs) + ' --> '
      else if SubTitle.TSMs < 100 then
             Text := Text + '0' + IntToStr(SubTitle.TSMs) + ' --> '
           else
             Text := Text + IntToStr(SubTitle.TSMs) + ' --> ';

      Text := Text + '0' + IntToStr(SubTitle.TEH) + ':';

      if SubTitle.TEM < 10 then
        Text := Text + '0' + IntToStr(SubTitle.TEM) + ':'
      else
        Text := Text + IntToStr(SubTitle.TEM) + ':';
      if SubTitle.TES < 10 then
        Text := Text + '0' + IntToStr(SubTitle.TES) + ','
      else
        Text := Text + IntToStr(SubTitle.TES) + ',';
      if SubTitle.TEMs < 10 then
        Text := Text + '00' + IntToStr(SubTitle.TEMs)
      else if SubTitle.TEMs < 100 then
             Text := Text + '0' + IntToStr(SubTitle.TEMs)
           else
             Text := Text + IntToStr(SubTitle.TEMs);
             
      SubOut.Add(Text);
      SubOut.AddStrings(SubTitle.Text);
      SubOut.Add('');

      pbProgress.Position := i * 100 div SubOut.Count;
    end;

  SubOut.SaveToFile(ChangeFileExt(SavedSubName, '.srt'));

  pbProgress.Visible := False;

  SubOut.Destroy;

  Screen.Cursor := crDefault;

  if Playing then
    mpPlayer.Play
end;

procedure TfmMain.acNewSubTitleExecute(Sender: TObject);
begin
  lvAllSubTitles.ItemIndex := -1;

  meStart.Text := '';
  meEnd.Text := '';
  mmSubTitle.Clear;
end;

procedure TfmMain.lvAllSubTitlesClick(Sender: TObject);
var
  SubTitle: TSubTitles;
  Text: string;
begin
  if lvAllSubTitles.ItemIndex = -1 then
    Exit;

  mmSubTitle.Clear;

  SubTitle := TSubTitles(lvAllSubTitles.Items[lvAllSubTitles.ItemIndex].Data);

  Text := IntToStr(SubTitle.TSH) + ':';
  if SubTitle.TSM < 10 then
    Text := Text + '0' + IntToStr(SubTitle.TSM) + ':'
  else
    Text := Text + IntToStr(SubTitle.TSM) + ':';
  if SubTitle.TSS < 10 then
        Text := Text + '0' + IntToStr(SubTitle.TSS) + ','
      else
        Text := Text + IntToStr(SubTitle.TSS) + ',';
      if SubTitle.TSMs < 10 then
        Text := Text + '00' + IntToStr(SubTitle.TSMs)
      else if SubTitle.TSMs < 100 then
             Text := Text + '0' + IntToStr(SubTitle.TSMs)
           else
             Text := Text + IntToStr(SubTitle.TSMs);

  meStart.Text := Text;

  Text := IntToStr(SubTitle.TEH) + ':';
  if SubTitle.TEM < 10 then
    Text := Text + '0' + IntToStr(SubTitle.TEM) + ':'
  else
    Text := Text + IntToStr(SubTitle.TEM) + ':';
  if SubTitle.TES < 10 then
        Text := Text + '0' + IntToStr(SubTitle.TES) + ','
      else
        Text := Text + IntToStr(SubTitle.TES) + ',';
      if SubTitle.TEMs < 10 then
        Text := Text + '00' + IntToStr(SubTitle.TEMs)
      else if SubTitle.TEMs < 100 then
             Text := Text + '0' + IntToStr(SubTitle.TEMs)
           else
             Text := Text + IntToStr(SubTitle.TEMs);

  meEnd.Text := Text;

  mmSubTitle.Lines.AddStrings(SubTitle.Text);
end;

procedure TfmMain.lvAllSubTitlesDblClick(Sender: TObject);
var
  SubTitle: TSubTitles;
  Text: string;
begin
  if lvAllSubTitles.ItemIndex = -1 then
    Exit;

  mmSubTitle.Clear;

  SubTitle := TSubTitles(lvAllSubTitles.Items[lvAllSubTitles.ItemIndex].Data);

  Text := IntToStr(SubTitle.TSH) + ':';
  if SubTitle.TSM < 10 then
    Text := Text + '0' + IntToStr(SubTitle.TSM) + ':'
  else
    Text := Text + IntToStr(SubTitle.TSM) + ':';
  if SubTitle.TSS < 10 then
        Text := Text + '0' + IntToStr(SubTitle.TSS) + ','
      else
        Text := Text + IntToStr(SubTitle.TSS) + ',';
      if SubTitle.TSMs < 10 then
        Text := Text + '00' + IntToStr(SubTitle.TSMs)
      else if SubTitle.TSMs < 100 then
             Text := Text + '0' + IntToStr(SubTitle.TSMs)
           else
             Text := Text + IntToStr(SubTitle.TSMs);

  meStart.Text := Text;

  Text := IntToStr(SubTitle.TEH) + ':';
  if SubTitle.TEM < 10 then
    Text := Text + '0' + IntToStr(SubTitle.TEM) + ':'
  else
    Text := Text + IntToStr(SubTitle.TEM) + ':';
  if SubTitle.TES < 10 then
        Text := Text + '0' + IntToStr(SubTitle.TES) + ','
      else
        Text := Text + IntToStr(SubTitle.TES) + ',';
      if SubTitle.TEMs < 10 then
        Text := Text + '00' + IntToStr(SubTitle.TEMs)
      else if SubTitle.TEMs < 100 then
             Text := Text + '0' + IntToStr(SubTitle.TEMs)
           else
             Text := Text + IntToStr(SubTitle.TEMs);

  meEnd.Text := Text;

  mmSubTitle.Lines.AddStrings(SubTitle.Text);

  mpPlayer.Position := SubTItle.SPosition;
  mpPlayer.Play;


end;

{ TSubTitles }

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

procedure TfmMain.acReplaceSubTitleExecute(Sender: TObject);
var
  SubTitle: TSubTitles;
begin
  if StartPos > EndPos then
  begin
    Application.MessageBox('Время начала субтитра не может быть больше времени конца!', 'Внимание!!!', mrNone);
    exit;
  end;

  SubTitle := TSubTitles.Create;
  SubTitle.Text.AddStrings(mmSubTitle.Lines);

  SubTitle.TSH := StrToInt(meStart.Text[1]);
  SubTitle.TSM := StrToInt(meStart.Text[3] + meStart.Text[4]);
  SubTitle.TSS := StrToInt(meStart.Text[6] + meStart.Text[7]);
  SubTitle.TSMs := StrToInt(meStart.Text[9] + meStart.Text[10] + meStart.Text[11]);
  SubTitle.SPosition := StartPos;

  SubTitle.TEH := StrToInt(meEnd.Text[1]);
  SubTitle.TEM := StrToInt(meEnd.Text[3] + meEnd.Text[4]);
  SubTitle.TES := StrToInt(meEnd.Text[6] + meEnd.Text[7]);
  SubTitle.TEMs := StrToInt(meEnd.Text[9] + meEnd.Text[10] + meEnd.Text[11]);
  SubTitle.EPosition := EndPos;

  with lvAllSubTitles.Selected do
    begin
      Caption := SubTitle.Text[0];
      SubItems.Text := meStart.Text;
      SubItems.Add(meEnd.Text);
      Data := SubTitle;
    end;
end;

procedure TfmMain.acOpenSubTitlesExecute(Sender: TObject);
var
  SubIn: TStringList;
  SubTitle: TSubTitles;
  i, j, OldI: Integer;
  Text, TextStart, TextEnd: string;
  Playing: Boolean;
begin
  Playing := False;
  if Started then
  case mpPlayer.Mode of
    mpPlaying:
              begin
                mpPlayer.Pause;
                Playing := True;
              end;
  end;

  if lvAllSubTitles.Items.Count > 0 then
  begin
    Beep;
    case Application.MessageBox('Сохранить субтитры?', 'Внимание!!!', mb_IconQuestion + mb_YesNoCancel) of
      idYes: acSaveSubTitles.OnExecute(Sender);
      idCancel:
               begin
                 if Playing then
                   mpPlayer.Play;
                   
                 exit;
               end;
    end;
  end;

  odOpenSubTitles.FileName := VideosName;
  odOpenSubTitles.InitialDir := TitleNow;

  if not odOpenSubTitles.Execute then
    begin
      Screen.Cursor := crDefault;

      if Playing then
        mpPlayer.Play;

      exit;
    end;

  Screen.Cursor := crHourGlass;  

  lvAllSubTitles.Clear;

  SavedSubName := odOpenSubTitles.FileName;
  OldSavedSubName := SavedSubName;
  fmMain.Caption := App_Name + ' - ' + SavedSubName;

  SubIn := TStringList.Create;

  OldI := 0;

  SubIn.LoadFromFile(odOpenSubTitles.FileName);

  fmMain.Repaint;

  pbProgress.Visible := True;

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

  pbProgress.Visible := False;
  Screen.Cursor := crDefault;

  if Playing then
    mpPlayer.Play
end;

procedure TfmMain.acReplaceSubTitleUpdate(Sender: TObject);
begin
  if lvAllSubTitles.ItemIndex = -1 then
    acReplaceSubTitle.Enabled := False
  else
    acReplaceSubTitle.Enabled := True;
end;

procedure TfmMain.acAddSubTitleUpdate(Sender: TObject);
begin
  if Started and (meStart.Text <> ' :  :  ,   ')and(meEnd.Text <> ' :  :  ,   ')
     and(mmSubTitle.Lines.Count > 0) then
    acAddSubTitle.Enabled := True
  else
    acAddSubTitle.Enabled := False;
end;

procedure TfmMain.acSetTimeStartUpdate(Sender: TObject);
begin
  if Started then
    acSetTimeStart.Enabled := True
  else
    acSetTimeStart.Enabled := False;
end;

procedure TfmMain.acSetTimeEndUpdate(Sender: TObject);
begin
  if Started then
    acSetTimeEnd.Enabled := True
  else
    acSetTimeEnd.Enabled := False;
end;

procedure TfmMain.acNewSubTitleUpdate(Sender: TObject);
begin
  if Started then
    acNewSubTitle.Enabled := True
  else
    acNewSubTitle.Enabled := False;
end;

procedure TfmMain.acDelSubTitleUpdate(Sender: TObject);
begin
  if lvAllSubTitles.ItemIndex <> -1 then
    acDelSubTitle.Enabled := True
  else
    acDelSubTitle.Enabled := False;
end;

procedure TfmMain.acDelAllSubTitlesExecute(Sender: TObject);
begin
  Beep;
  case Application.MessageBox('Вы действительно хотите удалить все субтитры?', 'Внимание!!!', mb_IconQuestion + mb_YesNoCancel) of
      idYes: lvAllSubTitles.Clear;
  end;
end;

procedure TfmMain.acDelAllSubTitlesUpdate(Sender: TObject);
begin
  if lvAllSubTitles.Items.Count > 0 then
    acDelAllSubTitles.Enabled := True
  else
    acDelAllSubTitles.Enabled := False;
end;

procedure TfmMain.acSaveSubTitlesUpdate(Sender: TObject);
begin
  if lvAllSubTitles.Items.Count > 0 then
    acSaveSubTitles.Enabled := True
  else
    acSaveSubTitles.Enabled := False;
end;

procedure TfmMain.acOpenSubTitlesUpdate(Sender: TObject);
begin
  if Started then
    acOpenSubTitles.Enabled := True
  else
    acOpenSubTitles.Enabled := False;
end;

procedure TfmMain.acSaveSubTitlesAsExecute(Sender: TObject);
begin
  SavedSubName := '';
  acSaveSubTitles.OnExecute(Sender);
end;

procedure TfmMain.acOpenVideoExecute(Sender: TObject);
var
  i: Integer;
  Video: TVideo;
  Playing: Boolean;
begin
  Playing := False;
  if Started then
  case mpPlayer.Mode of
    mpPlaying:
              begin
                mpPlayer.Pause;
                Playing := True;
              end;
  end;

  if not odOpenVideo.Execute then
    begin
      if Playing then
        mpPlayer.Play;
      Exit;
    end;

  if Started then
  case mpPlayer.Mode of
    mpPlaying: mpPlayer.Pause;
  end;

  lbListOfVideo.Clear;

  for i := 0 to odOpenVideo.Files.Count - 1 do
  begin
    Video := TVideo.Create;

    Video.Path := odOpenVideo.Files[i];

    lbListOfVideo.AddItem(GetName(odOpenVideo.Files[i]), Video);
  end;

  lbListOfVideo.ItemIndex := 0;

  acPlayFromList.OnExecute(Sender);
end;

procedure TfmMain.acClearListOfVideoExecute(Sender: TObject);
begin
  lbListOfVideo.Clear;
end;

procedure TfmMain.acClearListOfVideoUpdate(Sender: TObject);
begin
  if lbListOfVideo.Items.Count > 0 then
    acClearListOfVideo.Enabled := True
  else
    acClearListOfVideo.Enabled := False;
end;

procedure TfmMain.acDelFromListUpdate(Sender: TObject);
begin
  if lbListOfVideo.ItemIndex <> -1 then
    acDelFromList.Enabled := True
  else
    acDelFromList.Enabled := False;
end;

procedure TfmMain.acPlayFromListUpdate(Sender: TObject);
begin
  if lbListOfVideo.ItemIndex <> -1 then
    acPlayFromList.Enabled := True
  else
    acPlayFromList.Enabled := False;
end;

procedure TfmMain.acNewSubTitlesExecute(Sender: TObject);
begin
  if lvAllSubTitles.Items.Count > 0 then
  begin
    Beep;
    case Application.MessageBox('Сохранить субтитры?', 'Внимание!!!', mb_IconQuestion + mb_YesNoCancel) of
      idYes:
            begin
              acSaveSubTitles.OnExecute(Sender);

              SavedSubName := '';
              OldSavedSubName := SavedSubName;
              lvAllSubTitles.Clear;
              mmSubTitle.Clear;
              meStart.Text := '';
              meEnd.Text := '';
            end;
      idNo:
           begin
             SavedSubName := '';
             OldSavedSubName := SavedSubName;
             lvAllSubTitles.Clear;
             mmSubTitle.Clear;
             meStart.Text := '';
             meEnd.Text := '';
           end;
    end;
  end
  else
    begin
      SavedSubName := '';
      OldSavedSubName := SavedSubName;
      lvAllSubTitles.Clear;
      mmSubTitle.Clear;
      meStart.Text := '';
      meEnd.Text := '';
    end;
end;

procedure TfmMain.acAboutExecute(Sender: TObject);
begin
  fmAbout.ShowModal;
end;

procedure TfmMain.acPlayExecute(Sender: TObject);
begin
  if Started then
    Play
  else
    acPlayFromList.OnExecute(Sender);
end;

procedure TfmMain.acPauseExecute(Sender: TObject);
begin
  if Started then
  begin
    //mpPlayer.Pause;

    case mpPlayer.Mode of
      mpPlaying: begin
                   mpPlayer.Pause;
                   TimerPlay.Enabled := False;
                   sbStopVideo.Down := True;
                 end;
      mpPaused: begin
                  mpPlayer.Pause;
                  TimerPlay.Enabled := True;
                end;
    end;
  end;
end;

procedure TfmMain.acSaveSubTitlesAsUpdate(Sender: TObject);
begin
  {(SavedSubName <> '')or(}
  if lvAllSubTitles.Items.Count > 0 then
    acSaveSubTitlesAs.Enabled := True
  else
    acSaveSubTitlesAs.Enabled := False;
end;

procedure TfmMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var
  Playing: Boolean;
begin
  Playing := False;
  if Started then
  case mpPlayer.Mode of
    mpPlaying:
              begin
                mpPlayer.Pause;
                Playing := True;
              end;
  end;

  if lvAllSubTitles.Items.Count > 0 then
  begin
    Beep;
    case Application.MessageBox('Сохранить субтитры?', 'Внимание!!!', mb_IconQuestion + mb_YesNoCancel) of
      idYes: acSaveSubTitles.OnExecute(Sender);
      idCancel:
               begin
                 if Playing then
                   mpPlayer.Play;
                 CanClose := False;
               end;
    end;
  end;

  if Playing then
    mpPlayer.Play;
end;

procedure TfmMain.acStepLeftExecute(Sender: TObject);
var
  Playing: Boolean;
begin
  if mmSubTitle.Focused or meStart.Focused or meEnd.Focused or not Started then
    exit;

  Playing := False;
  case mpPlayer.Mode of
    mpPlaying: Playing := True;
  end; //case

  if mpPlayer.Position - StepLR < 0 then
    mpPlayer.Position := 0
  else
    mpPlayer.Position := mpPlayer.Position - StepLR;

  if Playing then
    mpPlayer.Play
  else
    WriteTime;
end;

procedure TfmMain.acStepRightExecute(Sender: TObject);
var
  Playing: Boolean;
begin
  if mmSubTitle.Focused or meStart.Focused or meEnd.Focused or not Started then
    exit;

  Playing := False;
  case mpPlayer.Mode of
    mpPlaying: Playing := True;
  end; //case

  if mpPlayer.Position + StepLR > mpPlayer.Length then
    mpPlayer.Position := mpPlayer.Length
  else
    mpPlayer.Position := mpPlayer.Position + StepLR;

  if Playing then
    mpPlayer.Play
  else
    WriteTime;
end;


procedure TfmMain.tbVolumeChange(Sender: TObject);
begin
  Volume.vPosition := tbVolume.Position;
  Volume.vVolume := 6500 * Volume.vPosition;
  Volume.vVolume := Volume.vVolume + (Volume.vVolume shl 16);
  WaveOutSetVolume(WAVE_MAPPER, Volume.vVolume);
end;

procedure TfmMain.acVolumeExecute(Sender: TObject);
begin
  if acVolume.ImageIndex = 16 then
    begin
      acVolume.ImageIndex := 17;
    end;
  
end;

procedure TfmMain.mmSubTitleChange(Sender: TObject);
begin
  lbSubTit.Caption := mmSubTitle.Text;
end;



end.
