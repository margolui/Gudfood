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

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    SalesSetup.Get();
                    NoSeriesMgt.TestManual(SalesSetup."Gudfood Item Nos.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Sell-to Customer No."; Code[20])
        {
            Caption = 'Sell-to Customer No.';
            DataClassification = CustomerContent;
            TableRelation = Customer;

            trigger OnValidate()
            var
                Customer: Record Customer;
            begin


                Customer.Get("Sell-to Customer No.");
                Rec."Sell-to Customer Name" := Customer.Name;
            end;

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
            FieldClass = FlowField;
            CalcFormula = Sum("Gudfood Order Line".Quantity WHERE("Order No." = field("No.")));
        }
        field(8; "Total Amount"; Decimal)
        {
            Caption = 'Total Amount';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Sum("Gudfood Order Line".Amount WHERE("Order No." = field("No.")));
        }
        field(9; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
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
        Rec."Order Date" := Today;

        if "No." = '' then begin
            SalesSetup.Get();
            SalesSetup.TestField("Gudfood Item Nos.");
            NoSeriesMgt.InitSeries(SalesSetup."Gudfood Item Nos.", xRec."No. Series", 0D, "No.", "No. Series");
        end;
    end;

    var
        SalesSetup: Record "Sales & Receivables Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
}
