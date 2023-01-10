report 50100 "Gudfood Order"
{
    Caption = 'Gudfood Order';
    RDLCLayout = '.\src\Reports\RDLC\Gudfood Order.rdl';
    dataset
    {
        dataitem(GudfoodOrderHeader; "Gudfood Order Header")
        {
            column(DateCreated; "Date Created")
            {
                IncludeCaption = true;
            }
            column(No; "No.")
            {
                IncludeCaption = true;
            }
            column(NoSeries; "No. Series")
            {
                IncludeCaption = true;
            }
            column(OrderDate; "Order Date")
            {
                IncludeCaption = true;
            }
            column(PostingNo; "Posting No.")
            {
                IncludeCaption = true;
            }
            column(SelltoCustomerName; "Sell-to Customer Name")
            {
                IncludeCaption = true;
            }
            column(SelltoCustomerNo; "Sell-to Customer No.")
            {
                IncludeCaption = true;
            }
            column(TotalAmount; "Total Amount")
            {
                IncludeCaption = true;
            }
            column(TotalQty; "Total Qty")
            {
                IncludeCaption = true;
            }

            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }

            dataitem(GudfoodOrderLine; "Gudfood Order Line")
            {
                DataItemLink = "Order No." = field("No.");

                column(Code_GudfoodItem; GudfoodItem.Code)
                {
                    IncludeCaption = true;
                }
                column(Type_GudfoodItem; GudfoodItem.Type)
                {
                    IncludeCaption = true;
                }
                column(Description_GudfoodItem; GudfoodItem.Description)
                {
                    IncludeCaption = true;
                }
                column(Quantity_GudfoodOrderLine; GudfoodOrderLine.Quantity)
                {
                    IncludeCaption = true;
                }
                column(UnitPrice_GudfoodOrderLine; GudfoodOrderLine."Unit Price")
                {
                    IncludeCaption = true;
                }
                column(Amount_GudfoodOrderLine; GudfoodOrderLine.Amount)
                {
                    IncludeCaption = true;
                }

                trigger OnAfterGetRecord()
                begin
                    if GudfoodOrderLine."Item No." <> '' then
                        GudfoodItem.Get(GudfoodOrderLine."Item No.")
                    else
                        Clear(GudfoodItem);
                end;
            }

        }
    }

    var
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        GudfoodItem: Record "Gudfood Item";

}
