cmake_minimum_required(VERSION 3.16)
project(ir_gen)

find_package(LLVM REQUIRED CONFIG)

message(STATUS "Found LLVM ${LLVM_PACKAGE_VERSION}")
message(STATUS "Using LLVMConfig.cmake in: ${LLVM_DIR}")

include_directories(${LLVM_INCLUDE_DIRS})
separate_arguments(LLVM_DEFINITIONS_LIST NATIVE_COMMAND ${LLVM_DEFINITIONS})
add_definitions(${LLVM_DEFINITIONS_LIST})

add_executable(ir_gen ir_gen.cpp)

llvm_map_components_to_libnames(llvm_libs support core irreader ExecutionEngine)

target_link_libraries(ir_gen ${llvm_libs})