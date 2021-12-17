#!/usr/bin/env bash
set -ex

if [ "${mpi}" == "openmpi" ]; then
   export OPAL_PREFIX=$PREFIX
   export OMPI_MCA_plm=isolated
   export OMPI_MCA_btl_vader_single_copy_mechanism=none
   export OMPI_MCA_rmaps_base_oversubscribe=yes
fi

cmake_options=(
   "-DCMAKE_INSTALL_PREFIX=${PREFIX}"
   "-DCMAKE_INSTALL_LIBDIR=lib"
   "-DBUILD_SHARED_LIBS=ON"
   "-GNinja"
   ".."
)

mkdir -p _build
pushd _build
cmake ${CMAKE_ARGS} "${cmake_options[@]}"

ninja all install

popd
