Features:
One-Command Setup

```bash
./setup_zed_project.sh my_project
```
Auto-Created Files:

*    Norm-compliant .clang-format
*    Pre-configured Zed settings (.zed/settings.json)
*    Sample C file with proper formatting
*    Basic Makefile with tab preservation
*    Dependency Check
*    Automatically installs norminette if missing

Usage:
Save as new42_project.sh

Make executable:

```bash
chmod +x new42_project.sh
```
Run with desired project name:

```bash
./new42_project.sh my_awesome_project

```
This ensures every new project starts with:
🔥 Zed configured for 4-space indentation
🔥 Auto-formatting on save
🔥 80-character line enforcement
🔥 Norm-compliant brace placement

Pro Tip: Add this script to your 
```
~/bin
```
directory and add 
```
export PATH=$PATH:~/bin to your .zshrc/.bashrc for global access!
```
