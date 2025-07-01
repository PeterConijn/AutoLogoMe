// ------------------------------------------------------------------------------------------------
// Copyright (c) Peter Conijn. All rights reserved.
// Licensed under the MIT License. See License in the project root for license information.
// ------------------------------------------------------------------------------------------------

namespace RabbitRamblings.AutoLogoMe;

using Microsoft.Purchases.Vendor;

codeunit 50172 "Retrieve Vend. Logo Impl."
{
    Access = Internal;
    InherentEntitlements = X;
    InherentPermissions = X;
    Permissions = tabledata "Vendor" = R;

    var
        RequestHandlerRR: Codeunit "Request Handler RR";
        IsBatch: Boolean;

    procedure RetrieveVendorLogo()
    var
        Vendor: Record Vendor;
    begin
        Vendor.ReadIsolation := IsolationLevel::ReadUncommitted;

        Vendor.FilterGroup(-1);
#pragma warning disable AL0432
        Vendor.SetFilter("Home Page", '<>%1', '');
#pragma warning restore AL0432
        Vendor.SetFilter("E-Mail", '<>%1', '');
        Vendor.FilterGroup(0);

        IsBatch := true;

        if Vendor.FindSet() then
            repeat
                this.RetrieveVendorLogo(Vendor);
            until Vendor.Next() = 0;

        IsBatch := false;
    end;

    procedure RetrieveVendorLogo(var Vendor: Record Vendor)
    var
        DescriptionLbl: Label 'Lobo_%1.png', Comment = '%1 = Customer Name';
        ResponseMessage: HttpResponseMessage;
        InStream: InStream;
        Domain: Text;
    begin
#pragma warning disable AL0432
        Domain := Vendor."Home Page";
#pragma warning restore AL0432
        if Domain = '' then
            if Vendor."E-Mail" <> '' then
                Domain := this.GetDomainFromEmail(Vendor."E-Mail");

        if Domain = '' then
            exit;

        if not this.RetrieveCustomerLogo(Domain, ResponseMessage) then
            exit;

        ResponseMessage.Content.ReadAs(InStream);
        Vendor.Image.ImportStream(InStream, StrSubstNo(DescriptionLbl, Vendor.Name), 'image/apng');
        Vendor.Modify(true);
    end;

    local procedure GetDomainFromEmail(EMail: Text[80]): Text
    var
        Emails: List of [Text];
    begin
        Emails := EMail.Split(';');
        if Emails.Count() = 0 then
            exit('');

        exit(Emails.Get(1).Split('@').Get(2).Trim());
    end;

    local procedure RetrieveCustomerLogo(Domain: Text; var ResponseMessage: HttpResponseMessage): Boolean
    begin
        if this.IsBatch then
            RequestHandlerRR.SetBatchMode();
        exit(RequestHandlerRR.RetrieveLogo(Domain, ResponseMessage));
    end;
}
