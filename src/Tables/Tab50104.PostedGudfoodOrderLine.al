table 50104 "Posted Gudfood Order Line"
{
    Caption = 'Posted Gudfood Order Line';
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
        }
        field(4; "Date Created"; Date)
        {
            Caption = 'Date Created';
            DataClassification = ToBeClassified;
        }
        field(5; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            DataClassification = ToBeClassified;
        }
        field(6; "Item Type"; Enum GudfoodItemType)
        {
            Caption = 'Item Type';
            FieldClass = FlowField;
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
        }
        field(9; "Unit Price"; Decimal)
        {
            Caption = 'Unit Price';
            DataClassification = ToBeClassified;
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
}
