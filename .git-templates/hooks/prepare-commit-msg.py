#!/usr/bin/env python3
import os
import subprocess
import sys
from typing import List


def add_committer_and_author(commit_msg_lines: List[str]) -> List[str]:

    committer_name = env_or_cmd("GIT_COMMITTER_NAME", ["git", "config", "user.name"])
    committer_email = env_or_cmd("GIT_COMMITTER_EMAIL", ["git", "config", "user.email"])

    author_name = os.environ.get("GIT_AUTHOR_NAME")
    author_email = os.environ.get("GIT_AUTHOR_EMAIL")

    committer_and_author = [
        "#\n",
        f"# Committer: {committer_name} <{committer_email}>\n",
        f"# Author:    {author_name} <{author_email}>\n",
    ]

    msg = commit_msg_lines[:3] + committer_and_author + commit_msg_lines[3:]

    return msg


def env_or_cmd(var: str, cmd: List[str]) -> str:

    res = subprocess.run(
        cmd,
        stdout=subprocess.PIPE,
        text=True,
        check=True,
    )

    res_text = res.stdout.strip() if res.stdout else ""

    return os.environ.get(var, res_text)


def read_lines(path: str) -> List[str]:

    with open(path, "r") as file:
        lines = file.readlines()

    return lines


def write_lines(path: str, lines: List[str]) -> None:

    text = "".join(lines)

    with open(path, "w") as file:
        file.write(text)


def main() -> None:

    commit_msg_path = sys.argv[1]

    commit_msg_lines = read_lines(commit_msg_path)
    commit_msg_lines = add_committer_and_author(commit_msg_lines)

    write_lines(commit_msg_path, commit_msg_lines)


if __name__ == "__main__":
    main()
