table 50103 "Posted Gudfood Order Header"
{
    Caption = 'Posted Gudfood Order Header';
    DataClassification = ToBeClassified;


    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;
        }
        field(2; "Sell-to Customer No."; Code[20])
        {
            Caption = 'Sell-to Customer No.';
            DataClassification = ToBeClassified;
        }
        field(3; "Sell-to Customer Name"; Text[100])
        {
            Caption = 'Sell-to Customer Name';
            DataClassification = ToBeClassified;
        }
        field(4; "Order Date"; Date)
        {
            Caption = 'Order Date';
            DataClassification = ToBeClassified;
        }
        field(5; "Posting No."; Code[20])
        {
            Caption = 'Posting No.';
            DataClassification = ToBeClassified;
        }
        field(6; "Date Created"; Date)
        {
            Caption = 'Date Created';
            DataClassification = ToBeClassified;
        }
        field(7; "Total Qty"; Decimal)
        {
            Caption = 'Total Qty';
            FieldClass = FlowField;
            CalcFormula = Sum("Posted Gudfood Order Line".Quantity WHERE("Order No." = field("No.")));
        }
        field(8; "Total Amount"; Decimal)
        {
            Caption = 'Total Amount';
            FieldClass = FlowField;
            CalcFormula = Sum("Posted Gudfood Order Line".Amount WHERE("Order No." = field("No.")));
        }
        field(9; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            DataClassification = ToBeClassified;
        }
        field(10; "Posting Date"; Date)
        {
            Caption = 'Order Date';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    begin
        Rec."Posting Date" := Today;
    end;
}
