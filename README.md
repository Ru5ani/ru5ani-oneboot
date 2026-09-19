# Ru5ani OneBoot

One-command setup for existing Termux/Andronix-style Linux environments.

**Flow:** Termux audio → detect Linux → select if multiple → automatically enter selected launcher → install Firefox → configure audio → finish.

Install:
```bash
curl -fsSL https://raw.githubusercontent.com/Ru5ani/ru5ani-oneboot/main/install.sh | bash
```

Supported launcher families: Ubuntu, Debian, Kali, Arch, Manjaro, Fedora, Alpine and Void.

The installer only auto-enters launchers that visibly forward command arguments; it will stop rather than modify an incompatible launcher.
