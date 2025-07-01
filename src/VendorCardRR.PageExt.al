pageextension 50172 "Vendor Card RR" extends "Vendor Card"
{
    actions
    {
        addlast(Processing)
        {
            action("Retrieve Logo")
            {
                ApplicationArea = All;
                Caption = 'Retrieve Logo';
                Image = Picture;
                ToolTip = 'Retrieve the company logo from the vendor''s home page or email address.';
                trigger OnAction()
                var
                    RetrieveLogo: Codeunit "Retrieve Logo";
                begin
                    RetrieveLogo.RetrieveVendorLogo(Rec);
                end;
            }
        }
        addlast(Category_Process)
        {
            actionref("Retrieve Logo_Promoted"; "Retrieve Logo")
            {
            }
        }
    }
}
