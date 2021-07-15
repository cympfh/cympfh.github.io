import logging
import subprocess

from watchgod import watch

logger = logging.getLogger("watch")

for changes in watch("./"):
    for _, path in changes:
        if not path.endswith(".md"):
            continue
        html = f"{path[:len(path)-3]}.html"
        logger.info("Make %s", html)
        subprocess.run(["make", html, "index"])
