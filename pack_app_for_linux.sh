#!/usr/bin/bash

# Function to log errors
log_error() {
    local exit_code=$?
    local line_number=${BASH_LINENO[0]}
    local script_name=${BASH_SOURCE[1]}
    echo "Error in script: $script_name at line: $line_number (exit code: $exit_code)" >> error.log
    exit $exit_code
}

# Trap errors
trap 'log_error' ERR

# Get app name from JAR artifact
source get_jar_path.sh
echo "Getting app name from jar artifact"
jar_name=$(basename $jar_path)
app_name=$(echo "$jar_name" | cut -d '.' -f 1)

# Create build directory structure
echo "Creating build directory"
build_dir="${app_name}"
rm -rf $build_dir
mkdir -pv $build_dir/resources/icons
echo "Retrieveing app version and main class"
version=$(cat gradle.properties | grep -i 'version' | cut -d '=' -f 2 | tr -d ' ')
main_class=$(sed -En "s/^mainClassName = '(.*)'$/\1/p" lwjgl3/build.gradle)
echo "Copying jar to current directory"
cp -v $jar_path .
echo "Copying jar and icon to build directory"
cp -v $jar_path $build_dir/
echo "Ciopying icon to build directory"
cp -v icon.png $build_dir/resources/icons/
echo "Creating script to run app"
cat <<EOF > $build_dir/resources/$app_name.sh
#!/bin/bash
java -jar $jar_name
EOF
echo "Packaging app to deb"
jpackage \
  --type deb \
  --name $app_name \
  --input $build_dir \
  --main-jar ./$jar_name \
  --resource-dir $build_dir/resources \
  --icon $build_dir/resources/icons/icon.png 

echo "Packing app to rpm"
jpackage \
    --type rpm \
    --name $app_name \
    --app-version 1.0 \
    --input $build_dir \
    --main-jar ./$jar_name \
    --dest . \
    --icon $build_dir/resources/icons/icon.png \
    --description "My awesome Java application"
