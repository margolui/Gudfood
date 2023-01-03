table 50100 "Gudfood Item"
{
    Caption = 'Gudfood Item';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Code; Code[20])
        {
            Caption = 'Code';
            DataClassification = ToBeClassified;
        }
        field(2; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(3; "Unit Price"; Decimal)
        {
            Caption = 'Unit Price';
            DataClassification = ToBeClassified;
        }
        field(4; "Type"; Option)
        {
            Caption = 'Type';

            OptionCaption = ''',Salat, Burder, Capcake, Drink';
            OptionMembers = Salat, Burder;
        }
        field(5; "Qty. Ordered"; Decimal)
        {
            Caption = 'Qty. Ordered';
            DataClassification = ToBeClassified;
        }
        field(6; "Qty. in Order"; Decimal)
        {
            Caption = 'Qty. in Order';
            DataClassification = ToBeClassified;
        }
        field(7; "Shelf Life"; Date)
        {
            Caption = 'Shelf Life';
            DataClassification = ToBeClassified;
        }
        field(8; Picture; Media)
        {
            Caption = 'Picture';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; Description)
        {
            Clustered = true;
        }
    }
}
