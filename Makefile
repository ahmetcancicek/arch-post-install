# Installation targets
.PHONY: all install quick-install clean help

# Default target
all: install

# Quick install using git
quick-install:
	@echo "Installing via git..."
	sudo bash -c "$$(curl -fsSL https://raw.githubusercontent.com/ahmetcancicek/arch-post-install/main/install.sh)"

# Full installation
install:
	@echo "Starting installation..."
	chmod +x arch-post-install.sh
	sudo ./arch-post-install.sh

# Clean temporary files
clean:
	@echo "Cleaning temporary files..."
	rm -rf /tmp/arch-post-install*

# Help target
help:
	@echo "Available targets:"
	@echo "  make              - Run full installation"
	@echo "  make quick-install- Quick install using git"
	@echo "  make clean       - Clean temporary files"
	@echo "  make help        - Show this help message"