set(sources
    src/example/sha.cpp
)

set(exe_sources
    app/main.cpp
    ${sources}
)

set(headers
    include/example/sha.hpp
)

set(test_sources
    tests/test_example.cpp
)