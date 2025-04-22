import argparse


def convert_path(input_path):
    # Replace the 'Y:' with '/VITO' and convert backslashes to forward slashes
    replaced_path = input_path.replace("Y:", "/VITO").replace("\\", "/")
    replaced_path = replaced_path.replace("\\", "/")
    return replaced_path


def main():
    parser = argparse.ArgumentParser(
        description="Convert Windows file path to Unix-like path."
    )
    parser.add_argument(
        "path", type=str, help="The Windows-style file path to convert."
    )

    args = parser.parse_args()
    converted_path = convert_path(args.path)

    print(converted_path)


if __name__ == "__main__":
    main()
