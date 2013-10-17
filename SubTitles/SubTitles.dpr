program SubTitles;

uses
  Forms,
  uMain in 'uMain.pas' {fmMain},
  uAbout in 'uAbout.pas' {fmAbout};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'SubTitles';
  Application.CreateForm(TfmMain, fmMain);
  Application.CreateForm(TfmAbout, fmAbout);
  Application.Run;
end.
