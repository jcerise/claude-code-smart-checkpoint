#!/bin/bash

# Claude Code Smart Checkpoint System Installer
# Usage: ./install.sh [project|personal|both]

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
INSTALL_TYPE="${1:-project}"

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${BLUE}╔════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║  Claude Code Checkpoint System Setup  ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════╝${NC}"
echo ""

# Function to install to project
install_project() {
  echo -e "${YELLOW}Installing to project (.claude/commands/)...${NC}"

  # Create directories
  mkdir -p .claude/commands
  mkdir -p .claude/checkpoints

  # Copy command files
  cp "$SCRIPT_DIR/commands/smart-save.md" .claude/commands/
  cp "$SCRIPT_DIR/commands/checkpoint.md" .claude/commands/
  cp "$SCRIPT_DIR/commands/restore.md" .claude/commands/
  cp "$SCRIPT_DIR/commands/list-checkpoints.md" .claude/commands/
  cp "$SCRIPT_DIR/commands/diff-checkpoint.md" .claude/commands/

  # Copy example
  cp "$SCRIPT_DIR/example-checkpoint.md" .claude/checkpoints/

  echo -e "${GREEN}✓ Project installation complete${NC}"
  echo -e "  Commands installed to: ${BLUE}.claude/commands/${NC}"
  echo -e "  Checkpoints directory: ${BLUE}.claude/checkpoints/${NC}"
  echo ""

  # Ask about gitignore
  if [ -f .gitignore ]; then
    echo -e "${YELLOW}Add .claude/checkpoints/ to .gitignore?${NC}"
    echo "  (y) Yes - keep checkpoints local"
    echo "  (n) No - commit checkpoints to git (team sharing)"
    read -p "Choice [y/n]: " -n 1 -r
    echo ""

    if [[ $REPLY =~ ^[Yy]$ ]]; then
      if ! grep -q ".claude/checkpoints/" .gitignore; then
        echo ".claude/checkpoints/" >>.gitignore
        echo -e "${GREEN}✓ Added to .gitignore${NC}"
      else
        echo -e "${BLUE}Already in .gitignore${NC}"
      fi
    else
      echo -e "${BLUE}Checkpoints will be tracked by git${NC}"
    fi
    echo ""
  fi
}

# Function to install to personal
install_personal() {
  echo -e "${YELLOW}Installing to personal (~/.claude/commands/)...${NC}"

  # Create directory
  mkdir -p ~/.claude/commands

  # Copy command files
  cp "$SCRIPT_DIR/commands/smart-save.md" ~/.claude/commands/
  cp "$SCRIPT_DIR/commands/checkpoint.md" ~/.claude/commands/
  cp "$SCRIPT_DIR/commands/restore.md" ~/.claude/commands/
  cp "$SCRIPT_DIR/commands/list-checkpoints.md" ~/.claude/commands/
  cp "$SCRIPT_DIR/commands/diff-checkpoint.md" ~/.claude/commands/

  echo -e "${GREEN}✓ Personal installation complete${NC}"
  echo -e "  Commands installed to: ${BLUE}~/.claude/commands/${NC}"
  echo -e "  Available in all projects!${NC}"
  echo ""
}

# Main installation logic
case "$INSTALL_TYPE" in
project)
  install_project
  ;;
personal)
  install_personal
  ;;
both)
  install_project
  install_personal
  ;;
*)
  echo -e "${YELLOW}Usage: ./install.sh [project|personal|both]${NC}"
  echo ""
  echo "  project  - Install to current project (.claude/commands/)"
  echo "  personal - Install to personal commands (~/.claude/commands/)"
  echo "  both     - Install to both locations"
  echo ""
  exit 1
  ;;
esac

# Final instructions
echo -e "${GREEN}╔════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║         Installation Complete!         ║${NC}"
echo -e "${GREEN}╚════════════════════════════════════════╝${NC}"
echo ""
echo -e "${BLUE}Available commands:${NC}"
echo -e "  /smart-save [name]      - Analyze and recommend strategy"
echo -e "  /checkpoint [name]      - Quick checkpoint save"
echo -e "  /restore [name]         - Load checkpoint"
echo -e "  /list-checkpoints       - Browse all checkpoints"
echo -e "  /diff-checkpoint [name] - Compare with checkpoint"
echo ""
echo -e "${BLUE}Quick start:${NC}"
echo -e "  1. ${YELLOW}claude${NC}  (start Claude Code)"
echo -e "  2. ${YELLOW}/smart-save test${NC}  (try it out)"
echo -e "  3. ${YELLOW}/restore test${NC}  (see the difference)"
echo ""
echo -e "${BLUE}Documentation:${NC} See README.md for full guide"
echo ""
