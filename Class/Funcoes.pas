unit Funcoes;

interface

uses Winapi.Windows,
     Winapi.Messages,
     System.SysUtils,
     Vcl.Dialogs,
     Vcl.Forms;

function CriaForm(Owner, Formulario: TForm; ClasseFormulario: TFormClass; Modal: Boolean; Sender: TObject = nil): TFormClass;

implementation

function CriaForm(Owner, Formulario: TForm; ClasseFormulario: TFormClass; Modal: Boolean; Sender: TObject = nil): TFormClass;
begin
    Formulario := nil;

    if not Assigned(Formulario) then
        Formulario := TFormClass(ClasseFormulario).Create(Owner);

    with Formulario do
    begin
        if WindowState = wsMinimized then
            WindowState := wsNormal;
        if Modal then
        begin
            FormStyle := fsNormal;
            ShowModal;
            Result := nil;
        end
        else
        begin
            if DebugHook = 0 then
                Formulario.FormStyle := fsStayOnTop;
            Show;
            Result := TFormClass(Formulario);
        end;
    end;
end;

end.
