#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
cd "$PROJECT_ROOT"

export JAVA_HOME=/usr/lib/jvm/java-25-openjdk
export PATH="$JAVA_HOME/bin:$PATH"

echo "Building MyFirstGUI with Maven (JDK 25 + JavaFX 25.0.1)..."

# clean old manual build
rm -f MyFirstGUI.jar MyFirstGUI.class
rm -rf out

# Maven does everything: download JavaFX, compile, bundle CSS/GIFs
mvn -q clean package

# copy the result where your old script put it
mkdir -p out
cp target/MyFirstGUI-1.0.jar out/MyFirstGUI.jar

echo "Build completed: out/MyFirstGUI.jar"
