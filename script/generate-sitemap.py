#!/usr/bin/env python3
"""
Google-friendly sitemap generator for cympfh.cc
"""

import os
import xml.etree.ElementTree as ET
from datetime import datetime
from pathlib import Path


def get_file_modification_date(filepath):
    """Get the last modification date of a file"""
    timestamp = os.path.getmtime(filepath)
    return datetime.fromtimestamp(timestamp).strftime("%Y-%m-%d")


def should_include_file(filepath):
    """Determine if a file should be included in the sitemap"""
    path_str = str(filepath)

    # Exclude 404 page
    if path_str.endswith("/404.html") or path_str == "404.html":
        return False

    # Exclude template files and certain directories
    exclude_patterns = [
        "/templates/",
        "/.git/",
        "/node_modules/",
        "/bin/",
    ]

    for pattern in exclude_patterns:
        if pattern in path_str:
            return False

    return True


def generate_sitemap(base_url="https://cympfh.cc"):
    """Generate XML sitemap"""
    # Create root element
    urlset = ET.Element("urlset")
    urlset.set("xmlns", "http://www.sitemaps.org/schemas/sitemap/0.9")

    # Find all HTML files
    html_files = []
    for html_file in Path(".").rglob("*.html"):
        if should_include_file(html_file):
            html_files.append(html_file)

    print(f"Found {len(html_files)} HTML files to include in sitemap")

    # Sort files for consistent output
    html_files.sort()

    # Add each HTML file to sitemap
    for html_file in html_files:
        # Convert path to URL
        url_path = str(html_file).lstrip("./")
        url = f"{base_url}/{url_path}"

        # Create URL entry
        url_elem = ET.SubElement(urlset, "url")

        loc = ET.SubElement(url_elem, "loc")
        loc.text = url

        lastmod = ET.SubElement(url_elem, "lastmod")
        lastmod.text = get_file_modification_date(html_file)

    # Create tree and write to file
    tree = ET.ElementTree(urlset)
    ET.indent(tree, space="  ")

    with open("sitemap.xml", "wb") as f:
        f.write(b'<?xml version="1.0" encoding="UTF-8"?>\n')
        tree.write(f, encoding="utf-8", xml_declaration=False)

    print(f"Sitemap generated: sitemap.xml ({len(html_files)} URLs)")


if __name__ == "__main__":
    generate_sitemap()
