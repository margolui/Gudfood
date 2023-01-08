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
            FieldClass = FlowField; //FlowField на “Gudfood Item”.Type
            CalcFormula = lookup("Gudfood Item".Type where(Code = field("Order No.")));
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
}
