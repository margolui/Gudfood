codeunit 50100 "Posted Gudfood Orders"
{
    TableNo = "Gudfood Order Header";

    trigger OnRun()
    var
        PostedGudfoodOrderHeader: Record "Posted Gudfood Order Header";
        NoSeries: Record "No. Series";
        SalesSetup: Record "Sales & Receivables Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        PostedGudfoodOrderLine: Record "Posted Gudfood Order Line";
        GudfoodOrderLine: Record "Gudfood Order Line";
    begin
        PostedGudfoodOrderHeader.TransferFields(Rec);
        PostedGudfoodOrderHeader."No." := '';

        if Rec."Posting No." = '' then begin
            SalesSetup.Get();
            SalesSetup.TestField("Gudfood Item Nos.");
            NoSeriesMgt.InitSeries(SalesSetup."Posted Gudfood Order Nos.", Rec."No. Series", 0D, PostedGudfoodOrderHeader."No.", PostedGudfoodOrderHeader."No. Series");
        end
        else
            PostedGudfoodOrderheader."No." := Rec."Posting No.";
        PostedGudfoodOrderHeader.Insert(true);

        GudfoodOrderLine.SetRange("Order No.", Rec."No.");
        if GudfoodOrderLine.FindSet() then
            repeat
                PostedGudfoodOrderLine.TransferFields(GudfoodOrderLine);
                PostedGudfoodOrderLine."Order No." := PostedGudfoodOrderHeader."No.";
                PostedGudfoodOrderLine.Insert();
            until GudfoodOrderLine.Next() = 0;

        Rec.Delete();
        GudfoodOrderLine.DeleteAll();
    end;
}
