page 50100 "Gudfood Item List"
{
    ApplicationArea = All;
    Caption = 'Gudfood Item List';
    PageType = List;
    SourceTable = "Gudfood Item";
    UsageCategory = Lists;
    Editable = false;
    InsertAllowed = true;
    CardPageId = "Gudfood Item Card";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Code"; Rec."Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Type"; Rec."Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Type field.';
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Unit Price field.';
                }
                field("Qty. Ordered"; Rec."Qty. Ordered")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Qty. Ordered field.';
                }
                field(Picture; Rec.Picture)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Picture field.';
                }
                field("Qty. in Order"; Rec."Qty. in Order")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Qty. in Order field.';
                }
                field("Shelf Life"; Rec."Shelf Life")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Shelf Life field.';
                }
            }
        }
    }
}
