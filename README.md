# Goal

This repo aims to give an example of good practices when creating modular cpp projects with cmake. 

It contains an example of two minimal cpp projects *xxx* and *yyy*

* `xxx` is composed of two libraries, *foo* and *bar* and one execuatable called *xxx*. `foo` is a "public" (in the `CMake` meaning) dependence of `bar` and `bar` is a public dependence of the execuatble `xxx`.
* `yyy` is composed of one library *foo* and one executable called *yyy*. The `xxx::bar` library is a public dependence of `yyy::foo` and `yyy::foo` is a public dependence of the execuatble `yyy`.

---

All the burden of creating a library target and correctly install it (in the "modern" `CMake` way) is done in the [`new_target_library`](https://github.com/rdebroiz/helloworlcpp/blob/main/cmake/module/NewTargetLibrary.cmake) function.
The content of that function can be mimic for more complex situation, projects that depends on non modern cmake target and required explicit call to `target_include_directories` for instance (even if one could create an imported target for that).

At the end all one needs to do to create a new library is a call to that function with the right arguments. 
Here is what it looks like for the `yyy::foo` library:

```cmake
new_target_library(foo 
    PUBLIC_DEPENDENCIES
        "xxx REQUIRED COMPONENTS bar"
    PUBLIC_LINK_LIBRARIES
        xxx::bar
    SOURCES 
        src/foo.cpp
)
```

---

# Files structure

To correctly works it requires that the library sources and headers tree follow some other good practices.

* Sources are expected to be found in an `src` folder at the root of the library.
* Public headers are expected to be found in a `include/project_name/library_name` folder at the root of the library. 
* Private headers are expected to be found along the sources (.cpp files).

Public headers are then included using their path relative to the `include` folder .
Private headers are then included using their path relative to the `src` folder.

Example for the `yyy::foo` library:

```
└───foo
    │   CMakeLists.txt
    │
    ├───include
    │   └───yyy
    │       └───foo
    │               foo.h
    │
    └───src
            foo.cpp
```

---
# Symbols visibility

All symbols are hidden by default on every plateform. The export macro are genereated in a `export.h` header by CMake.
It must be icnluded with `#include <project_name/library_name/export.h>`

The export macro is called <PROJECT_NAME>_<LIBRARY_NAME>_EXPORT

example of how it is used in `yyy::foo`

```cpp
#pragma once

#include <yyy/foo/export.h>

#include <xxx/foo/foo.h>
#include <xxx/bar/bar.h>

namespace yyy {
namespace foo {

class YYY_FOO_EXPORT Foo {
    public:
        Foo() = default;
        ~Foo() = default;

        void trigger();

        xxx::foo::Foo xxxFoo;
        xxx::bar::Bar xxxBar;
};

} // eon foo
} // eon yyy
```


# Artifacts location

* Public headers are installed into `<project_install_dir>/include/<project_name>/<library_name>`
* Libraries are installed into `<project_install_dir>/lib`(on windows dll are installed into `<project_install_dir>/bin`)
* Executables are installed into `<project_install_dir>/bin`
* CMake files (Config, ConfigVersion and Target modules) are installed in `<project_install_dir>/lib/cmake/<project_name>`

Here is what it looks like on windows (xxx libraries are static, yyy library is dynamic):

```
├───bin
│       xxx.exe
│       yyy.exe
│       yyy_foo.dll
│
├───include
│   ├───xxx
│   │   ├───bar
│   │   │       bar.h
│   │   │       export.h
│   │   │
│   │   └───foo
│   │           export.h
│   │           foo.h
│   │
│   └───yyy
│       └───foo
│               export.h
│               foo.h
│
└───lib
    │   xxx_bar.lib
    │   xxx_foo.lib
    │   yyy_foo.lib
    │
    └───cmake
        ├───xxx
        │       barConfig.cmake
        │       barConfigVersion.cmake
        │       barTarget.cmake
        │       fooConfig.cmake
        │       fooConfigVersion.cmake
        │       fooTarget.cmake
        │       xxxConfig.cmake
        │       xxxConfigVersion.cmake
        │
        └───yyy
                fooConfig.cmake
                fooConfigVersion.cmake
                fooTarget.cmake
                yyyConfig.cmake
                yyyConfigVersion.cmake
```

# Import the projects

Projects can be imported from both the build and the install tree. 
* When imported from the build tree the project dir is `<project_build_dir>/cmake`
* When imported from the install tree the project dir is `<project_install_dir>/lib/cmake/project_name`
