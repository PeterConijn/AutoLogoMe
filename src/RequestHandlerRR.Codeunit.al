codeunit 50173 "Request Handler RR"
{
    Access = Internal;
    InherentEntitlements = X;
    InherentPermissions = X;

    var
        Client: HttpClient;
        IsBatch: Boolean;

    procedure RetrieveLogo(Domain: Text; var ResponseMessage: HttpResponseMessage): Boolean
    begin
        if Domain = '' then
            exit;

        case false of
            this.Client.Get('https://logo.clearbit.com/' + Domain, ResponseMessage),
            ResponseMessage.IsSuccessStatusCode:
                exit(this.HandleError(ResponseMessage));
        end;

        exit(true);
    end;

    procedure SetBatchMode()
    begin
        IsBatch := true;
    end;

    local procedure HandleError(ResponseMessage: HttpResponseMessage): Boolean
    var
        BlockedByEnvironmentErr: Label 'The request to retrieve the logo was blocked by the environment. Please enable the Http Client calls for the app "%1" in extension management.', Comment = '%1 = App Name';
        ResponseErr: Label 'Request for logo failed with status code %1: %2. Please check the URL and try again.', Comment = '%1 = Http Status Code, %2 = Reason Phrase';
        CurrentModule: ModuleInfo;
    begin
        if IsBatch or not GuiAllowed() then
            exit;

        if ResponseMessage.IsBlockedByEnvironment() then begin
            NavApp.GetCurrentModuleInfo(CurrentModule);
            Error(BlockedByEnvironmentErr, CurrentModule.Name);
        end;

        Error(ResponseErr, ResponseMessage.HttpStatusCode(), ResponseMessage.ReasonPhrase());
    end;
}
