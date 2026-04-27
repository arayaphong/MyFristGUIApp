#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
OUT_DIR="$PROJECT_ROOT/out"
DIST_DIR="$PROJECT_ROOT/dist"
JAR_FILE="$OUT_DIR/MyFirstGUI.jar"

export JAVA_HOME=/usr/lib/jvm/java-25-openjdk
export PATH="$JAVA_HOME/bin:$PATH"

[ -f "$JAR_FILE" ] || bash "$SCRIPT_DIR/build.sh"

M2="$HOME/.m2/repository/org/openjfx"
FX_VER="25.0.1"
FX_MODS="$M2/javafx-controls/$FX_VER/javafx-controls-$FX_VER.jar:$M2/javafx-controls/$FX_VER/javafx-controls-$FX_VER-linux.jar:$M2/javafx-graphics/$FX_VER/javafx-graphics-$FX_VER.jar:$M2/javafx-graphics/$FX_VER/javafx-graphics-$FX_VER-linux.jar:$M2/javafx-base/$FX_VER/javafx-base-$FX_VER.jar:$M2/javafx-base/$FX_VER/javafx-base-$FX_VER-linux.jar"

echo "Using JavaFX $FX_VER from Maven cache"

# bundle assets alongside the jar so jpackage includes them in lib/
cp "$PROJECT_ROOT/dark.css" "$OUT_DIR/dark.css"
cp "$PROJECT_ROOT/กระดึ๊บ.gif" "$OUT_DIR/กระดึ๊บ.gif"

rm -rf "$DIST_DIR"; mkdir -p "$DIST_DIR"

jpackage \
  --type app-image \
  --name MyFirstGUI \
  --input "$OUT_DIR" \
  --main-jar MyFirstGUI.jar \
  --main-class MyFirstGUI \
  --module-path "$FX_MODS" \
  --add-modules javafx.controls,javafx.graphics \
  --java-options "--enable-native-access=javafx.graphics" \
  --dest "$DIST_DIR"

cd "$DIST_DIR"
tar -czf MyFirstGUI-arch.tar.gz MyFirstGUI/

echo "Done: $DIST_DIR/MyFirstGUI-arch.tar.gz"
