#!/bin/bash


SOURCE=${BASH_SOURCE[0]}
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR=$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )
  SOURCE=$(readlink "$SOURCE")
  [[ $SOURCE != /* ]] && SOURCE=$DIR/$SOURCE # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR=$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )

TEMPLATES_ROOT_DIR="$DIR/.."

if [ "$#" -lt 1 ]; then
	echo "Usage: $0 <new_project_path> [project_name]"
	exit 1
fi

NEW_PROJECT_PATH="$1"
if [ "$#" -lt 2 ]; then
	NEW_PROJECT_NAME="$(basename "$NEW_PROJECT_PATH")"
else
	NEW_PROJECT_NAME="$2"
fi

TEMPLATE_DIR="$TEMPLATES_ROOT_DIR/CMakeTemplate"

if [ ! -e "$NEW_PROJECT_PATH" ]; then
	mkdir -p "$NEW_PROJECT_PATH"
fi

TEMPDIR=$(mktemp -d)

cp -r "$TEMPLATE_DIR/." -t "$TEMPDIR"

# find "$TEMPDIR" -type f
readarray -d '' FOUND_FILES < <(find "$TEMPDIR" -type f -print0)
# xargs sed -i "s/projectname/$NEW_PROJECT_NAME/g"

for i in "${FOUND_FILES[@]}"; do
	sed -i "s/projectname/$NEW_PROJECT_NAME/g" "$i"
	sed -i "s/PROJECTNAME/\U$NEW_PROJECT_NAME/g" "$i"
	if [ $(echo "$i" | grep 'projectname') ]; then
		mv "$i" "$(echo "$i" | sed "s/projectname/$NEW_PROJECT_NAME/")"
	fi
done

cp -r "$TEMPDIR/." -t "$NEW_PROJECT_PATH"

rm -rf "$TEMPDIR"

echo "Project $NEW_PROJECT_NAME created"

