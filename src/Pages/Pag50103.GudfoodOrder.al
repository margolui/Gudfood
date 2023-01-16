page 50103 "Gudfood Order"
{
    Caption = 'Gudfood Order';
    PageType = Document;
    SourceTable = "Gudfood Order Header";


    layout
    {
        area(content)
        {
            group(General)
            {
                field("Date Created"; Rec."Date Created")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date Created field.';
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field("Order Date"; Rec."Order Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Order Date field.';
                }
                field("Posting No."; Rec."Posting No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Posting No. field.';
                }
                field("Sell-to Customer Name"; Rec."Sell-to Customer Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Sell-to Customer Name field.';
                }
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Sell-to Customer No. field.';
                }
                field("Total Amount"; Rec."Total Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Total Amount field.';
                }
                field("Total Qty"; Rec."Total Qty")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Total Qty field.';
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = Dimensions;
                    ToolTip = 'Specifies the code for Shortcut Dimension 1, which is one of two global dimension codes that you set up in the General Ledger Setup window.';

                    trigger OnValidate()
                    begin
                        ShortcutDimension1CodeOnAfterV;
                    end;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = Dimensions;
                    ToolTip = 'Specifies the code for Shortcut Dimension 2, which is one of two global dimension codes that you set up in the General Ledger Setup window.';

                    trigger OnValidate()
                    begin
                        ShortcutDimension2CodeOnAfterV;
                    end;
                }
            }
            part(GudfoodOrderSubform; "Gudfood Order Subform")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "Order No." = FIELD("No.");
                UpdatePropagation = Both;
            }
        }
    }

    actions
    {
        area(Navigation)
        {
            action(OrderReport)
            {
                ApplicationArea = All;
                Caption = 'Print';
                Image = Report;

                trigger OnAction()
                var
                    GudFoodOrder: Report "Gudfood Order";
                    GudFoodOrderHeader: Record "GudFood Order Header";
                begin
                    GudFoodOrderHeader.Get(Rec."No.");
                    GudFoodOrderHeader.SetRecFilter();

                    report.RunModal(Report::"Gudfood Order", true, false, Rec);
                end;
            }
            action(OrderPost)
            {
                ApplicationArea = All;
                Caption = 'Post';
                Image = Post;

                trigger OnAction()
                begin
                    Codeunit.Run(50100, Rec);
                end;

            }
            action(ExportGudfoodOrder)
            {
                Caption = 'Export Gudfood Order';
                Promoted = true;
                PromotedCategory = Process;
                Image = Export;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    Xmlport.Run(50100, true, false);
                end;
            }
            action(Dimensions)
            {
                AccessByPermission = TableData Dimension = R;
                ApplicationArea = Dimensions;
                Caption = 'Dimensions';
                Enabled = Rec."No." <> '';
                Image = Dimensions;
                ShortCutKey = 'Alt+D';
                ToolTip = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.';

                trigger OnAction()
                begin
                    Rec.ShowDocDim;
                    CurrPage.SaveRecord;
                end;
            }
        }
    }
    local procedure ShortcutDimension1CodeOnAfterV()
    begin
        CurrPage.Update();
    end;

    local procedure ShortcutDimension2CodeOnAfterV()
    begin
        CurrPage.Update();
    end;
}
