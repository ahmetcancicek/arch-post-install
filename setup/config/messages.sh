#!/bin/bash

# Colors for messages
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Basic message functions
print_error() { echo -e "${RED}✗ $1${NC}"; }
print_success() { echo -e "${GREEN}✓ $1${NC}"; }
print_info() { echo -e "${BLUE}ℹ $1${NC}"; }
print_warning() { echo -e "${YELLOW}⚠ $1${NC}"; }

# Section headers
print_section() { echo -e "\n${BLUE}=== $1 ===${NC}"; }
print_step() { echo -e "\n${BLUE}→ $1${NC}"; }

# Installation messages
print_installing() { print_info "Installing: $1"; }
print_installed() { print_success "Installed: $1"; }
print_download() { print_info "Downloading: $1"; }
print_cleanup() { print_info "Cleaning up: $1"; }

# Program flow
print_start() { print_section "Starting: $1"; }
print_done() { print_section "Completed: $1"; } 