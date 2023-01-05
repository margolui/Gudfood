tableextension 50100 SalesReceivablesSetupExt extends "Sales & Receivables Setup"
{
    fields
    {
        field(50100; "Gudfood Item Nos."; Code[20])
        {
            Caption = 'Gudfood Item Nos.';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(50101; "Gudfood Order Nos."; Code[20])
        {
            Caption = 'Gudfood Order Nos.';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(50102; "Posted Gudfood Order Nos."; Code[20])
        {
            Caption = 'Posted Gudfood Order Nos.';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
    }
}
