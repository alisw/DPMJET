# **************************************************************************
# * Copyright(c) 1998-2016, ALICE Experiment at CERN, All rights reserved. *
# *                                                                        *
# * Author: The ALICE Off-line Project.                                    *
# * Contributors are mentioned in the code where appropriate.              *
# *                                                                        *
# * Permission to use, copy, modify and distribute this software and its   *
# * documentation strictly for non-commercial purposes is hereby granted   *
# * without fee, provided that the above copyright notice appears in all   *
# * copies and that both the copyright notice and this permission notice   *
# * appear in the supporting documentation. The authors make no claims     *
# * about the suitability of this software for any purpose. It is          *
# * provided "as is" without express or implied warranty.                  *
# **************************************************************************

cmake_minimum_required(VERSION 2.8.12 FATAL_ERROR)

project(DPMJET)
enable_language(Fortran)
set(CMAKE_Fortran_PREPROCESS ON)

# Set by default DEBUG build type
# The optimisation affects the initialisation of COMMON blocks
if (NOT CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE DEBUG)
endif(NOT CMAKE_BUILD_TYPE)

# ``MACOSX_RPATH`` is enabled by default.
cmake_policy(SET CMP0042 NEW)

# PHOJET sources. Use GLOB for the moment
file(GLOB PHOJET_SRCS "src/phojet/*.f")

# DPMJET sources
file(GLOB DPMJET_SRCS "src/dpmjet/*.f")

# PYTHIA sources
file(GLOB PYTHIA_SRCS "src/pythia/*.f")

# DUMMY sources
file(GLOB DUMMY_SRCS "common/*.f")

# All Fortran sources
set(FSRCS ${PHOJET_SRCS} ${DPMJET_SRCS} ${PYTHIA_SRCS} ${DUMMY_SRCS})

# Add a library to the project using the specified source files
add_library(${PROJECT_NAME} SHARED ${FSRCS})

target_include_directories(${PROJECT_NAME} SYSTEM PUBLIC
  include/phojet
  include/dpmjet
  include/flinclude
  include/pythia
  )

# System dependent: Modify the way the library is build
if(${CMAKE_SYSTEM} MATCHES Darwin)
    set(CMAKE_Fortran_FLAGS "${CMAKE_Fortran_FLAGS} -undefined dynamic_lookup")
endif(${CMAKE_SYSTEM} MATCHES Darwin)

# Add executable
add_executable(dpmjet.exe src/exe/DPMJET.f)
target_include_directories(dpmjet.exe SYSTEM PUBLIC
  include/dpmjet
  )
target_link_libraries(dpmjet.exe ${PROJECT_NAME})
# Installation
install(TARGETS ${PROJECT_NAME}
  ARCHIVE DESTINATION lib
  LIBRARY DESTINATION lib)

# Install data files and documentation
install(DIRECTORY dpmdata DESTINATION .)
install(DIRECTORY docs DESTINATION .)

# Install the executable
install(TARGETS dpmjet.exe RUNTIME DESTINATION bin)
