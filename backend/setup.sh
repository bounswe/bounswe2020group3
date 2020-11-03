# copy pre-commit to git hooks
cp pre-commit .git/hooks
cp .pylintrc .git/hooks
echo "Copied pre-commit file to hooks"

exit 0