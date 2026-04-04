#!/bin/bash
# scripts/generate_proto.sh

# 스크립트 위치 기준으로 프로젝트 루트 계산
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(dirname "$SCRIPT_DIR")"

PROTO_DIR="$ROOT_DIR/proto"
OUT_DIR="$ROOT_DIR/lib/core/generated"

mkdir -p "$OUT_DIR"

protoc \
  --proto_path="$PROTO_DIR" \
  --dart_out=grpc:"$OUT_DIR" \
  $(find "$PROTO_DIR" -name "*.proto")

echo "✅ proto generation complete → $OUT_DIR"