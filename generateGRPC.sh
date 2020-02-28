#!/bin/sh

if [ $# -eq 0 ]
then
  echo "Usage: ./generateCPPGRPC.sh [OPTIONS]"
  echo "OPTIONS:"
  echo "  PROTO_DIR=<protocol_buffer_directory> Specify the component to build. This should match what has been configured in vmodl2.json and package-info.vmodl file for your component."
  echo "  LANG=<language> Language in whihc the bindings to be generated. Supported languages are java and cpp "
  echo "  OUT_DIR=<output_dir_name> Location of the directory where the Generated bindings ot be saved. "
  exit 1
else

  for ARGUMENT in "$@"
     do
       KEY=$(echo $ARGUMENT | cut -f1 -d=)
       VALUE=$(echo $ARGUMENT | cut -f2 -d=)

     case "$KEY" in
            PROTO_DIR)              PROTO_DIR=${VALUE} ;;
            LANG)                   LANG=${VALUE} ;;
            OUT_DIR)                OUT_DIR=${VALUE} ;;
            *)   
     esac
    done

echo "PROTO_DIR = $PROTO_DIR"
echo "LANG = $LANG"
echo "OUT_DIR = $OUT_DIR"
for f in $PROTO_DIR/*.proto; 
do 
	#echo "protoc  --"$LANG"_out="$OUT_DIR" $f"
	protoc  --"$LANG"_out="$OUT_DIR" --proto_path="$PROTO_DIR" "$f"
done
fi
