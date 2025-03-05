# ============================================================================
# CROSS-PLATFORM C++ PROJECT TEMPLATE
# ============================================================================
# This CMakeLists.txt is designed to work across multiple platforms and
# compilers, with detailed configuration for both GCC/Clang and MSVC.
# ============================================================================

# Minimum CMake version required (3.20 supports better C++20 features)
cmake_minimum_required(VERSION 3.20)

# ============================================================================
# CUSTOM VARIABLES
# ============================================================================
set(PROJECT_NAME_VAR "my_project") # Set project name here
set(PROJECT_VERSION_VAR 1.0.0) # Set project version here
set(CPP_VERSION 23) # Set C++ Version

# ============================================================================
# PROJECT CONFIGURATION
# ============================================================================
project(
        ${PROJECT_NAME_VAR}             # Project name variable
        VERSION ${PROJECT_VERSION_VAR}  # Project version variable
        LANGUAGES CXX                   # Using C++ language
)

# ============================================================================
# C++ STANDARD CONFIGURATION
# ============================================================================

# Set C++ standard
set(CMAKE_CXX_STANDARD ${CPP_VERSION})

# Require the specified C++ standard, don't silently fall back to older standards
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Don't use compiler-specific extensions to C++ (improved portability)
set(CMAKE_CXX_EXTENSIONS OFF)

# ============================================================================
# OUTPUT DIRECTORY CONFIGURATION
# ============================================================================

# Place all executables in a "bin" subdirectory of the build folder
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/bin")

# Place all libraries (shared libraries, DLLs) in a "lib" subdirectory
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/lib")

# Place all static libraries (.a/.lib files) in a "lib" subdirectory
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/lib")

# ============================================================================
# BUILD OPTIONS
# ============================================================================

# Option to enable/disable building tests (ON by default)
option(BUILD_TESTS "Build the tests" ON)

# Option to enable sanitizers for catching memory and UB errors in Debug mode
option(ENABLE_SANITIZERS "Enable sanitizers in Debug mode" ON)

# ============================================================================
# SOURCE FILES CONFIGURATION
# ============================================================================
# Sources are explicitly listed by category for better organization
# and easier maintenance.
# ============================================================================

# Basics module source files
set(MAIN_SOURCES
        src/main.cpp
        # Add more source files as needed
)

# set(OTHER_SOURCES)
        # Add more source files as needed
# )


# Combine all source files for easier processing later
set(ALL_SOURCES
        ${MAIN_SOURCES}
        # ${OTHER_SOURCES}
        # etc...
)

# ============================================================================
# CROSS-PLATFORM COMPILER FLAGS
# ============================================================================
# Using generator expressions to apply the right flags for each compiler
# ============================================================================

# Common warning flags using generator expressions to select compiler-appropriate syntax
add_compile_options(
        # GCC and Clang flags:
        "$<$<CXX_COMPILER_ID:GNU,Clang>:-Wall;-Wextra;-Wpedantic;-Wshadow;-Wconversion;-Wunused>"
        # -Wall:        Enable all basic warning messages
        # -Wextra:      Enable additional warnings not covered by -Wall
        # -Wpedantic:   Warn about non-standard C++ features
        # -Wshadow:     Warn when a variable declaration shadows another
        # -Wconversion: Warn about implicit type conversions that may change value
        # -Wunused:     Warn about unused variables, functions, etc.

        # MSVC flags:
        "$<$<CXX_COMPILER_ID:MSVC>:/W4;/permissive-;/Zc:__cplusplus>"
        # /W4:               Enable level 4 warnings (highest useful level)
        # /permissive-:      Enforce standard C++ conformance
        # /Zc:__cplusplus:   Make __cplusplus macro correctly report the C++ version
)

# ============================================================================
# DEBUG CONFIGURATION
# ============================================================================

if (CMAKE_CXX_COMPILER_ID MATCHES "GNU|Clang")
    # GCC and Clang debug flags
    set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} -g -O0 -DDEBUG")
    # -g:       Generate debugging information
    # -O0:      Disable optimization (for better debugging experience)
    # -DDEBUG:  Define DEBUG macro for conditional compilation
elseif (CMAKE_CXX_COMPILER_ID MATCHES "MSVC")
    # MSVC debug flags
    set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} /Zi /Od /DDEBUG /RTC1")
    # /Zi:      Generate complete debugging information
    # /Od:      Disable optimization (for better debugging experience)
    # /DDEBUG:  Define DEBUG macro for conditional compilation
    # /RTC1:    Enable runtime error checks
endif ()

# ============================================================================
# RELEASE CONFIGURATION
# ============================================================================

if (CMAKE_CXX_COMPILER_ID MATCHES "GNU|Clang")
    # GCC and Clang release flags
    set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE} -O3 -DNDEBUG")
    # -O3:      Optimize for maximum performance
    # -DNDEBUG: Define NDEBUG macro (disables assertions)

    # Security-enhancing flags (only if supported by the compiler)
    include(CheckCXXCompilerFlag)

    # Check for FORTIFY_SOURCE support (adds runtime buffer overflow checks)
    check_cxx_compiler_flag("-D_FORTIFY_SOURCE=2" HAVE_FORTIFY_SOURCE)
    if (HAVE_FORTIFY_SOURCE)
        set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE} -D_FORTIFY_SOURCE=2")
    endif ()

    # Check for stack protector support (helps detect stack buffer overflows)
    check_cxx_compiler_flag("-fstack-protector-strong" HAVE_STACK_PROTECTOR)
    if (HAVE_STACK_PROTECTOR)
        set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE} -fstack-protector-strong")
    endif ()
elseif (CMAKE_CXX_COMPILER_ID MATCHES "MSVC")
    # MSVC release flags
    set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE} /O2 /Ob2 /DNDEBUG /guard:cf")
    # /O2:       Optimize for speed
    # /Ob2:      Inline any suitable functions
    # /DNDEBUG:  Define NDEBUG macro (disables assertions)
    # /guard:cf: Enable Control Flow Guard security checks
endif ()

# ============================================================================
# SANITIZER CONFIGURATION (DEBUG MODE ONLY)
# ============================================================================

# Sanitizers for debug mode (GCC/Clang only)
if (ENABLE_SANITIZERS AND CMAKE_BUILD_TYPE STREQUAL "Debug")
    if (CMAKE_CXX_COMPILER_ID MATCHES "GNU|Clang")
        include(CheckCXXCompilerFlag)

        # Skip UBSan on MinGW as it's often not available
        if (NOT MINGW)
            check_cxx_compiler_flag("-fsanitize=undefined" HAVE_SANITIZE_UNDEFINED)
            if (HAVE_SANITIZE_UNDEFINED)
                message(STATUS "UndefinedBehaviorSanitizer enabled")
                add_compile_options(-fsanitize=undefined)
                add_link_options(-fsanitize=undefined)
            endif ()
        else ()
            message(STATUS "UndefinedBehaviorSanitizer disabled on MinGW")
        endif ()

        # Check for AddressSanitizer support
        check_cxx_compiler_flag("-fsanitize=address" HAVE_SANITIZE_ADDRESS)
        if (HAVE_SANITIZE_ADDRESS)
            message(STATUS "AddressSanitizer enabled")
            add_compile_options(-fsanitize=address -fno-omit-frame-pointer)
            add_link_options(-fsanitize=address)
        endif ()
    else ()
        message(STATUS "Sanitizers not supported with this compiler")
    endif ()
endif ()

# ============================================================================
# INCLUDE DIRECTORIES
# ============================================================================

# Add project's include directory to include search path
include_directories(${CMAKE_SOURCE_DIR}/include)

# ============================================================================
# TARGET CREATION
# ============================================================================

# Create a list to store the names of all generated executables
set(ALL_EXECUTABLES)

# Process each source file and create a corresponding executable
foreach (SRC_FILE ${ALL_SOURCES})
    # Extract the filename without extension as the executable name
    get_filename_component(EXE_NAME ${SRC_FILE} NAME_WE)

    # Create executable target
    add_executable(${EXE_NAME} ${SRC_FILE})

    # Add the executable name to our list of executables
    list(APPEND ALL_EXECUTABLES ${EXE_NAME})

    # ================================================
    # PLATFORM-SPECIFIC LIBRARY CONFIGURATION
    # ================================================
    # Uncomment and modify as needed for your project
    # ================================================

    if (WIN32)
        # Windows-specific libraries
        # target_link_libraries(${EXE_NAME} PRIVATE wsock32 ws2_32)
        # wsock32: Windows socket library
        # ws2_32:  Windows socket library version 2
    elseif (UNIX AND NOT APPLE)
        # Linux-specific libraries
        # target_link_libraries(${EXE_NAME} PRIVATE pthread dl)
        # pthread: POSIX threads library
        # dl:      Dynamic linking library
    elseif (APPLE)
        # macOS-specific libraries
        # target_link_libraries(${EXE_NAME} PRIVATE "-framework CoreFoundation")
        # CoreFoundation: Apple's framework for common data types
    endif ()

    # Add executable as a test if testing is enabled
    if (BUILD_TESTS)
        add_test(NAME ${EXE_NAME}_test COMMAND ${EXE_NAME})
    endif ()
endforeach ()

# ============================================================================
# TESTING FRAMEWORK
# ============================================================================

# Enable CMake's testing infrastructure if tests are requested
if (BUILD_TESTS)
    enable_testing()
endif ()

# ============================================================================
# INSTALLATION CONFIGURATION
# ============================================================================

# Installation rules - install the executable targets, not the source files
install(TARGETS ${ALL_EXECUTABLES}
        RUNTIME DESTINATION bin    # Install executables to <prefix>/bin
)