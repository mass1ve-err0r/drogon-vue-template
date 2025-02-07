# C++ Web Development Template
> Powered by **Drogon** & **Vue 3**

This template kickstarts your development with a **C++ backend** and a **Vue 3 frontend** , providing a high-performance foundation for **Single Page Applications (SPA)**.

## Prerequisites
All you need is **Docker** –no manual setup required! If you prefer to build it manually, jump to the **Build Instructions*** below.

### Quick Start with Docker

To **build** the application image:
```sh
docker compose build
``` 

To **run** it in detached mode:
```sh
docker compose up -d
``` 

## Build Instructions
If you want to build the project manually without Docker, follow these steps:

1. **Install Drogon and Dependencies**
    - Follow the official Drogon **installation guide** :   
      [Drogon Installation](https://github.com/drogonframework/drogon/wiki/ENG-02-Installation)
    - Ensure you have **CMake, g++ (C+++ 20), and Drogon's dependencies** installed.


2. **Clone the Repository & Build**
```sh
git clone https://github.com/mass1ve-err0r/drogon-vue-template <your-project-folder>
cd <your-project-folder>
mkdir build && cd build
cmake ..
make -j$(nproc)

```

3. **Run the Application**
```sh
./dv3
``` 

(The executable name depends on your configuration, default is "dv3")


---

## Components

### Backend (Drogon)
[drogon documentation](https://github.com/drogonframework/drogon/wiki)

### Frontend (Vue 3)
[vue.js documentation](https://vuejs.org/?uwu)

### Docker Integration


---

## License
This project is **MIT licensed** – modify it freely to suit your needs! 🚀
