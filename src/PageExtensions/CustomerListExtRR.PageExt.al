// ------------------------------------------------------------------------------------------------
// Copyright (c) Peter Conijn. All rights reserved.
// Licensed under the MIT License. See License in the project root for license information.
// ------------------------------------------------------------------------------------------------

namespace RabbitRamblings.AutoLogoMe;

using Microsoft.Sales.Customer;

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
