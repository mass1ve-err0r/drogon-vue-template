//
// Created by Saadat Baig on 04.02.25.
//
#pragma once
#include <drogon/HttpController.h>


class HealthController : public drogon::HttpController<HealthController>
{
public:
    METHOD_LIST_BEGIN
    ADD_METHOD_TO(HealthController::checkHealth, "/api/health", drogon::HttpMethod::Get);
    METHOD_LIST_END

protected:
    drogon::Task<void> checkHealth(const drogon::HttpRequestPtr req, std::function<void(const drogon::HttpResponsePtr &)> callback);

};
