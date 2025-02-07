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

1. **Install Drogon**
    - Follow the official Drogon **installation guide** :   
      [Drogon Installation](https://github.com/drogonframework/drogon/wiki/ENG-02-Installation)


2. **Install Node + npm**
   - Follow the instructions at [nodejs](https://nodejs.org/en/download)


3. **Clone the Repository & Build**
```sh
git clone https://github.com/mass1ve-err0r/drogon-vue-template <your-project-folder>
cd <your-project-folder>
mkdir build && cd build
cmake ..
make -j$(nproc)

```

4. **Run the Application**
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


### GitHub Workflows Integration
Commits prefixed with `[REL]` will trigger the build & release workflow.
It will automatically tag and build a release binary for you.

---

## License
This project is **MIT licensed** – modify it freely to suit your needs! 🚀
