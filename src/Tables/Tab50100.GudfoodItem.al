table 50100 "Gudfood Item"
{
    Caption = 'Gudfood Item';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Code; Code[20])
        {
            Caption = 'Code';
            DataClassification = CustomerContent;
            //NotBlank = true;

            trigger OnValidate()
            begin
                if Code <> xRec.Code then begin
                    SalesSetup.Get();
                    NoSeriesMgt.TestManual(SalesSetup."Gudfood Item Nos.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(3; "Unit Price"; Decimal)
        {
            Caption = 'Unit Price';
            DataClassification = CustomerContent;
        }
        field(4; Type; Enum GudfoodItemType)
        {
            Caption = 'Type';
        }
        field(5; "Qty. Ordered"; Decimal)
        {
            Caption = 'Qty. Ordered';
            // FieldClass = FlowField;
            // CalcFormula = 
        }
        field(6; "Qty. in Order"; Decimal)
        {
            Caption = 'Qty. in Order';
            FieldClass = FlowField;
            CalcFormula = Sum("Gudfood Order Line".Quantity where("Order No." = field(Code)));
        }
        field(7; "Shelf Life"; Date)
        {
            Caption = 'Shelf Life';
            DataClassification = CustomerContent;
        }
        field(8; Picture; Media)
        {
            Caption = 'Picture';
            DataClassification = CustomerContent;
        }
        field(9; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
    }
    keys
    {
        key(PK; Code)
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    var
    begin
        if Code = '' then begin
            SalesSetup.Get();
            SalesSetup.TestField("Gudfood Item Nos.");
            NoSeriesMgt.InitSeries(SalesSetup."Gudfood Item Nos.", xRec."No. Series", 0D, "Code", "No. Series");
        end;
    end;

    var
        SalesSetup: Record "Sales & Receivables Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
}
