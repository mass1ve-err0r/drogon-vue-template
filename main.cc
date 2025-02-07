#include "main.h"


int main() {
    drogon::app()
            .setDocumentRoot("./public")
            .setStaticFilesCacheTime(86400)
            .addListener("0.0.0.0", 10420)
            .run();

    return 0;
}
