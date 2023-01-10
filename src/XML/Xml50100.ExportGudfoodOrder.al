xmlport 50100 "Export Gudfood Order"
{
    Caption = 'Export Gudfood Order';
    Direction = Export;
    Format = Xml;
    UseRequestPage = false;

    schema
    {
        textelement(RootNodeName)
        {
            tableelement(GudfoodOrderHeader; "Gudfood Order Header")
            {
                fieldelement(DateCreated; GudfoodOrderHeader."Date Created")
                {
                }
                fieldelement(No; GudfoodOrderHeader."No.")
                {
                }
                fieldelement(NoSeries; GudfoodOrderHeader."No. Series")
                {
                }
                fieldelement(OrderDate; GudfoodOrderHeader."Order Date")
                {
                }
                fieldelement(PostingNo; GudfoodOrderHeader."Posting No.")
                {
                }
                fieldelement(SelltoCustomerName; GudfoodOrderHeader."Sell-to Customer Name")
                {
                }
                fieldelement(SelltoCustomerNo; GudfoodOrderHeader."Sell-to Customer No.")
                {
                }
                fieldelement(TotalAmount; GudfoodOrderHeader."Total Amount")
                {
                }
                fieldelement(TotalQty; GudfoodOrderHeader."Total Qty")
                {
                }
                tableelement(GudfoodOrderLine; "Gudfood Order Line")
                {

                    fieldelement(OrderNo; GudfoodOrderLine."Order No.")
                    {
                    }
                    fieldelement(LineNo; GudfoodOrderLine."Line No.")
                    {

                    }
                    fieldelement(SelltoCustomerNo; GudfoodOrderLine."Sell- to Customer  No.")
                    {
                    }
                    fieldelement(DateCreated; GudfoodOrderLine."Date Created")
                    {
                    }
                    fieldelement(ItemNo; GudfoodOrderLine."Item No.")
                    {
                    }
                    fieldelement(ItemType; GudfoodOrderLine."Item Type")
                    {
                    }
                    fieldelement(Description; GudfoodOrderLine.Description)
                    {
                    }
                    fieldelement(Quantity; GudfoodOrderLine."Quantity")
                    {
                    }
                    fieldelement(UnitPrice; GudfoodOrderLine."Unit Price")
                    {
                    }
                    fieldelement(Amount; GudfoodOrderLine.Amount)
                    {
                    }

                    trigger OnPreXmlItem()
                    begin
                        GudfoodOrderLine.SetRange("Order No.", GudfoodOrderHeader."No.");
                    end;
                }
            }

        }

    }
}
