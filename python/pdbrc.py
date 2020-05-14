"""
pdb++ configuration

Symlink this file to ~/.pdbrc.py and pdb++ will pick it up:

    ln -s "$PROFILE/python/pdbrc.py" ~/.pdbrc.py
"""
import pdb


class Config(pdb.DefaultConfig):
    sticky_by_default = True  # start in sticky mode
    current_line_color = 40  # black
