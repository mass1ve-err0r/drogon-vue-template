//
// Created by Saadat Baig on 04.02.25.
//
#include "HealthController.h"


drogon::Task<void> HealthController::checkHealth(const drogon::HttpRequestPtr req, std::function<void(const drogon::HttpResponsePtr &)> callback)
{
    auto res = drogon::HttpResponse::newHttpResponse(drogon::HttpStatusCode::k200OK, drogon::ContentType::CT_TEXT_PLAIN);
    res->setBody("OK");

    co_return callback(res);
}
