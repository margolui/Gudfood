pageextension 50100 SalesReceivablesSetupPageExt extends "Sales & Receivables Setup"
{
    layout
    {
        addafter("Customer Nos.")
        {
            field("Gudfood Item Nos."; Rec."Gudfood Item Nos.")
            {
                Caption = 'Gudfood Item Nos.';
                ApplicationArea = All;
            }
            field("Gudfood Order Nos."; Rec."Gudfood Order Nos.")
            {
                Caption = 'Gudfood Order Nos.';
                ApplicationArea = All;
            }
            field("Posted Gudfood Order Nos."; Rec."Posted Gudfood Order Nos.")
            {
                Caption = 'Posted Gudfood Order Nos.';
                ApplicationArea = All;
            }
        }
    }
}
