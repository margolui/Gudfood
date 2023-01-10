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
                var
                    PostedGudfoodOrderHeader: Record "Posted Gudfood Order Header";
                    NoSeries: Record "No. Series";

                begin
                    PostedGudfoodOrderHeader.TransferFields(Rec);
                    PostedGudfoodOrderHeader."No." := '';

                    if Rec."Posting No." = '' then begin
                        SalesSetup.Get();
                        SalesSetup.TestField("Gudfood Item Nos.");
                        NoSeriesMgt.InitSeries(SalesSetup."Posted Gudfood Order Nos.", xRec."No. Series", 0D, PostedGudfoodOrderHeader."No.", PostedGudfoodOrderHeader."No. Series");
                    end
                    else
                        PostedGudfoodOrderheader."No." := Rec."Posting No.";

                    PostedGudfoodOrderHeader.Insert(true);

                end;

            }
        }
    }
    var
        SalesSetup: Record "Sales & Receivables Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
}
