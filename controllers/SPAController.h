#pragma once

#include <drogon/HttpController.h>


class SPAController : public drogon::HttpController<SPAController>
{
public:
    METHOD_LIST_BEGIN
    ADD_METHOD_VIA_REGEX(SPAController::redirectToIndex, "^(?!/(api|assets|public|js|css|img|fonts|favicon\\.ico|robots\\.txt)).*$", drogon::HttpMethod::Get);

    METHOD_LIST_END

protected:
    drogon::Task<void> redirectToIndex(const drogon::HttpRequestPtr req, std::function<void(const drogon::HttpResponsePtr &)> callback);

};
