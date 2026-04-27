#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
cd "$PROJECT_ROOT"

# make sure we use JDK 25
export JAVA_HOME=/usr/lib/jvm/java-25-openjdk
export PATH="$JAVA_HOME/bin:$PATH"

OUT_JAR="out/MyFirstGUI.jar"
if [ ! -f "$OUT_JAR" ]; then
    echo "JAR not found: $OUT_JAR"
    echo "Run scripts/build.sh first."
    exit 1
fi

M2="$HOME/.m2/repository/org/openjfx"
FX_VER="25.0.1"
FX_MODS="$M2/javafx-controls/$FX_VER/javafx-controls-$FX_VER.jar:$M2/javafx-controls/$FX_VER/javafx-controls-$FX_VER-linux.jar:$M2/javafx-graphics/$FX_VER/javafx-graphics-$FX_VER.jar:$M2/javafx-graphics/$FX_VER/javafx-graphics-$FX_VER-linux.jar:$M2/javafx-base/$FX_VER/javafx-base-$FX_VER.jar:$M2/javafx-base/$FX_VER/javafx-base-$FX_VER-linux.jar"

echo "Running MyFirstGUI (JavaFX $FX_VER)..."
java --module-path "$FX_MODS" \
     --add-modules javafx.controls \
     --enable-native-access=javafx.graphics \
     -cp "$OUT_JAR" \
     MyFirstGUI
