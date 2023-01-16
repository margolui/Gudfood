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
                    NoSeriesMgt.TestManual(SalesSetup."Gudfood Order Nos.");
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
                if Rec."Sell-to Customer No." = '' then
                    exit;

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
        field(29; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1),
                                                          Blocked = CONST(false));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
            end;
        }
        field(30; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2),
                                                          Blocked = CONST(false));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
            end;
        }
        field(480; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            Editable = false;
            TableRelation = "Dimension Set Entry";

            trigger OnLookup()
            begin
                ShowDocDim;
            end;

            trigger OnValidate()
            begin
                DimMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
            end;
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
            SalesSetup.TestField("Gudfood Order Nos.");
            NoSeriesMgt.InitSeries(SalesSetup."Gudfood Order Nos.", xRec."No. Series", 0D, "No.", "No. Series");
        end;
    end;



    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    var
        OldDimSetID: Integer;
    begin
        OldDimSetID := "Dimension Set ID";
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
        if "No." <> '' then
            Modify;

        if OldDimSetID <> "Dimension Set ID" then begin
            Modify;
            if GudfoodLinesExist then
                UpdateAllLineDim("Dimension Set ID", OldDimSetID);
        end;
    end;

    procedure GudfoodLinesExist(): Boolean
    begin
        GudfoodOrderLine.Reset();
        GudfoodOrderLine.SetRange("Order No.", "No.");
        exit(not GudfoodOrderLine.IsEmpty);
    end;

    procedure ShowDocDim()
    var
        OldDimSetID: Integer;
    begin

        OldDimSetID := "Dimension Set ID";
        "Dimension Set ID" :=
          DimMgt.EditDimensionSet(
            "Dimension Set ID", StrSubstNo('%1 %2', "No."),
            "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
        if OldDimSetID <> "Dimension Set ID" then begin
            Modify;
            if GudfoodLinesExist then
                UpdateAllLineDim("Dimension Set ID", OldDimSetID);
        end;
    end;

    procedure UpdateAllLineDim(NewParentDimSetID: Integer; OldParentDimSetID: Integer)
    var
        NewDimSetID: Integer;
        ShippedReceivedItemLineDimChangeConfirmed: Boolean;
    begin

        if NewParentDimSetID = OldParentDimSetID then
            exit;

        GudfoodOrderLine.Reset();
        GudfoodOrderLine.SetRange("Order No.", "No.");
        GudfoodOrderLine.LockTable();
        if GudfoodOrderLine.FindFirst() then
            repeat
                NewDimSetID := DimMgt.GetDeltaDimSetID(GudfoodOrderLine."Dimension Set ID", NewParentDimSetID, OldParentDimSetID);

                if GudfoodOrderLine."Dimension Set ID" <> NewDimSetID then begin
                    GudfoodOrderLine."Dimension Set ID" := NewDimSetID;

                    DimMgt.UpdateGlobalDimFromDimSetID(
                      GudfoodOrderLine."Dimension Set ID", GudfoodOrderLine."Shortcut Dimension 1 Code", GudfoodOrderLine."Shortcut Dimension 2 Code");


                    GudfoodOrderLine.Modify();
                end;
            until GudfoodOrderLine.Next() = 0;
    end;

    procedure CreateDim(Type1: Integer; No1: Code[20])
    var
        SourceCodeSetup: Record "Source Code Setup";
        TableID: array[10] of Integer;
        No: array[10] of Code[20];
        OldDimSetID: Integer;
    begin

        SourceCodeSetup.Get();
        TableID[1] := Type1;
        No[1] := No1;

        "Shortcut Dimension 1 Code" := '';
        "Shortcut Dimension 2 Code" := '';
        OldDimSetID := "Dimension Set ID";
        "Dimension Set ID" :=
            DimMgt.GetRecDefaultDimID(
                Rec, CurrFieldNo, TableID, No, SourceCodeSetup.Sales, "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code", 0, 0);

        if (OldDimSetID <> "Dimension Set ID") and GudfoodLinesExist then begin
            Modify;
            UpdateAllLineDim("Dimension Set ID", OldDimSetID);
        end;
    end;

    local procedure CreateDimensionsFromValidateBillToCustomerNo()
    begin
        CreateDim(DATABASE::Customer, Rec."Sell-to Customer No.");
    end;

    var
        SalesSetup: Record "Sales & Receivables Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        DimMgt: Codeunit DimensionManagement;
        GudfoodOrderLine: Record "Gudfood Order Line";
}
