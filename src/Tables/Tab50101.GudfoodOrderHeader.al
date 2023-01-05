table 50101 "Gudfood Order Header"
{
    Caption = 'Gudfood Order Header';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;
        }
        field(2; "Sell-to Customer No."; Code[20])
        {
            Caption = 'Sell-to Customer No.';
            DataClassification = CustomerContent;
            TableRelation = Customer;
        }
        field(3; "Sell-to Customer Name"; Text[100])
        {
            Caption = 'Sell-to Customer Name';
            DataClassification = CustomerContent;
        }
        field(4; "Order Date"; Date)
        {
            Caption = 'Order Date';
            DataClassification = CustomerContent;
        }
        field(5; "Posting No."; Code[20])
        {
            Caption = 'Posting No.';
            DataClassification = CustomerContent;
        }
        field(6; "Date Created"; Date)
        {
            Caption = 'Date Created';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(7; "Total Qty"; Decimal)
        {
            Caption = 'Total Qty';
            Editable = false;
            //FieldClass = FlowField;
            //CalcFormula = Sum
        }
        field(8; "Total Amount"; Decimal)
        {
            Caption = 'Total Amount';
            Editable = false;
            //FieldClass = FlowField;
            //CalcFormula = Sum

        }
    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }
}
