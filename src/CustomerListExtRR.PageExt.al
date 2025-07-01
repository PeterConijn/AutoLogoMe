pageextension 50171 "Customer List Ext RR" extends "Customer List"
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
                ToolTip = 'Retrieve the company logo from the customer''s home page or email address.';
                trigger OnAction()
                var
                    RetrieveLogo: Codeunit "Retrieve Logo";
                begin
                    RetrieveLogo.RetrieveCustomerLogo();
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
