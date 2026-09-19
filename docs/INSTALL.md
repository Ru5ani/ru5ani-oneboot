# Beginner GitHub setup

1. Open GitHub and sign in.
2. Tap **+ → New repository**.
3. Repository name: `ru5ani-oneboot`
4. Description: `One-command Linux browser and Android audio setup for Termux`
5. Select **Public**.
6. Turn **Add README** OFF.
7. Tap **Create repository**.
8. Download and extract the ZIP supplied with this project.
9. In your repository tap **Add file → Upload files**.
10. Upload `install.sh`, `README.md`, the whole `lib` folder, and `docs/INSTALL.md`.
11. Tap **Commit changes**.
12. Your installer command is:

```bash
curl -fsSL https://raw.githubusercontent.com/Ru5ani/ru5ani-oneboot/main/install.sh | bash
```

GitHub officially supports creating a repository from **New repository** and uploading files through **Add file → Upload files**. Raw files are served through `raw.githubusercontent.com`. 

First test the command on your own phone. If multiple launchers exist, the script displays a numbered menu. If the chosen launcher does not support passing a command into the distro, it stops safely instead of altering that launcher.
