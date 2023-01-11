page 50102 "Gudfood Picture"
{
    Caption = 'Gudfood Picture';
    PageType = CardPart;
    SourceTable = "Gudfood Item";
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;

    layout
    {
        area(content)
        {
            group(General)
            {
                field(Picture; Rec.Picture)
                {
                    ApplicationArea = All;
                    ShowCaption = false;
                    ToolTip = 'Specifies the value of the Picture field.';
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
            action(ImportPicture)
            {
                ApplicationArea = All;
                Caption = 'Import';
                Image = Import;
                ToolTip = 'Import a picture file.';
                Visible = HideActions = FALSE;

                trigger OnAction()
                begin
                    ImportFromDevice;
                end;
            }
            action(ExportFile)
            {
                ApplicationArea = All;
                Caption = 'Export';
                Enabled = DeleteExportEnabled;
                Image = Export;
                ToolTip = 'Export the picture to a file.';
                Visible = HideActions = FALSE;

                trigger OnAction()
                var
                    DummyPictureEntity: Record "Picture Entity";
                    FileManagement: Codeunit "File Management";
                    ToFile: Text;
                    ExportPath: Text;
                begin
                    Rec.TestField(Code);
                    Rec.TestField(Description);

                    ToFile := DummyPictureEntity.GetDefaultMediaDescription(Rec);
                    ExportPath := TemporaryPath + Rec.Code + Format(Rec.Picture.MediaId);
                    Rec.Picture.ExportFile(ExportPath + '.' + DummyPictureEntity.GetDefaultExtension);

                    FileManagement.ExportImage(ExportPath, ToFile);
                end;
            }
            action(DeletePicture)
            {
                ApplicationArea = All;
                Caption = 'Delete';
                Enabled = DeleteExportEnabled;
                Image = Delete;
                ToolTip = 'Delete the record.';
                Visible = HideActions = FALSE;

                trigger OnAction()
                begin
                    DeleteItemPicture;
                end;
            }
        }
    }

    var
        CameraAvailable: Boolean;
        HideActions: Boolean;
        DeleteExportEnabled: Boolean;
        DeleteImageQst: Label 'Are you sure you want to delete the picture?';
        MustSpecifyDescriptionErr: Label 'You must add a description to the item before you can import a picture.';
        OverrideImageQst: Label 'The existing picture will be replaced. Do you want to continue?';
        SelectPictureTxt: Label 'Select a picture to upload';

    procedure DeleteItemPicture()
    begin
        Rec.TestField(Code);

        if not Confirm(DeleteImageQst) then
            exit;

        Clear(Rec.Picture);
        Rec.Modify(true);
    end;

    [Scope('OnPrem')]
    procedure ImportFromDevice()
    var
        FileManagement: Codeunit "File Management";
        FileName: Text;
        ClientFileName: Text;
    begin
        Rec.Find;
        Rec.TestField(Code);
        if Rec.Description = '' then
            Error(MustSpecifyDescriptionErr);

        ClientFileName := '';
        FileName := FileManagement.UploadFile(SelectPictureTxt, ClientFileName);
        if FileName = '' then
            Error('');

        Clear(Rec.Picture);
        Rec.Picture.ImportFile(FileName, ClientFileName);
        Rec.Modify(true);

        if FileManagement.DeleteServerFile(FileName) then;
    end;

}
