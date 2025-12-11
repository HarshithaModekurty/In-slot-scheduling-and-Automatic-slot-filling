#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BUILD_DIR="${ROOT_DIR}/build"
mkdir -p "${BUILD_DIR}"

IVERILOG_FLAGS="-g2012 -I ${ROOT_DIR}/rtl"

echo "[RUN] tb_core_basic"
iverilog ${IVERILOG_FLAGS} -o "${BUILD_DIR}/tb_core_basic.vvp" \
    "${ROOT_DIR}/tb/tb_core_basic.v" "${ROOT_DIR}/rtl/"*.v
vvp "${BUILD_DIR}/tb_core_basic.vvp"

echo "[RUN] tb_core_edgecases"
iverilog ${IVERILOG_FLAGS} -o "${BUILD_DIR}/tb_core_edgecases.vvp" \
    "${ROOT_DIR}/tb/tb_core_edgecases.v" "${ROOT_DIR}/rtl/"*.v
vvp "${BUILD_DIR}/tb_core_edgecases.vvp"
