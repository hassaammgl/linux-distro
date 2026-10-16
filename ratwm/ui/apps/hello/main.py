#!/usr/bin/env python3
"""Very basic Python app — dock se Launcher.run se start hota hai."""

from pathlib import Path

print("=== rat hello (python) ===")
print("home:", Path.home())
print("files:")
for p in sorted(Path.home().iterdir())[:20]:
    kind = "dir " if p.is_dir() else "file"
    print(f"  [{kind}] {p.name}")
print("done.")
