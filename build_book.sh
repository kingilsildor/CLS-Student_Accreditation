jupyter-book build --all .
git add .
git commit -m "Update my book on $(date +'%Y-%m-%d %H:%M:%S')."
git push
ghp-import -n -p -f _build/html
