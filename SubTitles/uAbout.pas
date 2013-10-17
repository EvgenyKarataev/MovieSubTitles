unit uAbout;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ShellApi, jpeg;

type
  TfmAbout = class(TForm)
    Label47: TLabel;
    Image1: TImage;
    Bevel8: TBevel;
    Label43: TLabel;
    Label44: TLabel;
    Bevel1: TBevel;
    Label42: TLabel;
    Label41: TLabel;
    lbAuthor: TLabel;
    Label45: TLabel;
    procedure lbAuthorClick(Sender: TObject);
    procedure lbAuthorMouseEnter(Sender: TObject);
    procedure lbAuthorMouseLeave(Sender: TObject);
    procedure FormClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmAbout: TfmAbout;

implementation

{$R *.dfm}

procedure TfmAbout.lbAuthorClick(Sender: TObject);
begin
  ShellExecute(Self.Handle, 'open', PChar(Format('mailto:karataevevgeniy@mail.ru?Subject="%s"', ['Clock'])), nil, nil, SW_SHOW);
end;

procedure TfmAbout.lbAuthorMouseEnter(Sender: TObject);
begin
  TLabel(Sender).Font.Color := clBlue;
end;

procedure TfmAbout.lbAuthorMouseLeave(Sender: TObject);
begin
  TLabel(Sender).Font.Color := clWindowText;
end;

procedure TfmAbout.FormClick(Sender: TObject);
begin
  Self.ModalResult := mrOk;
end;

end.
