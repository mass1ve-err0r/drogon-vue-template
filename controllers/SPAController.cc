#include "SPAController.h"


drogon::Task<void> SPAController::redirectToIndex(const drogon::HttpRequestPtr req, std::function<void(const drogon::HttpResponsePtr &)> callback)
{
    auto res = drogon::HttpResponse::newFileResponse("./public/index.html");
    res->setStatusCode(drogon::HttpStatusCode::k200OK);

    co_return callback(res);
}
