cmake_minimum_required(VERSION 3.16)
project(delayed_branch_scheduler LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

add_library(project_lib
    src/instruction.cpp
    src/parser.cpp
    src/scheduler.cpp
    src/pipeline_sim.cpp
)

target_include_directories(project_lib PUBLIC include)

add_executable(schedule_tool src/schedule_tool.cpp)
target_link_libraries(schedule_tool PRIVATE project_lib)

add_executable(pipeline_sim src/pipeline_sim_main.cpp)
target_link_libraries(pipeline_sim PRIVATE project_lib)

include(CTest)
if(BUILD_TESTING)
    add_executable(scheduler_tests tests/scheduler_tests.cpp)
    target_link_libraries(scheduler_tests PRIVATE project_lib)
    add_test(NAME scheduler_tests COMMAND scheduler_tests)
endif()
