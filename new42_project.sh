#!/bin/bash

# setup_zed_project.sh
# Creates a new 42 project with Zed/Norm V4.1 configurations

PROJECT_NAME=$1

if [ -z "$PROJECT_NAME" ]; then
    echo "Usage: ./setup_zed_project.sh <project_name>"
    exit 1
fi

# Create project structure
mkdir -p "$PROJECT_NAME"/src "$PROJECT_NAME"/include
cd "$PROJECT_NAME" || exit

# Create .clang-format configuration
cat > .clang-format << 'EOL'
BasedOnStyle: GNU
BreakBeforeBraces: Allman
IndentWidth: 4
UseTab: Never
ColumnLimit: 80
AllowShortFunctionsOnASingleLine: false
AlignAfterOpenBracket: Align
SpaceBeforeParens: ControlStatements
PointerAlignment: Left
SpacesInParentheses: false
EOL

# Create Zed settings
mkdir -p .zed
cat > .zed/settings.json << 'EOL'
{
  "agent": {
    "inline_assistant_model": {
      "provider": "zed.dev",
      "model": "claude-3-7-sonnet-thinking-latest"
    },
    "default_model": {
      "provider": "zed.dev",
      "model": "claude-3-7-sonnet-latest"
    },
    "version": "2"
  },
  "edit_predictions": {
    "mode": "subtle",
    "copilot": {
      "proxy": null,
      "proxy_no_verify": null
    },
    "enabled_in_text_threads": false
  },
  "show_edit_predictions": false,
  "ui_font_size": 16,
  "buffer_font_size": 16,
  "theme": {
    "mode": "system",
    "light": "One Light",
    "dark": "One Dark"
  },
  "languages": {
    "C": {
      "tab_size": 4,
      "hard_tabs": false,
      "format_on_save": "on",
      "formatter": {
        "external": {
          "command": "clang-format",
          "arguments": ["--style=file"]
        }
      }
    },
    "Makefile": {
      "tab_size": 4,
      "formatter": "language_server",
      "format_on_save": "on"
    }
  }
}
EOL

# Create sample C file
cat > src/main.c << 'EOL'
#include <stdio.h>

int
main(void)
{
    printf("Hello 42!\n");
    return (0);
}
EOL

# Create basic Makefile
cat > Makefile << 'EOL'
NAME = program
SRC = src/main.c

all: $(NAME)

$(NAME):
	cc -Wall -Wextra -Werror $(SRC) -o $(NAME)

clean:
	rm -f $(NAME)

.PHONY: all clean
EOL

# Install norminette if missing
if ! command -v norminette &> /dev/null; then
    echo "Installing norminette..."
    pip3 install norminette
fi

echo "Project $PROJECT_NAME created with:"
echo "✅ Zed Norm V4.1 configuration"
echo "✅ .clang-format rules"
echo "✅ Sample C file & Makefile"
echo "To verify formatting: norminette src/main.c && clang-format --style=file -i src/main.c"
