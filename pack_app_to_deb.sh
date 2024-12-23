#!/usr/bin/bash
# Get app name from JAR artifact
source get_jar_path.sh
echo "Getting app name from jar artifact"
jar_name=$(basename $jar_path)
app_name=$(echo "$jar_name" | cut -d '.' -f 1)

# Create build directory structure
echo "Creating build directory"
build_dir="${app_name}"
rm -rf $build_dir
mkdir -p $build_dir/resources/icons
version=$(cat gradle.properties | grep -i 'version' | cut -d '=' -f 2 | tr -d ' ')
main_class=$(sed -En "s/^mainClassName = '(.*)'$/\1/p" lwjgl3/build.gradle)
cp $jar_path $build_dir/
cp $jar_path ./
cp icon.png $build_dir/resources/icons/
cat <<EOF > $build_dir/resources/$app_name.sh
#!/bin/bash
java -jar $jar_name
EOF
jpackage \
  --type deb \
  --name $app_name \
  --input $build_dir \
  --main-jar ./$jar_name \
  --resource-dir $build_dir/resources \
  --icon $build_dir/resources/icons/icon.png \