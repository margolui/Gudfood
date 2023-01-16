table 50102 "Gudfood Order Line"
{
    Caption = 'Gudfood Order Line';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Order No."; Code[20])
        {
            Caption = 'Order No.';
            DataClassification = ToBeClassified;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = ToBeClassified;
        }
        field(3; "Sell- to Customer  No."; Code[20])
        {
            Caption = 'Sell- to Customer  No.';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(4; "Date Created"; Date)
        {
            Caption = 'Date Created';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(5; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            DataClassification = ToBeClassified;
            TableRelation = "Gudfood Item";

            trigger OnValidate()
            var
                GudFoodItem: Record "Gudfood Item";
            begin
                if Rec."Item No." = '' then
                    exit;

                GudfoodItem.Get("Item No.");
                Rec.Description := GudfoodItem.Description;
                Rec."Unit Price" := GudFoodItem."Unit Price";

                Amount := Quantity * "Unit Price";

                if GudFoodItem."Shelf Life" < Today then
                    Message('The expiration date has passed');
            end;
        }
        field(6; "Item Type"; Enum GudfoodItemType)
        {
            Caption = 'Item Type';
            FieldClass = FlowField;
            CalcFormula = lookup("Gudfood Item".Type where(Code = field("Item No.")));
        }
        field(7; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(8; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DataClassification = ToBeClassified;
            MinValue = 0;
            trigger OnValidate()
            var
                GudfoodItem: Record "Gudfood Item";
            begin
                Amount := Quantity * "Unit Price";
            end;
        }
        field(9; "Unit Price"; Decimal)
        {
            Caption = 'Unit Price';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(10; Amount; Decimal)
        {
            Caption = 'Amount';
            DataClassification = ToBeClassified;
        }
        field(11; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            Editable = false;
            TableRelation = "Dimension Set Entry";

            trigger OnLookup()
            begin
                ShowDimensions();
            end;

            trigger OnValidate()
            begin
                DimMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
            end;
        }
        field(40; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1),
                                                          Blocked = CONST(false));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
            end;
        }
        field(41; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2),
                                                          Blocked = CONST(false));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
            end;
        }
    }
    keys
    {
        key(PK; "Order No.", "Line No.")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    var
        GudfoodOrderHeader: Record "Gudfood Order Header";
    begin
        GudfoodOrderHeader.Get("Order No.");
        Rec."Sell- to Customer  No." := GudfoodOrderHeader."Sell-to Customer No.";
        Rec."Date Created" := GudfoodOrderHeader."Order Date";
    end;

    procedure ShowDimensions() IsChanged: Boolean
    var
        OldDimSetID: Integer;
    begin

        OldDimSetID := "Dimension Set ID";
        "Dimension Set ID" :=
          DimMgt.EditDimensionSet("Dimension Set ID", StrSubstNo('%1 %2 %3', "Order No.", "Line No."));
        DimMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
        IsChanged := OldDimSetID <> "Dimension Set ID";

    end;

    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
    end;

    var
        DimMgt: Codeunit DimensionManagement;
        ATOLink: Record "Assemble-to-Order Link";
}
