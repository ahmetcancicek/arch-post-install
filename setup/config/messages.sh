#!/bin/bash

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Basic message functions
print_error() {
    echo -e "${RED}[ERROR] $1${NC}"
}

print_success() {
    echo -e "${GREEN}[SUCCESS] $1${NC}"
}

print_info() {
    echo -e "${BLUE}[INFO] $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}[WARNING] $1${NC}"
}

# Installation specific messages
print_message() {
    echo -e "${BLUE}==> $1${NC}"
}

print_section() {
    echo
    echo -e "${GREEN}====== $1 ======${NC}"
    echo
}

# Installation status messages
print_start() {
    print_section "Starting: $1"
}

print_done() {
    print_section "Completed: $1"
}

# Package installation messages
print_installing() {
    print_info "Installing: $1"
}

print_installed() {
    print_success "Installed: $1"
}

print_skipped() {
    print_warning "Skipped: $1"
}

print_failed() {
    print_error "Failed: $1"
} 