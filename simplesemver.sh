#!/bin/sh

SEMVER_REGEX="^(0|[1-9]\d*)\.(0|[1-9]\d*)\.(0|[1-9]\d*)(?:-((?:0|[1-9]\d*|\d*[a-zA-Z-][0-9a-zA-Z-]*)(?:\.(?:0|[1-9]\d*|\d*[a-zA-Z-][0-9a-zA-Z-]*))*))?(?:\+([0-9a-zA-Z-]+(?:\.[0-9a-zA-Z-]+)*))?$"
BASENAME=$(basename $0)
MAJOR=0
MINOR=0
PATCH=0

usage()
{
  echo "Usage: $BASENAME [-m|-i|-p] [-v semver ]"
  echo
  echo "Parameters:"
  echo " m - Increment MAJOR version"
  echo " i - Increment MINOR version"
  echo " p - Increment PATCH version"
  echo " v - semver string, e.g. '1.0.0'"
  echo
  echo "Specify only ONE of 'm', 'i' or 'p'"
  exit 2
}

while getopts 'mipv:?h' o
do
  case $o in
    m) MAJOR=1 ;;
    i) MINOR=1 ;;
    p) PATCH=1 ;;
    v) VERSION=$OPTARG ;;
    h|?) usage ;;
  esac
done

# Check we have one and only one number to increment
TOTAL=$((MAJOR+MINOR+PATCH))
if [ $TOTAL -ne 1 ]; then
  echo "Specify only one of m|i|p"
  echo
  usage
fi

# validate semver string
if $(echo $VERSION | grep -P -qv $SEMVER_REGEX); then
  echo "Semver not in expected format"
  echo
  usage
fi

MAJORVALUE=$(echo $VERSION | cut -d. -f1)
MINORVALUE=$(echo $VERSION | cut -d. -f2)
PATCHVALUE=$(echo $VERSION | cut -d. -f3)

if [ $MAJOR -eq 1 ]; then
  MAJORVALUE=$(( MAJORVALUE+1 ))
  MINORVALUE=0
  PATCHVALUE=0
fi

if [ $MINOR -eq 1 ]; then
  MINORVALUE=$(( MINORVALUE+1 ))
  PATCHVALUE=0
fi

if [ $PATCH -eq 1 ]; then
  PATCHVALUE=$(( PATCHVALUE+1 ))
fi

echo "$MAJORVALUE.$MINORVALUE.$PATCHVALUE"
