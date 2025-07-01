codeunit 50170 "Retrieve Logo"
{
    Access = Public;
    InherentEntitlements = X;
    InherentPermissions = X;

    var
        RetrieveCustLogoImpl: Codeunit "Retrieve Cust. Logo Impl.";
        RetrieveVendorLogoImpl: Codeunit "Retrieve Vend. Logo Impl.";

    /// <summary>
    /// Retrieves the logo for all customers that have a home page or email address.
    /// </summary>
    procedure RetrieveCustomerLogo()
    begin
        RetrieveCustLogoImpl.RetrieveCustomerLogo();
    end;

    /// <summary>
    /// Retrieves the logo for a specific customer.
    /// The logo is retrieved from the customer's home page or email address.
    /// </summary>
    procedure RetrieveCustomerLogo(var Customer: Record Customer)
    begin
        RetrieveCustLogoImpl.RetrieveCustomerLogo(Customer);
    end;

    /// <summary>
    /// Retrieves the logo for all vendors that have a home page or email address.
    /// </summary>
    procedure RetrieveVendorLogo()
    begin
        RetrieveVendorLogoImpl.RetrieveVendorLogo();
    end;

    /// <summary>
    /// Retrieves the logo for a specific vendor.
    /// The logo is retrieved from the vendor's home page or email address.
    /// </summary>
    procedure RetrieveVendorLogo(var Vendor: Record Vendor)
    begin
        RetrieveVendorLogoImpl.RetrieveVendorLogo(Vendor);
    end;
}
