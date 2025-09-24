import json
import os
import sys
import argparse

def collect_metadata(history_path):
    metadata = []
    for fname in os.listdir(history_path):
        fpath = os.path.join(history_path, fname)
        if os.path.isfile(fpath):
            metadata.append({
                "name": fname,
                "size": os.path.getsize(fpath),
                "path": fpath
            })
    return metadata

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--output", required=True)
    args = parser.parse_args()

    # Galaxy sets working directory to a temp dir with all input files
    history_dir = os.getcwd()
    metadata = collect_metadata(history_dir)

    with open(args.output, "w") as out:
        json.dump(metadata, out, indent=4)

if __name__ == "__main__":
    main()
