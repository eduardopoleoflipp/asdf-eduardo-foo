#!/usr/bin/env bash

set -euo pipefail

GH_REPO="https://github.com/eduardopoleoflipp/eduardo-foo"
TOOL_NAME="eduardo-foo"
TOOL_TEST="foo"

fail() {
	echo -e "asdf-$TOOL_NAME: $*"
	exit 1
}

curl_opts=(-fsSL)

# NOTE: You might want to remove this if eduardo-foo is not hosted on GitHub releases.
if [ -n "${GITHUB_API_TOKEN:-}" ]; then
	curl_opts=("${curl_opts[@]}" -H "Authorization: token $GITHUB_API_TOKEN")
fi

sort_versions() {
	sed 'h; s/[+-]/./g; s/.p\([[:digit:]]\)/.z\1/; s/$/.z/; G; s/\n/ /' |
		LC_ALL=C sort -t. -k 1,1 -k 2,2n -k 3,3n -k 4,4n -k 5,5n | awk '{print $2}'
}

list_github_tags() {
	git ls-remote --tags --refs "$GH_REPO" |
		grep -o 'refs/tags/.*' | cut -d/ -f3- |
		sed 's/^v//' # NOTE: You might want to adapt this sed to remove non-version strings from tags
}

list_all_versions() {
	list_github_tags
}

download_release() {
  local version filename url
  version="$1"
  filename="$2"

  # Determine OS and architecture
  local os arch
  case "$(uname -s)" in
    Darwin) os="darwin" ;;
    Linux) os="linux" ;;
    MINGW*|MSYS*|CYGWIN*) os="windows" ;;
    *) fail "Unsupported operating system: $(uname -s)" ;;
  esac

  case "$(uname -m)" in
    x86_64) arch="amd64" ;;
    arm64|aarch64) arch="arm64" ;;
    i*86) arch="386" ;;
    *) fail "Unsupported architecture: $(uname -m)" ;;
  esac

  # Construct URL for the binary release
  url="$GH_REPO/releases/download/v${version}/${TOOL_NAME}_${version}_${os}_${arch}.tar.gz"

  echo "* Downloading $TOOL_NAME release $version for ${os}_${arch}..."
	echo "Downloading from $url"
	echo "Download options ${curl_opts[@]}"
	echo "Filename $filename"
  curl "${curl_opts[@]}" -o "$filename" -C - "$url" || fail "Could not download $url"
}


install_version() {
  local install_type="$1"
  local version="$2"
  local install_path="${3%/bin}/bin"

  if [ "$install_type" != "version" ]; then
    fail "asdf-$TOOL_NAME supports release installs only"
  fi

  (
    mkdir -p "$install_path"
    
    # Determine OS and architecture for the downloaded file
    local os arch
    case "$(uname -s)" in
      Darwin) os="darwin" ;;
      Linux) os="linux" ;;
      MINGW*|MSYS*|CYGWIN*) os="windows" ;;
      *) fail "Unsupported operating system: $(uname -s)" ;;
    esac

    case "$(uname -m)" in
      x86_64) arch="amd64" ;;
      arm64|aarch64) arch="arm64" ;;
      i*86) arch="386" ;;
      *) fail "Unsupported architecture: $(uname -m)" ;;
    esac
    
    # Use the correct filename pattern
    local archive_file="${TOOL_NAME}_${version}_${os}_${arch}.tar.gz"
    
    echo "* Extracting $archive_file..."
    tar -xzf "$ASDF_DOWNLOAD_PATH/$archive_file" -C "$install_path"
    
    # Make sure the binary is executable
    chmod +x "$install_path/$TOOL_NAME"
    
    # Verify installation
    test -x "$install_path/$TOOL_NAME" || fail "Expected $install_path/$TOOL_NAME to be executable."

    echo "$TOOL_NAME $version installation was successful!"
  ) || (
    rm -rf "$install_path"
    fail "An error occurred while installing $TOOL_NAME $version."
  )
}

