codeunit 50171 "Retrieve Cust. Logo Impl."
{
    Access = Internal;
    InherentEntitlements = X;
    InherentPermissions = X;
    Permissions = tabledata Customer = R;

    var
        RequestHandlerRR: Codeunit "Request Handler RR";
        IsBatch: Boolean;

    procedure RetrieveCustomerLogo()
    var
        Customer: Record Customer;
    begin
        Customer.ReadIsolation := IsolationLevel::ReadUncommitted;

        Customer.FilterGroup(-1);
#pragma warning disable AL0432
        Customer.SetFilter("Home Page", '<>%1', '');
#pragma warning restore AL0432
        Customer.SetFilter("E-Mail", '<>%1', '');
        Customer.FilterGroup(0);

        IsBatch := true;

        if Customer.FindSet() then
            repeat
                this.RetrieveCustomerLogo(Customer);
            until Customer.Next() = 0;

        IsBatch := false;
    end;

    procedure RetrieveCustomerLogo(var Customer: Record Customer)
    var
        DescriptionLbl: Label 'Lobo_%1.png', Comment = '%1 = Customer Name';
        ResponseMessage: HttpResponseMessage;
        InStream: InStream;
        Domain: Text;
    begin
#pragma warning disable AL0432
        Domain := Customer."Home Page";
#pragma warning restore AL0432
        if Domain = '' then
            if Customer."E-Mail" <> '' then
                Domain := this.GetDomainFromEmail(Customer."E-Mail");

        if Domain = '' then
            exit;

        if not this.RetrieveCustomerLogo(Domain, ResponseMessage) then
            exit;

        ResponseMessage.Content.ReadAs(InStream);
        Customer.Image.ImportStream(InStream, StrSubstNo(DescriptionLbl, Customer.Name), 'image/apng');
        Customer.Modify(true);
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
