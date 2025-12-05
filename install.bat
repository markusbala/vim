@echo off
setlocal

echo 🚀 Setting up Vim Environment for Windows...

:: 1. Define Variables
set "REPO_DIR=%~dp0"
set "VIM_DIR=%USERPROFILE%\.vim"
set "VIMRC=%USERPROFILE%\_vimrc"

:: 2. Backup existing config
if exist "%VIMRC%" (
    echo 📦 Backing up existing _vimrc...
    move "%VIMRC%" "%VIMRC%.backup"
)

:: 3. Setup Vim Directory
if not exist "%VIM_DIR%" mkdir "%VIM_DIR%"
if not exist "%VIM_DIR%\autoload" mkdir "%VIM_DIR%\autoload"

:: 4. Copy Config Files
echo 📋 Copying vimrc...
copy /Y "%REPO_DIR%vimrc" "%VIMRC%"

echo 📋 Copying Snippets...
if exist "%VIM_DIR%\UltiSnips" rmdir /s /q "%VIM_DIR%\UltiSnips"
xcopy /E /I /Y "%REPO_DIR%UltiSnips" "%VIM_DIR%\UltiSnips"

:: 5. Download Vim-Plug
echo 🔌 Downloading Vim-Plug...
powershell -Command "Invoke-WebRequest -Uri https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim -OutFile '%VIM_DIR%\autoload\plug.vim'"

:: 6. Install Plugins
echo 📦 Installing Plugins (Vim will open, wait for 'Done' then close it)...
vim -c "PlugInstall" -c "qa"

echo.
echo ✅ Setup Complete!
echo ⚠️  IMPORTANT: Ensure you have installed 'Git', 'Python', and 'Nerd Fonts'.
pause